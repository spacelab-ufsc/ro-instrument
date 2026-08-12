--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Code_Discriminator.vhd
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
use IEEE.STD_LOGIC_1164.ALL;   
use ieee.std_logic_arith.all;

entity Code_Discriminator_DP is
generic (
    DATA_WIDTH : integer := 18
);
port (
    clk : in std_logic;
    rst : in std_logic;

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
    -- Control interface (from controller FSM)
    ------------------------------------------------------------------
    save_corr   : in std_logic;  -- saves the correlation data
    op_start    : in std_logic;  -- starts the operation
    op_done     : out std_logic;
    
    disc_sel    : in std_logic_vector(1 downto 0);
    -- "00" Early-Late Difference
    -- "01" Dot-Product
    -- "10" Early-Late Difference Normalized
    -- 
    mul_sel     : in std_logic;  -- selects correlator: 0=Early, 1=Late

    div_start   : in std_logic;
    div_done    : out std_logic;

    ------------------------------------------------------------------
    -- Output
    ------------------------------------------------------------------
    err_out : out std_logic_vector(2*DATA_WIDTH downto 0)
);
end entity;


architecture architecture_Code_Discriminator_DP of Code_Discriminator_DP is

    ------------------------------------------------------------------
    -- Type declarations
    ------------------------------------------------------------------
    constant MUL_OUT_DATAWIDTH : integer := 2*DATA_WIDTH; 
    signal ZERO48         : std_logic_vector(47 downto 0);

    type iq_array_t   is array (0 to 1) of std_logic_vector(DATA_WIDTH-1 downto 0);
    type ELP_array_t  is array (0 to 2) of std_logic_vector(DATA_WIDTH-1 downto 0);
    type mul_array_t  is array (0 to 1) of std_logic_vector(MUL_OUT_DATAWIDTH+1 downto 0);
    type EL_array_t   is array (0 to 1) of std_logic_vector(MUL_OUT_DATAWIDTH downto 0);
    type corr_array_t is array (0 to 2) of iq_array_t; -- E,P,L
    
    ------------------------------------------------------------------
    -- Correlator arrays
    ------------------------------------------------------------------
    signal input_corr   : corr_array_t;
    signal IQ_corr      : corr_array_t;  -- 0=E, 1=P, 2=L
    
    ------------------------------------------------------------------
    -- Selected correlator (I/Q)
    ------------------------------------------------------------------
    signal corr_sel_iq  : iq_array_t;
    signal NEG_Q        : std_logic_vector(DATA_WIDTH-1 downto 0);

    ------------------------------------------------------------------
    -- Multiplier signals
    ------------------------------------------------------------------
    signal mul_pipe : std_logic_vector(3 downto 0);
    signal mul_out  : mul_array_t;

    ------------------------------------------------------------------
    -- Magnitudes
    ------------------------------------------------------------------
    signal mag_sel  : std_logic_vector(1 downto 0);
    signal mag_out  : EL_array_t;
    signal mag_sum  : std_logic_vector(MUL_OUT_DATAWIDTH downto 0);
    signal mag_L_n  : std_logic_vector(MUL_OUT_DATAWIDTH downto 0);

    ------------------------------------------------------------------
    -- Arithmetic results
    ------------------------------------------------------------------
    signal diff_EL  : std_logic_vector(MUL_OUT_DATAWIDTH downto 0);
    signal num_val  : std_logic_vector(MUL_OUT_DATAWIDTH downto 0);
    signal den_val  : std_logic_vector(MUL_OUT_DATAWIDTH downto 0);
    signal div_val  : std_logic_vector(MUL_OUT_DATAWIDTH downto 0);
    
    ------------------------------------------------------------------
    -- mul register
    ------------------------------------------------------------------    
    signal mag_dest : std_logic_vector(1 downto 0); 
    signal NRST     : std_logic;
    
    ------------------------------------------------------------------
    -- MACC SIGNALS
    ------------------------------------------------------------------    
    constant MACC_LATENCY           : integer := 1; -- integer to measure MACC latency
    signal macc_pipe                : std_logic_vector(MACC_LATENCY downto 0);
    signal MACC_OUT                 : std_logic_vector(47 downto 0);
    signal corr_sel_ELP, MACC_EN    : std_logic;
    signal ELP_sel                  : ELP_array_t; -- E = 0, P = 1, L = 2
    signal CDIN_FDBK_SEL            : std_logic_vector(1 downto 0);
    
    ------------------------------------------------------------------
    -- Aliases
    ------------------------------------------------------------------
    alias mag_E : std_logic_vector(MUL_OUT_DATAWIDTH downto 0) is mag_out(0);
    alias mag_L : std_logic_vector(MUL_OUT_DATAWIDTH downto 0) is mag_out(1);    
