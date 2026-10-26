--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Acquisition_Detection.vhd
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

entity Acquisition_Detection is
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
end Acquisition_Detection;
architecture architecture_Acquisition_Detection of Acquisition_Detection is
    -- component etc. declarations
    -- data_width
    constant data_width_out   : natural := 32;
    constant FFT_length       : natural := 12;
    
    -- signals
	signal ABS_VALID        : std_logic; 
    signal NEW_MAX_CORR_EN  : std_logic; 
    signal reset_max        : std_logic;
    
    --signal cordic_x            : std_logic_vector (15 downto 0);
    --signal cordic_y            : std_logic_vector (15 downto 0);
    --signal cordic_a            : std_logic_vector (17 downto 0);
    
    --signal x_squared    : signed (31 downto 0);
    --signal y_squared    : signed (31 downto 0);
    --signal abs_squared  : signed (32 downto 0);
    
    signal Y_IN_NEG       : std_logic_vector (15 downto 0);
    signal abs_squared    : std_logic_vector (32 downto 0);
        
    signal clkd         : std_logic_vector (4 downto 0);
	
    signal ABS_DATA     : std_logic_vector (31 downto 0);
    signal MAX_CORR     : std_logic_vector (31 downto 0);

    signal NEW_CODE_VAL : std_logic_vector (FFT_length-1 downto 0);
    signal CODE_DELAY_S : std_logic_vector (15 downto 0);
    
    component CORECORDIC_C0
    -- Port list
    port(
        -- Inputs
        CLK        : in  std_logic;
        DIN_VALID  : in  std_logic;
        DIN_X      : in  std_logic_vector(15 downto 0);
        DIN_Y      : in  std_logic_vector(15 downto 0);
        NGRST      : in  std_logic;
        RST        : in  std_logic;
        -- Outputs
        DOUT_A     : out std_logic_vector(17 downto 0);
        DOUT_VALID : out std_logic;
        DOUT_X     : out std_logic_vector(17 downto 0)
        );
    end component;
    
    component Flip_Flop_D is
    port(	
        D:	    in std_logic;
        rst:	in std_logic;
        clk:	in std_logic;
        Q:	    out std_logic
    );
    end component;
    
    component UAL
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
    
    component shift_reg
    generic(
        data_width : integer := 64
    );
    port(
        -- 	Bit Inputs
        en:	    in std_logic;
        clk:	in std_logic;
        rst:	in std_logic;
        serial:	in std_logic;
        shift:	in std_logic;

        -- 	Bit_Vector Inputs
        I:	in std_logic_vector(data_width-1 downto 0);

        --	Bit_Vector Outputs
        O:	out std_logic_vector(data_width-1 downto 0)
    );
    end component;
    
    component contador
    generic(
        data_width  : integer := 6
    );
    port(	
        clk     : 	in std_logic;
        init    :	in std_logic;
        count   :	out std_logic_vector(data_width-1 downto 0)
    );
    end component;
    
    component complex_multiplier_C2 is
    -- Port list
    port(
        -- Inputs
        aimag_i  : in  std_logic_vector(15 downto 0);
        areal_i  : in  std_logic_vector(15 downto 0);
        bimag_i  : in  std_logic_vector(15 downto 0);
        breal_i  : in  std_logic_vector(15 downto 0);
        clock_i  : in  std_logic;
        nreset_i : in  std_logic;
        -- Outputs
        cimag_o  : out std_logic_vector(32 downto 0);
        creal_o  : out std_logic_vector(32 downto 0)
        );
    end component;
    
