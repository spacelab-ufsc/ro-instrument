library IEEE;
use IEEE.STD_LOGIC_1164.ALL;   
use ieee.std_logic_arith.all;
use ieee.math_real.all;

entity Code_Discriminator is
	generic(
		Discriminator_Type : natural := 1 
	);
	Port ( 
		IE_corr 	: in  real;
		QE_corr		: in  real;
		IP_corr 	: in  real;
		QP_corr		: in  real;
		IL_corr 	: in  real;
		QL_corr		: in  real;
		discriminator   : out real
	);
end Code_Discriminator;

architecture Behavioral of Code_Discriminator is
	
begin
	Discriminator_1: if Discriminator_Type = 1 generate
		discriminator <= (IE_corr*IE_corr + QE_corr*QE_corr) - (IL_corr*IL_corr + QL_corr*QL_corr);
	end generate Discriminator_1;

	Discriminator_2: if Discriminator_Type = 2 generate
		discriminator <= ((IE_corr*IE_corr + QE_corr*QE_corr) - (IL_corr*IL_corr + QL_corr*QL_corr))/((IE_corr*IE_corr + QE_corr*QE_corr) + (IL_corr*IL_corr + QL_corr*QL_corr));
	end generate Discriminator_2;

	Discriminator_3: if Discriminator_Type = 3 generate
		discriminator <= IP_corr*(IE_corr - IL_corr) + QP_corr*(QE_corr - QL_corr);
	end generate Discriminator_3;
end Behavioral;
