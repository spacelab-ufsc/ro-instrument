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

entity Acquisition_V3 is
port (
    --<port_name> : <direction> <type>;
	CLK             : IN  std_logic; -- example
    CA_CLK          : IN  std_logic;
    NRST            : IN  std_logic;
	MAX_INPUT_I     : IN  std_logic_vector(1 downto 0); -- MAX INPUT IN PHASE SIGNAL
    MAX_INPUT_Q     : IN  std_logic_vector(1 downto 0); -- MAX INPUT QUADRATURE SIGNAL
    MAX_INPUT_CLK   : IN  std_logic; -- MAX INPUT CLOCK    
    OUT_DATA_READY  : OUT std_logic;
    ABS_OUT_DATA    : OUT std_logic_vector(31 downto 0);
    F_Doppler_DATA  : OUT std_logic_vector(4 downto 0);
    SAT_ID_DATA_O   : OUT std_logic_vector(4 downto 0);
    CODE_DELAY_DATA : OUT std_logic_vector(15 downto 0)
);
end Acquisition_V3;

architecture architecture_AcquisitionV3 of Acquisition_V3 is
    -- signal, component etc. declarations
    constant Contador_WIDTH     : integer := 10;
    constant DDS_Width          : integer := 5; -- Datawidth of the DDS
    constant FFT_Width          : integer := 8; -- Datawidth before the fft
    constant IFFT_Width         : integer := 16; -- Datawidth before the ifft
    
    -- Control signals
    signal doppler_dir      : std_logic;
    signal ACQ_OUT_VALID    : std_logic;
    signal count_bit_d1     : std_logic;
    signal count_bit_d2     : std_logic;
    signal ca_rst_pulse     : std_logic;
    signal CORR_OUT_READY   : std_logic;
    signal CORR_OUT_VALID   : std_logic;
    
    -- Controle do processo
    signal count_state              : std_logic_vector(Contador_WIDTH-1 downto 0); 
	signal Frequency_offset_data    : std_logic_vector(Contador_WIDTH-6 downto 0); 
    signal FDoppler_Delay           : std_logic_vector(Contador_WIDTH-6 downto 0); 
    signal DDS_Frequency            : std_logic_vector(Contador_WIDTH-7 downto 0);
    
    -- Fluxo do sinal GNSS
	signal FFT_I_signal     : std_logic_vector(FFT_Width-1 downto 0);
    signal FFT_Q_signal     : std_logic_vector(FFT_Width-1 downto 0);
	signal FFT_CA_in_real   : std_logic_vector(FFT_Width-1 downto 0);
    signal FFT_CA_in_imag   : std_logic_vector(FFT_Width-1 downto 0);
	signal IFFT_I_signal    : std_logic_vector(IFFT_Width-1 downto 0);
    signal IFFT_Q_signal    : std_logic_vector(IFFT_Width-1 downto 0);
    
    -- Replica sinal C/A
    signal ca_prn           : std_logic;
    signal CA_RST           : std_logic;
    signal DDS_RSTN         : std_logic;
    signal counter_clk      : std_logic;
    signal sat_int          : integer range 0 to 31; -- 32 GPS
    signal SAT_ID_Delay     : std_logic_vector(4 downto 0); -- 32 GPS
    
    component GNSS_Input_Chain
    generic (
        -- COREDDS_C0 in the current Libero project has eight-bit outputs.
        DDS_WIDTH       : positive  := 4;
        FREQ_OFFSET_W   : positive  := 4;
        OUT_Width       : natural   := 8
    );
    port (
        -- Clock and reset. Reset is synchronous and active high for registers.
        clk     : in std_logic;
        DDS_clk : in std_logic;
        DDS_rst : in std_logic;
        rst     : in std_logic;

        -- Raw two-bit I/Q samples from MAX2771.
        -- Encoding expected by Multiplier_simplified:
        --   bit 1 = sign, bit 0 = enable/high-amplitude indication.
        MAX_INPUT_I : in std_logic_vector(1 downto 0);
        MAX_INPUT_Q : in std_logic_vector(1 downto 0);
        sample_valid : in std_logic;

        -- Runtime frequency correction of the Libero DDS.
        DDS_FREQUENCY_OFFSET    : in std_logic_vector(3 downto 0);
        DDS_FREQUENCY_PN : in std_logic;

        -- Registered complex baseband sample for the following block.
        -- Each simplified product has DDS_WIDTH+1 bits. 
        OUTPUT_I    : out std_logic_vector(OUT_Width-1 downto 0);
        OUTPUT_Q    : out std_logic_vector(OUT_Width-1 downto 0);
        OUTPUT_VALID : out std_logic
    );
    end component;
    
    component FFT_Correlator
    generic(
        INPUT_WIDTH : positive := 8
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
        out_fft_valid   : OUT std_logic;
        out_valid       : OUT std_logic;
        out_ready       : OUT std_logic;
        
        -- data output
        I_OUT           : OUT std_logic_vector(2*INPUT_WIDTH-1 downto 0);
        Q_OUT           : OUT std_logic_vector(2*INPUT_WIDTH-1 downto 0)
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
    
    component Acquisition_Detection
    port (
        CLK             : IN  std_logic; 
        NRST            : IN  std_logic;       
        START_Cycle     : IN  std_logic; 
        -- INPUT data
        VALID_IN        : IN std_logic;
        X_IN            : IN std_logic_vector(15 downto 0);
        Y_IN            : IN std_logic_vector(15 downto 0);
        F_Doppler_IN    : IN std_logic_vector(4 downto 0);
        SAT_ID_IN       : IN std_logic_vector(4 downto 0);
        --OUTPUT DATA
        VALID_OUT       : OUT std_logic;
        A_OUT           : OUT std_logic_vector(31 downto 0);
        F_Doppler_O     : OUT std_logic_vector(4 downto 0);
        SAT_ID_O        : OUT std_logic_vector(4 downto 0);
        CODE_DELAY      : OUT std_logic_vector(15 downto 0)
    );
    end component;
    
    component reg_gen 
    generic(
        reg_width : integer := 16
    );
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        en  : in  std_logic;
        D   : in  std_logic_vector(reg_width-1 downto 0);
        Q   : out std_logic_vector(reg_width-1 downto 0)
    );
    end component;
    
