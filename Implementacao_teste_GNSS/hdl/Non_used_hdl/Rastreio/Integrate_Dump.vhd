--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Integrate_Dump.vhd
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
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Integrate_Dump is
port (
    clk      : in std_logic;
    reset    : in std_logic;
    data_in  : in signed(15 downto 0);
    dump_en  : in std_logic;
    data_out : out signed (15 downto 0);
);
end Integrate_Dump;
architecture architecture_Integrate_Dump of Integrate_Dump is
	signal acc : signed(15 downto 0);

begin
    process(clk,reset)
    begin
        if reset = '1' then
            acc <= (others => '0');
            data_out <= (others => '0');
        elsif rising_edge(clk) then
            if dump_en = '1' then
                data_out <= acc;
                acc <= (others => '0');
            end if;
        end if;
        acc <= acc + data_in;
    end process;
    
end architecture_Integrate_Dump;
