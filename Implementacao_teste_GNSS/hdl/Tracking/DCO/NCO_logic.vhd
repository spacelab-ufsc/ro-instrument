library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NCO_logic is
	Port ( 
		clk		: in  	std_logic;
		reset		: in  	std_logic;
		target   	: in 	integer;
		nco_out   	: out 	std_logic
	);
end NCO_logic;

architecture Behavioral of NCO_logic is
	signal	counter : integer;
	signal 	reached	: std_logic;
begin

	process(clk, reset)
	begin
		if reset = '1' then
			counter <= 0;
		elsif clk'event and clk = '1' then
			if reached = '1' then
				counter <= 0;
			else
				counter <= counter + 1; 		
			end if;
		end if;
	end process;

	reached <= '1' when counter = target else '0';
	nco_out <= reached;

end Behavioral;
