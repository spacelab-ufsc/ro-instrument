--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: FLL_Discriminator.vhd
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

entity FLL_Discriminator_DP is
generic (
    DATA_WIDTH     : integer := 32;
    CORDIC_WIDTH   : integer := 32;
    NORM_SHIFT     : integer := 25  -- log2(N^2)
);
port (
    clk : in std_logic;
    rst : in std_logic;

    IP  : in std_logic_vector(DATA_WIDTH-1 downto 0);
    QP  : in std_logic_vector(DATA_WIDTH-1 downto 0);

    disc_sel  : in  std_logic_vector(1 downto 0);

    mul_start : in  std_logic;  
    mul_done  : out std_logic;

    fll_err   : out std_logic_vector(DATA_WIDTH-1 downto 0);
    fll_valid : out std_logic
);
end entity;

architecture rtl of FLL_Discriminator_DP is

    ------------------------------------------------------------------
    -- Delayed correlators
    ------------------------------------------------------------------
    type IQ_line_t is array (0 to 1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    type mul_line_t is array (0 to 1) of std_logic_vector(DATA_WIDTH downto 0);
    
    signal IQ, IQ_d : IQ_line_t;
    ------------------------------------------------------------------
    -- Multiplier inputs
    ------------------------------------------------------------------
    signal QP_neg    : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    ------------------------------------------------------------------
    -- Multiplier outputs
    ------------------------------------------------------------------
    signal mul_out   : mul_line_t;
    
    signal cross_neg, cross, cross_sc, cordic_out : std_logic_vector(DATA_WIDTH-1 downto 0);
    
    signal Re_full, Im_full : std_logic_vector(DATA_WIDTH downto 0);
    signal Re_norm, Im_norm : std_logic_vector(CORDIC_WIDTH-1 downto 0);
    signal cordic_valid, mul_valid    : std_logic;
    signal mul_pipe : std_logic_vector(0 to 3);

    signal real_neg, NGRST     : std_logic;

begin

    ------------------------------------------------------------------
    -- Delay registers (1 integration period)
    ------------------------------------------------------------------
    
    IQ_Delay : for i in 0 to 1 generate
        IQ(i) <= IP when i = 0 else QP;
        S_REG: entity work.shift_reg
            generic map (
                data_width => DATA_WIDTH
            )
            port map (
                en     => '1',
                clk    => clk,
                rst    => rst,
                serial => '0',        -- not used
                shift  => '0',        -- parallel load
                I      => IQ(i),
                O      => IQ_d(i)
            );
    end generate;

    NEG_Q1: entity work.Negative_Integer
        generic map (data_width => DATA_WIDTH)
        port map (SIG_IN => QP, SIG_OUT => QP_neg);
    ------------------------------------------------------------------
    -- Multiplier 1: IP(k) × QP(k-1)
    ------------------------------------------------------------------
    MUL1 : entity work.complex_multiplier_C_FLL_Discriminator 
        -- Port list
        port map(
            -- Inputs
            aimag_i  => QP_neg,
            areal_i  => IQ(0),
            bimag_i  => IQ_d(1),
            breal_i  => IQ_d(0),
            clock_i  => clk,
            nreset_i => NGRST,
            -- Outputs
            cimag_o  => mul_out(1),
            creal_o  => mul_out(0)
            );
            
    cross <= mul_out(1)(data_width-1 downto 0);

    mul_pipe(0) <= mul_start;

    GEN_MUL_DELAY : for i in 0 to 2 generate
        FF_MUL : entity work.Flip_Flop_D
            port map (
                D   => mul_pipe(i),
                RST => rst,
                CLK => clk,
                Q   => mul_pipe(i+1)
            );
    end generate;

    -- After 4 cycles
    mul_valid <= mul_pipe(3);

    NEG_CROSS: entity work.Negative_Integer
        generic map (data_width => DATA_WIDTH)
        port map (SIG_IN => cross, SIG_OUT => cross_neg);  

    real_neg <= mul_out(0)(DATA_WIDTH);  -- sign of real part
    cross_sc <= cross when real_neg = '0' else cross_neg;

    Re_full <= mul_out(0);  -- creal_o
    Im_full <= mul_out(1);  -- cimag_o
    
    Re_norm <= Re_full(DATA_WIDTH-NORM_SHIFT downto 
                   DATA_WIDTH-NORM_SHIFT-CORDIC_WIDTH+1);

    Im_norm <= Im_full(DATA_WIDTH-NORM_SHIFT downto 
                   DATA_WIDTH-NORM_SHIFT-CORDIC_WIDTH+1);
    
    ATAN_Cordic: entity work.CORECORDIC_C_FLL_Driscriminator
    -- Port list
    port map(
        -- Inputs
        CLK        => clk,
        DIN_VALID  => mul_valid,
        DIN_X      => Re_norm,
        DIN_Y      => Im_norm,
        NGRST      => NGRST,
        RST        => rst,
        -- Outputs
        DOUT_A     => cordic_out,
        DOUT_VALID => cordic_valid,
        RFD        => open
        );

    with disc_sel select
        fll_err <=
            cross                                              when "00", -- raw cross-product
        cross_sc when "01", -- sign-corrected
        cordic_out(DATA_WIDTH-1 downto 0) when "10", -- atan
            cross                                              when others;

    fll_valid <=
        cordic_valid when disc_sel = "10" else
        mul_valid;
            
    NGRST <= not rst;
    
    mul_done <= mul_valid;

end architecture;

library IEEE;
use IEEE.std_logic_1164.all;

entity FLL_Discriminator_CTRL is
port (
    clk       : in  std_logic;
    rst       : in  std_logic;

    start     : in  std_logic;  -- new coherent integration ready
    disc_sel  : in  std_logic_vector(1 downto 0);

    mul_done  : in  std_logic;
    fll_valid : in  std_logic;

    mul_start : out std_logic;
    update_en : out std_logic
);
end entity;

architecture rtl of FLL_Discriminator_CTRL is

    type state_t is (IDLE, START_MUL, WAIT_RESULT, DONE);
    signal state, state_n : state_t;

begin

    --------------------------------------------------
    -- State register
    --------------------------------------------------
    process(clk)
    begin
        if clk'event and clk = '1' then
            if rst = '1' then
                state <= IDLE;
            else
                state <= state_n;
            end if;
        end if;
    end process;

    --------------------------------------------------
    -- Next-state logic
    --------------------------------------------------
    process(state, start, mul_done, fll_valid, disc_sel)
    begin
        state_n   <= state;

        case state is

            when IDLE =>
                if start = '1' then
                    state_n <= START_MUL;
                end if;

            when START_MUL =>
                state_n <= WAIT_RESULT;

            when WAIT_RESULT =>
                if disc_sel = "10" then
                    if fll_valid = '1' then
                        state_n <= DONE;
                    end if;
                else
                    if mul_done = '1' then
                        state_n <= DONE;
                    end if;
                end if;

            when DONE =>
                state_n <= IDLE;

            when others =>
                state_n <= IDLE;

        end case;
    end process;

    --------------------------------------------------
    -- Output logic
    --------------------------------------------------
    mul_start <= '1' when state = START_MUL else '0';

    update_en <= '1' when state = DONE else '0';

end architecture;

library IEEE;
use IEEE.std_logic_1164.all;

entity FLL_Discriminator is
generic (
    DATA_WIDTH   : integer := 32;
    CORDIC_WIDTH : integer := 32;
    NORM_SHIFT   : integer := 25
);
port (
    clk       : in  std_logic;
    rst       : in  std_logic;

    -- Correlator outputs
    IP        : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    QP        : in  std_logic_vector(DATA_WIDTH-1 downto 0);

    -- Control
    start     : in  std_logic;                     -- new integration ready
    disc_sel  : in  std_logic_vector(1 downto 0);  -- discriminator select

    -- Outputs to loop filter
    fll_err   : out std_logic_vector(DATA_WIDTH-1 downto 0);
    update_en : out std_logic
);
end entity;

architecture rtl of FLL_Discriminator is

    ------------------------------------------------------------------
    -- Internal control signals
    ------------------------------------------------------------------
    signal mul_start  : std_logic;
    signal mul_done   : std_logic;
    signal fll_valid  : std_logic;

begin

    ------------------------------------------------------------------
    -- Datapath
    ------------------------------------------------------------------
    DP : entity work.FLL_Discriminator_DP
    generic map (
        DATA_WIDTH   => DATA_WIDTH,
        CORDIC_WIDTH => CORDIC_WIDTH,
        NORM_SHIFT   => NORM_SHIFT
    )
    port map (
        clk        => clk,
        rst        => rst,

        IP         => IP,
        QP         => QP,

        disc_sel   => disc_sel,

        mul_start  => mul_start,
        mul_done   => mul_done,

        fll_err    => fll_err,
        fll_valid  => fll_valid
    );

    ------------------------------------------------------------------
    -- Control FSM
    ------------------------------------------------------------------
    CTRL : entity work.FLL_Discriminator_CTRL
    port map (
        clk        => clk,
        rst        => rst,

        start      => start,
        disc_sel   => disc_sel,

        mul_done   => mul_done,
        fll_valid  => fll_valid,

        mul_start  => mul_start,
        update_en  => update_en
    );

end architecture;
