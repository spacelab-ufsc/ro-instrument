--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Complex_multiplier.vhd
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

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Complex_multiplier is
generic(
    mult_width : integer := 8
);
port (
    clk : in std_logic;
    en : in std_logic;
    rst : in std_logic;
    -- P = A*B
    -- A = a_real + a_imag
    -- B = b_real + b_imag
	a_real : in std_logic_vector((mult_width-1) downto 0);
    a_imag : in std_logic_vector((mult_width-1) downto 0);
	b_real : in std_logic_vector((mult_width-1) downto 0);
    b_imag : in std_logic_vector((mult_width-1) downto 0);
	p_real : out std_logic_vector((2*mult_width-1) downto 0);
    p_imag : out std_logic_vector((2*mult_width-1) downto 0);
    overflow : out std_logic
    );
end Complex_multiplier;

architecture architecture_Complex_multiplier of Complex_multiplier is

    signal a, b, ai, bi : signed((mult_width-1) downto 0);
	signal k1, k2, k3, p, pi, k1r, k2r, k3r : signed((2*mult_width-1) downto 0);
    signal ov, of_k1, of_k2, of_k3, of_p, of_pi : std_logic;
    signal aai, aia, bbi, aair, aiar, bbir : signed((mult_width-1) downto 0);
  
    component reg_gen is
    generic (
        reg_width : integer := 16
    );
    port (
        clk : in  std_logic;
        rst : in  std_logic;
        en  : in  std_logic;
        D   : in  std_logic_vector((reg_width-1) downto 0);
        Q   : out std_logic_vector((reg_width-1) downto 0)
    );
    end component;
    
    component reg_signed is
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
end component;
    
begin
    REG_IN_A: reg_signed generic map (mult_width) port map(clk, rst, en, signed(a_real), a );
    REG_IN_AI: reg_signed generic map (mult_width) port map(clk, rst, en, signed(a_imag), ai);
    REG_IN_B: reg_signed generic map (mult_width) port map(clk, rst, en, signed(b_real), b);
    REG_IN_BI: reg_signed generic map (mult_width) port map(clk, rst, en, signed(b_imag), bi);
    
    aai <= a + ai;
    bbi <= b + bi;
    aia <= ai - a;
    
    REG_AAI: reg_signed generic map (mult_width) port map(clk, rst, en, aai, aair);
    REG_BBI: reg_signed generic map (mult_width) port map(clk, rst, en, bbi, bbir);
    REG_AIA: reg_signed generic map (mult_width) port map(clk, rst, en, aia, aiar);
    
    k1 <= a*bbir;
    k2 <= bi*aair;
    k3 <= b*aiar;
    
    REG_K1: reg_signed generic map (2*mult_width) port map(clk, rst, en, k1, k1r);
    REG_K2: reg_signed generic map (2*mult_width) port map(clk, rst, en, k2, k2r);
    REG_K3: reg_signed generic map (2*mult_width) port map(clk, rst, en, k3, k3r);
    
    p <= k1r - k2r;
    pi <= k1r + k3r;
    
    of_k1 <= (b(mult_width-1) xnor bi(mult_width-1)) and (b(mult_width-1) xor bbi(mult_width-1));
    of_k2 <= (a(mult_width-1) xnor ai(mult_width-1)) and (a(mult_width-1) xor aai(mult_width-1));
    of_k3 <= (a(mult_width-1) xor ai(mult_width-1)) and (a(mult_width-1) xor aia(mult_width-1));
    
    of_p  <= (k1(2*mult_width-1) xor k2(2*mult_width-1)) and (k1(2*mult_width-1) xor p(2*mult_width-1));
    of_pi <= (k1(2*mult_width-1) xnor k3(2*mult_width-1)) and (k1(2*mult_width-1) xor pi(2*mult_width-1));
    
    ov <= of_k1 or of_k2 or of_k3 or of_p or of_pi;
    
    REG_OUT_R: reg_gen generic map (2*mult_width) port map(clk, rst, en, std_logic_vector(p), p_real);
    REG_OUT_I: reg_gen generic map (2*mult_width) port map(clk, rst, en, std_logic_vector(pi), p_imag);
    REG_OUT_OV : reg_gen generic map (reg_width => 1) port map (clk => clk, rst => rst, en => en, D(0) => ov, Q(0) => overflow);
end architecture_Complex_multiplier;