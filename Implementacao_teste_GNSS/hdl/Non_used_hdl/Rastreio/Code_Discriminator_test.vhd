--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Code_Discriminator_test.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFireSoC> <Die::MPFS025T> <Package::FCVG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;  
use ieee.std_logic_arith.all;

entity Code_Discriminator_test is
	generic(
		Discriminator_Type : integer := 1
        data_width : integer := 16
	);
	Port ( 
		IE_corr 	: in  signed(data_width-1 downto 0);
		QE_corr		: in  signed(data_width-1 downto 0);
		IP_corr 	: in  signed(data_width-1 downto 0);
		QP_corr		: in  signed(data_width-1 downto 0);
		IL_corr 	: in  signed(data_width-1 downto 0);
		QL_corr		: in  signed(data_width-1 downto 0);
		discriminator   : out signed(data_width-1 downto 0)
	);
end Code_Discriminator_test;

architecture Behavioral of Code_Discriminator_test is

    signal P_E, P_P, P_L : signed(2*data_width-1 downto 0);
    signal numerador, denominador : unsigned(data_width-1 downto 0);
    signal reciprocal : std_logic_vector(7 downto 0);
    signal mult_out : unsigned(data_width+7 downto 0);
    
    component Division_LUT is
    port(
        y     : in  std_logic_vector(3 downto 0);
        y_inv : out std_logic_vector(7 downto 0))
    );
    end component;
	
begin
    P_E <= resize(IE_corr*IE_corr + QE_corr*QE_corr, 2*data_width);
    P_P <= resize(IP_corr*IP_corr + QP_corr*QP_corr, 2*data_width);
    P_L <= resize(IL_corr*IL_corr + QL_corr*QL_corr, 2*data_width);
    
    
	Discriminator_1: if Discriminator_Type = 1 generate
        discriminator <= resize(P_E - P_L, data_width);
	end generate Discriminator_1;

	Discriminator_2: if Discriminator_Type = 2 generate
        numerador <= std_logic_vector(resize(P_E - P_L, data_width));
        denominador <= std_logic_vector(resize(P_E + P_L, data_width));
        
        DIVISION : Division_LUT
            port map(
                y => std_logic_vector(denominador(data_width-1 downto data_width-4)),
                y_inv => reciprocal
            );
        
        mult_out <= unsigned(numerador) * unsigned(reciprocal);
        discriminator <= signed(resize(mult_out(mult_out'high downto 8), data_width)); --'high' pega o maior indice do vetor
        --shift right 8 bits
        --discriminator <= ((IE_corr*IE_corr + QE_corr*QE_corr) - (IL_corr*IL_corr + QL_corr*QL_corr))/((IE_corr*IE_corr + QE_corr*QE_corr) + (IL_corr*IL_corr + QL_corr*QL_corr));
	end generate Discriminator_2;

	Discriminator_3: 
        if Discriminator_Type = 3 generate
            discriminator <= resize(IP_corr*(IE_corr - IL_corr) + QP_corr*(QE_corr - QL_corr), data_width);
	end generate Discriminator_3;
end Behavioral;

