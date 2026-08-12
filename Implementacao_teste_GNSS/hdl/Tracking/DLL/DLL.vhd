library IEEE;
use IEEE.STD_LOGIC_1164.ALL;   
use ieee.numeric_std.all;

entity DLL is
generic (
    ------------------------------------------------------------------
    -- Precision
    ------------------------------------------------------------------
    DATA_WIDTH : integer := 32;
    PHASE_W    : integer := 24;
    CNT_WIDTH  : integer := 6;
    
------------------------------------------------------------------
    -- DLL Discriminator
    ------------------------------------------------------------------
    DISC_TYPE : integer := 0;
    ------------------------------------------------------------------
    -- Loop filter configuration
    ------------------------------------------------------------------
    KP_SHIFT   : integer := 2;
    KI_SHIFT   : integer := 6;
    KD_SHIFT   : integer := 0;

    USE_P      : boolean := true;
    USE_I      : boolean := true;
    USE_D      : boolean := false
);
port (
    clk         : in    std_logic;
    rst         : in    std_logic;
    start       : in    std_logic;

    -- Correlator outputs (from tracking channels)
    IE, QE : in std_logic_vector(DATA_WIDTH-1 downto 0);
    IP, QP : in std_logic_vector(DATA_WIDTH-1 downto 0);
    IL, QL : in std_logic_vector(DATA_WIDTH-1 downto 0);
    ------------------------------------------------------------------
    -- Lock detector thresholds
    ------------------------------------------------------------------
    LOCK_TH    : in std_logic_vector(DATA_WIDTH-1 downto 0);
    UNLOCK_TH  : in std_logic_vector(DATA_WIDTH-1 downto 0);
    
    SAT     : in std_logic_vector(4 downto 0);
    -- Outputs
    code_lock : out std_logic
);
end DLL;
architecture Behavioral of DLL is
    -- ================================
    -- Internal signals
    -- ================================
    signal chip_en_1x   : std_logic;
    signal chip_en_2x   : std_logic;

    signal early_code   : std_logic;
    signal prompt_code  : std_logic;
    signal late_code    : std_logic;
    signal update       : std_logic;
    signal disc_sel     : std_logic_vector (1 downto 0);

    signal err_code     : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal phase_inc    : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal SAT_int : integer range 0 to 31;
    
    signal code_lock_i : std_logic;
	
    component PRN_Early_Prompt_Late is
    port ( 
        clk           : in  std_logic;
        reset         : in  std_logic;

        -- Chip timing from external counter / NCO
        chip_en_1x    : in  std_logic;  -- 1.023 MHz
        chip_en_2x    : in  std_logic;  -- 2.046 MHz (half-chip)

        early_code    : out std_logic;
        prompt_code   : out std_logic;
        late_code     : out std_logic;

        valid_out     : out std_logic;
        SAT           : in integer range 0 to 31
    );
    end component;
    
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
    
    component DCO is
    generic (
        PHASE_W : integer := 24
    );
    port (
        clk           : in  std_logic;
        reset         : in  std_logic;

        -- Signed control from DLL loop filter
        phase_inc     : in  std_logic_vector(PHASE_W-1 downto 0);

        -- Chip enables
        chip_en_1x    : out std_logic; -- 1.023 MHz
        chip_en_2x    : out std_logic  -- 2.046 MHz
    );
    end component;
    
    component Code_Lock_Detector is
    generic (
        DATA_WIDTH : integer := 32;
        CNT_WIDTH  : integer := 6
    );
    port (
        clk        : in  std_logic;
        rst        : in  std_logic;
        chip_en    : in  std_logic;

        err_in     : in  std_logic_vector(DATA_WIDTH-1 downto 0);

        lock_th    : in  std_logic_vector(DATA_WIDTH-1 downto 0);
        unlock_th  : in  std_logic_vector(DATA_WIDTH-1 downto 0);

        code_lock  : out std_logic
    );
    end component;
    
begin
    -- ================================
    -- PRN generator (E/P/L)
    -- ================================
    PRN_GEN : PRN_Early_Prompt_Late
        port map (
            clk         => clk,
            reset       => rst,
            chip_en_1x  => chip_en_1x,
            chip_en_2x  => chip_en_2x,
            early_code  => early_code,
            prompt_code => prompt_code,
            late_code   => late_code,
            valid_out   => open,
            SAT         => SAT_int
        );
    SAT_int <= to_integer(unsigned(SAT));
    -- ================================
    -- Correlators (I/Q not shown here)
    -- ================================
    -- You already have these blocks

    -- ================================
    -- Code discriminator
    -- ================================
    DISCR : Code_Discriminator
        generic map (
            DATA_WIDTH => DATA_WIDTH
        )
        port map (
            clk         => clk,
            rst         => rst,
            start       => start,
            disc_sel    => disc_sel,
            IE          => IE,
            QE          => QE,
            IL          => IL,
            QL          => QL,
            IP          => IP,
            QP          => QP,
            err_out     => err_code,
            done        => update
        );

    -- ================================
    -- Loop filter (PI)
    -- ================================
    U_LOOP_FILTER : Loop_filter
        generic map (
            WIDTH     => DATA_WIDTH,
            KP_SHIFT  => KP_SHIFT,
            KI_SHIFT  => KI_SHIFT,
            KD_SHIFT  => KD_SHIFT,
            USE_P     => USE_P,
            USE_I     => USE_I,
            USE_D     => USE_D
        )
        port map (
            clk          => clk,
            reset        => rst,
            update       => update,
            input_error  => err_code,
            filtered_out => phase_inc
        );

    -- ================================
    -- DCO / NCO
    -- ================================
    DCO_INST : DCO
        generic map (
            PHASE_W => PHASE_W
        )
        port map (
            clk         => clk,
            reset       => rst,
            phase_inc   => phase_inc(PHASE_W-1 downto 0),
            chip_en_1x  => chip_en_1x,
            chip_en_2x  => chip_en_2x
        );

    -- ================================
    -- Code lock detector
    -- ================================
    LOCK_DET : Code_Lock_Detector
        generic map (
            DATA_WIDTH => DATA_WIDTH,
            CNT_WIDTH  => CNT_WIDTH
        )
        port map (
            clk        => clk,
            rst        => rst,
            chip_en    => chip_en_1x,
            err_in     => err_code,
            lock_th    => LOCK_TH,
            unlock_th  => UNLOCK_TH,
            code_lock  => code_lock_i
        );

    code_lock <= code_lock_i;
    
    assert (DISC_TYPE >= 0 and DISC_TYPE <= 2)
    report "Illegal DISC_TYPE"
    severity FAILURE;
    
    with DISC_TYPE select 
        disc_sel <= "00" when 0,
                    "01" when 1,
                    "10" when 2,
                    "00" when others;
    
    assert not (USE_D = true and KD_SHIFT = 0)
    report "Derivative enabled with zero shift"
    severity WARNING;

end Behavioral;
