-- Version: 2025.1 2025.1.0.14

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity reg_signed_8_0 is

    port( a_imag_c   : in    std_logic_vector(7 downto 0);
          ai         : out   std_logic_vector(7 downto 0);
          en_c       : in    std_logic;
          clk        : in    std_logic;
          rst_arst_i : in    std_logic
        );

end reg_signed_8_0;

architecture DEF_ARCH of reg_signed_8_0 is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \VCC\, \GND\ : std_logic;

begin 


    \Q[6]\ : SLE
      port map(D => a_imag_c(6), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => ai(6));
    
    \Q[1]\ : SLE
      port map(D => a_imag_c(1), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => ai(1));
    
    \Q[0]\ : SLE
      port map(D => a_imag_c(0), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => ai(0));
    
    \Q[7]\ : SLE
      port map(D => a_imag_c(7), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => ai(7));
    
    \Q[2]\ : SLE
      port map(D => a_imag_c(2), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => ai(2));
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    \Q[5]\ : SLE
      port map(D => a_imag_c(5), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => ai(5));
    
    \Q[4]\ : SLE
      port map(D => a_imag_c(4), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => ai(4));
    
    \Q[3]\ : SLE
      port map(D => a_imag_c(3), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => ai(3));
    
    GND_Z : GND
      port map(Y => \GND\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity reg_signed_8 is

    port( a_real_c   : in    std_logic_vector(7 downto 0);
          a          : out   std_logic_vector(7 downto 0);
          en_c       : in    std_logic;
          clk        : in    std_logic;
          rst_arst_i : in    std_logic
        );

end reg_signed_8;

architecture DEF_ARCH of reg_signed_8 is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \VCC\, \GND\ : std_logic;

begin 


    \Q[6]\ : SLE
      port map(D => a_real_c(6), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => a(6));
    
    \Q[1]\ : SLE
      port map(D => a_real_c(1), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => a(1));
    
    \Q[0]\ : SLE
      port map(D => a_real_c(0), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => a(0));
    
    \Q[7]\ : SLE
      port map(D => a_real_c(7), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => a(7));
    
    \Q[2]\ : SLE
      port map(D => a_real_c(2), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => a(2));
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    \Q[5]\ : SLE
      port map(D => a_real_c(5), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => a(5));
    
    \Q[4]\ : SLE
      port map(D => a_real_c(4), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => a(4));
    
    \Q[3]\ : SLE
      port map(D => a_real_c(3), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => a(3));
    
    GND_Z : GND
      port map(Y => \GND\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity reg_signed_8_2 is

    port( b_imag_c   : in    std_logic_vector(7 downto 0);
          bi         : out   std_logic_vector(7 downto 0);
          en_c       : in    std_logic;
          clk        : in    std_logic;
          rst_arst_i : in    std_logic
        );

end reg_signed_8_2;

architecture DEF_ARCH of reg_signed_8_2 is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \VCC\, \GND\ : std_logic;

begin 


    \Q[6]\ : SLE
      port map(D => b_imag_c(6), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => bi(6));
    
    \Q[1]\ : SLE
      port map(D => b_imag_c(1), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => bi(1));
    
    \Q[0]\ : SLE
      port map(D => b_imag_c(0), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => bi(0));
    
    \Q[7]\ : SLE
      port map(D => b_imag_c(7), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => bi(7));
    
    \Q[2]\ : SLE
      port map(D => b_imag_c(2), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => bi(2));
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    \Q[5]\ : SLE
      port map(D => b_imag_c(5), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => bi(5));
    
    \Q[4]\ : SLE
      port map(D => b_imag_c(4), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => bi(4));
    
    \Q[3]\ : SLE
      port map(D => b_imag_c(3), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => bi(3));
    
    GND_Z : GND
      port map(Y => \GND\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity reg_signed_8_1 is

    port( b_real_c   : in    std_logic_vector(7 downto 0);
          b          : out   std_logic_vector(7 downto 0);
          en_c       : in    std_logic;
          clk        : in    std_logic;
          rst_arst_i : in    std_logic
        );

end reg_signed_8_1;

architecture DEF_ARCH of reg_signed_8_1 is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \VCC\, \GND\ : std_logic;

begin 


    \Q[6]\ : SLE
      port map(D => b_real_c(6), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => b(6));
    
    \Q[1]\ : SLE
      port map(D => b_real_c(1), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => b(1));
    
    \Q[0]\ : SLE
      port map(D => b_real_c(0), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => b(0));
    
    \Q[7]\ : SLE
      port map(D => b_real_c(7), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => b(7));
    
    \Q[2]\ : SLE
      port map(D => b_real_c(2), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => b(2));
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    \Q[5]\ : SLE
      port map(D => b_real_c(5), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => b(5));
    
    \Q[4]\ : SLE
      port map(D => b_real_c(4), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => b(4));
    
    \Q[3]\ : SLE
      port map(D => b_real_c(3), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => b(3));
    
    GND_Z : GND
      port map(Y => \GND\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity reg_gen_16 is

    port( p           : in    std_logic_vector(15 downto 1);
          p_real_c    : out   std_logic_vector(15 downto 0);
          p_0_axb_0_i : in    std_logic;
          en_c        : in    std_logic;
          clk         : in    std_logic;
          rst_arst_i  : in    std_logic
        );

end reg_gen_16;

architecture DEF_ARCH of reg_gen_16 is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal \VCC\, \GND\ : std_logic;

begin 


    \Q[6]\ : SLE
      port map(D => p(6), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(6));
    
    GND_Z : GND
      port map(Y => \GND\);
    
    \Q[13]\ : SLE
      port map(D => p(13), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(13));
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    \Q[14]\ : SLE
      port map(D => p(14), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(14));
    
    \Q[15]\ : SLE
      port map(D => p(15), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(15));
    
    \Q[11]\ : SLE
      port map(D => p(11), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(11));
    
    \Q[2]\ : SLE
      port map(D => p(2), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(2));
    
    \Q[4]\ : SLE
      port map(D => p(4), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(4));
    
    \Q[10]\ : SLE
      port map(D => p(10), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(10));
    
    \Q[3]\ : SLE
      port map(D => p(3), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(3));
    
    \Q[7]\ : SLE
      port map(D => p(7), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(7));
    
    \Q[12]\ : SLE
      port map(D => p(12), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(12));
    
    \Q[8]\ : SLE
      port map(D => p(8), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(8));
    
    \Q[1]\ : SLE
      port map(D => p(1), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(1));
    
    \Q[0]\ : SLE
      port map(D => p_0_axb_0_i, CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(0));
    
    \Q[9]\ : SLE
      port map(D => p(9), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(9));
    
    \Q[5]\ : SLE
      port map(D => p(5), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_real_c(5));
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity reg_gen_1 is

    port( en_c       : in    std_logic;
          ov         : in    std_logic;
          clk        : in    std_logic;
          rst_arst_i : in    std_logic;
          overflow_c : out   std_logic
        );

end reg_gen_1;

architecture DEF_ARCH of reg_gen_1 is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

    signal \VCC\, \GND\ : std_logic;

begin 


    \Q[0]\ : SLE
      port map(D => ov, CLK => clk, EN => en_c, ALn => rst_arst_i, 
        ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT => \GND\, Q
         => overflow_c);
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    GND_Z : GND
      port map(Y => \GND\);
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity reg_gen_16_0 is

    port( pi           : in    std_logic_vector(15 downto 1);
          p_imag_c     : out   std_logic_vector(15 downto 0);
          pi_0_cry_0_Y : in    std_logic;
          en_c         : in    std_logic;
          clk          : in    std_logic;
          rst_arst_i   : in    std_logic
        );

end reg_gen_16_0;

architecture DEF_ARCH of reg_gen_16_0 is 

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

    signal \VCC\, \GND\ : std_logic;

begin 


    \Q[6]\ : SLE
      port map(D => pi(6), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(6));
    
    GND_Z : GND
      port map(Y => \GND\);
    
    \Q[13]\ : SLE
      port map(D => pi(13), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(13));
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    \Q[14]\ : SLE
      port map(D => pi(14), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(14));
    
    \Q[15]\ : SLE
      port map(D => pi(15), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(15));
    
    \Q[11]\ : SLE
      port map(D => pi(11), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(11));
    
    \Q[2]\ : SLE
      port map(D => pi(2), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(2));
    
    \Q[4]\ : SLE
      port map(D => pi(4), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(4));
    
    \Q[10]\ : SLE
      port map(D => pi(10), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(10));
    
    \Q[3]\ : SLE
      port map(D => pi(3), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(3));
    
    \Q[7]\ : SLE
      port map(D => pi(7), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(7));
    
    \Q[12]\ : SLE
      port map(D => pi(12), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(12));
    
    \Q[8]\ : SLE
      port map(D => pi(8), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(8));
    
    \Q[1]\ : SLE
      port map(D => pi(1), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(1));
    
    \Q[0]\ : SLE
      port map(D => pi_0_cry_0_Y, CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(0));
    
    \Q[9]\ : SLE
      port map(D => pi(9), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(9));
    
    \Q[5]\ : SLE
      port map(D => pi(5), CLK => clk, EN => en_c, ALn => 
        rst_arst_i, ADn => \VCC\, SLn => \VCC\, SD => \GND\, LAT
         => \GND\, Q => p_imag_c(5));
    

end DEF_ARCH; 

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity Complex_multiplier is

    port( clk      : in    std_logic;
          en       : in    std_logic;
          rst      : in    std_logic;
          a_real   : in    std_logic_vector(7 downto 0);
          a_imag   : in    std_logic_vector(7 downto 0);
          b_real   : in    std_logic_vector(7 downto 0);
          b_imag   : in    std_logic_vector(7 downto 0);
          p_real   : out   std_logic_vector(15 downto 0);
          p_imag   : out   std_logic_vector(15 downto 0);
          overflow : out   std_logic
        );

end Complex_multiplier;

architecture DEF_ARCH of Complex_multiplier is 

  component OUTBUF
    port( D   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component ARI1
    generic (INIT:std_logic_vector(19 downto 0) := x"00000");

    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          D   : in    std_logic := 'U';
          FCI : in    std_logic := 'U';
          S   : out   std_logic;
          Y   : out   std_logic;
          FCO : out   std_logic
        );
  end component;

  component reg_signed_8_0
    port( a_imag_c   : in    std_logic_vector(7 downto 0) := (others => 'U');
          ai         : out   std_logic_vector(7 downto 0);
          en_c       : in    std_logic := 'U';
          clk        : in    std_logic := 'U';
          rst_arst_i : in    std_logic := 'U'
        );
  end component;

  component INBUF
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component MACC_PA
    port( A                    : in    std_logic_vector(17 downto 0) := (others => 'U');
          AL_N                 : in    std_logic := 'U';
          ARSHFT17             : in    std_logic := 'U';
          ARSHFT17_AD_N        : in    std_logic := 'U';
          ARSHFT17_BYPASS      : in    std_logic := 'U';
          ARSHFT17_EN          : in    std_logic := 'U';
          ARSHFT17_SD_N        : in    std_logic := 'U';
          ARSHFT17_SL_N        : in    std_logic := 'U';
          A_BYPASS             : in    std_logic := 'U';
          A_EN                 : in    std_logic := 'U';
          A_SRST_N             : in    std_logic := 'U';
          B                    : in    std_logic_vector(17 downto 0) := (others => 'U');
          B_BYPASS             : in    std_logic := 'U';
          B_EN                 : in    std_logic := 'U';
          B_SRST_N             : in    std_logic := 'U';
          C                    : in    std_logic_vector(47 downto 0) := (others => 'U');
          CARRYIN              : in    std_logic := 'U';
          CDIN                 : in    std_logic_vector(47 downto 0) := (others => 'U');
          CDIN_FDBK_SEL        : in    std_logic_vector(1 downto 0) := (others => 'U');
          CDIN_FDBK_SEL_AD_N   : in    std_logic_vector(1 downto 0) := (others => 'U');
          CDIN_FDBK_SEL_BYPASS : in    std_logic := 'U';
          CDIN_FDBK_SEL_EN     : in    std_logic := 'U';
          CDIN_FDBK_SEL_SD_N   : in    std_logic_vector(1 downto 0) := (others => 'U');
          CDIN_FDBK_SEL_SL_N   : in    std_logic := 'U';
          CLK                  : in    std_logic := 'U';
          C_ARST_N             : in    std_logic := 'U';
          C_BYPASS             : in    std_logic := 'U';
          C_EN                 : in    std_logic := 'U';
          C_SRST_N             : in    std_logic := 'U';
          D                    : in    std_logic_vector(17 downto 0) := (others => 'U');
          DOTP                 : in    std_logic := 'U';
          D_ARST_N             : in    std_logic := 'U';
          D_BYPASS             : in    std_logic := 'U';
          D_EN                 : in    std_logic := 'U';
          D_SRST_N             : in    std_logic := 'U';
          OVFL_CARRYOUT_SEL    : in    std_logic := 'U';
          PASUB                : in    std_logic := 'U';
          PASUB_AD_N           : in    std_logic := 'U';
          PASUB_BYPASS         : in    std_logic := 'U';
          PASUB_EN             : in    std_logic := 'U';
          PASUB_SD_N           : in    std_logic := 'U';
          PASUB_SL_N           : in    std_logic := 'U';
          P_BYPASS             : in    std_logic := 'U';
          P_EN                 : in    std_logic := 'U';
          P_SRST_N             : in    std_logic := 'U';
          SIMD                 : in    std_logic := 'U';
          SUB                  : in    std_logic := 'U';
          SUB_AD_N             : in    std_logic := 'U';
          SUB_BYPASS           : in    std_logic := 'U';
          SUB_EN               : in    std_logic := 'U';
          SUB_SD_N             : in    std_logic := 'U';
          SUB_SL_N             : in    std_logic := 'U';
          CDOUT                : out   std_logic_vector(47 downto 0);
          OVFL_CARRYOUT        : out   std_logic;
          P                    : out   std_logic_vector(47 downto 0)
        );
  end component;

  component reg_signed_8
    port( a_real_c   : in    std_logic_vector(7 downto 0) := (others => 'U');
          a          : out   std_logic_vector(7 downto 0);
          en_c       : in    std_logic := 'U';
          clk        : in    std_logic := 'U';
          rst_arst_i : in    std_logic := 'U'
        );
  end component;

  component reg_signed_8_2
    port( b_imag_c   : in    std_logic_vector(7 downto 0) := (others => 'U');
          bi         : out   std_logic_vector(7 downto 0);
          en_c       : in    std_logic := 'U';
          clk        : in    std_logic := 'U';
          rst_arst_i : in    std_logic := 'U'
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component reg_signed_8_1
    port( b_real_c   : in    std_logic_vector(7 downto 0) := (others => 'U');
          b          : out   std_logic_vector(7 downto 0);
          en_c       : in    std_logic := 'U';
          clk        : in    std_logic := 'U';
          rst_arst_i : in    std_logic := 'U'
        );
  end component;

  component reg_gen_16
    port( p           : in    std_logic_vector(15 downto 1) := (others => 'U');
          p_real_c    : out   std_logic_vector(15 downto 0);
          p_0_axb_0_i : in    std_logic := 'U';
          en_c        : in    std_logic := 'U';
          clk         : in    std_logic := 'U';
          rst_arst_i  : in    std_logic := 'U'
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component reg_gen_1
    port( en_c       : in    std_logic := 'U';
          ov         : in    std_logic := 'U';
          clk        : in    std_logic := 'U';
          rst_arst_i : in    std_logic := 'U';
          overflow_c : out   std_logic
        );
  end component;

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component reg_gen_16_0
    port( pi           : in    std_logic_vector(15 downto 1) := (others => 'U');
          p_imag_c     : out   std_logic_vector(15 downto 0);
          pi_0_cry_0_Y : in    std_logic := 'U';
          en_c         : in    std_logic := 'U';
          clk          : in    std_logic := 'U';
          rst_arst_i   : in    std_logic := 'U'
        );
  end component;

    signal a : std_logic_vector(7 downto 0);
    signal ai : std_logic_vector(7 downto 0);
    signal b : std_logic_vector(7 downto 0);
    signal bi : std_logic_vector(7 downto 0);
    signal aai : std_logic_vector(7 downto 1);
    signal bbi : std_logic_vector(7 downto 1);
    signal k1r : std_logic_vector(15 downto 1);
    signal k2r : std_logic_vector(15 downto 0);
    signal k3r : std_logic_vector(15 downto 0);
    signal pi : std_logic_vector(15 downto 1);
    signal Q_1_NC : std_logic_vector(47 downto 0);
    signal Q_1_ONC : std_logic_vector(47 downto 16);
    signal Q_0_NC : std_logic_vector(47 downto 0);
    signal Q_0_ONC : std_logic_vector(47 downto 16);
    signal Q_NC : std_logic_vector(47 downto 0);
    signal Q_ONC : std_logic_vector(47 downto 16);
    signal a_real_c : std_logic_vector(7 downto 0);
    signal a_imag_c : std_logic_vector(7 downto 0);
    signal b_real_c : std_logic_vector(7 downto 0);
    signal b_imag_c : std_logic_vector(7 downto 0);
    signal p_real_c : std_logic_vector(15 downto 0);
    signal p_imag_c : std_logic_vector(15 downto 0);
    signal p : std_logic_vector(15 downto 1);
    signal aia : std_logic_vector(7 downto 1);
    signal NN_1, p_0, ov_Z, \VCC\, \GND\, of_p_Z, OVFL_CARRYOUT_1, 
        OVFL_CARRYOUT_0, OVFL_CARRYOUT, clk_ibuf_Z, en_c, rst_c, 
        overflow_c, p_0_cry_0_Z, p_0_cry_1_Z, p_0_cry_2_Z, 
        p_0_cry_3_Z, p_0_cry_4_Z, p_0_cry_5_Z, p_0_cry_6_Z, 
        p_0_cry_7_Z, p_0_cry_8_Z, p_0_cry_9_Z, p_0_cry_10_Z, 
        p_0_cry_11_Z, p_0_cry_12_Z, p_0_cry_13_Z, p_0_cry_14_Z, 
        pi_0_cry_0_Z, pi_0_cry_1_Z, pi_0_cry_2_Z, pi_0_cry_3_Z, 
        pi_0_cry_4_Z, pi_0_cry_5_Z, pi_0_cry_6_Z, pi_0_cry_7_Z, 
        pi_0_cry_8_Z, pi_0_cry_9_Z, pi_0_cry_10_Z, pi_0_cry_11_Z, 
        pi_0_cry_12_Z, pi_0_cry_13_Z, pi_0_cry_14_Z, 
        aia_0_cry_0_Z, aia_0_cry_1_Z, aia_0_cry_2_Z, 
        aia_0_cry_3_Z, aia_0_cry_4_Z, aia_0_cry_5_Z, 
        aia_0_cry_6_Z, bbi_0_cry_0_Z, bbi_0_cry_1_Z, 
        bbi_0_cry_2_Z, bbi_0_cry_3_Z, bbi_0_cry_4_Z, 
        bbi_0_cry_5_Z, bbi_0_cry_6_Z, aai_0_cry_0_Z, 
        aai_0_cry_1_Z, aai_0_cry_2_Z, aai_0_cry_3_Z, 
        aai_0_cry_4_Z, aai_0_cry_5_Z, aai_0_cry_6_Z, ov_0_Z, 
        ov_1_Z, ov_2_Z, rst_arst_i, aia_0_axb_0_i, p_0_axb_0_i, 
        p_0_cry_14_Y, p_0_s_15_FCO, p_0_s_15_Y, p_0_cry_13_Y, 
        p_0_cry_12_Y, p_0_cry_11_Y, p_0_cry_10_Y, p_0_cry_9_Y, 
        p_0_cry_8_Y, p_0_cry_7_Y, p_0_cry_6_Y, p_0_cry_5_Y, 
        p_0_cry_4_Y, p_0_cry_3_Y, p_0_cry_2_Y, p_0_cry_1_Y, 
        p_0_cry_0_S, p_0_cry_0_Y, pi_0_cry_14_Y, pi_0_s_15_FCO, 
        pi_0_s_15_Y, pi_0_cry_13_Y, pi_0_cry_12_Y, pi_0_cry_11_Y, 
        pi_0_cry_10_Y, pi_0_cry_9_Y, pi_0_cry_8_Y, pi_0_cry_7_Y, 
        pi_0_cry_6_Y, pi_0_cry_5_Y, pi_0_cry_4_Y, pi_0_cry_3_Y, 
        pi_0_cry_2_Y, pi_0_cry_1_Y, pi_0_cry_0_S, pi_0_cry_0_Y, 
        aia_0_cry_6_Y, aia_0_s_7_FCO, aia_0_s_7_Y, aia_0_cry_5_Y, 
        aia_0_cry_4_Y, aia_0_cry_3_Y, aia_0_cry_2_Y, 
        aia_0_cry_1_Y, aia_0_cry_0_S, aia_0_cry_0_Y, 
        bbi_0_cry_6_Y, bbi_0_s_7_FCO, bbi_0_s_7_Y, bbi_0_cry_5_Y, 
        bbi_0_cry_4_Y, bbi_0_cry_3_Y, bbi_0_cry_2_Y, 
        bbi_0_cry_1_Y, bbi_0_cry_0_S, bbi_0_cry_0_Y, 
        aai_0_cry_6_Y, aai_0_s_7_FCO, aai_0_s_7_Y, aai_0_cry_5_Y, 
        aai_0_cry_4_Y, aai_0_cry_3_Y, aai_0_cry_2_Y, 
        aai_0_cry_1_Y, aai_0_cry_0_S, aai_0_cry_0_Y : std_logic;

    for all : reg_signed_8_0
	Use entity work.reg_signed_8_0(DEF_ARCH);
    for all : reg_signed_8
	Use entity work.reg_signed_8(DEF_ARCH);
    for all : reg_signed_8_2
	Use entity work.reg_signed_8_2(DEF_ARCH);
    for all : reg_signed_8_1
	Use entity work.reg_signed_8_1(DEF_ARCH);
    for all : reg_gen_16
	Use entity work.reg_gen_16(DEF_ARCH);
    for all : reg_gen_1
	Use entity work.reg_gen_1(DEF_ARCH);
    for all : reg_gen_16_0
	Use entity work.reg_gen_16_0(DEF_ARCH);
begin 


    \p_real_obuf[8]\ : OUTBUF
      port map(D => p_real_c(8), PAD => p_real(8));
    
    \p_real_obuf[6]\ : OUTBUF
      port map(D => p_real_c(6), PAD => p_real(6));
    
    \p_imag_obuf[10]\ : OUTBUF
      port map(D => p_imag_c(10), PAD => p_imag(10));
    
    pi_0_cry_1 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(1), B => k3r(1), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_0_Z, S => pi(1), Y => pi_0_cry_1_Y, FCO
         => pi_0_cry_1_Z);
    
    \p_imag_obuf[14]\ : OUTBUF
      port map(D => p_imag_c(14), PAD => p_imag(14));
    
    REG_IN_AI : reg_signed_8_0
      port map(a_imag_c(7) => a_imag_c(7), a_imag_c(6) => 
        a_imag_c(6), a_imag_c(5) => a_imag_c(5), a_imag_c(4) => 
        a_imag_c(4), a_imag_c(3) => a_imag_c(3), a_imag_c(2) => 
        a_imag_c(2), a_imag_c(1) => a_imag_c(1), a_imag_c(0) => 
        a_imag_c(0), ai(7) => ai(7), ai(6) => ai(6), ai(5) => 
        ai(5), ai(4) => ai(4), ai(3) => ai(3), ai(2) => ai(2), 
        ai(1) => ai(1), ai(0) => ai(0), en_c => en_c, clk => NN_1, 
        rst_arst_i => rst_arst_i);
    
    bbi_0_cry_5 : ARI1
      generic map(INIT => x"555AA")

      port map(A => b(5), B => bi(5), C => \GND\, D => \GND\, FCI
         => bbi_0_cry_4_Z, S => bbi(5), Y => bbi_0_cry_5_Y, FCO
         => bbi_0_cry_5_Z);
    
    aia_0_cry_4 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => ai(4), B => a(4), C => \GND\, D => \GND\, FCI
         => aia_0_cry_3_Z, S => aia(4), Y => aia_0_cry_4_Y, FCO
         => aia_0_cry_4_Z);
    
    pi_0_cry_9 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(9), B => k3r(9), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_8_Z, S => pi(9), Y => pi_0_cry_9_Y, FCO
         => pi_0_cry_9_Z);
    
    pi_0_cry_10 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(10), B => k3r(10), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_9_Z, S => pi(10), Y => pi_0_cry_10_Y, FCO
         => pi_0_cry_10_Z);
    
    \p_imag_obuf[7]\ : OUTBUF
      port map(D => p_imag_c(7), PAD => p_imag(7));
    
    \p_imag_obuf[6]\ : OUTBUF
      port map(D => p_imag_c(6), PAD => p_imag(6));
    
    \a_real_ibuf[4]\ : INBUF
      port map(PAD => a_real(4), Y => a_real_c(4));
    
    rst_ibuf_RNIUUM54 : CFG1
      generic map(INIT => "01")

      port map(A => rst_c, Y => rst_arst_i);
    
    ov : CFG4
      generic map(INIT => x"F4F2")

      port map(A => a(7), B => ai(7), C => ov_2_Z, D => aia(7), Y
         => ov_Z);
    
    \a_real_ibuf[5]\ : INBUF
      port map(PAD => a_real(5), Y => a_real_c(5));
    
    \b_imag_ibuf[4]\ : INBUF
      port map(PAD => b_imag(4), Y => b_imag_c(4));
    
    \k2_mulonly_0[15:0]\ : MACC_PA
      port map(A(17) => b_imag_c(7), A(16) => b_imag_c(7), A(15)
         => b_imag_c(7), A(14) => b_imag_c(7), A(13) => 
        b_imag_c(7), A(12) => b_imag_c(7), A(11) => b_imag_c(7), 
        A(10) => b_imag_c(7), A(9) => b_imag_c(7), A(8) => 
        b_imag_c(7), A(7) => b_imag_c(7), A(6) => b_imag_c(6), 
        A(5) => b_imag_c(5), A(4) => b_imag_c(4), A(3) => 
        b_imag_c(3), A(2) => b_imag_c(2), A(1) => b_imag_c(1), 
        A(0) => b_imag_c(0), AL_N => rst_arst_i, ARSHFT17 => 
        \GND\, ARSHFT17_AD_N => \VCC\, ARSHFT17_BYPASS => \VCC\, 
        ARSHFT17_EN => \VCC\, ARSHFT17_SD_N => \GND\, 
        ARSHFT17_SL_N => \VCC\, A_BYPASS => \GND\, A_EN => en_c, 
        A_SRST_N => \VCC\, B(17) => aai(7), B(16) => aai(7), 
        B(15) => aai(7), B(14) => aai(7), B(13) => aai(7), B(12)
         => aai(7), B(11) => aai(7), B(10) => aai(7), B(9) => 
        aai(7), B(8) => aai(7), B(7) => aai(7), B(6) => aai(6), 
        B(5) => aai(5), B(4) => aai(4), B(3) => aai(3), B(2) => 
        aai(2), B(1) => aai(1), B(0) => aai_0_cry_0_Y, B_BYPASS
         => \GND\, B_EN => en_c, B_SRST_N => \VCC\, C(47) => 
        \GND\, C(46) => \GND\, C(45) => \GND\, C(44) => \GND\, 
        C(43) => \GND\, C(42) => \GND\, C(41) => \GND\, C(40) => 
        \GND\, C(39) => \GND\, C(38) => \GND\, C(37) => \GND\, 
        C(36) => \GND\, C(35) => \GND\, C(34) => \GND\, C(33) => 
        \GND\, C(32) => \GND\, C(31) => \GND\, C(30) => \GND\, 
        C(29) => \GND\, C(28) => \GND\, C(27) => \GND\, C(26) => 
        \GND\, C(25) => \GND\, C(24) => \GND\, C(23) => \GND\, 
        C(22) => \GND\, C(21) => \GND\, C(20) => \GND\, C(19) => 
        \GND\, C(18) => \GND\, C(17) => \GND\, C(16) => \GND\, 
        C(15) => \GND\, C(14) => \GND\, C(13) => \GND\, C(12) => 
        \GND\, C(11) => \GND\, C(10) => \GND\, C(9) => \GND\, 
        C(8) => \GND\, C(7) => \GND\, C(6) => \GND\, C(5) => 
        \GND\, C(4) => \GND\, C(3) => \GND\, C(2) => \GND\, C(1)
         => \GND\, C(0) => \GND\, CARRYIN => \GND\, CDIN(47) => 
        \GND\, CDIN(46) => \GND\, CDIN(45) => \GND\, CDIN(44) => 
        \GND\, CDIN(43) => \GND\, CDIN(42) => \GND\, CDIN(41) => 
        \GND\, CDIN(40) => \GND\, CDIN(39) => \GND\, CDIN(38) => 
        \GND\, CDIN(37) => \GND\, CDIN(36) => \GND\, CDIN(35) => 
        \GND\, CDIN(34) => \GND\, CDIN(33) => \GND\, CDIN(32) => 
        \GND\, CDIN(31) => \GND\, CDIN(30) => \GND\, CDIN(29) => 
        \GND\, CDIN(28) => \GND\, CDIN(27) => \GND\, CDIN(26) => 
        \GND\, CDIN(25) => \GND\, CDIN(24) => \GND\, CDIN(23) => 
        \GND\, CDIN(22) => \GND\, CDIN(21) => \GND\, CDIN(20) => 
        \GND\, CDIN(19) => \GND\, CDIN(18) => \GND\, CDIN(17) => 
        \GND\, CDIN(16) => \GND\, CDIN(15) => \GND\, CDIN(14) => 
        \GND\, CDIN(13) => \GND\, CDIN(12) => \GND\, CDIN(11) => 
        \GND\, CDIN(10) => \GND\, CDIN(9) => \GND\, CDIN(8) => 
        \GND\, CDIN(7) => \GND\, CDIN(6) => \GND\, CDIN(5) => 
        \GND\, CDIN(4) => \GND\, CDIN(3) => \GND\, CDIN(2) => 
        \GND\, CDIN(1) => \GND\, CDIN(0) => \GND\, 
        CDIN_FDBK_SEL(1) => \GND\, CDIN_FDBK_SEL(0) => \GND\, 
        CDIN_FDBK_SEL_AD_N(1) => \VCC\, CDIN_FDBK_SEL_AD_N(0) => 
        \VCC\, CDIN_FDBK_SEL_BYPASS => \VCC\, CDIN_FDBK_SEL_EN
         => \VCC\, CDIN_FDBK_SEL_SD_N(1) => \GND\, 
        CDIN_FDBK_SEL_SD_N(0) => \GND\, CDIN_FDBK_SEL_SL_N => 
        \VCC\, CLK => NN_1, C_ARST_N => \VCC\, C_BYPASS => \VCC\, 
        C_EN => \VCC\, C_SRST_N => \VCC\, D(17) => \GND\, D(16)
         => \GND\, D(15) => \GND\, D(14) => \GND\, D(13) => \GND\, 
        D(12) => \GND\, D(11) => \GND\, D(10) => \GND\, D(9) => 
        \GND\, D(8) => \GND\, D(7) => \GND\, D(6) => \GND\, D(5)
         => \GND\, D(4) => \GND\, D(3) => \GND\, D(2) => \GND\, 
        D(1) => \GND\, D(0) => \GND\, DOTP => \GND\, D_ARST_N => 
        \VCC\, D_BYPASS => \VCC\, D_EN => \VCC\, D_SRST_N => 
        \VCC\, OVFL_CARRYOUT_SEL => \GND\, PASUB => \GND\, 
        PASUB_AD_N => \VCC\, PASUB_BYPASS => \VCC\, PASUB_EN => 
        \VCC\, PASUB_SD_N => \GND\, PASUB_SL_N => \VCC\, P_BYPASS
         => \GND\, P_EN => en_c, P_SRST_N => \VCC\, SIMD => \GND\, 
        SUB => \GND\, SUB_AD_N => \VCC\, SUB_BYPASS => \VCC\, 
        SUB_EN => \VCC\, SUB_SD_N => \VCC\, SUB_SL_N => \VCC\, 
        CDOUT(47) => Q_0_NC(47), CDOUT(46) => Q_0_NC(46), 
        CDOUT(45) => Q_0_NC(45), CDOUT(44) => Q_0_NC(44), 
        CDOUT(43) => Q_0_NC(43), CDOUT(42) => Q_0_NC(42), 
        CDOUT(41) => Q_0_NC(41), CDOUT(40) => Q_0_NC(40), 
        CDOUT(39) => Q_0_NC(39), CDOUT(38) => Q_0_NC(38), 
        CDOUT(37) => Q_0_NC(37), CDOUT(36) => Q_0_NC(36), 
        CDOUT(35) => Q_0_NC(35), CDOUT(34) => Q_0_NC(34), 
        CDOUT(33) => Q_0_NC(33), CDOUT(32) => Q_0_NC(32), 
        CDOUT(31) => Q_0_NC(31), CDOUT(30) => Q_0_NC(30), 
        CDOUT(29) => Q_0_NC(29), CDOUT(28) => Q_0_NC(28), 
        CDOUT(27) => Q_0_NC(27), CDOUT(26) => Q_0_NC(26), 
        CDOUT(25) => Q_0_NC(25), CDOUT(24) => Q_0_NC(24), 
        CDOUT(23) => Q_0_NC(23), CDOUT(22) => Q_0_NC(22), 
        CDOUT(21) => Q_0_NC(21), CDOUT(20) => Q_0_NC(20), 
        CDOUT(19) => Q_0_NC(19), CDOUT(18) => Q_0_NC(18), 
        CDOUT(17) => Q_0_NC(17), CDOUT(16) => Q_0_NC(16), 
        CDOUT(15) => Q_0_NC(15), CDOUT(14) => Q_0_NC(14), 
        CDOUT(13) => Q_0_NC(13), CDOUT(12) => Q_0_NC(12), 
        CDOUT(11) => Q_0_NC(11), CDOUT(10) => Q_0_NC(10), 
        CDOUT(9) => Q_0_NC(9), CDOUT(8) => Q_0_NC(8), CDOUT(7)
         => Q_0_NC(7), CDOUT(6) => Q_0_NC(6), CDOUT(5) => 
        Q_0_NC(5), CDOUT(4) => Q_0_NC(4), CDOUT(3) => Q_0_NC(3), 
        CDOUT(2) => Q_0_NC(2), CDOUT(1) => Q_0_NC(1), CDOUT(0)
         => Q_0_NC(0), OVFL_CARRYOUT => OVFL_CARRYOUT_0, P(47)
         => Q_0_ONC(47), P(46) => Q_0_ONC(46), P(45) => 
        Q_0_ONC(45), P(44) => Q_0_ONC(44), P(43) => Q_0_ONC(43), 
        P(42) => Q_0_ONC(42), P(41) => Q_0_ONC(41), P(40) => 
        Q_0_ONC(40), P(39) => Q_0_ONC(39), P(38) => Q_0_ONC(38), 
        P(37) => Q_0_ONC(37), P(36) => Q_0_ONC(36), P(35) => 
        Q_0_ONC(35), P(34) => Q_0_ONC(34), P(33) => Q_0_ONC(33), 
        P(32) => Q_0_ONC(32), P(31) => Q_0_ONC(31), P(30) => 
        Q_0_ONC(30), P(29) => Q_0_ONC(29), P(28) => Q_0_ONC(28), 
        P(27) => Q_0_ONC(27), P(26) => Q_0_ONC(26), P(25) => 
        Q_0_ONC(25), P(24) => Q_0_ONC(24), P(23) => Q_0_ONC(23), 
        P(22) => Q_0_ONC(22), P(21) => Q_0_ONC(21), P(20) => 
        Q_0_ONC(20), P(19) => Q_0_ONC(19), P(18) => Q_0_ONC(18), 
        P(17) => Q_0_ONC(17), P(16) => Q_0_ONC(16), P(15) => 
        k2r(15), P(14) => k2r(14), P(13) => k2r(13), P(12) => 
        k2r(12), P(11) => k2r(11), P(10) => k2r(10), P(9) => 
        k2r(9), P(8) => k2r(8), P(7) => k2r(7), P(6) => k2r(6), 
        P(5) => k2r(5), P(4) => k2r(4), P(3) => k2r(3), P(2) => 
        k2r(2), P(1) => k2r(1), P(0) => k2r(0));
    
    pi_0_cry_4 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(4), B => k3r(4), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_3_Z, S => pi(4), Y => pi_0_cry_4_Y, FCO
         => pi_0_cry_4_Z);
    
    \b_real_ibuf[2]\ : INBUF
      port map(PAD => b_real(2), Y => b_real_c(2));
    
    pi_0_cry_12 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(12), B => k3r(12), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_11_Z, S => pi(12), Y => pi_0_cry_12_Y, 
        FCO => pi_0_cry_12_Z);
    
    REG_IN_A : reg_signed_8
      port map(a_real_c(7) => a_real_c(7), a_real_c(6) => 
        a_real_c(6), a_real_c(5) => a_real_c(5), a_real_c(4) => 
        a_real_c(4), a_real_c(3) => a_real_c(3), a_real_c(2) => 
        a_real_c(2), a_real_c(1) => a_real_c(1), a_real_c(0) => 
        a_real_c(0), a(7) => a(7), a(6) => a(6), a(5) => a(5), 
        a(4) => a(4), a(3) => a(3), a(2) => a(2), a(1) => a(1), 
        a(0) => a(0), en_c => en_c, clk => NN_1, rst_arst_i => 
        rst_arst_i);
    
    \p_real_obuf[5]\ : OUTBUF
      port map(D => p_real_c(5), PAD => p_real(5));
    
    REG_IN_BI : reg_signed_8_2
      port map(b_imag_c(7) => b_imag_c(7), b_imag_c(6) => 
        b_imag_c(6), b_imag_c(5) => b_imag_c(5), b_imag_c(4) => 
        b_imag_c(4), b_imag_c(3) => b_imag_c(3), b_imag_c(2) => 
        b_imag_c(2), b_imag_c(1) => b_imag_c(1), b_imag_c(0) => 
        b_imag_c(0), bi(7) => bi(7), bi(6) => bi(6), bi(5) => 
        bi(5), bi(4) => bi(4), bi(3) => bi(3), bi(2) => bi(2), 
        bi(1) => bi(1), bi(0) => bi(0), en_c => en_c, clk => NN_1, 
        rst_arst_i => rst_arst_i);
    
    p_0_cry_14 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(14), B => k2r(14), C => \GND\, D => \GND\, 
        FCI => p_0_cry_13_Z, S => p(14), Y => p_0_cry_14_Y, FCO
         => p_0_cry_14_Z);
    
    \p_imag_obuf[0]\ : OUTBUF
      port map(D => p_imag_c(0), PAD => p_imag(0));
    
    \p_real_obuf[15]\ : OUTBUF
      port map(D => p_real_c(15), PAD => p_real(15));
    
    \p_real_obuf[0]\ : OUTBUF
      port map(D => p_real_c(0), PAD => p_real(0));
    
    p_0_cry_11 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(11), B => k2r(11), C => \GND\, D => \GND\, 
        FCI => p_0_cry_10_Z, S => p(11), Y => p_0_cry_11_Y, FCO
         => p_0_cry_11_Z);
    
    p_0_cry_8 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(8), B => k2r(8), C => \GND\, D => \GND\, 
        FCI => p_0_cry_7_Z, S => p(8), Y => p_0_cry_8_Y, FCO => 
        p_0_cry_8_Z);
    
    bbi_0_cry_6 : ARI1
      generic map(INIT => x"555AA")

      port map(A => b(6), B => bi(6), C => \GND\, D => \GND\, FCI
         => bbi_0_cry_5_Z, S => bbi(6), Y => bbi_0_cry_6_Y, FCO
         => bbi_0_cry_6_Z);
    
    \p_real_obuf[11]\ : OUTBUF
      port map(D => p_real_c(11), PAD => p_real(11));
    
    pi_0_cry_14 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(14), B => k3r(14), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_13_Z, S => pi(14), Y => pi_0_cry_14_Y, 
        FCO => pi_0_cry_14_Z);
    
    p_0_axb_0_i_0 : CFG2
      generic map(INIT => x"6")

      port map(A => p_0, B => k2r(0), Y => p_0_axb_0_i);
    
    \b_real_ibuf[4]\ : INBUF
      port map(PAD => b_real(4), Y => b_real_c(4));
    
    \p_real_obuf[3]\ : OUTBUF
      port map(D => p_real_c(3), PAD => p_real(3));
    
    \b_imag_ibuf[0]\ : INBUF
      port map(PAD => b_imag(0), Y => b_imag_c(0));
    
    \a_real_ibuf[7]\ : INBUF
      port map(PAD => a_real(7), Y => a_real_c(7));
    
    of_p : CFG3
      generic map(INIT => x"42")

      port map(A => k1r(15), B => p(15), C => k2r(15), Y => 
        of_p_Z);
    
    \p_real_obuf[7]\ : OUTBUF
      port map(D => p_real_c(7), PAD => p_real(7));
    
    \p_real_obuf[10]\ : OUTBUF
      port map(D => p_real_c(10), PAD => p_real(10));
    
    \p_imag_obuf[1]\ : OUTBUF
      port map(D => p_imag_c(1), PAD => p_imag(1));
    
    \p_imag_obuf[12]\ : OUTBUF
      port map(D => p_imag_c(12), PAD => p_imag(12));
    
    overflow_obuf : OUTBUF
      port map(D => overflow_c, PAD => overflow);
    
    aai_0_cry_1 : ARI1
      generic map(INIT => x"555AA")

      port map(A => a(1), B => ai(1), C => \GND\, D => \GND\, FCI
         => aai_0_cry_0_Z, S => aai(1), Y => aai_0_cry_1_Y, FCO
         => aai_0_cry_1_Z);
    
    REG_IN_B : reg_signed_8_1
      port map(b_real_c(7) => b_real_c(7), b_real_c(6) => 
        b_real_c(6), b_real_c(5) => b_real_c(5), b_real_c(4) => 
        b_real_c(4), b_real_c(3) => b_real_c(3), b_real_c(2) => 
        b_real_c(2), b_real_c(1) => b_real_c(1), b_real_c(0) => 
        b_real_c(0), b(7) => b(7), b(6) => b(6), b(5) => b(5), 
        b(4) => b(4), b(3) => b(3), b(2) => b(2), b(1) => b(1), 
        b(0) => b(0), en_c => en_c, clk => NN_1, rst_arst_i => 
        rst_arst_i);
    
    REG_OUT_R : reg_gen_16
      port map(p(15) => p(15), p(14) => p(14), p(13) => p(13), 
        p(12) => p(12), p(11) => p(11), p(10) => p(10), p(9) => 
        p(9), p(8) => p(8), p(7) => p(7), p(6) => p(6), p(5) => 
        p(5), p(4) => p(4), p(3) => p(3), p(2) => p(2), p(1) => 
        p(1), p_real_c(15) => p_real_c(15), p_real_c(14) => 
        p_real_c(14), p_real_c(13) => p_real_c(13), p_real_c(12)
         => p_real_c(12), p_real_c(11) => p_real_c(11), 
        p_real_c(10) => p_real_c(10), p_real_c(9) => p_real_c(9), 
        p_real_c(8) => p_real_c(8), p_real_c(7) => p_real_c(7), 
        p_real_c(6) => p_real_c(6), p_real_c(5) => p_real_c(5), 
        p_real_c(4) => p_real_c(4), p_real_c(3) => p_real_c(3), 
        p_real_c(2) => p_real_c(2), p_real_c(1) => p_real_c(1), 
        p_real_c(0) => p_real_c(0), p_0_axb_0_i => p_0_axb_0_i, 
        en_c => en_c, clk => NN_1, rst_arst_i => rst_arst_i);
    
    ov_1 : CFG4
      generic map(INIT => x"F1F8")

      port map(A => b(7), B => bi(7), C => ov_0_Z, D => bbi(7), Y
         => ov_1_Z);
    
    \p_real_obuf[4]\ : OUTBUF
      port map(D => p_real_c(4), PAD => p_real(4));
    
    \p_real_obuf[13]\ : OUTBUF
      port map(D => p_real_c(13), PAD => p_real(13));
    
    aai_0_cry_4 : ARI1
      generic map(INIT => x"555AA")

      port map(A => a(4), B => ai(4), C => \GND\, D => \GND\, FCI
         => aai_0_cry_3_Z, S => aai(4), Y => aai_0_cry_4_Y, FCO
         => aai_0_cry_4_Z);
    
    \p_imag_obuf[3]\ : OUTBUF
      port map(D => p_imag_c(3), PAD => p_imag(3));
    
    \a_real_ibuf[2]\ : INBUF
      port map(PAD => a_real(2), Y => a_real_c(2));
    
    p_0_cry_7 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(7), B => k2r(7), C => \GND\, D => \GND\, 
        FCI => p_0_cry_6_Z, S => p(7), Y => p_0_cry_7_Y, FCO => 
        p_0_cry_7_Z);
    
    bbi_0_s_7 : ARI1
      generic map(INIT => x"46600")

      port map(A => \VCC\, B => b(7), C => bi(7), D => \GND\, FCI
         => bbi_0_cry_6_Z, S => bbi(7), Y => bbi_0_s_7_Y, FCO => 
        bbi_0_s_7_FCO);
    
    bbi_0_cry_2 : ARI1
      generic map(INIT => x"555AA")

      port map(A => b(2), B => bi(2), C => \GND\, D => \GND\, FCI
         => bbi_0_cry_1_Z, S => bbi(2), Y => bbi_0_cry_2_Y, FCO
         => bbi_0_cry_2_Z);
    
    \p_imag_obuf[13]\ : OUTBUF
      port map(D => p_imag_c(13), PAD => p_imag(13));
    
    \a_imag_ibuf[6]\ : INBUF
      port map(PAD => a_imag(6), Y => a_imag_c(6));
    
    aia_0_cry_1 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => ai(1), B => a(1), C => \GND\, D => \GND\, FCI
         => aia_0_cry_0_Z, S => aia(1), Y => aia_0_cry_1_Y, FCO
         => aia_0_cry_1_Z);
    
    p_0_cry_3 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(3), B => k2r(3), C => \GND\, D => \GND\, 
        FCI => p_0_cry_2_Z, S => p(3), Y => p_0_cry_3_Y, FCO => 
        p_0_cry_3_Z);
    
    aai_0_cry_6 : ARI1
      generic map(INIT => x"555AA")

      port map(A => a(6), B => ai(6), C => \GND\, D => \GND\, FCI
         => aai_0_cry_5_Z, S => aai(6), Y => aai_0_cry_6_Y, FCO
         => aai_0_cry_6_Z);
    
    aia_0_s_7 : ARI1
      generic map(INIT => x"49900")

      port map(A => \VCC\, B => a(7), C => ai(7), D => \GND\, FCI
         => aia_0_cry_6_Z, S => aia(7), Y => aia_0_s_7_Y, FCO => 
        aia_0_s_7_FCO);
    
    \p_imag_obuf[2]\ : OUTBUF
      port map(D => p_imag_c(2), PAD => p_imag(2));
    
    bbi_0_cry_4 : ARI1
      generic map(INIT => x"555AA")

      port map(A => b(4), B => bi(4), C => \GND\, D => \GND\, FCI
         => bbi_0_cry_3_Z, S => bbi(4), Y => bbi_0_cry_4_Y, FCO
         => bbi_0_cry_4_Z);
    
    GND_Z : GND
      port map(Y => \GND\);
    
    \p_imag_obuf[11]\ : OUTBUF
      port map(D => p_imag_c(11), PAD => p_imag(11));
    
    rst_ibuf : INBUF
      port map(PAD => rst, Y => rst_c);
    
    \b_real_ibuf[3]\ : INBUF
      port map(PAD => b_real(3), Y => b_real_c(3));
    
    aia_0_cry_2 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => ai(2), B => a(2), C => \GND\, D => \GND\, FCI
         => aia_0_cry_1_Z, S => aia(2), Y => aia_0_cry_2_Y, FCO
         => aia_0_cry_2_Z);
    
    VCC_Z : VCC
      port map(Y => \VCC\);
    
    pi_0_cry_2 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(2), B => k3r(2), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_1_Z, S => pi(2), Y => pi_0_cry_2_Y, FCO
         => pi_0_cry_2_Z);
    
    clk_ibuf : INBUF
      port map(PAD => clk, Y => clk_ibuf_Z);
    
    p_0_cry_1 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(1), B => k2r(1), C => \GND\, D => \GND\, 
        FCI => p_0_cry_0_Z, S => p(1), Y => p_0_cry_1_Y, FCO => 
        p_0_cry_1_Z);
    
    \a_real_ibuf[0]\ : INBUF
      port map(PAD => a_real(0), Y => a_real_c(0));
    
    \b_real_ibuf[5]\ : INBUF
      port map(PAD => b_real(5), Y => b_real_c(5));
    
    bbi_0_cry_3 : ARI1
      generic map(INIT => x"555AA")

      port map(A => b(3), B => bi(3), C => \GND\, D => \GND\, FCI
         => bbi_0_cry_2_Z, S => bbi(3), Y => bbi_0_cry_3_Y, FCO
         => bbi_0_cry_3_Z);
    
    pi_0_cry_5 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(5), B => k3r(5), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_4_Z, S => pi(5), Y => pi_0_cry_5_Y, FCO
         => pi_0_cry_5_Z);
    
    en_ibuf : INBUF
      port map(PAD => en, Y => en_c);
    
    aia_0_axb_0_i_0 : CFG2
      generic map(INIT => x"6")

      port map(A => a(0), B => ai(0), Y => aia_0_axb_0_i);
    
    \b_real_ibuf[1]\ : INBUF
      port map(PAD => b_real(1), Y => b_real_c(1));
    
    p_0_cry_0 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => p_0, B => k2r(0), C => \GND\, D => \GND\, FCI
         => \VCC\, S => p_0_cry_0_S, Y => p_0_cry_0_Y, FCO => 
        p_0_cry_0_Z);
    
    pi_0_cry_7 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(7), B => k3r(7), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_6_Z, S => pi(7), Y => pi_0_cry_7_Y, FCO
         => pi_0_cry_7_Z);
    
    aai_0_cry_3 : ARI1
      generic map(INIT => x"555AA")

      port map(A => a(3), B => ai(3), C => \GND\, D => \GND\, FCI
         => aai_0_cry_2_Z, S => aai(3), Y => aai_0_cry_3_Y, FCO
         => aai_0_cry_3_Z);
    
    ov_0 : CFG4
      generic map(INIT => x"FF18")

      port map(A => k3r(15), B => k1r(15), C => pi(15), D => 
        of_p_Z, Y => ov_0_Z);
    
    p_0_cry_13 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(13), B => k2r(13), C => \GND\, D => \GND\, 
        FCI => p_0_cry_12_Z, S => p(13), Y => p_0_cry_13_Y, FCO
         => p_0_cry_13_Z);
    
    pi_0_s_15 : ARI1
      generic map(INIT => x"46600")

      port map(A => \VCC\, B => k1r(15), C => k3r(15), D => \GND\, 
        FCI => pi_0_cry_14_Z, S => pi(15), Y => pi_0_s_15_Y, FCO
         => pi_0_s_15_FCO);
    
    \b_imag_ibuf[6]\ : INBUF
      port map(PAD => b_imag(6), Y => b_imag_c(6));
    
    p_0_cry_6 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(6), B => k2r(6), C => \GND\, D => \GND\, 
        FCI => p_0_cry_5_Z, S => p(6), Y => p_0_cry_6_Y, FCO => 
        p_0_cry_6_Z);
    
    \p_imag_obuf[9]\ : OUTBUF
      port map(D => p_imag_c(9), PAD => p_imag(9));
    
    \a_imag_ibuf[7]\ : INBUF
      port map(PAD => a_imag(7), Y => a_imag_c(7));
    
    aai_0_cry_5 : ARI1
      generic map(INIT => x"555AA")

      port map(A => a(5), B => ai(5), C => \GND\, D => \GND\, FCI
         => aai_0_cry_4_Z, S => aai(5), Y => aai_0_cry_5_Y, FCO
         => aai_0_cry_5_Z);
    
    p_0_cry_4 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(4), B => k2r(4), C => \GND\, D => \GND\, 
        FCI => p_0_cry_3_Z, S => p(4), Y => p_0_cry_4_Y, FCO => 
        p_0_cry_4_Z);
    
    \p_real_obuf[9]\ : OUTBUF
      port map(D => p_real_c(9), PAD => p_real(9));
    
    pi_0_cry_8 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(8), B => k3r(8), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_7_Z, S => pi(8), Y => pi_0_cry_8_Y, FCO
         => pi_0_cry_8_Z);
    
    pi_0_cry_6 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(6), B => k3r(6), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_5_Z, S => pi(6), Y => pi_0_cry_6_Y, FCO
         => pi_0_cry_6_Z);
    
    p_0_s_15 : ARI1
      generic map(INIT => x"49900")

      port map(A => \VCC\, B => k1r(15), C => k2r(15), D => \GND\, 
        FCI => p_0_cry_14_Z, S => p(15), Y => p_0_s_15_Y, FCO => 
        p_0_s_15_FCO);
    
    \p_real_obuf[1]\ : OUTBUF
      port map(D => p_real_c(1), PAD => p_real(1));
    
    bbi_0_cry_1 : ARI1
      generic map(INIT => x"555AA")

      port map(A => b(1), B => bi(1), C => \GND\, D => \GND\, FCI
         => bbi_0_cry_0_Z, S => bbi(1), Y => bbi_0_cry_1_Y, FCO
         => bbi_0_cry_1_Z);
    
    \p_imag_obuf[4]\ : OUTBUF
      port map(D => p_imag_c(4), PAD => p_imag(4));
    
    pi_0_cry_0 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k3r(0), B => p_0, C => \GND\, D => \GND\, FCI
         => \GND\, S => pi_0_cry_0_S, Y => pi_0_cry_0_Y, FCO => 
        pi_0_cry_0_Z);
    
    REG_OUT_OV : reg_gen_1
      port map(en_c => en_c, ov => ov_Z, clk => NN_1, rst_arst_i
         => rst_arst_i, overflow_c => overflow_c);
    
    \p_imag_obuf[15]\ : OUTBUF
      port map(D => p_imag_c(15), PAD => p_imag(15));
    
    \a_real_ibuf[6]\ : INBUF
      port map(PAD => a_real(6), Y => a_real_c(6));
    
    \p_real_obuf[2]\ : OUTBUF
      port map(D => p_real_c(2), PAD => p_real(2));
    
    p_0_cry_12 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(12), B => k2r(12), C => \GND\, D => \GND\, 
        FCI => p_0_cry_11_Z, S => p(12), Y => p_0_cry_12_Y, FCO
         => p_0_cry_12_Z);
    
    \b_imag_ibuf[2]\ : INBUF
      port map(PAD => b_imag(2), Y => b_imag_c(2));
    
    p_0_cry_5 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(5), B => k2r(5), C => \GND\, D => \GND\, 
        FCI => p_0_cry_4_Z, S => p(5), Y => p_0_cry_5_Y, FCO => 
        p_0_cry_5_Z);
    
    \p_imag_obuf[8]\ : OUTBUF
      port map(D => p_imag_c(8), PAD => p_imag(8));
    
    \b_imag_ibuf[3]\ : INBUF
      port map(PAD => b_imag(3), Y => b_imag_c(3));
    
    p_0_cry_9 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(9), B => k2r(9), C => \GND\, D => \GND\, 
        FCI => p_0_cry_8_Z, S => p(9), Y => p_0_cry_9_Y, FCO => 
        p_0_cry_9_Z);
    
    I_1 : CLKINT
      port map(A => clk_ibuf_Z, Y => NN_1);
    
    bbi_0_cry_0 : ARI1
      generic map(INIT => x"555AA")

      port map(A => b(0), B => bi(0), C => \GND\, D => \GND\, FCI
         => \GND\, S => bbi_0_cry_0_S, Y => bbi_0_cry_0_Y, FCO
         => bbi_0_cry_0_Z);
    
    pi_0_cry_3 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(3), B => k3r(3), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_2_Z, S => pi(3), Y => pi_0_cry_3_Y, FCO
         => pi_0_cry_3_Z);
    
    aia_0_cry_3 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => ai(3), B => a(3), C => \GND\, D => \GND\, FCI
         => aia_0_cry_2_Z, S => aia(3), Y => aia_0_cry_3_Y, FCO
         => aia_0_cry_3_Z);
    
    aia_0_cry_5 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => ai(5), B => a(5), C => \GND\, D => \GND\, FCI
         => aia_0_cry_4_Z, S => aia(5), Y => aia_0_cry_5_Y, FCO
         => aia_0_cry_5_Z);
    
    aia_0_cry_0 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => ai(0), B => a(0), C => \GND\, D => \GND\, FCI
         => \VCC\, S => aia_0_cry_0_S, Y => aia_0_cry_0_Y, FCO
         => aia_0_cry_0_Z);
    
    \p_real_obuf[12]\ : OUTBUF
      port map(D => p_real_c(12), PAD => p_real(12));
    
    \p_imag_obuf[5]\ : OUTBUF
      port map(D => p_imag_c(5), PAD => p_imag(5));
    
    \a_real_ibuf[3]\ : INBUF
      port map(PAD => a_real(3), Y => a_real_c(3));
    
    aai_0_s_7 : ARI1
      generic map(INIT => x"46600")

      port map(A => \VCC\, B => a(7), C => ai(7), D => \GND\, FCI
         => aai_0_cry_6_Z, S => aai(7), Y => aai_0_s_7_Y, FCO => 
        aai_0_s_7_FCO);
    
    p_0_cry_10 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(10), B => k2r(10), C => \GND\, D => \GND\, 
        FCI => p_0_cry_9_Z, S => p(10), Y => p_0_cry_10_Y, FCO
         => p_0_cry_10_Z);
    
    \a_imag_ibuf[0]\ : INBUF
      port map(PAD => a_imag(0), Y => a_imag_c(0));
    
    \a_imag_ibuf[5]\ : INBUF
      port map(PAD => a_imag(5), Y => a_imag_c(5));
    
    ov_2 : CFG4
      generic map(INIT => x"F1F8")

      port map(A => a(7), B => ai(7), C => ov_1_Z, D => aai(7), Y
         => ov_2_Z);
    
    REG_OUT_I : reg_gen_16_0
      port map(pi(15) => pi(15), pi(14) => pi(14), pi(13) => 
        pi(13), pi(12) => pi(12), pi(11) => pi(11), pi(10) => 
        pi(10), pi(9) => pi(9), pi(8) => pi(8), pi(7) => pi(7), 
        pi(6) => pi(6), pi(5) => pi(5), pi(4) => pi(4), pi(3) => 
        pi(3), pi(2) => pi(2), pi(1) => pi(1), p_imag_c(15) => 
        p_imag_c(15), p_imag_c(14) => p_imag_c(14), p_imag_c(13)
         => p_imag_c(13), p_imag_c(12) => p_imag_c(12), 
        p_imag_c(11) => p_imag_c(11), p_imag_c(10) => 
        p_imag_c(10), p_imag_c(9) => p_imag_c(9), p_imag_c(8) => 
        p_imag_c(8), p_imag_c(7) => p_imag_c(7), p_imag_c(6) => 
        p_imag_c(6), p_imag_c(5) => p_imag_c(5), p_imag_c(4) => 
        p_imag_c(4), p_imag_c(3) => p_imag_c(3), p_imag_c(2) => 
        p_imag_c(2), p_imag_c(1) => p_imag_c(1), p_imag_c(0) => 
        p_imag_c(0), pi_0_cry_0_Y => pi_0_cry_0_Y, en_c => en_c, 
        clk => NN_1, rst_arst_i => rst_arst_i);
    
    \p_real_obuf[14]\ : OUTBUF
      port map(D => p_real_c(14), PAD => p_real(14));
    
    \a_imag_ibuf[1]\ : INBUF
      port map(PAD => a_imag(1), Y => a_imag_c(1));
    
    aai_0_cry_0 : ARI1
      generic map(INIT => x"555AA")

      port map(A => a(0), B => ai(0), C => \GND\, D => \GND\, FCI
         => \GND\, S => aai_0_cry_0_S, Y => aai_0_cry_0_Y, FCO
         => aai_0_cry_0_Z);
    
    \a_imag_ibuf[3]\ : INBUF
      port map(PAD => a_imag(3), Y => a_imag_c(3));
    
    \b_imag_ibuf[7]\ : INBUF
      port map(PAD => b_imag(7), Y => b_imag_c(7));
    
    \b_real_ibuf[7]\ : INBUF
      port map(PAD => b_real(7), Y => b_real_c(7));
    
    \b_imag_ibuf[5]\ : INBUF
      port map(PAD => b_imag(5), Y => b_imag_c(5));
    
    pi_0_cry_11 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(11), B => k3r(11), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_10_Z, S => pi(11), Y => pi_0_cry_11_Y, 
        FCO => pi_0_cry_11_Z);
    
    aia_0_cry_6 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => ai(6), B => a(6), C => \GND\, D => \GND\, FCI
         => aia_0_cry_5_Z, S => aia(6), Y => aia_0_cry_6_Y, FCO
         => aia_0_cry_6_Z);
    
    \k3_mulonly_0[15:0]\ : MACC_PA
      port map(A(17) => b_real_c(7), A(16) => b_real_c(7), A(15)
         => b_real_c(7), A(14) => b_real_c(7), A(13) => 
        b_real_c(7), A(12) => b_real_c(7), A(11) => b_real_c(7), 
        A(10) => b_real_c(7), A(9) => b_real_c(7), A(8) => 
        b_real_c(7), A(7) => b_real_c(7), A(6) => b_real_c(6), 
        A(5) => b_real_c(5), A(4) => b_real_c(4), A(3) => 
        b_real_c(3), A(2) => b_real_c(2), A(1) => b_real_c(1), 
        A(0) => b_real_c(0), AL_N => rst_arst_i, ARSHFT17 => 
        \GND\, ARSHFT17_AD_N => \VCC\, ARSHFT17_BYPASS => \VCC\, 
        ARSHFT17_EN => \VCC\, ARSHFT17_SD_N => \GND\, 
        ARSHFT17_SL_N => \VCC\, A_BYPASS => \GND\, A_EN => en_c, 
        A_SRST_N => \VCC\, B(17) => aia(7), B(16) => aia(7), 
        B(15) => aia(7), B(14) => aia(7), B(13) => aia(7), B(12)
         => aia(7), B(11) => aia(7), B(10) => aia(7), B(9) => 
        aia(7), B(8) => aia(7), B(7) => aia(7), B(6) => aia(6), 
        B(5) => aia(5), B(4) => aia(4), B(3) => aia(3), B(2) => 
        aia(2), B(1) => aia(1), B(0) => aia_0_axb_0_i, B_BYPASS
         => \GND\, B_EN => en_c, B_SRST_N => \VCC\, C(47) => 
        \GND\, C(46) => \GND\, C(45) => \GND\, C(44) => \GND\, 
        C(43) => \GND\, C(42) => \GND\, C(41) => \GND\, C(40) => 
        \GND\, C(39) => \GND\, C(38) => \GND\, C(37) => \GND\, 
        C(36) => \GND\, C(35) => \GND\, C(34) => \GND\, C(33) => 
        \GND\, C(32) => \GND\, C(31) => \GND\, C(30) => \GND\, 
        C(29) => \GND\, C(28) => \GND\, C(27) => \GND\, C(26) => 
        \GND\, C(25) => \GND\, C(24) => \GND\, C(23) => \GND\, 
        C(22) => \GND\, C(21) => \GND\, C(20) => \GND\, C(19) => 
        \GND\, C(18) => \GND\, C(17) => \GND\, C(16) => \GND\, 
        C(15) => \GND\, C(14) => \GND\, C(13) => \GND\, C(12) => 
        \GND\, C(11) => \GND\, C(10) => \GND\, C(9) => \GND\, 
        C(8) => \GND\, C(7) => \GND\, C(6) => \GND\, C(5) => 
        \GND\, C(4) => \GND\, C(3) => \GND\, C(2) => \GND\, C(1)
         => \GND\, C(0) => \GND\, CARRYIN => \GND\, CDIN(47) => 
        \GND\, CDIN(46) => \GND\, CDIN(45) => \GND\, CDIN(44) => 
        \GND\, CDIN(43) => \GND\, CDIN(42) => \GND\, CDIN(41) => 
        \GND\, CDIN(40) => \GND\, CDIN(39) => \GND\, CDIN(38) => 
        \GND\, CDIN(37) => \GND\, CDIN(36) => \GND\, CDIN(35) => 
        \GND\, CDIN(34) => \GND\, CDIN(33) => \GND\, CDIN(32) => 
        \GND\, CDIN(31) => \GND\, CDIN(30) => \GND\, CDIN(29) => 
        \GND\, CDIN(28) => \GND\, CDIN(27) => \GND\, CDIN(26) => 
        \GND\, CDIN(25) => \GND\, CDIN(24) => \GND\, CDIN(23) => 
        \GND\, CDIN(22) => \GND\, CDIN(21) => \GND\, CDIN(20) => 
        \GND\, CDIN(19) => \GND\, CDIN(18) => \GND\, CDIN(17) => 
        \GND\, CDIN(16) => \GND\, CDIN(15) => \GND\, CDIN(14) => 
        \GND\, CDIN(13) => \GND\, CDIN(12) => \GND\, CDIN(11) => 
        \GND\, CDIN(10) => \GND\, CDIN(9) => \GND\, CDIN(8) => 
        \GND\, CDIN(7) => \GND\, CDIN(6) => \GND\, CDIN(5) => 
        \GND\, CDIN(4) => \GND\, CDIN(3) => \GND\, CDIN(2) => 
        \GND\, CDIN(1) => \GND\, CDIN(0) => \GND\, 
        CDIN_FDBK_SEL(1) => \GND\, CDIN_FDBK_SEL(0) => \GND\, 
        CDIN_FDBK_SEL_AD_N(1) => \VCC\, CDIN_FDBK_SEL_AD_N(0) => 
        \VCC\, CDIN_FDBK_SEL_BYPASS => \VCC\, CDIN_FDBK_SEL_EN
         => \VCC\, CDIN_FDBK_SEL_SD_N(1) => \GND\, 
        CDIN_FDBK_SEL_SD_N(0) => \GND\, CDIN_FDBK_SEL_SL_N => 
        \VCC\, CLK => NN_1, C_ARST_N => \VCC\, C_BYPASS => \VCC\, 
        C_EN => \VCC\, C_SRST_N => \VCC\, D(17) => \GND\, D(16)
         => \GND\, D(15) => \GND\, D(14) => \GND\, D(13) => \GND\, 
        D(12) => \GND\, D(11) => \GND\, D(10) => \GND\, D(9) => 
        \GND\, D(8) => \GND\, D(7) => \GND\, D(6) => \GND\, D(5)
         => \GND\, D(4) => \GND\, D(3) => \GND\, D(2) => \GND\, 
        D(1) => \GND\, D(0) => \GND\, DOTP => \GND\, D_ARST_N => 
        \VCC\, D_BYPASS => \VCC\, D_EN => \VCC\, D_SRST_N => 
        \VCC\, OVFL_CARRYOUT_SEL => \GND\, PASUB => \GND\, 
        PASUB_AD_N => \VCC\, PASUB_BYPASS => \VCC\, PASUB_EN => 
        \VCC\, PASUB_SD_N => \GND\, PASUB_SL_N => \VCC\, P_BYPASS
         => \GND\, P_EN => en_c, P_SRST_N => \VCC\, SIMD => \GND\, 
        SUB => \GND\, SUB_AD_N => \VCC\, SUB_BYPASS => \VCC\, 
        SUB_EN => \VCC\, SUB_SD_N => \VCC\, SUB_SL_N => \VCC\, 
        CDOUT(47) => Q_1_NC(47), CDOUT(46) => Q_1_NC(46), 
        CDOUT(45) => Q_1_NC(45), CDOUT(44) => Q_1_NC(44), 
        CDOUT(43) => Q_1_NC(43), CDOUT(42) => Q_1_NC(42), 
        CDOUT(41) => Q_1_NC(41), CDOUT(40) => Q_1_NC(40), 
        CDOUT(39) => Q_1_NC(39), CDOUT(38) => Q_1_NC(38), 
        CDOUT(37) => Q_1_NC(37), CDOUT(36) => Q_1_NC(36), 
        CDOUT(35) => Q_1_NC(35), CDOUT(34) => Q_1_NC(34), 
        CDOUT(33) => Q_1_NC(33), CDOUT(32) => Q_1_NC(32), 
        CDOUT(31) => Q_1_NC(31), CDOUT(30) => Q_1_NC(30), 
        CDOUT(29) => Q_1_NC(29), CDOUT(28) => Q_1_NC(28), 
        CDOUT(27) => Q_1_NC(27), CDOUT(26) => Q_1_NC(26), 
        CDOUT(25) => Q_1_NC(25), CDOUT(24) => Q_1_NC(24), 
        CDOUT(23) => Q_1_NC(23), CDOUT(22) => Q_1_NC(22), 
        CDOUT(21) => Q_1_NC(21), CDOUT(20) => Q_1_NC(20), 
        CDOUT(19) => Q_1_NC(19), CDOUT(18) => Q_1_NC(18), 
        CDOUT(17) => Q_1_NC(17), CDOUT(16) => Q_1_NC(16), 
        CDOUT(15) => Q_1_NC(15), CDOUT(14) => Q_1_NC(14), 
        CDOUT(13) => Q_1_NC(13), CDOUT(12) => Q_1_NC(12), 
        CDOUT(11) => Q_1_NC(11), CDOUT(10) => Q_1_NC(10), 
        CDOUT(9) => Q_1_NC(9), CDOUT(8) => Q_1_NC(8), CDOUT(7)
         => Q_1_NC(7), CDOUT(6) => Q_1_NC(6), CDOUT(5) => 
        Q_1_NC(5), CDOUT(4) => Q_1_NC(4), CDOUT(3) => Q_1_NC(3), 
        CDOUT(2) => Q_1_NC(2), CDOUT(1) => Q_1_NC(1), CDOUT(0)
         => Q_1_NC(0), OVFL_CARRYOUT => OVFL_CARRYOUT_1, P(47)
         => Q_1_ONC(47), P(46) => Q_1_ONC(46), P(45) => 
        Q_1_ONC(45), P(44) => Q_1_ONC(44), P(43) => Q_1_ONC(43), 
        P(42) => Q_1_ONC(42), P(41) => Q_1_ONC(41), P(40) => 
        Q_1_ONC(40), P(39) => Q_1_ONC(39), P(38) => Q_1_ONC(38), 
        P(37) => Q_1_ONC(37), P(36) => Q_1_ONC(36), P(35) => 
        Q_1_ONC(35), P(34) => Q_1_ONC(34), P(33) => Q_1_ONC(33), 
        P(32) => Q_1_ONC(32), P(31) => Q_1_ONC(31), P(30) => 
        Q_1_ONC(30), P(29) => Q_1_ONC(29), P(28) => Q_1_ONC(28), 
        P(27) => Q_1_ONC(27), P(26) => Q_1_ONC(26), P(25) => 
        Q_1_ONC(25), P(24) => Q_1_ONC(24), P(23) => Q_1_ONC(23), 
        P(22) => Q_1_ONC(22), P(21) => Q_1_ONC(21), P(20) => 
        Q_1_ONC(20), P(19) => Q_1_ONC(19), P(18) => Q_1_ONC(18), 
        P(17) => Q_1_ONC(17), P(16) => Q_1_ONC(16), P(15) => 
        k3r(15), P(14) => k3r(14), P(13) => k3r(13), P(12) => 
        k3r(12), P(11) => k3r(11), P(10) => k3r(10), P(9) => 
        k3r(9), P(8) => k3r(8), P(7) => k3r(7), P(6) => k3r(6), 
        P(5) => k3r(5), P(4) => k3r(4), P(3) => k3r(3), P(2) => 
        k3r(2), P(1) => k3r(1), P(0) => k3r(0));
    
    pi_0_cry_13 : ARI1
      generic map(INIT => x"555AA")

      port map(A => k1r(13), B => k3r(13), C => \GND\, D => \GND\, 
        FCI => pi_0_cry_12_Z, S => pi(13), Y => pi_0_cry_13_Y, 
        FCO => pi_0_cry_13_Z);
    
    \a_imag_ibuf[2]\ : INBUF
      port map(PAD => a_imag(2), Y => a_imag_c(2));
    
    aai_0_cry_2 : ARI1
      generic map(INIT => x"555AA")

      port map(A => a(2), B => ai(2), C => \GND\, D => \GND\, FCI
         => aai_0_cry_1_Z, S => aai(2), Y => aai_0_cry_2_Y, FCO
         => aai_0_cry_2_Z);
    
    \b_imag_ibuf[1]\ : INBUF
      port map(PAD => b_imag(1), Y => b_imag_c(1));
    
    \b_real_ibuf[6]\ : INBUF
      port map(PAD => b_real(6), Y => b_real_c(6));
    
    p_0_cry_2 : ARI1
      generic map(INIT => x"5AA55")

      port map(A => k1r(2), B => k2r(2), C => \GND\, D => \GND\, 
        FCI => p_0_cry_1_Z, S => p(2), Y => p_0_cry_2_Y, FCO => 
        p_0_cry_2_Z);
    
    \k1_mulonly_0[15:0]\ : MACC_PA
      port map(A(17) => a_real_c(7), A(16) => a_real_c(7), A(15)
         => a_real_c(7), A(14) => a_real_c(7), A(13) => 
        a_real_c(7), A(12) => a_real_c(7), A(11) => a_real_c(7), 
        A(10) => a_real_c(7), A(9) => a_real_c(7), A(8) => 
        a_real_c(7), A(7) => a_real_c(7), A(6) => a_real_c(6), 
        A(5) => a_real_c(5), A(4) => a_real_c(4), A(3) => 
        a_real_c(3), A(2) => a_real_c(2), A(1) => a_real_c(1), 
        A(0) => a_real_c(0), AL_N => rst_arst_i, ARSHFT17 => 
        \GND\, ARSHFT17_AD_N => \VCC\, ARSHFT17_BYPASS => \VCC\, 
        ARSHFT17_EN => \VCC\, ARSHFT17_SD_N => \GND\, 
        ARSHFT17_SL_N => \VCC\, A_BYPASS => \GND\, A_EN => en_c, 
        A_SRST_N => \VCC\, B(17) => bbi(7), B(16) => bbi(7), 
        B(15) => bbi(7), B(14) => bbi(7), B(13) => bbi(7), B(12)
         => bbi(7), B(11) => bbi(7), B(10) => bbi(7), B(9) => 
        bbi(7), B(8) => bbi(7), B(7) => bbi(7), B(6) => bbi(6), 
        B(5) => bbi(5), B(4) => bbi(4), B(3) => bbi(3), B(2) => 
        bbi(2), B(1) => bbi(1), B(0) => bbi_0_cry_0_Y, B_BYPASS
         => \GND\, B_EN => en_c, B_SRST_N => \VCC\, C(47) => 
        \GND\, C(46) => \GND\, C(45) => \GND\, C(44) => \GND\, 
        C(43) => \GND\, C(42) => \GND\, C(41) => \GND\, C(40) => 
        \GND\, C(39) => \GND\, C(38) => \GND\, C(37) => \GND\, 
        C(36) => \GND\, C(35) => \GND\, C(34) => \GND\, C(33) => 
        \GND\, C(32) => \GND\, C(31) => \GND\, C(30) => \GND\, 
        C(29) => \GND\, C(28) => \GND\, C(27) => \GND\, C(26) => 
        \GND\, C(25) => \GND\, C(24) => \GND\, C(23) => \GND\, 
        C(22) => \GND\, C(21) => \GND\, C(20) => \GND\, C(19) => 
        \GND\, C(18) => \GND\, C(17) => \GND\, C(16) => \GND\, 
        C(15) => \GND\, C(14) => \GND\, C(13) => \GND\, C(12) => 
        \GND\, C(11) => \GND\, C(10) => \GND\, C(9) => \GND\, 
        C(8) => \GND\, C(7) => \GND\, C(6) => \GND\, C(5) => 
        \GND\, C(4) => \GND\, C(3) => \GND\, C(2) => \GND\, C(1)
         => \GND\, C(0) => \GND\, CARRYIN => \GND\, CDIN(47) => 
        \GND\, CDIN(46) => \GND\, CDIN(45) => \GND\, CDIN(44) => 
        \GND\, CDIN(43) => \GND\, CDIN(42) => \GND\, CDIN(41) => 
        \GND\, CDIN(40) => \GND\, CDIN(39) => \GND\, CDIN(38) => 
        \GND\, CDIN(37) => \GND\, CDIN(36) => \GND\, CDIN(35) => 
        \GND\, CDIN(34) => \GND\, CDIN(33) => \GND\, CDIN(32) => 
        \GND\, CDIN(31) => \GND\, CDIN(30) => \GND\, CDIN(29) => 
        \GND\, CDIN(28) => \GND\, CDIN(27) => \GND\, CDIN(26) => 
        \GND\, CDIN(25) => \GND\, CDIN(24) => \GND\, CDIN(23) => 
        \GND\, CDIN(22) => \GND\, CDIN(21) => \GND\, CDIN(20) => 
        \GND\, CDIN(19) => \GND\, CDIN(18) => \GND\, CDIN(17) => 
        \GND\, CDIN(16) => \GND\, CDIN(15) => \GND\, CDIN(14) => 
        \GND\, CDIN(13) => \GND\, CDIN(12) => \GND\, CDIN(11) => 
        \GND\, CDIN(10) => \GND\, CDIN(9) => \GND\, CDIN(8) => 
        \GND\, CDIN(7) => \GND\, CDIN(6) => \GND\, CDIN(5) => 
        \GND\, CDIN(4) => \GND\, CDIN(3) => \GND\, CDIN(2) => 
        \GND\, CDIN(1) => \GND\, CDIN(0) => \GND\, 
        CDIN_FDBK_SEL(1) => \GND\, CDIN_FDBK_SEL(0) => \GND\, 
        CDIN_FDBK_SEL_AD_N(1) => \VCC\, CDIN_FDBK_SEL_AD_N(0) => 
        \VCC\, CDIN_FDBK_SEL_BYPASS => \VCC\, CDIN_FDBK_SEL_EN
         => \VCC\, CDIN_FDBK_SEL_SD_N(1) => \GND\, 
        CDIN_FDBK_SEL_SD_N(0) => \GND\, CDIN_FDBK_SEL_SL_N => 
        \VCC\, CLK => NN_1, C_ARST_N => \VCC\, C_BYPASS => \VCC\, 
        C_EN => \VCC\, C_SRST_N => \VCC\, D(17) => \GND\, D(16)
         => \GND\, D(15) => \GND\, D(14) => \GND\, D(13) => \GND\, 
        D(12) => \GND\, D(11) => \GND\, D(10) => \GND\, D(9) => 
        \GND\, D(8) => \GND\, D(7) => \GND\, D(6) => \GND\, D(5)
         => \GND\, D(4) => \GND\, D(3) => \GND\, D(2) => \GND\, 
        D(1) => \GND\, D(0) => \GND\, DOTP => \GND\, D_ARST_N => 
        \VCC\, D_BYPASS => \VCC\, D_EN => \VCC\, D_SRST_N => 
        \VCC\, OVFL_CARRYOUT_SEL => \GND\, PASUB => \GND\, 
        PASUB_AD_N => \VCC\, PASUB_BYPASS => \VCC\, PASUB_EN => 
        \VCC\, PASUB_SD_N => \GND\, PASUB_SL_N => \VCC\, P_BYPASS
         => \GND\, P_EN => en_c, P_SRST_N => \VCC\, SIMD => \GND\, 
        SUB => \GND\, SUB_AD_N => \VCC\, SUB_BYPASS => \VCC\, 
        SUB_EN => \VCC\, SUB_SD_N => \VCC\, SUB_SL_N => \VCC\, 
        CDOUT(47) => Q_NC(47), CDOUT(46) => Q_NC(46), CDOUT(45)
         => Q_NC(45), CDOUT(44) => Q_NC(44), CDOUT(43) => 
        Q_NC(43), CDOUT(42) => Q_NC(42), CDOUT(41) => Q_NC(41), 
        CDOUT(40) => Q_NC(40), CDOUT(39) => Q_NC(39), CDOUT(38)
         => Q_NC(38), CDOUT(37) => Q_NC(37), CDOUT(36) => 
        Q_NC(36), CDOUT(35) => Q_NC(35), CDOUT(34) => Q_NC(34), 
        CDOUT(33) => Q_NC(33), CDOUT(32) => Q_NC(32), CDOUT(31)
         => Q_NC(31), CDOUT(30) => Q_NC(30), CDOUT(29) => 
        Q_NC(29), CDOUT(28) => Q_NC(28), CDOUT(27) => Q_NC(27), 
        CDOUT(26) => Q_NC(26), CDOUT(25) => Q_NC(25), CDOUT(24)
         => Q_NC(24), CDOUT(23) => Q_NC(23), CDOUT(22) => 
        Q_NC(22), CDOUT(21) => Q_NC(21), CDOUT(20) => Q_NC(20), 
        CDOUT(19) => Q_NC(19), CDOUT(18) => Q_NC(18), CDOUT(17)
         => Q_NC(17), CDOUT(16) => Q_NC(16), CDOUT(15) => 
        Q_NC(15), CDOUT(14) => Q_NC(14), CDOUT(13) => Q_NC(13), 
        CDOUT(12) => Q_NC(12), CDOUT(11) => Q_NC(11), CDOUT(10)
         => Q_NC(10), CDOUT(9) => Q_NC(9), CDOUT(8) => Q_NC(8), 
        CDOUT(7) => Q_NC(7), CDOUT(6) => Q_NC(6), CDOUT(5) => 
        Q_NC(5), CDOUT(4) => Q_NC(4), CDOUT(3) => Q_NC(3), 
        CDOUT(2) => Q_NC(2), CDOUT(1) => Q_NC(1), CDOUT(0) => 
        Q_NC(0), OVFL_CARRYOUT => OVFL_CARRYOUT, P(47) => 
        Q_ONC(47), P(46) => Q_ONC(46), P(45) => Q_ONC(45), P(44)
         => Q_ONC(44), P(43) => Q_ONC(43), P(42) => Q_ONC(42), 
        P(41) => Q_ONC(41), P(40) => Q_ONC(40), P(39) => 
        Q_ONC(39), P(38) => Q_ONC(38), P(37) => Q_ONC(37), P(36)
         => Q_ONC(36), P(35) => Q_ONC(35), P(34) => Q_ONC(34), 
        P(33) => Q_ONC(33), P(32) => Q_ONC(32), P(31) => 
        Q_ONC(31), P(30) => Q_ONC(30), P(29) => Q_ONC(29), P(28)
         => Q_ONC(28), P(27) => Q_ONC(27), P(26) => Q_ONC(26), 
        P(25) => Q_ONC(25), P(24) => Q_ONC(24), P(23) => 
        Q_ONC(23), P(22) => Q_ONC(22), P(21) => Q_ONC(21), P(20)
         => Q_ONC(20), P(19) => Q_ONC(19), P(18) => Q_ONC(18), 
        P(17) => Q_ONC(17), P(16) => Q_ONC(16), P(15) => k1r(15), 
        P(14) => k1r(14), P(13) => k1r(13), P(12) => k1r(12), 
        P(11) => k1r(11), P(10) => k1r(10), P(9) => k1r(9), P(8)
         => k1r(8), P(7) => k1r(7), P(6) => k1r(6), P(5) => 
        k1r(5), P(4) => k1r(4), P(3) => k1r(3), P(2) => k1r(2), 
        P(1) => k1r(1), P(0) => p_0);
    
    \b_real_ibuf[0]\ : INBUF
      port map(PAD => b_real(0), Y => b_real_c(0));
    
    \a_real_ibuf[1]\ : INBUF
      port map(PAD => a_real(1), Y => a_real_c(1));
    
    \a_imag_ibuf[4]\ : INBUF
      port map(PAD => a_imag(4), Y => a_imag_c(4));
    

end DEF_ARCH; 
