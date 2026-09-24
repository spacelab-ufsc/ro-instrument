--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Freq_divider.vhd
-- File history:
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--      <Revision number>: <Date>: <Comments>
--
-- Description: 
--
-- <Description here>
--
-- Targeted device: <Family::PolarFireSoC> <Die::MPFS025TL> <Package::FCVG484>
-- Author: <Name>
--
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use IEEE.MATH_REAL.ALL;


entity Freq_divider is
generic (
    DIV : positive :=  1
);
port (
    --<port_name> : <direction> <type>;
	clk_in      : IN  std_logic; 
    rstn        : IN  std_logic; 
    clk_out     : out std_logic
    --<other_ports>;
);
end Freq_divider;
architecture architecture_Freq_divider of Freq_divider is
    -- signal, component etc. declarations
    -- Defining the constants for std_vector widths
    constant LIMIT_VAL : integer := (DIV / 2) - 1;
    constant COUNTER_WIDTH : integer := integer(ceil(log2(real(LIMIT_VAL + 1))));

    -- Defining the signals
	signal TR           : std_logic;
	signal freq_div     : std_logic_vector(COUNTER_WIDTH-1 downto 0); -- example
    signal counter_out  : std_logic_vector(COUNTER_WIDTH-1 downto 0);

    component contador_srst
        generic(
            data_width : integer := 6
        );
        port( 
            -- Inputs
            clk : in std_logic;
            en : in std_logic;
            nrst : in std_logic;
            srst : in std_logic;
            -- Outputs
            count : out std_logic_vector(data_width-1 downto 0)
        );
    end component;
    
    component TFF is
    port (
        Tin     :	in std_logic;
        nrst    :	in std_logic;
        clk     :	in std_logic;
        Q       :	out std_logic
    );
    end component;
    
begin
    -- architecture body
    assert (DIV > 0 and (DIV mod 2 = 0))
        report "Error: Division factor must be positive and even."
        severity failure;
        
    freq_div <= std_logic_vector(to_unsigned(LIMIT_VAL, COUNTER_WIDTH));
    
    U1: contador_srst 
                generic map (
                data_width => COUNTER_WIDTH
                )
                port map(
                    clk => clk_in, 
                    en => '1',
                    nrst => rstn,
                    srst => TR,
                    count => counter_out
                    );
                    
    U2: TFF port map(Tin => TR, nrst => rstn, clk => clk_in, Q => clk_out);
    
    TR <= and(not(counter_out xor freq_div));
end architecture_Freq_divider;
