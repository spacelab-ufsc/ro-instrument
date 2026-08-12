library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity NCO_test is
	generic(
		phase_width	: integer := 32
	);
	Port ( 
		clk	        : in std_logic;
		reset		: in std_logic;
		phase_diff  : in unsigned(phase_width-1 downto 0);
		nco_out   	: out std_logic;
	);
end NCO_test;

architecture Behavioral of NCO_test is
    signal	phase_acc : unsigned(phase_width-1 downto 0) := (others => '0');
    
begin
	process(clk, reset, phase_diff)
	begin
		if clk'event and clk = '1' then
			if reset = '1' then
				phase_acc <= (others => '0');
			else
				phase_acc <= phase_acc + phase_diff;				
			end if;
		end if;
	end process;
    nco_out <= phase_acc(phase_width-1); 

end Behavioral;
