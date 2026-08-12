--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: EPL_IQ_Correlator.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFireSoC> <Die::MPFS025T> <Package::FCSG325>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity EPL_IQ_Correlator is
    generic (
        input_width : integer := 10;
        acc_width   : integer := 32
    );
    port (
        clk   : in  std_logic;
        rst   : in  std_logic;
        en    : in  std_logic;
        dump  : in  std_logic; -- dump: end-of-coherent-integration strobe

        I_in  : in  std_logic_vector(input_width-1 downto 0);
        Q_in  : in  std_logic_vector(input_width-1 downto 0);

        prn_early  : in  std_logic;
        prn_prompt : in  std_logic;
        prn_late   : in  std_logic;

        I_E : out std_logic_vector(acc_width-1 downto 0);
        Q_E : out std_logic_vector(acc_width-1 downto 0);
        I_P : out std_logic_vector(acc_width-1 downto 0);
        Q_P : out std_logic_vector(acc_width-1 downto 0);
        I_L : out std_logic_vector(acc_width-1 downto 0);
        Q_L : out std_logic_vector(acc_width-1 downto 0)
    );
end entity;

architecture structural of EPL_IQ_Correlator is

    ------------------------------------------------------------------
    -- Constants for readability
    ------------------------------------------------------------------
    constant IDX_E : integer := 0;
    constant IDX_P : integer := 1;
    constant IDX_L : integer := 2;

    constant IDX_I : integer := 0;
    constant IDX_Q : integer := 1;

    ------------------------------------------------------------------
    -- Arrays
    ------------------------------------------------------------------
    type slv_array_3 is array (0 to 2) of std_logic;
    type slv_array_3x2_acc is array (0 to 2, 0 to 1) of std_logic_vector(acc_width-1 downto 0);

    ------------------------------------------------------------------
    -- Signals
    ------------------------------------------------------------------
    signal prn_sel  : slv_array_3;
    signal mac_out  : slv_array_3x2_acc;

    ------------------------------------------------------------------
    -- Components
    ------------------------------------------------------------------
    component GNSS_Serial_Correlator is
    generic (
        input_width  : integer := 10;
        output_width : integer := 32
    );
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        en     : in  std_logic;
        dump   : in  std_logic; -- dump: end-of-coherent-integration strobe

        PRN    : in  std_logic;

        I_Real : in  std_logic_vector(input_width-1 downto 0);
        Q_Real : in  std_logic_vector(input_width-1 downto 0);

        I_acc  : out std_logic_vector(output_width-1 downto 0);
        Q_acc  : out std_logic_vector(output_width-1 downto 0)
    );
    end component;

begin

    ------------------------------------------------------------------
    -- Assign inputs to arrays
    ------------------------------------------------------------------
    prn_sel(IDX_E) <= prn_early;
    prn_sel(IDX_P) <= prn_prompt;
    prn_sel(IDX_L) <= prn_late;

    ------------------------------------------------------------------
    -- MAC instances (3 × 2)
    ------------------------------------------------------------------
    gen_corr : for c in 0 to 2 generate
            Correlator : GNSS_Serial_Correlator
                generic map (
                    input_width  => input_width,
                    output_width => acc_width
                )
                port map (
                    clk     => clk,
                    rst     => rst,
                    en      => en,
                    dump    => dump, -- dump: end-of-coherent-integration strobe
                    PRN     => prn_sel(c),
                    I_Real  => I_in,
                    Q_Real  => Q_in,
                    I_acc   => mac_out(c, IDX_I),
                    Q_acc   => mac_out(c, IDX_Q)
                );
    end generate;

    ------------------------------------------------------------------
    -- Outputs
    ------------------------------------------------------------------
    I_E <= mac_out(IDX_E, IDX_I);
    Q_E <= mac_out(IDX_E, IDX_Q);

    I_P <= mac_out(IDX_P, IDX_I);
    Q_P <= mac_out(IDX_P, IDX_Q);

    I_L <= mac_out(IDX_L, IDX_I);
    Q_L <= mac_out(IDX_L, IDX_Q);

end architecture structural;

