library ieee ;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity division_lut is
port(
  y          : in  std_logic_vector(3 downto 0);
  y_inv      : out std_logic_vector(7 downto 0));
end division_lut;

architecture rtl of division_lut is
constant C_NY       : integer:= 4;
constant C_NDY      : integer:= 8;

type t_divition_lut is array (0 to 2**C_NY-1) of integer range 0 to 2**C_NDY-1;

constant C_DIV_LUT  : t_divition_lut := (
  255,
  255,
  127,
   84,
   63,
   50,
   42,
   36,
   31,
   27,
   25,
   22,
   20,
   19,
   17,
   16);

begin

  y_inv <= std_logic_vector(to_unsigned(C_DIV_LUT(to_integer(unsigned(y))),C_NDY));
    
end rtl;