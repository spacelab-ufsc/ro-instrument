--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: SR_Flip_Flop.vhd
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

entity SR_Flip_Flop is
port (
    clk : in  std_logic;
    rst : in  std_logic;
    S   : in  std_logic;
    R   : in  std_logic;
    Q   : out std_logic
);
end SR_Flip_Flop;
architecture architecture_SR_Flip_Flop of SR_Flip_Flop is
    signal q_i : std_logic;
begin
    process(clk, rst)
    begin
        if rst = '1' then
            q_i <= '0';
        elsif clk'event and clk = '1' then
            if R = '1' then
                q_i <= '0';      -- RESET priority
            elsif S = '1' then
                q_i <= '1';
            end if;
        end if;
    end process;

    Q <= q_i;

end architecture_SR_Flip_Flop;