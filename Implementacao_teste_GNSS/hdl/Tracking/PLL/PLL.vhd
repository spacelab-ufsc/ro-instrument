--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: PLL.vhd
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

library IEEE;

use IEEE.std_logic_1164.all;

entity PLL is
generic(
    INPUT_WIDTH : integer := 10;
    OUTPUT_WIDTH : integer := 10
);
port (
    --<port_name> : <direction> <type>;
	clk         : IN  std_logic;
    rst         : IN  std_logic;
    update      : in  std_logic;
    IP          : IN  std_logic_vector(INPUT_WIDTH-1 downto 0);
    QP          : IN  std_logic_vector(INPUT_WIDTH-1 downto 0);
    COS_OUT     : OUT std_logic_vector(OUTPUT_WIDTH-1 downto 0);
    SIN_OUT     : OUT std_logic_vector(OUTPUT_WIDTH-1 downto 0)
);
end PLL;
architecture architecture_PLL of PLL is
   -- signal, component etc. declarations
    constant DDS_WIDTH : integer := 16;
	signal NRST : std_logic; -- example
	signal error_signal, PH_increment : std_logic_vector(INPUT_WIDTH downto 0) ; -- example
	signal DDS_Freq, NDDS_Freq : std_logic_vector(DDS_WIDTH-1 downto 0) ; -- example
	signal UDDS_Freq : std_logic_vector(DDS_WIDTH-2 downto 0) ; -- example
    signal neg_sin, pos_sin : std_logic_vector(OUTPUT_WIDTH-1 downto 0) ; 
    
    component PLL_Discriminator is
        generic (
            acc_width : integer := 32;
            DISC_TYPE : integer := 0   -- 0 = Costas, 1 = atan (future)
        );
        port (
            IP : in std_logic_vector(acc_width-1 downto 0);
            QP : in std_logic_vector(acc_width-1 downto 0);

            PLL_err : out std_logic_vector(acc_width-1 downto 0)
        );
	end component;

	component Loop_filter is
        generic (
            WIDTH     : integer := 16;
            KP_SHIFT  : integer := 2;
            USE_P   : boolean := true;
            KI_SHIFT  : integer := 6;
            USE_I   : boolean := true;
            KD_SHIFT  : integer := 0;
            USE_D   : boolean := true
        );
        Port ( 
            clk             : in  std_logic;
            reset           : in  std_logic;
            update          : in  std_logic;
            input_error     : in  std_logic_vector(WIDTH-1 downto 0);
            filtered_out    : out std_logic_vector(WIDTH-1 downto 0)
        );
	end component;
    
    component Negative_Integer is
        generic ( data_width : integer := 32 );
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
    
    component COREDDS_C_PLL is
    -- Port list
    port(
        -- Inputs
        CLK            : in  std_logic;
        FREQ_OFFSET    : in  std_logic_vector(15 downto 0);
        FREQ_OFFSET_WE : in  std_logic;
        INIT           : in  std_logic;
        NGRST          : in  std_logic;
        RSTN           : in  std_logic;
        -- Outputs
        COSINE         : out std_logic_vector(9 downto 0);
        INIT_OVER      : out std_logic;
        SINE           : out std_logic_vector(9 downto 0)
        );
	end component;

begin
   -- architecture body

    discriminator: PLL_Discriminator 
                    generic map (INPUT_WIDTH, 0)
                    port map (  IP => IP,
                                QP => QP,
                                PLL_err => error_signal);

    Filter: Loop_filter 
                generic map (
                    WIDTH       => INPUT_WIDTH,
                    KP_SHIFT    => 4,
                    USE_P       => true,
                    KI_SHIFT    => 10,
                    USE_I       => true,
                    KD_SHIFT    => 15,
                    USE_D       => false
                    )
                port map (
                    clk             => clk,
                    reset           => rst,
                    update          => update,
                    input_error     => error_signal,
                    filtered_out    => PH_increment
                );
                
    Freq_accumulator: Accumulator
                generic map (
                    input_width     => INPUT_WIDTH,
                    output_width    => DDS_WIDTH
                )
                port map (
                            clk     => clk,
                            rst     => rst,
                            en      => '1',
                            dump    => '0',

                            data_in => PH_increment,
                            result  => DDS_Freq
                );
                
    Wave_generation: COREDDS_C_PLL
                port map (
                    CLK            => clk,
                    FREQ_OFFSET    => UDDS_Freq,
                    FREQ_OFFSET_WE => '1',
                    INIT           => '0',
                    NGRST          => NRST,
                    RSTN           => '1',
                    -- Outputs
                    COSINE         => COS_OUT,
                    INIT_OVER      => open,
                    SINE           => neg_sin
                    );
    
    neg_sine : Negative_Integer 
                    generic map (OUTPUT_WIDTH)
                    port map (neg_sin, pos_sin);
    
    DDS_UControl : Negative_Integer 
                generic map (DDS_WIDTH)
                port map (DDS_Freq, NDDS_Freq);
    
    NRST <= not rst;
    UDDS_Freq <= DDS_Freq(DDS_WIDTH-2 downto 0) when
                DDS_Freq(DDS_WIDTH-1) = '0' else
                NDDS_Freq(DDS_WIDTH-2 downto 0);
    SIN_OUT   <= neg_sin when 
                DDS_Freq(DDS_WIDTH-1) = '0'
                else pos_sin;
    
end architecture_PLL;
