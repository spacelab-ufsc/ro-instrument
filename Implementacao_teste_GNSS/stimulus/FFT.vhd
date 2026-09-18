----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Sun Sep 13 22:19:31 2026
-- Testbench Template
-- This is a basic testbench that instantiates your design with basic 
-- clock and reset pins connected.  If your design has special
-- clock/reset or testbench driver requirements then you should 
-- copy this file and modify it. 
----------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: FFT.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFireSoC> <Die::MPFS025T> <Package::FCVG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FFT is
end FFT;

architecture behavioral of FFT is

    constant SYSCLK_PERIOD  : time := 10 ns; -- 100MHZ
    constant dataperiod     : time := 1 us;
    
    constant DDS_IN_WIDTH   : positive := 4;
    constant DDS_OUT_WIDTH  : positive := 5;

    --------------------------------------------------------------------
    -- Clock and reset signals
    --------------------------------------------------------------------
    signal SYSCLK       : std_logic := '0';
    signal NGRST        : std_logic := '0';
    signal SYSRESET     : std_logic := '0';
    signal readData     : std_logic := '0';
    signal readpulse    : std_logic := '0';
    signal slwclk       : std_logic := '0';
    signal inready      : std_logic := '0';
    signal outready     : std_logic := '0';

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
    signal FFT_IN_RE,  FFT_IN_IM        : std_logic_vector(7 downto 0);
    signal FFT_OUT_RE, FFT_OUT_IM       : std_logic_vector(7 downto 0);
    
    
    component DDS_PNFreq
        -- ports
        port( 
            -- Inputs
            CLK : in std_logic;
            FREQ_OFFSET : in std_logic_vector(4 downto 0);
            NGRST : in std_logic;
            RSTN : in std_logic;
            PN_SIN : in std_logic;

            -- Outputs
            COSINE : out std_logic_vector(3 downto 0);
            SINE : out std_logic_vector(3 downto 0)

            -- Inouts

        );
    end component;
    
    component COREFFT_C2 is -- In-Place FFT
    port(
        -- Inputs
        CLK         : in  std_logic;
        DATAI_IM    : in  std_logic_vector(7 downto 0);
        DATAI_RE    : in  std_logic_vector(7 downto 0);
        DATAI_VALID : in  std_logic;
        NGRST       : in  std_logic;
        READ_OUTP   : in  std_logic;
        SLOWCLK     : in  std_logic;
        -- Outputs
        BUF_READY   : out std_logic;
        DATAO_IM    : out std_logic_vector(7 downto 0);
        DATAO_RE    : out std_logic_vector(7 downto 0);
        DATAO_VALID : out std_logic;
        OUTP_READY  : out std_logic
    );
    end component;

begin
    
    SYSRESET <= '1' after 400 ns;

    process
        variable vhdl_initial : BOOLEAN := TRUE;

    begin
        if ( vhdl_initial ) then
            -- Assert Reset
            NGRST <= '0';
            wait for ( SYSCLK_PERIOD * 10 );
            
            NGRST <= '1';
            wait;
        end if;
    end process;

    -- Clock Driver
    SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );
    slwclk <= not slwclk after (SYSCLK_PERIOD * 4.0 );
    readData <= not readData after (dataperiod);
    slwclk <= not slwclk after (SYSCLK_PERIOD * 4.0 );

    U1: DDS_PNFreq
        port map (
            -- Inputs
            CLK            => SYSCLK,
            FREQ_OFFSET    => "0100",
            NGRST          => NGRST,
            RSTN           => SYSRESET,
            PN_SIN         => '0',
            -- Outputs
            COSINE         => cos_signal,
            SINE           => sin_signal
        );
        
    --FFT
    FFT_IQ : COREFFT_C2
	port map (
	    CLK         => SYSCLK,                -- clock de processamento
	    DATAI_IM    => FFT_IN_IM, -- parte imaginaria (Q)
	    DATAI_RE    => FFT_IN_RE, -- parte real (I)
	    DATAI_VALID => readData,                -- sinaliza dados validos
	    READ_OUTP   => '1',                -- habilita leitura da saida
	    SLOWCLK     => slwclk,      -- SLOWCLK
	    NGRST       => SYSRESET,                -- reset ativo baixo (nao resetado)
	    BUF_READY   => InReady,               -- nao usado aqui
	    DATAO_IM    => FFT_OUT_IM, -- saida imag
	    DATAO_RE    => FFT_OUT_RE, -- saida real
	    DATAO_VALID => open,               -- valido quando saida ativa
	    OUTP_READY  => OutReady
	);

end behavioral;

