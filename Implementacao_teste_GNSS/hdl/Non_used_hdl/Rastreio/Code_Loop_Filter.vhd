library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Code_Loop_Filter is
	generic(
		WIDTH : integer := 16;
        Kp    : integer := 0; --ajustar o ganho
        Ki    : integer := 0; --ajustar o ganho
    );
	Port ( 
		clk             : in  std_logic;
		reset           : in  std_logic;
		input_error     : in  std_logic_vector(WIDTH-1 downto 0);
		filtered_out    : out std_logic_vector(WIDTH-1 downto 0)
	);
end Code_Loop_Filter;

architecture Behavioral of Code_Loop_Filter is

    signal integrator_out, filtered_signal : std_logic_vector(WIDTH-1 downto 0);
    

	component adder 
	generic(
		data_width : integer := WIDTH
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
		data_width : integer := WIDTH
	);
	port(
		-- 	Bit Inputs
		en:	in std_logic;
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

begin

	reg1 : shift_reg 
		generic map( data_width => WIDTH)
		port map (en=>'1',clk=>clk,rst=>reset,serial => '0', shift  => '0', I => filtered_signal, O => integrator_out);

	sum1: adder
		generic map(data_width => WIDTH)
		port map (A => input_error, B => integrator_out, Cin => '0', S => filtered_signal, Cout => open);

	filtered_out <= filtered_signal;
end Behavioral;
