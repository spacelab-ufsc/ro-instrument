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
--      Ver 0.0.1: 11/08/2026
-- Description: 
--
-- Testbench for DLL_Discriminator module. It generates a PRN signal and feeds it to the DLL module, while also providing clock and reset signals. The testbench monitors the output of the DLL module to verify its functionality.
--
-- Targeted device: <Family::PolarFireSoC> <Die::MPFS025T> <Package::FCSG325>
-- Author: Renato Augusto Schenkel Meneghin Marchiori
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
    
    component Code_Discriminator is
    generic (
        DATA_WIDTH : integer := 32
    );
    port (
        clk         : in std_logic;
        rst         : in std_logic;
        start       : in std_logic;
        disc_sel    : in std_logic_vector(1 downto 0);

        ------------------------------------------------------------------
        -- Correlator inputs (signed, two's complement)
        ------------------------------------------------------------------
        IE : in std_logic_vector(DATA_WIDTH-1 downto 0);
        QE : in std_logic_vector(DATA_WIDTH-1 downto 0);

        IL : in std_logic_vector(DATA_WIDTH-1 downto 0);
        QL : in std_logic_vector(DATA_WIDTH-1 downto 0);

        IP : in std_logic_vector(DATA_WIDTH-1 downto 0);
        QP : in std_logic_vector(DATA_WIDTH-1 downto 0);

        ------------------------------------------------------------------
        -- Output
        ------------------------------------------------------------------
        err_out : out std_logic_vector(2*DATA_WIDTH downto 0);
        done    : out std_logic
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

