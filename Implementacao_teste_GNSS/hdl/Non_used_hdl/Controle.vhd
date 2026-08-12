--------------------------------------------------------------
-- Multiplicador		
--------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.all;

--------------------------------------------------------------

entity Controle is
port(
	-- 	Bit Inputs
	go:	in std_logic;
	clk:	in std_logic;
	Tm:	in std_logic;
	Q0:	in std_logic;
	rst: 	in std_logic;

	--	Bit Outputs
	Tw_MSB:		out std_logic;
	Tc:		out std_logic;
	T_init: 	out std_logic;
	Ts:		out std_logic;
	
	idle:		out std_logic
);
end Controle;

--------------------------------------------------------------
architecture arq_Controle of Controle is

type STATES is (E0,E1,E2);
signal EA, PE: STATES;

begin

P1:	process(clk, rst, PE)
	begin
		if rst = '1' then
			EA <= E0;
		elsif clk'event and clk = '1' then
			EA <= PE;
		end if;	
	end process;

P2: 	process(EA, go, Tm, Q0)
	begin
		case EA is
			when E0 =>
				Tw_MSB 	<= 	'0';
				Tc 	<= 	'0';
				Ts	<= 	'0';
				idle	<=	'1';
				if go = '1' then
					PE 	<= 	E1;
					T_init 	<= 	'1';
				else 
					PE 	<= 	E0;
					T_init 	<= 	'0';
				end if;
			when E1 =>
				T_init 	<= 	'0';
				if Q0 = '1' then
					Tw_MSB 	<= 	'1';
					Tc 	<= 	'0';
				else 
					Tw_MSB 	<= 	'0';
					Tc 	<= 	'1';
				end if;
				Ts	<= 	'0';
				idle	<=	'0';
				PE <= E2;
			when E2 =>
				T_init 	<= 	'0';
				Tw_MSB 	<= 	'0';
				Tc 	<= 	'1';
				Ts	<= 	'1';
				idle	<=	'0';
				if Tm = '1' then
					PE <= E0;
				else 
					PE <= E1;
				end if;
		end case;
	end process;

end arq_Controle;

--------------------------------------------------------------
