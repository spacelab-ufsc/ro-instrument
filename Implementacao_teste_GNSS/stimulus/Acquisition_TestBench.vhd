----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Tue Sep 30 17:05:28 2025
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Acquisition_TestBench.vhd
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

entity Acquisition_TestBench is
end Acquisition_TestBench;

architecture behavioral of Acquisition_TestBench is

    constant SYSCLK_PERIOD : time := 100 ns; -- 10MHZ
    constant PRNCLK_PERIOD : time := 977.5171 ns; -- 10MHZ
    signal PRN_CLK : std_logic := '0';
    signal SYSCLK, SYSCLKL_2 : std_logic := '0';
    signal SYSRESET : std_logic := '1';
    signal CA_PRN, PRN_VALID : std_logic;
    signal MAX_I_INPUT: std_logic_vector(1 downto 0);
    signal ACQ_OUTPUT_I, ACQ_OUTPUT_Q : std_logic_vector(20 downto 0);
    signal pulso       : STD_LOGIC := '0';
    
    component Acquisition
        -- ports
        port( 
            -- Inputs
            CLK : in std_logic;
            CA_CLK : IN std_logic;
            RST : in std_logic;
            MAX_INPUT_I : in std_logic_vector(1 downto 0);
            MAX_INPUT_Q : in std_logic_vector(1 downto 0);
            MAX_INPUT_CLK : in std_logic;
            READ_OUT : in std_logic;

            -- Outputs
            READ_OUT_V : out std_logic;
            OUT_I : out std_logic_vector(20 downto 0);
            OUT_Q : out std_logic_vector(20 downto 0)

            -- Inouts

        );
    end component;

    component L1_CA_generator is
	Port (
			clk : in std_logic;
			rst	: in std_logic;		
			PRN : out std_logic;			
			ENABLE : in std_logic;
			valid_out : out std_logic;
			epoch : out std_logic;
			epoch_advce : out std_logic;
			SAT : in integer range 0 to 31 -- 32 GPS
		);
    end component;
    
    
begin

    SYSRESET <= '1','0' after 4 us;		-- gera o sinal de resetprocess

    -- Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );
    SYSCLKL_2 <= not SYSCLKL_2 after (SYSCLK_PERIOD*2.0 );
    PRN_CLK <= not PRN_CLK after (PRNCLK_PERIOD / 2.0 );

    
    -- Entrada do sinal
    PRN_INPUT_0: L1_CA_generator
	Port map (
			clk => PRN_CLK,
			rst	=> SYSRESET,
			PRN => CA_PRN,		
			ENABLE => '1',
			valid_out => open,
			epoch => open,
			epoch_advce => open,
			SAT => 0
		);
    
    -- Instantiate Unit Under Test:  Acquisition
    Acquisition_0 : Acquisition
        -- port map
        port map( 
            -- Inputs
            CLK => SYSCLK,
            CA_CLK => PRN_CLK,
            RST => SYSRESET,
            MAX_INPUT_I => MAX_I_INPUT,
            MAX_INPUT_Q => (others=> '0'),
            MAX_INPUT_CLK => PRN_VALID,
            READ_OUT => SYSCLKL_2,

            -- Outputs
            READ_OUT_V =>  open,
            OUT_I => ACQ_OUTPUT_I,
            OUT_Q => ACQ_OUTPUT_Q

            -- Inouts

        );
        
        MAX_I_INPUT <= CA_PRN & '1';
        pulso <= not pulso after (200 ns);
        
        process (pulso, PRN_VALID) is
            variable previous_pulse : std_logic := '0';
        begin
            if pulso'event then
                if pulso = '1' and previous_pulse = '0' then
                    PRN_VALID <= '1';
                    previous_pulse := '1';
                elsif pulso = '1' and previous_pulse = '1' then
                    PRN_VALID <= '0';
                else
                    PRN_VALID <= '0';
                    previous_pulse := '0';
                end if;
            end if;
        end process;

end behavioral;