begin
    ------------------------------------------------------------------
    -- Correlator packing
    ------------------------------------------------------------------
    input_corr(0)(0) <= IE;
    input_corr(0)(1) <= QE;
    input_corr(1)(0) <= IP;
    input_corr(1)(1) <= QP;
    input_corr(2)(0) <= IL;
    input_corr(2)(1) <= QL;
    
    SH_REG_SAVE: for i in IQ_corr'range generate
        IQ_REG: for k in IQ_corr(i)'range generate
            IQ_CORR_REG: entity work.shift_reg 
                generic map(DATA_WIDTH => DATA_WIDTH)
                port map (
                    en      => save_corr,
                    clk     => clk,
                    rst     => rst,
                    serial  => '0', 
                    shift   => '0', 
                    I       => input_corr(i)(k), 
                    O       => IQ_corr(i)(k)
                    );
        end generate;
    end generate;

    ------------------------------------------------------------------
    -- Correlator selector (explicit mux, no conversions)
    ------------------------------------------------------------------
    process(IQ_corr, mul_sel)
    begin
        -- default assignments (avoid latches)
        corr_sel_iq(0) <= (others => '0');
        corr_sel_iq(1) <= (others => '0');

        case mul_sel is
            when '0' =>  -- Early
                corr_sel_iq(0) <= IQ_corr(0)(0);
                corr_sel_iq(1) <= IQ_corr(0)(1);
            when others => -- Late
                corr_sel_iq(0) <= IQ_corr(2)(0);
                corr_sel_iq(1) <= IQ_corr(2)(1);
        end case;
    end process;
    
    ------------------------------------------------------------------
    -- POWER COMPUTATION BY COMPLEX MULTIPLIER: I² and Q²
    ------------------------------------------------------------------   
    UNEG_Q : entity work.Negative_Integer
        generic map (data_width => DATA_WIDTH)
        port map (SIG_IN => corr_sel_iq(1), SIG_OUT => NEG_Q);
        
    MUL1 : entity work.complex_multiplier_C_Code_Discriminator 
        -- Port list
        port map(
            -- Inputs
            aimag_i  => corr_sel_iq(1),
            areal_i  => corr_sel_iq(0),
            bimag_i  => NEG_Q,
            breal_i  => corr_sel_iq(0),
            clock_i  => clk,
            nreset_i => NGRST,
            -- Outputs
            cimag_o  => mul_out(1),
            creal_o  => mul_out(0)
            );
    
    ------------------------------------------------------------------
    -- Multiplier done
    ------------------------------------------------------------------
    mul_pipe(mul_pipe'right) <= op_start;
    GEN_MUL_DELAY : for i in 0 to mul_pipe'left-1 generate
        FF_MUL : entity work.Flip_Flop_D
            port map (
                D   => mul_pipe(i),
                RST => rst,
                CLK => clk,
                Q   => mul_pipe(i+1)
            );
    end generate;
    
    mag_sel <= ("01" xor (others => mul_sel)) 
                and (others => mul_pipe(mul_pipe'left));
    SH_REG_SAVE2: for i in mag_out'range generate
        EL_MAG_REG: entity work.shift_reg 
            generic map(DATA_WIDTH => MUL_OUT_DATAWIDTH)
            port map (
                en      => mag_sel(i),
                clk     => clk,
                rst     => rst,
                serial  => '0', 
                shift   => '0', 
                I       => mul_out(0)(MUL_OUT_DATAWIDTH downto 0), 
                O       => mag_out(i)
                );
    end generate;
    
    ------------------------------------------------------------------
    -- E - L
    ------------------------------------------------------------------
    SUB_EL : entity work.UAL
        generic map ( data_width => DATA_WIDTH )
        port map (
            A    => mag_E,
            B    => mag_L_n,
            Cin  => '1',
            S    => diff_EL,
            Cout => open
        );
    mag_L_n <= not mag_L;
    
    ------------------------------------------------------------------
    -- Dot Product (using MACC){(IE-IL).IP+(QE-QL).QP}
    ------------------------------------------------------------------
    ------------------------------------------------------------------
    -- Correlator selector (explicit mux, no conversions)
    ------------------------------------------------------------------
    process(IQ_corr, ELP_sel, corr_sel_ELP)
    begin
        -- default assignments (avoid latches)
        ELP_sel(0) <= (others => '0');
        ELP_sel(1) <= (others => '0');
        ELP_sel(2) <= (others => '0');

        case corr_sel_ELP is
            when '0' =>  -- I
                ELP_sel(0) <= IQ_corr(0)(0);
                ELP_sel(1) <= IQ_corr(1)(0);
                ELP_sel(2) <= IQ_corr(2)(0);
            when others => -- Q
                ELP_sel(0) <= IQ_corr(0)(1);
                ELP_sel(1) <= IQ_corr(1)(1);
                ELP_sel(2) <= IQ_corr(2)(1);
        end case;
    end process;
    ------------------------------------------------------------------
    -- MACC Delay line for latency
    ------------------------------------------------------------------
    macc_pipe(macc_pipe'right) <= op_start;
    GEN_MACC_DELAY : for i in 0 to macc_pipe'left-1 generate
        FF_MACC : entity work.Flip_Flop_D
            port map (
                D   => macc_pipe(i),
                RST => rst,
                CLK => clk,
                Q   => macc_pipe(i+1)
            );
    end generate;
    ------------------------------------------------------------------
    -- MACC control signals
    ------------------------------------------------------------------        
    MACC_EN <= or(macc_pipe);
    corr_sel_ELP <= mul_sel;
    CDIN_FDBK_SEL <= '0' & corr_sel_ELP;
    
    ------------------------------------------------------------------
    -- MACC entity
    ------------------------------------------------------------------
    DOTP: entity work.MACC_wrapper 
    -- Port list
    port map(

        -- =========================
        -- Clock
        -- =========================
        CLK => clk,
        
        -- =========================
        -- Asynchronous load
        -- =========================
        AL_N => '1',

        -- =========================
        -- A input path
        -- =========================
        A         => ELP_sel(1),
        A_EN      => MACC_EN,
        A_BYPASS  => '0',
        A_SRTN_N  => NRST,

        
        -- =========================
        -- B input path
        -- =========================
        B         => ELP_sel(0),
        B_EN      => MACC_EN,
        B_BYPASS  => '0',
        B_SRST_N  => NRST,

        -- =========================
        -- D path (unused)
        -- =========================
        D         => ELP_sel(2),
        D_EN      => MACC_EN,
        D_BYPASS  => '0',
        D_SRST_N  => NRST,
        D_ARST_N  => '1',

        -- =========================
        -- C / Accumulator path
        -- =========================
        C         => ZERO48,
        C_EN      => '0',
        C_BYPASS  => '1',
        C_SRST_N  => '0',
        C_ARST_N  => '0',
        CARRYIN   => '0',

        -- =========================
        -- Feedback path (disabled)
        -- =========================
        CDIN                  => ZERO48,
        CDIN_FDBK_SEL         => CDIN_FDBK_SEL,
        CDIN_FDBK_SEL_EN      => '1',
        CDIN_FDBK_SEL_BYPASS  => '1',
        CDIN_FDBK_SEL_AD_N    => "10",
        CDIN_FDBK_SEL_SD_N    => "10",
        CDIN_FDBK_SEL_SL_N    => '1',

        -- Disable Arithmetic shifts 
        ARSHFT17          => '0',
        ARSHFT17_EN       => '0',
        ARSHFT17_BYPASS   => '1',
        ARSHFT17_AD_N     => '1',
        ARSHFT17_SD_N     => '1',
        ARSHFT17_SL_N     => '1',      
        
        -- =========================
        -- Arithmetic control
        -- =========================
        PASUB         => '1',
        PASUB_EN      => '1',
        PASUB_BYPASS  => '1',
        PASUB_AD_N    => '0',
        PASUB_SD_N    => '0',
        PASUB_SL_N    => '1',

        SUB           => '0',
        SUB_EN        => '1',
        SUB_BYPASS    => '1',
        SUB_AD_N      => '1',
        SUB_SD_N      => '1',
        SUB_SL_N      => '1',

        -- =========================
        -- Special modes
        -- =========================
        DOTP   => '0',
        SIMD   => '0',

        -- =========================
        -- Output stage
        -- =========================
        P_EN     => MACC_EN,
        P_BYPASS => '0',
        P_SRST_N => NRST,

        OVFL_CARRYOUT_SEL => '0',

        -- =========================
        -- Outputs
        -- =========================
        P                => MACC_OUT,
        CDOUT            => open,
        OVFL_CARRYOUT    => open
        );
    

    ------------------------------------------------------------------
    -- Divider 
    ------------------------------------------------------------------
    num_val <= diff_EL;
 
    DEN_EL : entity work.UAL
    generic map ( data_width => MUL_OUT_DATAWIDTH )
    port map (
        A    => mag_E,
        B    => mag_L,
        Cin  => '0',
        S    => den_val,
        Cout => open
    );
 
    DIV : entity work.Divider_Signed
            generic map ( WIDTH => MUL_OUT_DATAWIDTH )
            port map (
                clk   => clk,
                rst   => rst,
                start => div_start,
                num   => num_val,
                den   => den_val,
                quot  => div_val,
                rema  => open,
                idle  => div_done
            );    
    
    with disc_sel select 
        err_out <=  diff_EL when "00",
                    MACC_OUT(MUL_OUT_DATAWIDTH downto 0) when "01",
                    div_val when "10",
                    (others => '0') when others;
       
    NRST <= not rst;
    ZERO48 <= (others => '0');
    op_done <=  (mul_pipe(mul_pipe'left) and not disc_sel(0)) or 
                (macc_pipe(macc_pipe'left) and disc_sel(0));
end architecture_Code_Discriminator_DP;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;   
use ieee.std_logic_arith.all;

entity Code_Discriminator_CTRL is
port (
    clk     : in std_logic;
    rst     : in std_logic;
    start   : in std_logic;
    
    ------------------------------------------------------------------
    -- Discriminator Selector
    ------------------------------------------------------------------
    disc_sel    : in std_logic_vector(1 downto 0);
    -- "00" Early-Late Difference
    -- "01" Dot-Product
    -- "10" Early-Late Difference Normalized
    -- "11" Reserved
    
    ------------------------------------------------------------------
    -- Handshake from datapath
    ------------------------------------------------------------------
    op_done     : in std_logic;
    div_done    : in std_logic;
    
    ------------------------------------------------------------------
    -- Control outputs to datapath
    ------------------------------------------------------------------
    save_corr   : out std_logic;  -- saves the correlation data
    mul_sel     : out std_logic;
    op_start    : out std_logic;
    div_start   : out std_logic;
    
    ------------------------------------------------------------------
    -- End of the operation
    ------------------------------------------------------------------
    done        : out std_logic
);
end Code_Discriminator_CTRL;

architecture rtl of Code_Discriminator_CTRL is

    type state_t is (
        IDLE,
        
        SAVE_DATA,

        MUL_OP1,
        MUL_OP2,

        NUM_READY,
        WAIT_DIV,

        DONE_ST
    );

    signal state, next_state : state_t;

begin

    ------------------------------------------------------------------
    -- State register
    ------------------------------------------------------------------
    process(clk, rst)
    begin
        if rst = '1' then
            state <= IDLE;
        elsif clk'event and clk = '1' then
            state <= next_state;
        end if;
    end process;

    ------------------------------------------------------------------
    -- FSM control logic
    ------------------------------------------------------------------
    process(state, start, disc_sel, op_done, div_done)
    begin
        -- defaults
        case state is
            ----------------------------------------------------------
            when IDLE =>
                save_corr <= start; -- this latches mul_sel into datapath
                op_start  <= '0';
                mul_sel   <= '0';
                div_start <= '0';
                done      <= '0';
                if start = '1' then
                    next_state  <= SAVE_DATA;
                else
                    next_state  <= IDLE;
                end if;

            ----------------------------------------------------------
            when SAVE_DATA =>
                save_corr   <= '0'; 
                op_start    <= '1';
                mul_sel     <= '0';
                div_start   <= '0';
                done        <= '0';
                next_state  <= MUL_OP1;
            
            when MUL_OP1 =>
                save_corr <= '0'; 
                op_start  <= '0';
                div_start <= '0';
                done      <= '0';
                if op_done = '1' then
                    mul_sel <= '1';
                    next_state <= MUL_OP2;
                else
                    mul_sel <= '0';
                    next_state <= MUL_OP1;
                end if;

            ----------------------------------------------------------
            when MUL_OP2 =>
                save_corr <= '0'; 
                op_start  <= '0';
                div_start <= '0';
                done      <= '0';
                if op_done = '1' then
                    mul_sel <= '0';
                    next_state <= NUM_READY;
                else
                    mul_sel <= '1';
                    next_state <= MUL_OP2;
                end if;

            ----------------------------------------------------------
            when NUM_READY =>
                save_corr   <= '0'; 
                op_start    <= '0';
                mul_sel     <= '0';
                done        <= '0';
                if disc_sel = "10" then
                    div_start   <= '1';
                    next_state  <= WAIT_DIV;
                else
                    div_start   <= '0';
                    next_state  <= DONE_ST;
                end if;

            when WAIT_DIV =>
                save_corr   <= '0'; 
                op_start    <= '0';
                mul_sel     <= '0';
                div_start   <= '0';
                done        <= '0';
                if div_done = '1' then
                    next_state <= DONE_ST;
                else
                    next_state <= WAIT_DIV;
                end if;

            ----------------------------------------------------------
            when DONE_ST =>
                save_corr   <= '0'; 
                op_start    <= '0';
                mul_sel     <= '0';
                div_start   <= '0';
                done        <= '1';
                next_state <= IDLE;
        end case;
    end process;

end architecture rtl;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;   
use ieee.std_logic_arith.all;

entity Code_Discriminator is
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
end Code_Discriminator;

architecture architecture_Code_Discriminator of Code_Discriminator is

    ------------------------------------------------------------------
    -- Control ? Datapath signals
    ------------------------------------------------------------------
    signal save_corr    : std_logic;
    signal mul_sel      : std_logic;
    signal op_start     : std_logic;
    signal op_done      : std_logic;

    signal div_start    : std_logic;
    signal div_done     : std_logic;

    component Code_Discriminator_CTRL is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        start   : in std_logic;
        
        ------------------------------------------------------------------
        -- Discriminator Selector
        ------------------------------------------------------------------
        disc_sel    : in std_logic_vector(1 downto 0);
        -- "00" Early-Late Difference
        -- "01" Dot-Product
        -- "10" Early-Late Difference Normalized
        -- "11" Reserved
        
        ------------------------------------------------------------------
        -- Handshake from datapath
        ------------------------------------------------------------------
        op_done     : in std_logic;
        div_done    : in std_logic;
        
        ------------------------------------------------------------------
        -- Control outputs to datapath
        ------------------------------------------------------------------
        save_corr   : out std_logic;  -- saves the correlation data
        mul_sel     : out std_logic;
        op_start    : out std_logic;
        div_start   : out std_logic;
        
        ------------------------------------------------------------------
        -- End of the operation
        ------------------------------------------------------------------
        done        : out std_logic
    );
    end component;
    
    component Code_Discriminator_DP is
        generic (
            DATA_WIDTH : integer := 18
        );
        port (
            clk         : in std_logic;
            rst         : in std_logic;
            disc_sel    : in std_logic_vector(1 downto 0);
            -- "00" Early-Late Difference
            -- "01" Dot-Product
            -- "10" Early-Late Difference Normalized
            -- "11" Reserved
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
            -- Control interface (from controller FSM)
            ------------------------------------------------------------------
            save_corr   : in std_logic;  -- saves the correlation data
            op_start    : in std_logic;  -- starts the operation
            op_done     : out std_logic;
            
            mul_sel     : in std_logic;  -- selects correlator: 0=Early, 1=Late

            div_start   : in std_logic;
            div_done    : out std_logic;

            ------------------------------------------------------------------
            -- Output
            ------------------------------------------------------------------
            err_out : out std_logic_vector(2*DATA_WIDTH downto 0)
        );
    end component;
    
begin

    ------------------------------------------------------------------
    -- Controller
    ------------------------------------------------------------------
    CTRL : Code_Discriminator_CTRL
    port map (
        clk         => clk,
        rst         => rst,
        start       => start,
        disc_sel    => disc_sel,

        op_done     => op_done,
        div_done    => div_done,

        save_corr   => save_corr,
        mul_sel     => mul_sel,
        op_start    => op_start,
        div_start   => div_start,
        
        done        => done
    );

    ------------------------------------------------------------------
    -- Datapath
    ------------------------------------------------------------------
    DP : Code_Discriminator_DP
    generic map (
        DATA_WIDTH => DATA_WIDTH
    )
    port map (
        clk       => clk,
        rst       => rst,
        disc_sel  => disc_sel,

        IE        => IE,
        QE        => QE,
        IL        => IL,
        QL        => QL,
        IP        => IP,
        QP        => QP,    

        save_corr   => save_corr,
        mul_sel     => mul_sel,
        op_start    => op_start,
        div_start   => div_start,

        op_done     => op_done,
        div_done    => div_done,

        err_out   => err_out
    );

end architecture_Code_Discriminator;
