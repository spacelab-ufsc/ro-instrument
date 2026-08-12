--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: GNSS_Serial_Correlator.vhd
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

entity GNSS_Serial_Correlator is
    generic (
        input_width  : integer := 6;
        output_width : integer := 18
    );
    port (
        clk    : in  std_logic;
        rst    : in  std_logic;
        en     : in  std_logic;
        dump   : in  std_logic;

        PRN    : in  std_logic;

        I_Real : in  std_logic_vector(input_width-1 downto 0);
        Q_Real : in  std_logic_vector(input_width-1 downto 0);

        I_acc  : out std_logic_vector(output_width-1 downto 0);
        Q_acc  : out std_logic_vector(output_width-1 downto 0)
    );
end entity GNSS_Serial_Correlator;
architecture architecture_GNSS_Serial_Correlator of GNSS_Serial_Correlator is

    --------------------------------------------------------------------
    -- Internal signals
    --------------------------------------------------------------------
    type IQ_in  is array (0 to 1) of std_logic_vector(input_width-1 downto 0);
    type IQ_out is array (0 to 1) of std_logic_vector(output_width-1 downto 0);
    
    signal IQ_dat       : IQ_in;
    signal IQ_neg       : IQ_in;
    signal IQ_sel       : IQ_in;

    signal IQ_acc_out   : IQ_out;
    
    --------------------------------------------------------------------
    -- Components
    --------------------------------------------------------------------
    component Negative_Integer is
        generic (
            data_width : integer := 10
        );
        port (
            SIG_IN  : in  std_logic_vector(data_width-1 downto 0);
            SIG_OUT : out std_logic_vector(data_width-1 downto 0)
        );
    end component;

    component Accumulator is
        generic (
            input_width  : integer := 64;
            output_width : integer := 64
        );
        port (
            clk     : in  std_logic;
            rst     : in  std_logic;
            en      : in  std_logic;
            dump    : in  std_logic;

            data_in : in  std_logic_vector(input_width-1 downto 0);
            result  : out std_logic_vector(output_width-1 downto 0)
        );
    end component;

begin

    IQ_dat(0) <= I_Real;
    IQ_dat(1) <= Q_Real;
    
    IQ_PRN: for i in 0 to 1 generate
    --------------------------------------------------------------------
    -- Negation blocks (PRN = 1 ? subtract)
    --------------------------------------------------------------------
        NEG_I : Negative_Integer
            generic map (
                data_width => input_width
            )
            port map (
                SIG_IN  => IQ_dat(i),
                SIG_OUT => IQ_neg(i)
            );
        --------------------------------------------------------------------
        -- PRN-controlled selection
        --------------------------------------------------------------------
        IQ_sel(i) <= IQ_dat(i) when PRN = '0' 
                    else IQ_neg(i);
        --------------------------------------------------------------------
        -- IQ-channel correlator (ACC)
        --------------------------------------------------------------------
        ACC: Accumulator
            generic map (
                input_width  => input_width,
                output_width => output_width
            )
            port map (
                clk     => clk,
                rst     => rst,
                en      => en,
                dump    => dump,
                data_in => IQ_sel(i),
                result  => IQ_acc_out(i)
            );
    end generate;
    
    --------------------------------------------------------------------
    -- Outputs (valid on dump cycle)
    --------------------------------------------------------------------
    I_acc <= IQ_acc_out(0);
    Q_acc <= IQ_acc_out(1);
end architecture_GNSS_Serial_Correlator;
