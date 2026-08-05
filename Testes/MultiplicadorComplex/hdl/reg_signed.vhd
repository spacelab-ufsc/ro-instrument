--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: reg16.vhd
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

entity reg_signed is
generic(
    reg_width : integer := 16
);
port (
    clk : in  std_logic;
    rst : in  std_logic;
    en  : in  std_logic;
    D   : in  signed(reg_width-1 downto 0);
    Q   : out signed(reg_width-1 downto 0)
);
end reg_signed;
architecture architecture_reg_signed of reg_signed is
begin
    process(clk, rst, en)
    begin
        if rst = '1' then
            Q <= (others => '0');
        elsif rising_edge(clk) then
            if en = '1' then
                Q <= D;
            end if;
        end if;    
    end process;
end architecture_reg_signed;
