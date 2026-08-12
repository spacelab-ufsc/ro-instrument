library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity adpll is
	generic( 
		WIDTH : integer := 16
	);
	Port ( 
		clk             : in  std_logic;
		reset           : in  std_logic;
		ref_signal     	: in  std_logic;
		input_signal 	: in  std_logic;
		dco_out       	: out std_logic;
		lock		: out std_logic
	);
end adpll;

architecture Behavioral of adpll is

    	signal phase_error_value : std_logic_vector(WIDTH-1 downto 0);
    	signal control_signal : std_logic_vector(WIDTH-1 downto 0);
	constant lock_value : std_logic_vector(WIDTH-1 downto 0) := (others => '0');

begin

	Phase_Detector_inst : entity work.Phase_Detector 
	generic map(
		WIDTH => WIDTH
		)
	Port map(
		clk 		=> clk,
		rst		=> reset,
		ref_signal 	=> ref_signal,
		input_signal 	=> input_signal,
		phase_error 	=> phase_error_value
		);	


 	Looop_Filter_inst: entity work.Loop_filter
	generic map(
		WIDTH => WIDTH
		)
	Port map( 
		clk 		=> clk,
		reset 		=> reset,
		input_error  	=> phase_error_value,
		filtered_out    => control_signal
	);


	DCO_inst : entity work.DCO
	generic map(
		control_width => WIDTH
	)
	Port map( 
		clk             => clk,
		reset           => reset,
		control_input   => control_signal,
		dco_out   	=> dco_out
	);

	lock <= '1' when phase_error_value = lock_value else 
		'0';
end Behavioral;
