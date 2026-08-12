library IEEE;
use IEEE.STD_LOGIC_1164.ALL;   
use ieee.std_logic_arith.all;
use ieee.math_real.all;

entity Phase_Discriminator is
	generic(
		Discriminator_Type : natural := 1 
	);
	Port (
		I_signal 	: in  real;
		Q_signal	: in  real;
		discriminator   : out real
	);
end Code_Discriminator;

architecture Behavioral of Code_Discriminator is
	
begin
	Discriminator_1: if Discriminator_Type = 1 generate
		discriminator <= sign(I_signal)*Q_signal;
	end generate Discriminator_1;

	Discriminator_2: if Discriminator_Type = 2 generate
		discriminator <= I_signal*Q_signal;
	end generate Discriminator_2;

	Discriminator_3: if Discriminator_Type = 3 generate
		discriminator <= atan2(Q_signal,I_signal);
	end generate Discriminator_3;
end Behavioral;
