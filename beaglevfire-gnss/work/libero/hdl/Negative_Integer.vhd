--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Negative_Integere.vhd
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

use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity Negative_Integer is
generic(
    data_width : integer := 10
    );
port (
    SIG_IN  : IN  std_logic_vector(data_width-1 downto 0); -- example
    SIG_OUT : OUT std_logic_vector(data_width-1 downto 0)  -- example
    --<other_ports>;
);
end Negative_Integer;
architecture architecture_Negative_Integer of Negative_Integer is
   -- signal, component etc. declarations
	signal NOT_SIGNAL: std_logic_vector(data_width-1 downto 0) ; -- example
    signal Carry : std_logic_vector(data_width downto 0);
begin

   -- architecture body
   NOT_SIGNAL <= not (SIG_IN);
   Carry(0) <= '1';
	loop_invert : for i in 0 to data_width - 1 generate
		SIG_OUT(i) 	<= NOT_SIGNAL (i) xor Carry(i);
		Carry(i+1) 	<= NOT_SIGNAL (i) and Carry(i);
	end generate;
	
end architecture_Negative_Integer;