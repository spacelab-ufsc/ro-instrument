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

entity DDS_PNFreq_tb is
end DDS_PNFreq_tb;

architecture behavioral of DDS_PNFreq_tb is

    component DDS_PNFreq is
    -- Port list
    port(
        -- Inputs
        CLK            : in  std_logic;
        FREQ_OFFSET    : in  std_logic_vector(3 downto 0);
        NGRST          : in  std_logic;
        RSTN           : in  std_logic;
        PN_SIN         : in  std_logic;
        -- Outputs
        COSINE         : out std_logic_vector(4 downto 0);
        SINE           : out std_logic_vector(4 downto 0)
    );
    end component;

    --------------------------------------------------------------------
    -- Constants
    --------------------------------------------------------------------
    constant SYSCLK_PERIOD  : time := 10 ns; -- 100MHZ
    constant DDS_PERIOD     : time := 100 ns; -- 10MHZ
    constant PRNCLK_PERIOD : time := 977.5171 ns; -- 1.023MHZ
    constant DDS_IN_WIDTH   : positive := 4;
    constant DDS_OUT_WIDTH  : positive := 5;

    --------------------------------------------------------------------
    -- Clock and reset signals
    --------------------------------------------------------------------
    signal SYSCLK   : std_logic := '0';
    signal NGRST    : std_logic := '0';
    signal PRNCLK   : std_logic := '0';
    signal SYSRESET : std_logic := '0';

    --------------------------------------------------------------------
    -- Input signals
    --------------------------------------------------------------------
    signal PN_SIN_SELECT    : std_logic;
    signal Freq_counter     : std_logic_vector(4 downto 0);

    --------------------------------------------------------------------
    -- Output signals
    --------------------------------------------------------------------
    signal cos_signal       : std_logic_vector(4 downto 0);
    signal sin_signal       : std_logic_vector(4 downto 0);

begin

    SYSRESET <= '1' after 400 ns;
    
    SYSCLK <= not SYSCLK after SYSCLK_PERIOD/2;
    PRNCLK <= not PRNCLK after PRNCLK_PERIOD/2;

    U1: DDS_PNFreq
        port map (
            -- Inputs
            CLK            => SYSCLK,
            FREQ_OFFSET    => Freq_counter(3 downto 0),
            NGRST          => NGRST,
            RSTN           => SYSRESET,
            PN_SIN         => Freq_counter(4),
            -- Outputs
            COSINE         => cos_signal,
            SINE           => sin_signal
        );


    NGRST_Process : process(SYSRESET, NGRST, SYSCLK)
        variable prev_NGRST : std_logic := '0';
    begin
        if SYSRESET = '0' then
            Freq_counter <= (others => '0');
            NGRST <= '0';
            prev_NGRST := '0';
        elsif rising_edge(SYSCLK) then
            prev_NGRST := NGRST;
            Freq_counter <= std_logic_vector(unsigned(Freq_counter) + 1);
            if rising_edge(PRNCLK) then
                NGRST <= '1';
            else
                NGRST <= '0';
            end if;
        end if;
    end process;


end behavioral;