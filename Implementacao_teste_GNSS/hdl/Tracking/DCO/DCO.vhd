library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity DCO is
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
end DCO;

architecture Behavioral of DCO is

    ------------------------------------------------------------------
    -- Internal signals
    ------------------------------------------------------------------
    signal phase_acc  : std_logic_vector(PHASE_W-1 downto 0);
    signal phase_next : std_logic_vector(PHASE_W-1 downto 0);
    signal cout_dummy : std_logic;

    ------------------------------------------------------------------
    -- Components
    ------------------------------------------------------------------
    component shift_reg
        generic (
            data_width : integer := PHASE_W
        );
        port (
            en     : in  std_logic;
            clk    : in  std_logic;
            rst    : in  std_logic;
            serial : in  std_logic;
            shift  : in  std_logic;
            I      : in  std_logic_vector(data_width-1 downto 0);
            O      : out std_logic_vector(data_width-1 downto 0)
        );
    end component;

	component adder
		generic(
			data_width : integer := PHASE_W
		);
		port(	
			A:	in std_logic_vector(data_width-1 downto 0);
			B:	in std_logic_vector(data_width-1 downto 0);
			Cin:	in std_logic;

			S:	out std_logic_vector(data_width-1 downto 0);
			Cout:	out std_logic
		);
	end component;

begin

    ------------------------------------------------------------------
    -- Phase adder (wrap-around accumulator)
    ------------------------------------------------------------------
    PHASE_ADD : adder
        generic map (
            data_width => PHASE_W
        )
        port map (
            A    => phase_acc,
            B    => phase_inc,
            Cin  => '0',
            S    => phase_next,
            Cout => cout_dummy
        );

    ------------------------------------------------------------------
    -- Phase accumulator register (using shift_reg)
    ------------------------------------------------------------------
    PHASE_REG : shift_reg
        generic map (
            data_width => PHASE_W
        )
        port map (
            en     => '1',
            clk    => clk,
            rst    => reset,
            serial => '0',        -- not used
            shift  => '0',        -- parallel load
            I      => phase_next,
            O      => phase_acc
        );

    ------------------------------------------------------------------
    -- Chip strobes from MSB toggles
    ------------------------------------------------------------------
    chip_en_1x <= phase_acc(PHASE_W-1) xor phase_next(PHASE_W-1);
    chip_en_2x <= phase_acc(PHASE_W-2) xor phase_next(PHASE_W-2);
end Behavioral;
