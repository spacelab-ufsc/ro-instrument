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
use IEEE.numeric_std.all;

entity GNSS_Input_Chain_tb is
end GNSS_Input_Chain_tb;

architecture behavioral of GNSS_Input_Chain_tb is

    component GNSS_Input_Chain is
        generic (
            DDS_WIDTH : positive := 8
        );
        port (
            clk     : in std_logic;
            DDS_clk : in std_logic;
            rst     : in std_logic;

            MAX_INPUT_I : in std_logic_vector(1 downto 0);
            MAX_INPUT_Q : in std_logic_vector(1 downto 0);
            sample_valid : in std_logic;

            DDS_FREQUENCY_OFFSET    : in std_logic_vector(4 downto 0);
            DDS_FREQUENCY_OFFSET_WE : in std_logic;
            DDS_INIT                : in std_logic;
            DDS_INIT_OVER           : out std_logic;

            OUTPUT_I    : out std_logic_vector(DDS_WIDTH+1 downto 0);
            OUTPUT_Q    : out std_logic_vector(DDS_WIDTH+1 downto 0);
            OUTPUT_VALID : out std_logic
        );
    end component;

    --------------------------------------------------------------------
    -- Constants
    --------------------------------------------------------------------
    constant SYSCLK_PERIOD : time := 10 ns; -- 100MHZ
    constant PRNCLK_PERIOD : time := 977.5171 ns; -- 1.023MHZ
    constant DDS_PERIOD : time := 100 ns; -- 10MHZ
    constant DDS_WIDTH : positive := 4;
    constant OUT_WIDTH : positive := DDS_WIDTH + 2;

    --------------------------------------------------------------------
    -- Clock and reset signals
    --------------------------------------------------------------------
    signal SYSCLK: std_logic := '0';
    signal DDS_CLK : std_logic := '0';
    signal SYSRESET : std_logic := '1';

    --------------------------------------------------------------------
    -- Input signals
    --------------------------------------------------------------------
    signal SAMPLE_VALID : std_logic;
    signal MAX_I_INPUT: std_logic_vector(1 downto 0);
    signal MAX_Q_INPUT: std_logic_vector(1 downto 0);

    --------------------------------------------------------------------
    -- Output signals
    --------------------------------------------------------------------
    signal ACQ_OUTPUT_I, ACQ_OUTPUT_Q : std_logic_vector(20 downto 0);

begin

    SYSRESET <= '0' after 400 ns;
    
    SYSCLK <= not SYSCLK after SYSCLK_PERIOD/2;
    DDS_CLK <= not DDS_CLK after DDS_PERIOD/2;

    U1: GNSS_Input_Chain
        generic map (
            DDS_WIDTH => DDS_WIDTH
        )
        port map (
            clk     => SYSCLK,
            DDS_clk => DDS_CLK,
            rst     => SYSRESET,

            MAX_INPUT_I => MAX_I_INPUT,
            MAX_INPUT_Q => MAX_Q_INPUT,
            sample_valid => SAMPLE_VALID,

            DDS_FREQUENCY_OFFSET    => "00000",
            DDS_FREQUENCY_OFFSET_WE => '0',
            DDS_INIT                => '0',
            DDS_INIT_OVER           => open,

            OUTPUT_I    => open,
            OUTPUT_Q    => open,
            OUTPUT_VALID => open
        );





end behavioral;