begin
    -- GNSS INPUT SIGNAL
    -- Doppler correction
    GNSS_IN : GNSS_Input_Chain
    generic map (
        DDS_WIDTH       => 4,
        FREQ_OFFSET_W   => 4,
        OUT_Width       => 8
    )
    port map(
        clk                     => clk,
        DDS_clk                 => clk,
        DDS_rst                 => DDS_RSTN,
        rst                     => NRST,
        MAX_INPUT_I             => MAX_INPUT_I,
        MAX_INPUT_Q             => MAX_INPUT_Q,
        sample_valid            => MAX_INPUT_CLK,
        DDS_FREQUENCY_OFFSET    => DDS_Frequency,
        DDS_FREQUENCY_PN        => doppler_dir,
        OUTPUT_I                => FFT_I_signal,
        OUTPUT_Q                => FFT_Q_signal,
        OUTPUT_VALID            => ACQ_OUT_VALID
        );
    
    -- C/A Code Generation
	CA_CODE: L1_CA_generator 
	   port map(
	     clk            => CA_CLK,
	     rst            => CA_RST,
	     PRN            => CA_PRN,
	     ENABLE         => '1',
	     valid_out      => open,
	     epoch          => open,
	     epoch_advce    => open,
	     SAT            => SAT_int
	   );
       
    FFT_CA_in_real(1 downto 0) <= "10";
    FFT_CA_in_real(FFT_Width-1 downto 2) <= (others => CA_PRN);
    FFT_CA_in_imag(FFT_Width-1 downto 0) <= (others => '0');
    
    -- CORRELATOR
    CORRELATION :   FFT_Correlator
    generic map(    INPUT_WIDTH => 8)
    port map(
        clk             => clk,
        NGRST           => NRST,
        in_valid        => ACQ_OUT_VALID,
        read_out        => '1',
        I1_IN           => FFT_I_signal,
        Q1_IN           => FFT_Q_signal,
        I2_IN           => FFT_CA_in_real,
        Q2_IN           => FFT_CA_in_imag,
        in_buf_ready    => open,
        out_fft_valid   => counter_clk,
        out_valid       => CORR_OUT_VALID,
        out_ready       => CORR_OUT_READY,
        I_OUT           => IFFT_I_signal,
        Q_OUT           => IFFT_Q_signal
    );
    
    -- Detection
    SAT_DETECTOR: Acquisition_Detection
        port map(
            CLK             => clk, 
            NRST            => NRST,
            START_Cycle     => CORR_OUT_READY, 
            VALID_IN        => CORR_OUT_VALID,
            X_IN            => IFFT_I_signal,
            Y_IN            => IFFT_Q_signal,
            F_Doppler_IN    => FDoppler_Delay, 
            SAT_ID_IN       => SAT_ID_Delay,
            VALID_OUT       => OUT_DATA_READY,
            A_OUT           => ABS_OUT_DATA,
            F_Doppler_O     => F_Doppler_DATA,
            SAT_ID_O        => SAT_ID_DATA_O,
            CODE_DELAY      => CODE_DELAY_DATA
        );
      
    -- Control routine and signals
    CONTADOR_ESTADO: contador generic map (Contador_WIDTH) port map(counter_clk, not NRST, count_state);
    FREQ_DATA_DELAY:    reg_gen generic map (Frequency_offset_data'length)
            port map(clk => counter_clk, rst => not NRST, en => '1', 
                D => Frequency_offset_data, Q => FDoppler_Delay);
    
    SATID_DATA_DELAY:   reg_gen generic map (Frequency_offset_data'length)
            port map(clk => counter_clk, rst => not NRST, en => '1', 
                D => count_state(Contador_WIDTH-1 downto Contador_WIDTH-5), Q => SAT_ID_Delay);
    
    SAT_int <= to_integer(unsigned(count_state(Contador_WIDTH-1 downto Contador_WIDTH-5)));    
    Frequency_offset_data <= count_state(Contador_WIDTH-6 downto 0);
    doppler_dir <= Frequency_offset_data(Contador_WIDTH-6);
    DDS_Frequency <= Frequency_offset_data(Contador_WIDTH-7 downto 0) when 
    doppler_dir = '0' else not Frequency_offset_data(Contador_WIDTH-7 downto 0);
    
    process(CLK, NRST, count_state, count_bit_d1, count_bit_d2, ca_rst_pulse)
    begin
        if NRST = '0' then
            ca_rst_pulse <= '1';
            count_bit_d1 <= '0';
            count_bit_d2 <= '0';
        elsif CLK'event and clk = '1' then
            count_bit_d1 <= count_state(Contador_WIDTH-5);
            count_bit_d2 <= count_bit_d1;
            -- Detecta mudan�a no bit monitorado
            if count_state(Contador_WIDTH-5) xor count_bit_d2 then
                ca_rst_pulse  <= '1';
            else
                ca_rst_pulse  <= '0';
            end if;
        end if;
    end process;
    
    CA_RST <= ca_rst_pulse;
    DDS_RSTN <= not CA_RST;
end architecture_AcquisitionV3;