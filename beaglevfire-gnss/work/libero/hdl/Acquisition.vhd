--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Acquisition.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFire> <Die::MPF050T> <Package::FCSG325>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity Acquisition is
port (
    --<port_name> : <direction> <type>;
	CLK             : IN  std_logic; -- example
    CA_CLK          : IN std_logic;
    RST             : IN    std_logic;
	MAX_INPUT_I     : IN  std_logic_vector(1 downto 0); -- MAX INPUT IN PHASE SIGNAL
    MAX_INPUT_Q     : IN  std_logic_vector(1 downto 0); -- MAX INPUT QUADRATURE SIGNAL
    MAX_INPUT_CLK   : IN  std_logic; -- MAX INPUT CLOCK
    READ_OUT        : IN  std_logic; -- READ  OUTPUT
    READ_OUT_V      : OUT  std_logic; -- VALID OUTPUT
    OUT_I           : OUT  std_logic_vector(31 downto 0); -- OUTPUT REAL PART
    OUT_Q           : OUT  std_logic_vector(31 downto 0) -- OUTPUT IMAG PART
);
end Acquisition;

architecture architecture_Acquisition of Acquisition is
    -- signal, component etc. declarations
    constant Contador_WIDTH     : integer := 9;
    constant DDS_Width          : integer := 13; -- Datawidth of the DDS
    constant FFT_Width          : integer := 16; -- Datawidth before the fft
    constant IFFT_Width         : integer := 32; -- Datawidth before the ifft
    
    -- slower clk
    signal clk_div2, slw_clk, slw_clk_2 : std_logic;
    signal NRST, MULT_RST, MULT_RST_IN, count_bit_d1, count_bit_d2, ca_rst_pulse  : std_logic;
    signal clkd, clkd2 : std_logic_vector(3 downto 0);
    -- Controle do processo
    signal count_state  : std_logic_vector(Contador_WIDTH-1 downto 0); -- example
	signal Frequency_offset_data : std_logic_vector(Contador_WIDTH-6 downto 0); -- example
    signal OutReady, InReady, I_MAX_IN, Q_MAX_IN : std_logic_vector(2 downto 0);
    signal ReadPulse : std_logic_vector (1 downto 0);
    -- Entrada do sinal 
    signal cos_signal, sin_signal : std_logic_vector(DDS_Width-1 downto 0) ; -- example
	signal FFT_I_signal, FFT_Q_signal : std_logic_vector(FFT_Width downto 0);
    signal FFT_X_signal, FFT_Y_signal : std_logic_vector(FFT_Width-1 downto 0); -- example
    
    -- Replica sinal C/A
    signal ca_prn, CA_RST, Read_data : std_logic;
    signal counter_clk : std_logic;
    signal sat_int: integer range 0 to 31; -- 32 GPS
    signal FFT_CA_in_real, FFT_CA_in_imag : std_logic_vector (FFT_Width-1 downto 0); 
    signal FFT_CA_out_real , FFT_CA_out_imag : std_logic_vector (FFT_Width-1 downto 0); 
    signal CA_CONJ_out_imag : std_logic_vector (FFT_Width-1 downto 0); 
    
    -- Sinais transformados
    signal IFFT_in_imag, IFFT_in_real : std_logic_vector (IFFT_Width downto 0); 
    signal IFFT_o_imag, IFFT_o_real : std_logic_vector (IFFT_Width-1 downto 0); 
    
    component Flip_Flop_D is
    port(	
        D:	in std_logic;
        rst:	in std_logic;
        clk:	in std_logic;
        Q:	out std_logic
    );
    end component;
    
    component Multiplier_simplified is
    generic(
        data_width : integer := 12
    );
    port(
        -- 	Bit_Vector Inputs
        A :	in std_logic_vector(data_width-1 downto 0);
        B :	in std_logic_vector(1 downto 0);

        --	Bit_Vector Outputs
        S :	out std_logic_vector(data_width downto 0)
    );
    end component;
    
    component UAL is
    generic(
        data_width : integer := 64
    );
    port(	
        A:	in std_logic_vector(data_width-1 downto 0);
        B:	in std_logic_vector(data_width-1 downto 0);
        Cin:	in std_logic;

        S:	out std_logic_vector(data_width-1 downto 0);
        Cout:	out std_logic
    );
    end component;
    
    component contador is
    generic(
        data_width : integer := 6
    );
    port(	
        clk: 	in std_logic;
        init:	in std_logic;
        count:	out std_logic_vector(data_width-1 downto 0)
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

    -- architecture body
    -- Divisor de clock
    DIV2_CLK: PF_CLK_DIV_C3 port map(CLK_IN => clk, CLK_OUT => clk_div2);
    DIV8_CLK: PF_CLK_DIV_C4 port map(CLK_IN => clk_div2, CLK_OUT => slw_clk);
    DIV16_CLK: PF_CLK_DIV_C5 port map(CLK_IN => slw_clk, CLK_OUT => slw_clk_2);
        
    -- DDS e contador 
    SINE_GENERATOR: entity work.COREDDS_C0 
    port map (
        CLK            => CLK,
        FREQ_OFFSET    => Frequency_offset_data, 
        FREQ_OFFSET_WE => '1',
        INIT           => '0',
        NGRST          => NRST,
        RSTN           => '1',
        COSINE         => cos_signal,
        INIT_OVER      => open,
        SINE           => sin_signal
    );
    
    CONTADOR_ESTADO: contador generic map (Contador_WIDTH) port map(counter_clk, RST, count_state);
    
    -- Entrada
    I_MAX_IN <= "001" when MAX_INPUT_I = "00" else
                "010" when MAX_INPUT_I = "01" else
                "111" when MAX_INPUT_I = "10" else
                "110";
    Q_MAX_IN <= "001" when MAX_INPUT_Q = "00" else
                "010" when MAX_INPUT_Q = "01" else
                "111" when MAX_INPUT_Q = "10" else
                "110";
                
    MULT_IN: entity work.complex_multiplier_C2 
    port map (
        aimag_i => sin_signal, 
        areal_i => cos_signal, 
        bimag_i => Q_MAX_IN, 
        breal_i => I_MAX_IN, 
        clock_i => clk, 
        nreset_i => MULT_RST_IN, 
        cimag_o => FFT_Q_signal, 
        creal_o => FFT_I_signal
    );
    
    clkd2(0) <= InReady(0) and InReady(1) and MAX_INPUT_CLK;
    CLK_MULT_D2: for i in 0 to 2 generate
		delay_II: Flip_Flop_D port map(clkd2(i),NRST, clk, clkd2(i+1)); -- ainda a ser verificado
	end generate;
    -- CÃ³digo CA
	CA_CODE: entity work.L1_CA_generator 
    port map(
        clk        => CA_CLK,
        rst        => CA_RST,
        PRN        => CA_PRN,
        ENABLE     => '1',
        valid_out  => open,
        epoch      => open,
        epoch_advce => open,
        SAT        => SAT_int
    );
       
    FFT_CA_in_real(1 downto 0) <= "10";
    FFT_CA_in_real(FFT_Width-1 downto 2) <= (others => CA_PRN);
    FFT_CA_in_imag(FFT_Width-1 downto 0) <= (others => '0');
    
    --FFT
    FFT_IQ : entity work.COREFFT_C2
	port map (
	    CLK         => CLK,                -- clock de processamento
	    DATAI_IM    => FFT_Q_signal(FFT_Width-1 downto 0), -- parte imaginaria (Q)
	    DATAI_RE    => FFT_I_signal(FFT_Width-1 downto 0), -- parte real (I)
	    DATAI_VALID => Read_data,                -- sinaliza dados validos
	    READ_OUTP   => ReadPulse(0),                -- habilita leitura da saida
	    SLOWCLK     => slw_clk,      -- SLOWCLK
	    NGRST       => NRST,                -- reset ativo baixo (nao resetado)
	    BUF_READY   => InReady(0),               -- nao usado aqui
	    DATAO_IM    => FFT_Y_signal, -- saida imag
	    DATAO_RE    => FFT_X_signal, -- saida real
	    DATAO_VALID => open,               -- valido quando saida ativa
	    OUTP_READY  => OutReady(0)
	);
		
    FFT_CA: entity work.COREFFT_C3
	port map (
	    CLK         => CLK,                -- clock de processamento
	    DATAI_IM    => FFT_CA_in_imag(FFT_Width-1 downto 0), -- parte imaginaria (Q)
	    DATAI_RE    => FFT_CA_in_real(FFT_Width-1 downto 0), -- parte real (I)
	    DATAI_VALID => Read_data,                -- sinaliza dados validos
	    READ_OUTP   => ReadPulse(0),                -- habilita leitura da saida
	    SLOWCLK     => slw_clk,      -- SLOWCLK
	    NGRST       => NRST,                -- reset ativo baixo (nao resetado)
	    BUF_READY   => InReady(1),               -- nao usado aqui
	    DATAO_IM    => FFT_CA_out_imag, -- saida imag
	    DATAO_RE    => FFT_CA_out_real, -- saida real
	    DATAO_VALID => clkd(0),               -- valido quando saida ativa
	    OUTP_READY  => OutReady(1)
	);
    
    -- CorrelaÃ§Ã£o
    MULT5: entity work.complex_multiplier_C0 
        port map (
        aimag_i => FFT_Y_signal, 
        areal_i => FFT_X_signal, 
        bimag_i => CA_CONJ_out_imag, 
        breal_i => FFT_CA_out_real, 
        clock_i => slw_clk, 
        nreset_i => MULT_RST, 
        cimag_o => IFFT_in_imag, 
        creal_o => IFFT_in_real
    ); -- Verificar
    
    CLK_MULT_D: for i in 0 to 2 generate
		delay_I: Flip_Flop_D port map(clkd(i),NRST, clk_div2, clkd(i+1)); -- ainda a ser verificado
	end generate;	
                                            
    IFFT: entity work.COREFFT_C4
	port map (
	    CLK         => clk_div2,                -- clock de processamento
	    DATAI_IM    => IFFT_in_imag(IFFT_Width-1 downto 0), -- parte imaginaria (Q)
	    DATAI_RE    => IFFT_in_real(IFFT_Width-1 downto 0), -- parte real (I)
	    DATAI_VALID => clkd(3),                -- sinaliza dados validos
	    READ_OUTP   => ReadPulse(1),                -- habilita leitura da saida
	    SLOWCLK     => slw_clk_2,      -- SLOWCLK
	    NGRST       => NRST,                -- reset ativo baixo (nao resetado)
	    BUF_READY   => InReady(2),               -- nao usado aqui
	    DATAO_IM    => IFFT_o_imag, -- saida imag
	    DATAO_RE    => IFFT_o_real, -- saida real
	    DATAO_VALID => READ_OUT_V,               -- valido quando saida ativa
	    OUTP_READY  => OutReady(2)
	);
    
    CA_CONJ: entity work.Negative_Integer generic map(data_width => FFT_Width) 
                port map(SIG_IN  => FFT_CA_out_imag, SIG_OUT => CA_CONJ_out_imag);
    
    SAT_int <= to_integer(unsigned(count_state(Contador_WIDTH-1 downto Contador_WIDTH-5)));
    
    Frequency_offset_data <= count_state(Contador_WIDTH-6 downto 0);
    NRST <= not (RST);
    Read_data <= clkd2(3);
    MULT_RST <= NRST and ((OutReady(0) and OutReady(1)) or clkd(3) or clkd(1));
    MULT_RST_IN <= NRST and InReady(0) and InReady(1);
    ReadPulse(0) <= OutReady(0) and OutReady(1) and slw_clk and InReady(2);
    ReadPulse(1) <= OutReady(2) and READ_OUT;
    counter_clk  <= OutReady(0);
    
    process(CLK, RST, count_state, count_bit_d1, count_bit_d2, ca_rst_pulse)
    begin
        if RST = '1' then
            ca_rst_pulse       <= '1';
            count_bit_d1 <= '0';
            count_bit_d2 <= '0';
        elsif CLK'event and clk = '1' then
            count_bit_d1 <= count_state(Contador_WIDTH-5);
            count_bit_d2 <= count_bit_d1;
            -- Detecta mudança no bit monitorado
            if count_state(Contador_WIDTH-5) xor count_bit_d2 then
                ca_rst_pulse  <= '1';
            else
                ca_rst_pulse  <= '0';
            end if;
        end if;
end process;
    
    CA_RST <= ca_rst_pulse;
    OUT_I               <=  IFFT_o_real;
    OUT_Q               <=  IFFT_o_imag;
end architecture_Acquisition;