begin   
    -- Compute ABS of the Correlation
    CONJ_Y: entity work.Negative_Integer generic map(data_width => 16) 
        port map(SIG_IN  => Y_IN, SIG_OUT => Y_IN_NEG);
    
    ABS_CALC: complex_multiplier_C2 port map (Y_IN, X_IN, Y_IN_NEG, X_IN, clk, NRST, open, abs_squared);
    
    clkd(0) <= VALID_IN;
    CLK_MULT_D: for i in 0 to 3 generate
		delay_I: Flip_Flop_D port map(clkd(i),NRST, clk, clkd(i+1)); -- ainda a ser verificado
	end generate;	
    
    ABS_DATA    <= abs_squared(ABS_DATA'high downto ABS_DATA'low);
    ABS_VALID   <= clkd(clkd'high);
    
    --x_squared <= signed(X_IN) * signed(X_IN);
    --y_squared <= signed(Y_IN) * signed(Y_IN);
    --abs_squared <= x_squared + y_squared;
    
    --cordic_x <= X_IN(15)& X_IN(15)& X_IN(14 downto 1);
    --cordic_y <= std_logic_vector(shift_right(signed(Y_IN), 1));
   -- 
    --ABS_CALC: CORECORDIC_C0 
        --port map(
            --CLK         => clk,
            --DIN_VALID   => VALID_IN,
            --DIN_X       => cordic_x,
            --DIN_Y       => cordic_y,
            --NGRST       => NRST,
            --RST         => '0',
            --DOUT_A      => open,
            --DOUT_VALID  => ABS_VALID,
            --DOUT_X      => cordic_a
        --);
        --
        --ABS_DATA(cordic_a'high downto 0) <= cordic_a;
        --ABS_DATA(ABS_DATA'high downto cordic_a'high + 1) <= (others => cordic_a(cordic_a'high));
        --
    --clkd(0) <= VALID_IN;
    ---- Core CORDIC has a delay de 18 clock cycles in the configuration
    ---- Delay = Number_of_interactions + 2 = 30 + 2 = 8 
    --CLK_MULT_D: for i in 0 to 30 generate
		--delay_I: Flip_Flop_D port map(clkd(i), NRST, clk, clkd(i+1));
	--end generate;

    COMPARATOR: UAL 
        generic map (data_width => data_width_out)
        port map (
            A       =>  ABS_DATA,
            B       =>  not MAX_CORR,
            Cin     =>  '1',
            S       =>  open,
            Cout    =>  NEW_MAX_CORR_EN
        );
        
    STORED_CORR: shift_reg
        generic map (data_width => data_width_out)
        port map(
            en      =>  NEW_MAX_CORR_EN,
            clk     =>	clk,
            rst     =>	reset_max,
            serial  =>  '0',
            shift   =>  '0',
            I       =>  ABS_DATA,            
            O       =>	MAX_CORR            
        );
    A_OUT <= MAX_CORR;
    --reset_max <= NRST and ABS_VALID;
    reset_max <= NRST and not (clkd(3) and not clkd(4));
    VALID_OUT <= (not clkd(3) and clkd(4));
    ---------------------------------------------------
    --- Code position
    ---------------------------------------------------
    CODE_POS: contador
        generic map (data_width => FFT_length)
        port map (
        clk     =>  clk, 
        init    =>  not reset_max, 
        count   =>  NEW_CODE_VAL
        );
        
    CODE_DELAY_S <=
    std_logic_vector(resize(unsigned(NEW_CODE_VAL), CODE_DELAY_S'length));

    STORED_CODE_DELAY: shift_reg
        generic map (data_width => 16)
        port map(
            en      =>  NEW_MAX_CORR_EN,
            clk     =>	clk,
            rst     =>	NRST,
            serial  =>  '0',
            shift   =>  '0',
            I       =>  CODE_DELAY_S,            
            O       =>	CODE_DELAY       
        );
        
    ---------------------------------------------------
    --- Doppler shift frequency
    ---------------------------------------------------
    STORED_FDoppler: shift_reg
        generic map (data_width => F_Doppler_IN'length)
        port map(
            en      =>  START_Cycle,
            clk     =>	clk,
            rst     =>	NRST,
            serial  =>  '0',
            shift   =>  '0',
            I       =>  F_Doppler_IN,            
            O       =>	F_Doppler_O       
        );
    
    ---------------------------------------------------
    --- SAT ID 
    ---------------------------------------------------
    STORED_SAT_ID: shift_reg
        generic map (data_width => SAT_ID_IN'length)
        port map(
            en      =>  START_Cycle,
            clk     =>	clk,
            rst     =>	NRST,
            serial  =>  '0',
            shift   =>  '0',
            I       =>  SAT_ID_IN,            
            O       =>	SAT_ID_O
        );
   
end architecture_Acquisition_Detection;
