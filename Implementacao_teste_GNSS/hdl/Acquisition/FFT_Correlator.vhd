--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: FFT_Correlator.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFireSoC> <Die::MPFS025TL> <Package::FCVG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity FFT_Correlator is
generic(
    INPUT_WIDTH : positive := 8;
    FFT_TYPE    : positive := 0
);
port (
    -- digital inputs
	clk             : IN  std_logic;
    slw_clk         : IN  std_logic;
    NGRST           : IN  std_logic;
    in_valid        : IN  std_logic;
    out_read        : IN  std_logic;
    
    -- data inputs
    I1_IN           : IN  std_logic_vector(INPUT_WIDTH-1 downto 0);
    Q1_IN           : IN  std_logic_vector(INPUT_WIDTH-1 downto 0);
    I2_IN           : IN  std_logic_vector(INPUT_WIDTH-1 downto 0);
    Q2_IN           : IN  std_logic_vector(INPUT_WIDTH-1 downto 0);
    
    -- digital outputs
    in_buf_ready    : OUT std_logic;
    out_valid       : OUT std_logic;
    out_ready       : OUT std_logic;
    
    -- data output
    I_OUT           : OUT std_logic_vector(2*INPUT_WIDTH-1 downto 0);
    Q_OUT           : OUT std_logic_vector(2*INPUT_WIDTH-1 downto 0)
);
end FFT_Correlator;
architecture architecture_FFT_Correlator of FFT_Correlator is
   -- signal, component etc. declarations
	signal signal_name1 : std_logic; -- example
	signal signal_name2 : std_logic_vector(1 downto 0) ; -- example

    component COREFFT_C2 is -- In-Place FFT
    port(
        -- Inputs
        CLK         : in  std_logic;
        DATAI_IM    : in  std_logic_vector(FFT_Width-1 downto 0);
        DATAI_RE    : in  std_logic_vector(FFT_Width-1 downto 0);
        DATAI_VALID : in  std_logic;
        NGRST       : in  std_logic;
        READ_OUTP   : in  std_logic;
        SLOWCLK     : in  std_logic;
        -- Outputs
        BUF_READY   : out std_logic;
        DATAO_IM    : out std_logic_vector(FFT_Width-1 downto 0);
        DATAO_RE    : out std_logic_vector(FFT_Width-1 downto 0);
        DATAO_VALID : out std_logic;
        OUTP_READY  : out std_logic
    );
    end component;
    
    component Flip_Flop_D is
    port(	
        D:	in std_logic;
        rst:	in std_logic;
        clk:	in std_logic;
        Q:	out std_logic
    );
    end component;    
    
    component COREFFT_C4 is -- In-Place FFT
    port(
        -- Inputs
        CLK         : in  std_logic;
        DATAI_IM    : in  std_logic_vector(IFFT_Width-1 downto 0);
        DATAI_RE    : in  std_logic_vector(IFFT_Width-1 downto 0);
        DATAI_VALID : in  std_logic;
        NGRST       : in  std_logic;
        READ_OUTP   : in  std_logic;
        SLOWCLK     : in  std_logic;
        -- Outputs
        BUF_READY   : out std_logic;
        DATAO_IM    : out std_logic_vector(IFFT_Width-1 downto 0);
        DATAO_RE    : out std_logic_vector(IFFT_Width-1 downto 0);
        DATAO_VALID : out std_logic;
        OUTP_READY  : out std_logic
    );
    end component;

    component complex_multiplier_C0 is
    -- Port list
    port(
        --Inputs
        aimag_i  : in  std_logic_vector(FFT_Width-1 downto 0);
        areal_i  : in  std_logic_vector(FFT_Width-1 downto 0);
        bimag_i  : in  std_logic_vector(FFT_Width-1 downto 0);
        breal_i  : in  std_logic_vector(FFT_Width-1 downto 0);
        clock_i  : in  std_logic;
        nreset_i : in  std_logic;
        
        --Outputs
        cimag_o  : out std_logic_vector(IFFT_Width downto 0);
        creal_o  : out std_logic_vector(IFFT_Width downto 0)
    );
    end component;    
    
begin
   -- architecture body
       --FFT
    FFT_IQ : COREFFT_C2
	port map (
	    CLK         => clk,                -- clock de processamento
	    DATAI_IM    => Q1_IN, -- parte imaginaria (Q)
	    DATAI_RE    => I1_IN, -- parte real (I)
	    DATAI_VALID => in_valid,                -- sinaliza dados validos
	    READ_OUTP   => ReadPulse(0),                -- habilita leitura da saida
	    SLOWCLK     => slw_clk,      -- SLOWCLK
	    NGRST       => NRST,                -- reset ativo baixo (nao resetado)
	    BUF_READY   => InReady(0),               -- nao usado aqui
	    DATAO_IM    => FFT_Y_signal, -- saida imag
	    DATAO_RE    => FFT_X_signal, -- saida real
	    DATAO_VALID => open,               -- valido quando saida ativa
	    OUTP_READY  => OutReady(0)
	);
		
    FFT_CA: COREFFT_C2
	port map (
	    CLK         => clk,                -- clock de processamento
	    DATAI_IM    => Q_IN, -- parte imaginaria (Q)
	    DATAI_RE    => I2_IN, -- parte real (I)
	    DATAI_VALID => in_valid,                -- sinaliza dados validos
	    READ_OUTP   => ReadPulse(0),                -- habilita leitura da saida
	    SLOWCLK     => slw_clk,      -- SLOWCLK
	    NGRST       => NRST,                -- reset ativo baixo (nao resetado)
	    BUF_READY   => InReady(1),               -- nao usado aqui
	    DATAO_IM    => FFT_CA_out_imag, -- saida imag
	    DATAO_RE    => FFT_CA_out_real, -- saida real
	    DATAO_VALID => clkd(0),               -- valido quando saida ativa
	    OUTP_READY  => OutReady(1)
	);
    
    -- Correlação
    MULT5: complex_multiplier_C0 port map (FFT_Y_signal, FFT_X_signal, 
                    CA_CONJ_out_imag, FFT_CA_out_real, 
                    slw_clk, MULT_RST, 
                    IFFT_in_imag, IFFT_in_real); 
    
    CLK_MULT_D: for i in 0 to 2 generate
		delay_I: Flip_Flop_D port map(clkd(i),NRST, clk_div2, clkd(i+1)); -- ainda a ser verificado
	end generate;	
                                            
    IFFT: COREFFT_C4
	port map (
	    CLK         => clk,                -- clock de processamento
	    DATAI_IM    => IFFT_in_imag(IFFT_Width-1 downto 0), -- parte imaginaria (Q)
	    DATAI_RE    => IFFT_in_real(IFFT_Width-1 downto 0), -- parte real (I)
	    DATAI_VALID => clkd(3),                -- sinaliza dados validos
	    READ_OUTP   => ReadPulse(1),                -- habilita leitura da saida
	    SLOWCLK     => slw_clk_2,      -- SLOWCLK
	    NGRST       => NRST,                -- reset ativo baixo (nao resetado)
	    BUF_READY   => InReady(2),               -- nao usado aqui
	    DATAO_IM    => Q_OUT, -- saida imag
	    DATAO_RE    => I_OUT, -- saida real
	    DATAO_VALID => READ_OUT_V,               -- valido quando saida ativa
	    OUTP_READY  => out_ready
	);
   
end architecture_FFT_Correlator;
