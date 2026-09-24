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
    NGRST           : IN  std_logic;
    in_valid        : IN  std_logic;
    read_out        : IN  std_logic;
    
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
	
    -- control signals
    signal slw_clk      : std_logic; 
    signal MULT_RST     : std_logic;
    signal READ_DATA    : std_logic;
    signal clkd         : std_logic_vector(3 downto 0);
    signal ReadPulse    : std_logic_vector(1 downto 0);
    signal OutReady     : std_logic_vector(2 downto 0);
    signal InReady      : std_logic_vector(2 downto 0);
    
    -----------------------------------------
    -- correlation signals
    -----------------------------------------
    signal  IX1, QX1, 
            IX2, QX2, QX2n      : std_logic_vector(INPUT_WIDTH-1 downto 0);
    signal  IM, QM              : std_logic_vector(2*INPUT_WIDTH downto 0);
    signal  IY, QY              : std_logic_vector(2*INPUT_WIDTH-1 downto 0);
    
    
	signal signal_name2 : std_logic_vector(1 downto 0) ; -- example

    component COREFFT_C2 is -- In-Place FFT
    port(
        -- Inputs
        CLK         : in  std_logic;
        DATAI_IM    : in  std_logic_vector(INPUT_WIDTH-1 downto 0);
        DATAI_RE    : in  std_logic_vector(INPUT_WIDTH-1 downto 0);
        DATAI_VALID : in  std_logic;
        NGRST       : in  std_logic;
        READ_OUTP   : in  std_logic;
        SLOWCLK     : in  std_logic;
        -- Outputs
        BUF_READY   : out std_logic;
        DATAO_IM    : out std_logic_vector(INPUT_WIDTH-1 downto 0);
        DATAO_RE    : out std_logic_vector(INPUT_WIDTH-1 downto 0);
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
    
    component Freq_divider
        generic (
            DIV : positive :=  1
        );
        port (
            clk_in      : IN  std_logic; 
            rstn        : IN  std_logic; 
            clk_out     : out std_logic
        );
    end component;
    
    component COREFFT_C4 is -- In-Place FFT
    port(
        -- Inputs
        CLK         : in  std_logic;
        DATAI_IM    : in  std_logic_vector(2*INPUT_WIDTH-1 downto 0);
        DATAI_RE    : in  std_logic_vector(2*INPUT_WIDTH-1 downto 0);
        DATAI_VALID : in  std_logic;
        NGRST       : in  std_logic;
        READ_OUTP   : in  std_logic;
        SLOWCLK     : in  std_logic;
        -- Outputs
        BUF_READY   : out std_logic;
        DATAO_IM    : out std_logic_vector(2*INPUT_WIDTH-1 downto 0);
        DATAO_RE    : out std_logic_vector(2*INPUT_WIDTH-1 downto 0);
        DATAO_VALID : out std_logic;
        OUTP_READY  : out std_logic
    );
    end component;

    component complex_multiplier_C0 is
    -- Port list
    port(
        --Inputs
        aimag_i  : in  std_logic_vector(INPUT_WIDTH-1 downto 0);
        areal_i  : in  std_logic_vector(INPUT_WIDTH-1 downto 0);
        bimag_i  : in  std_logic_vector(INPUT_WIDTH-1 downto 0);
        breal_i  : in  std_logic_vector(INPUT_WIDTH-1 downto 0);
        clock_i  : in  std_logic;
        nreset_i : in  std_logic;
        
        --Outputs
        cimag_o  : out std_logic_vector(2*INPUT_WIDTH downto 0);
        creal_o  : out std_logic_vector(2*INPUT_WIDTH downto 0)
    );
    end component;    
    
begin
   -- architecture body
    SLW_CLK_U: Freq_divider 
        generic map (DIV => 8)
        port map(clk, NGRST, slw_clk);    
 
 --FFT
    FFT_IQ : COREFFT_C2
	port map (
	    CLK         => clk,                -- clock de processamento
	    DATAI_IM    => Q1_IN, -- parte imaginaria (Q)
	    DATAI_RE    => I1_IN, -- parte real (I)
	    DATAI_VALID => READ_DATA,                -- sinaliza dados validos
	    READ_OUTP   => ReadPulse(0),                -- habilita leitura da saida
	    SLOWCLK     => slw_clk,      -- SLOWCLK
	    NGRST       => NGRST,                -- reset ativo baixo (nao resetado)
	    BUF_READY   => InReady(0),               -- nao usado aqui
	    DATAO_IM    => QX1, -- saida imag
	    DATAO_RE    => IX1, -- saida real
	    DATAO_VALID => open,               -- valido quando saida ativa
	    OUTP_READY  => OutReady(0)
	);
		
    FFT_CA: COREFFT_C2
	port map (
	    CLK         => clk,                -- clock de processamento
	    DATAI_IM    => Q2_IN, -- parte imaginaria (Q)
	    DATAI_RE    => I2_IN, -- parte real (I)
	    DATAI_VALID => READ_DATA,                -- sinaliza dados validos
	    READ_OUTP   => ReadPulse(0),                -- habilita leitura da saida
	    SLOWCLK     => slw_clk,      -- SLOWCLK
	    NGRST       => NGRST,                -- reset ativo baixo (nao resetado)
	    BUF_READY   => InReady(1),               -- nao usado aqui
	    DATAO_IM    => QX2, -- saida imag
	    DATAO_RE    => IX2, -- saida real
	    DATAO_VALID => clkd(0),               -- valido quando saida ativa
	    OUTP_READY  => OutReady(1)
	);
    
    CA_CONJ: entity work.Negative_Integer generic map(data_width => FFT_Width) 
        port map(SIG_IN  => QX2, SIG_OUT => QX2n);
    
    -- Correlação
    MULT5: complex_multiplier_C0 port map (
            aimag_i     => QX1,     areal_i     => IX1, 
            bimag_i     => QX2n,    breal_i     => IX2, 
            clock_i     => clk,     nreset_i    => MULT_RST, 
            cimag_o     => QM,      creal_o     => IM
            ); 
                    
    CLK_MULT_D: for i in 0 to 2 generate
		delay_I: Flip_Flop_D port map(clkd(i),NGRST, clk, clkd(i+1)); -- ainda a ser verificado
	end generate;	
    
    QY <= QM(2*INPUT_WIDTH-1 downto 0);
    IY <= IM(2*INPUT_WIDTH-1 downto 0);
                                            
    IFFT: COREFFT_C4
	port map (
	    CLK         => clk,     -- clock de processamento
	    DATAI_IM    => QY,      -- parte imaginaria (Q)
	    DATAI_RE    => IY,      -- parte real (I)
	    DATAI_VALID => clkd(3), -- sinaliza dados validos
	    READ_OUTP   => ReadPulse(1),                -- habilita leitura da saida
	    SLOWCLK     => slw_clk, -- SLOWCLK
	    NGRST       => NGRST,   -- reset ativo baixo (nao resetado)
	    BUF_READY   => InReady(2),               -- nao usado aqui
	    DATAO_IM    => Q_OUT, -- saida imag
	    DATAO_RE    => I_OUT, -- saida real
	    DATAO_VALID => out_valid,               -- valido quando saida ativa
	    OUTP_READY  => OutReady(2)
	);
    
    -- Control signals
    Read_data <= InReady(0) and InReady(1) and in_valid;
    
    MULT_RST <= NGRST and ((OutReady(0) and OutReady(1)) or clkd(3) or clkd(1));
    
    ReadPulse(0) <= OutReady(0) and OutReady(1) and InReady(2);
    ReadPulse(1) <= OutReady(2) and READ_OUT;
    out_ready    <= OutReady(2);
   
end architecture_FFT_Correlator;
