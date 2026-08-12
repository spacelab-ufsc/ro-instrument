--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Acquisition_control.vhd
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

--Detection and control logic
library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Acquisition_control is
Port( 
        clk : in std_logic;
        reset : in std_logic;
        OUT_I : in std_logic_vector(20 downto 0);
        OUT_Q : in std_logic_vector(20 downto 0);
        READ_OUT_V : out std_logic;
        SAT_state : out std_logic;
        idle : out std_logic
    );
end Acquisition_control;

architecture Behavioral of Acquisition_control is
    type sv_state is (acquired,not_acquired);
    signal state : sv_state := not_acquired;
    constant Threshold : integer := 5000;
    signal magnitude : integer;
    signal I_int,Q_int : integer;
    
begin
    I_int <= to_integer(signed(OUT_I));
    Q_int <= to_integer(signed(OUT_Q));
    process(I_int,Q_int)
    begin
       magnitude <= (I_int*I_int) + (Q_int*Q_int); 
    end process;
    
    process(clk,reset,magnitude,state)
    begin
        if reset = '0' then
            state <= not_acquired;
        elsif rising_edge(clk) then 
            case state is
                when not_acquired =>
                    if READ_OUT_V = '1'then
                        if magnitude >= Threshold then
                            state <= acquired;
                        else 
                            state <= not_acquired;
                        end if;
                    end if;
                    
                when acquired =>
                    if READ_OUT_V = '1' then
                        if magnitude < (Threshold / 2) then
                            state <= not_acquired;
                        else
                            state <= acquired;
                        end if;
                    end if;
            end case;
        end if;
    end process;
    
    SAT_state <= '1' when state = acquired else '0';
    idle <= '0' when state = acquired else '1';
end Behavioral;