--------------------------------------------------------------
-- Contador sincrono com reset		
--------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.all;

--------------------------------------------------------------

entity contador is
generic(
	data_width : integer := 6
);
port(	clk: 	in std_logic;
	init:	in std_logic;
	count:	out std_logic_vector(data_width-1 downto 0)
);
end contador;

--------------------------------------------------------------

architecture arq_contador of contador is

signal EA, PE: std_logic_vector(data_width-1 downto 0);

begin
 	process(clk, init, PE) is
	begin
		if init = '1' then
			EA <= (others => '0');
		elsif clk'event and clk= '1' then
			EA <= PE;
		end if;
	end process;
	PE <= unsigned(EA) + 1;
	count <= EA;
end arq_contador;


--------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.all;

entity contador_ud_en is
generic(
	data_width  : integer := 6;
    dir         : std_logic := '0'
);
port(	
    clk     : 	in std_logic;
    en      :   in std_logic;
	init    :	in std_logic;
	count   :	out std_logic_vector(data_width-1 downto 0)
);
end contador_ud_en;

--------------------------------------------------------------

architecture arq_contador_ud_en of contador_ud_en is

signal EA, PE, inc: std_logic_vector(data_width-1 downto 0);

begin
 	process(clk, init, PE) is
	begin
		if init = '1' then
			EA <= (others => dir);
		elsif clk'event and clk= '1' then
            if en = '1' then
                EA <= PE;
            end if;
		end if;
	end process;
    
    PE <= unsigned(EA) + unsigned(inc);
        
    inc(inc'left downto 1) <= (others => dir);
    inc(0) <= '1';
	
    count <= EA;
end arq_contador_ud_en;
