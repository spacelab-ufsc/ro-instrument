--
-- Synopsys
-- Vhdl wrapper for top level design, written on Wed Aug  5 15:47:03 2026
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wrapper_for_Complex_multiplier is
   port (
      clk : in std_logic;
      en : in std_logic;
      rst : in std_logic;
      a_real : in std_logic_vector(7 downto 0);
      a_imag : in std_logic_vector(7 downto 0);
      b_real : in std_logic_vector(7 downto 0);
      b_imag : in std_logic_vector(7 downto 0);
      p_real : out std_logic_vector(15 downto 0);
      p_imag : out std_logic_vector(15 downto 0);
      overflow : out std_logic
   );
end wrapper_for_Complex_multiplier;

architecture architecture_complex_multiplier of wrapper_for_Complex_multiplier is

component Complex_multiplier
 port (
   clk : in std_logic;
   en : in std_logic;
   rst : in std_logic;
   a_real : in std_logic_vector (7 downto 0);
   a_imag : in std_logic_vector (7 downto 0);
   b_real : in std_logic_vector (7 downto 0);
   b_imag : in std_logic_vector (7 downto 0);
   p_real : out std_logic_vector (15 downto 0);
   p_imag : out std_logic_vector (15 downto 0);
   overflow : out std_logic
 );
end component;

signal tmp_clk : std_logic;
signal tmp_en : std_logic;
signal tmp_rst : std_logic;
signal tmp_a_real : std_logic_vector (7 downto 0);
signal tmp_a_imag : std_logic_vector (7 downto 0);
signal tmp_b_real : std_logic_vector (7 downto 0);
signal tmp_b_imag : std_logic_vector (7 downto 0);
signal tmp_p_real : std_logic_vector (15 downto 0);
signal tmp_p_imag : std_logic_vector (15 downto 0);
signal tmp_overflow : std_logic;

begin

tmp_clk <= clk;

tmp_en <= en;

tmp_rst <= rst;

tmp_a_real <= a_real;

tmp_a_imag <= a_imag;

tmp_b_real <= b_real;

tmp_b_imag <= b_imag;

p_real <= tmp_p_real;

p_imag <= tmp_p_imag;

overflow <= tmp_overflow;



u1:   Complex_multiplier port map (
		clk => tmp_clk,
		en => tmp_en,
		rst => tmp_rst,
		a_real => tmp_a_real,
		a_imag => tmp_a_imag,
		b_real => tmp_b_real,
		b_imag => tmp_b_imag,
		p_real => tmp_p_real,
		p_imag => tmp_p_imag,
		overflow => tmp_overflow
       );
end architecture_complex_multiplier;
