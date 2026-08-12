--------------------------------------------------------------
-- D Flip Flop		
--------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.all;

--------------------------------------------------------------

entity Flip_Flop_D is
port(	
	D:	in std_logic;
	rst:	in std_logic;
	clk:	in std_logic;
	Q:	out std_logic
);
end Flip_Flop_D;

--------------------------------------------------------------
architecture arq_Flip_Flop_D of Flip_Flop_D is

begin
	process(rst, clk, D) is
	begin
		if rst = '0' then
			Q <= '0';
		elsif clk'event and clk = '1' then
			Q <= D;
		end if;
	end process;
end arq_Flip_Flop_D;

--------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.all;

--------------------------------------------------------------

entity Flip_Flop_D_en is
port(	
	D:	in std_logic;
    set:    in std_logic;
	rst:	in std_logic;
	clk:	in std_logic;
    en:     in std_logic;
	Q:	out std_logic
);
end Flip_Flop_D_en;

--------------------------------------------------------------
architecture arq_Flip_Flop_D_en of Flip_Flop_D_en is

begin
	process(rst, clk, en, D) is
	begin
		if rst = '0' then
			Q <= '0';
        elsif set = '0' then
            Q <= '1';
		elsif clk'event and clk = '1' then
            if en = '1' then 
                Q <= D;
            end if;
		end if;
	end process;
end arq_Flip_Flop_D_en;

--------------------------------------------------------------
