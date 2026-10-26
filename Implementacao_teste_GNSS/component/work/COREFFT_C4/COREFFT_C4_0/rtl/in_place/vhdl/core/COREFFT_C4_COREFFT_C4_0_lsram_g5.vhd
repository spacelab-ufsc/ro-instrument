-- Version: 2025.1 2025.1.0.14

library ieee;
use ieee.std_logic_1164.all;
library polarfire;
use polarfire.all;

entity COREFFT_C4_COREFFT_C4_0_lsram_g5 is

    port( DI       : in    std_logic_vector(63 downto 0);
          DO       : out   std_logic_vector(63 downto 0);
          WADDR    : in    std_logic_vector(10 downto 0);
          RADDR    : in    std_logic_vector(10 downto 0);
          WRB      : in    std_logic;
          WCLOCK   : in    std_logic;
          RCLOCK   : in    std_logic;
          DO_nGrst : in    std_logic;
          DO_en    : in    std_logic;
          DO_rst   : in    std_logic
        );

end COREFFT_C4_COREFFT_C4_0_lsram_g5;

architecture DEF_ARCH of COREFFT_C4_COREFFT_C4_0_lsram_g5 is 

  component RAM1K20
    generic (MEMORYFILE:string := ""; RAMINDEX:string := ""; 
        INIT0:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT1:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT2:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT3:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT4:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT5:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT6:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT7:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT8:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT9:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT10:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT11:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT12:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT13:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT14:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT15:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT16:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT17:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT18:std_logic_vector(1023 downto 0) := (others => 'X'); 
        INIT19:std_logic_vector(1023 downto 0) := (others => 'X')
        );

    port( A_DOUT        : out   std_logic_vector(19 downto 0);
          B_DOUT        : out   std_logic_vector(19 downto 0);
          DB_DETECT     : out   std_logic;
          SB_CORRECT    : out   std_logic;
          ACCESS_BUSY   : out   std_logic;
          A_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          A_BLK_EN      : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_CLK         : in    std_logic := 'U';
          A_DIN         : in    std_logic_vector(19 downto 0) := (others => 'U');
          A_REN         : in    std_logic := 'U';
          A_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_DOUT_EN     : in    std_logic := 'U';
          A_DOUT_ARST_N : in    std_logic := 'U';
          A_DOUT_SRST_N : in    std_logic := 'U';
          B_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          B_BLK_EN      : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_CLK         : in    std_logic := 'U';
          B_DIN         : in    std_logic_vector(19 downto 0) := (others => 'U');
          B_REN         : in    std_logic := 'U';
          B_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_DOUT_EN     : in    std_logic := 'U';
          B_DOUT_ARST_N : in    std_logic := 'U';
          B_DOUT_SRST_N : in    std_logic := 'U';
          ECC_EN        : in    std_logic := 'U';
          BUSY_FB       : in    std_logic := 'U';
          A_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_WMODE       : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_BYPASS      : in    std_logic := 'U';
          B_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_WMODE       : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_BYPASS      : in    std_logic := 'U';
          ECC_BYPASS    : in    std_logic := 'U'
        );
  end component;

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal DOUTSRSTAP, \ACCESS_BUSY[0][0]\, \ACCESS_BUSY[0][1]\, 
        \ACCESS_BUSY[0][2]\, \ACCESS_BUSY[0][3]\, 
        \ACCESS_BUSY[0][4]\, \ACCESS_BUSY[0][5]\, 
        \ACCESS_BUSY[0][6]\, \VCC\, \GND\, ADLIB_VCC : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;
    signal nc203, nc216, nc194, nc151, nc23, nc175, nc58, nc116, 
        nc74, nc133, nc167, nc84, nc39, nc72, nc212, nc205, nc82, 
        nc145, nc181, nc160, nc57, nc156, nc125, nc211, nc73, 
        nc107, nc66, nc83, nc9, nc171, nc54, nc135, nc41, nc100, 
        nc52, nc186, nc29, nc118, nc60, nc141, nc193, nc214, nc45, 
        nc53, nc121, nc176, nc158, nc209, nc162, nc11, nc131, 
        nc96, nc79, nc146, nc89, nc119, nc48, nc213, nc126, nc195, 
        nc188, nc15, nc102, nc3, nc207, nc47, nc90, nc159, nc136, 
        nc178, nc215, nc59, nc18, nc44, nc117, nc189, nc164, 
        nc148, nc42, nc191, nc17, nc2, nc110, nc128, nc43, nc179, 
        nc157, nc36, nc61, nc104, nc138, nc14, nc150, nc196, 
        nc149, nc12, nc30, nc187, nc65, nc7, nc129, nc8, nc13, 
        nc180, nc26, nc177, nc139, nc163, nc112, nc68, nc49, 
        nc170, nc91, nc5, nc20, nc198, nc147, nc67, nc152, nc127, 
        nc103, nc76, nc208, nc140, nc86, nc95, nc120, nc165, 
        nc137, nc64, nc19, nc70, nc182, nc62, nc199, nc80, nc130, 
        nc98, nc114, nc56, nc105, nc63, nc172, nc97, nc161, nc31, 
        nc154, nc50, nc142, nc94, nc197, nc122, nc35, nc4, nc92, 
        nc101, nc184, nc200, nc190, nc166, nc132, nc21, nc93, 
        nc69, nc206, nc174, nc38, nc113, nc106, nc25, nc1, nc37, 
        nc202, nc144, nc153, nc46, nc71, nc124, nc81, nc201, 
        nc168, nc34, nc28, nc115, nc192, nc134, nc32, nc40, nc99, 
        nc75, nc183, nc85, nc27, nc108, nc16, nc155, nc51, nc33, 
        nc204, nc173, nc169, nc78, nc24, nc88, nc111, nc55, nc10, 
        nc22, nc210, nc185, nc143, nc77, nc6, nc109, nc87, nc123
         : std_logic;

begin 

    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    ADLIB_VCC <= VCC_power_net1;

    COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C6 : RAM1K20

              generic map(RAMINDEX => "core%2048-2048%64-64%SPEED%0%6%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc203, A_DOUT(18) => nc216, 
        A_DOUT(17) => nc194, A_DOUT(16) => nc151, A_DOUT(15) => 
        nc23, A_DOUT(14) => nc175, A_DOUT(13) => nc58, A_DOUT(12)
         => nc116, A_DOUT(11) => nc74, A_DOUT(10) => nc133, 
        A_DOUT(9) => nc167, A_DOUT(8) => nc84, A_DOUT(7) => nc39, 
        A_DOUT(6) => nc72, A_DOUT(5) => nc212, A_DOUT(4) => nc205, 
        A_DOUT(3) => DO(63), A_DOUT(2) => DO(62), A_DOUT(1) => 
        DO(61), A_DOUT(0) => DO(60), B_DOUT(19) => nc82, 
        B_DOUT(18) => nc145, B_DOUT(17) => nc181, B_DOUT(16) => 
        nc160, B_DOUT(15) => nc57, B_DOUT(14) => nc156, 
        B_DOUT(13) => nc125, B_DOUT(12) => nc211, B_DOUT(11) => 
        nc73, B_DOUT(10) => nc107, B_DOUT(9) => nc66, B_DOUT(8)
         => nc83, B_DOUT(7) => nc9, B_DOUT(6) => nc171, B_DOUT(5)
         => nc54, B_DOUT(4) => nc135, B_DOUT(3) => nc41, 
        B_DOUT(2) => nc100, B_DOUT(1) => nc52, B_DOUT(0) => nc186, 
        DB_DETECT => OPEN, SB_CORRECT => OPEN, ACCESS_BUSY => 
        \ACCESS_BUSY[0][6]\, A_ADDR(13) => RADDR(10), A_ADDR(12)
         => RADDR(9), A_ADDR(11) => RADDR(8), A_ADDR(10) => 
        RADDR(7), A_ADDR(9) => RADDR(6), A_ADDR(8) => RADDR(5), 
        A_ADDR(7) => RADDR(4), A_ADDR(6) => RADDR(3), A_ADDR(5)
         => RADDR(2), A_ADDR(4) => RADDR(1), A_ADDR(3) => 
        RADDR(0), A_ADDR(2) => \GND\, A_ADDR(1) => \GND\, 
        A_ADDR(0) => \GND\, A_BLK_EN(2) => \VCC\, A_BLK_EN(1) => 
        \VCC\, A_BLK_EN(0) => \VCC\, A_CLK => RCLOCK, A_DIN(19)
         => \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, 
        A_DIN(16) => \GND\, A_DIN(15) => \GND\, A_DIN(14) => 
        \GND\, A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11)
         => \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, 
        A_DIN(8) => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, 
        A_DIN(5) => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, 
        A_DIN(2) => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, 
        A_REN => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => DO_en, A_DOUT_ARST_N => DO_nGrst, 
        A_DOUT_SRST_N => DOUTSRSTAP, B_ADDR(13) => WADDR(10), 
        B_ADDR(12) => WADDR(9), B_ADDR(11) => WADDR(8), 
        B_ADDR(10) => WADDR(7), B_ADDR(9) => WADDR(6), B_ADDR(8)
         => WADDR(5), B_ADDR(7) => WADDR(4), B_ADDR(6) => 
        WADDR(3), B_ADDR(5) => WADDR(2), B_ADDR(4) => WADDR(1), 
        B_ADDR(3) => WADDR(0), B_ADDR(2) => \GND\, B_ADDR(1) => 
        \GND\, B_ADDR(0) => \GND\, B_BLK_EN(2) => WRB, 
        B_BLK_EN(1) => \VCC\, B_BLK_EN(0) => \VCC\, B_CLK => 
        WCLOCK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, B_DIN(17)
         => \GND\, B_DIN(16) => \GND\, B_DIN(15) => \GND\, 
        B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12) => 
        \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, B_DIN(9)
         => \GND\, B_DIN(8) => \GND\, B_DIN(7) => \GND\, B_DIN(6)
         => \GND\, B_DIN(5) => \GND\, B_DIN(4) => \GND\, B_DIN(3)
         => DI(63), B_DIN(2) => DI(62), B_DIN(1) => DI(61), 
        B_DIN(0) => DI(60), B_REN => \VCC\, B_WEN(1) => \GND\, 
        B_WEN(0) => \VCC\, B_DOUT_EN => DO_en, B_DOUT_ARST_N => 
        \GND\, B_DOUT_SRST_N => DOUTSRSTAP, ECC_EN => \GND\, 
        BUSY_FB => \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => 
        \VCC\, A_WIDTH(0) => \VCC\, A_WMODE(1) => \GND\, 
        A_WMODE(0) => \GND\, A_BYPASS => \GND\, B_WIDTH(2) => 
        \GND\, B_WIDTH(1) => \VCC\, B_WIDTH(0) => \VCC\, 
        B_WMODE(1) => \GND\, B_WMODE(0) => \GND\, B_BYPASS => 
        \GND\, ECC_BYPASS => \GND\);
    
    COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C2 : RAM1K20

              generic map(RAMINDEX => "core%2048-2048%64-64%SPEED%0%2%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc29, A_DOUT(18) => nc118, 
        A_DOUT(17) => nc60, A_DOUT(16) => nc141, A_DOUT(15) => 
        nc193, A_DOUT(14) => nc214, A_DOUT(13) => nc45, 
        A_DOUT(12) => nc53, A_DOUT(11) => nc121, A_DOUT(10) => 
        nc176, A_DOUT(9) => DO(29), A_DOUT(8) => DO(28), 
        A_DOUT(7) => DO(27), A_DOUT(6) => DO(26), A_DOUT(5) => 
        DO(25), A_DOUT(4) => DO(24), A_DOUT(3) => DO(23), 
        A_DOUT(2) => DO(22), A_DOUT(1) => DO(21), A_DOUT(0) => 
        DO(20), B_DOUT(19) => nc158, B_DOUT(18) => nc209, 
        B_DOUT(17) => nc162, B_DOUT(16) => nc11, B_DOUT(15) => 
        nc131, B_DOUT(14) => nc96, B_DOUT(13) => nc79, B_DOUT(12)
         => nc146, B_DOUT(11) => nc89, B_DOUT(10) => nc119, 
        B_DOUT(9) => nc48, B_DOUT(8) => nc213, B_DOUT(7) => nc126, 
        B_DOUT(6) => nc195, B_DOUT(5) => nc188, B_DOUT(4) => nc15, 
        B_DOUT(3) => nc102, B_DOUT(2) => nc3, B_DOUT(1) => nc207, 
        B_DOUT(0) => nc47, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][2]\, A_ADDR(13) => 
        RADDR(10), A_ADDR(12) => RADDR(9), A_ADDR(11) => RADDR(8), 
        A_ADDR(10) => RADDR(7), A_ADDR(9) => RADDR(6), A_ADDR(8)
         => RADDR(5), A_ADDR(7) => RADDR(4), A_ADDR(6) => 
        RADDR(3), A_ADDR(5) => RADDR(2), A_ADDR(4) => RADDR(1), 
        A_ADDR(3) => RADDR(0), A_ADDR(2) => \GND\, A_ADDR(1) => 
        \GND\, A_ADDR(0) => \GND\, A_BLK_EN(2) => \VCC\, 
        A_BLK_EN(1) => \VCC\, A_BLK_EN(0) => \VCC\, A_CLK => 
        RCLOCK, A_DIN(19) => \GND\, A_DIN(18) => \GND\, A_DIN(17)
         => \GND\, A_DIN(16) => \GND\, A_DIN(15) => \GND\, 
        A_DIN(14) => \GND\, A_DIN(13) => \GND\, A_DIN(12) => 
        \GND\, A_DIN(11) => \GND\, A_DIN(10) => \GND\, A_DIN(9)
         => \GND\, A_DIN(8) => \GND\, A_DIN(7) => \GND\, A_DIN(6)
         => \GND\, A_DIN(5) => \GND\, A_DIN(4) => \GND\, A_DIN(3)
         => \GND\, A_DIN(2) => \GND\, A_DIN(1) => \GND\, A_DIN(0)
         => \GND\, A_REN => \VCC\, A_WEN(1) => \GND\, A_WEN(0)
         => \GND\, A_DOUT_EN => DO_en, A_DOUT_ARST_N => DO_nGrst, 
        A_DOUT_SRST_N => DOUTSRSTAP, B_ADDR(13) => WADDR(10), 
        B_ADDR(12) => WADDR(9), B_ADDR(11) => WADDR(8), 
        B_ADDR(10) => WADDR(7), B_ADDR(9) => WADDR(6), B_ADDR(8)
         => WADDR(5), B_ADDR(7) => WADDR(4), B_ADDR(6) => 
        WADDR(3), B_ADDR(5) => WADDR(2), B_ADDR(4) => WADDR(1), 
        B_ADDR(3) => WADDR(0), B_ADDR(2) => \GND\, B_ADDR(1) => 
        \GND\, B_ADDR(0) => \GND\, B_BLK_EN(2) => WRB, 
        B_BLK_EN(1) => \VCC\, B_BLK_EN(0) => \VCC\, B_CLK => 
        WCLOCK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, B_DIN(17)
         => \GND\, B_DIN(16) => \GND\, B_DIN(15) => \GND\, 
        B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12) => 
        \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, B_DIN(9)
         => DI(29), B_DIN(8) => DI(28), B_DIN(7) => DI(27), 
        B_DIN(6) => DI(26), B_DIN(5) => DI(25), B_DIN(4) => 
        DI(24), B_DIN(3) => DI(23), B_DIN(2) => DI(22), B_DIN(1)
         => DI(21), B_DIN(0) => DI(20), B_REN => \VCC\, B_WEN(1)
         => \GND\, B_WEN(0) => \VCC\, B_DOUT_EN => DO_en, 
        B_DOUT_ARST_N => \GND\, B_DOUT_SRST_N => DOUTSRSTAP, 
        ECC_EN => \GND\, BUSY_FB => \GND\, A_WIDTH(2) => \GND\, 
        A_WIDTH(1) => \VCC\, A_WIDTH(0) => \VCC\, A_WMODE(1) => 
        \GND\, A_WMODE(0) => \GND\, A_BYPASS => \GND\, B_WIDTH(2)
         => \GND\, B_WIDTH(1) => \VCC\, B_WIDTH(0) => \VCC\, 
        B_WMODE(1) => \GND\, B_WMODE(0) => \GND\, B_BYPASS => 
        \GND\, ECC_BYPASS => \GND\);
    
    INVDOUTSRSTAP : CFG1
      generic map(INIT => "01")

      port map(A => DO_rst, Y => DOUTSRSTAP);
    
    COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C0 : RAM1K20

              generic map(RAMINDEX => "core%2048-2048%64-64%SPEED%0%0%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc90, A_DOUT(18) => nc159, 
        A_DOUT(17) => nc136, A_DOUT(16) => nc178, A_DOUT(15) => 
        nc215, A_DOUT(14) => nc59, A_DOUT(13) => nc18, A_DOUT(12)
         => nc44, A_DOUT(11) => nc117, A_DOUT(10) => nc189, 
        A_DOUT(9) => DO(9), A_DOUT(8) => DO(8), A_DOUT(7) => 
        DO(7), A_DOUT(6) => DO(6), A_DOUT(5) => DO(5), A_DOUT(4)
         => DO(4), A_DOUT(3) => DO(3), A_DOUT(2) => DO(2), 
        A_DOUT(1) => DO(1), A_DOUT(0) => DO(0), B_DOUT(19) => 
        nc164, B_DOUT(18) => nc148, B_DOUT(17) => nc42, 
        B_DOUT(16) => nc191, B_DOUT(15) => nc17, B_DOUT(14) => 
        nc2, B_DOUT(13) => nc110, B_DOUT(12) => nc128, B_DOUT(11)
         => nc43, B_DOUT(10) => nc179, B_DOUT(9) => nc157, 
        B_DOUT(8) => nc36, B_DOUT(7) => nc61, B_DOUT(6) => nc104, 
        B_DOUT(5) => nc138, B_DOUT(4) => nc14, B_DOUT(3) => nc150, 
        B_DOUT(2) => nc196, B_DOUT(1) => nc149, B_DOUT(0) => nc12, 
        DB_DETECT => OPEN, SB_CORRECT => OPEN, ACCESS_BUSY => 
        \ACCESS_BUSY[0][0]\, A_ADDR(13) => RADDR(10), A_ADDR(12)
         => RADDR(9), A_ADDR(11) => RADDR(8), A_ADDR(10) => 
        RADDR(7), A_ADDR(9) => RADDR(6), A_ADDR(8) => RADDR(5), 
        A_ADDR(7) => RADDR(4), A_ADDR(6) => RADDR(3), A_ADDR(5)
         => RADDR(2), A_ADDR(4) => RADDR(1), A_ADDR(3) => 
        RADDR(0), A_ADDR(2) => \GND\, A_ADDR(1) => \GND\, 
        A_ADDR(0) => \GND\, A_BLK_EN(2) => \VCC\, A_BLK_EN(1) => 
        \VCC\, A_BLK_EN(0) => \VCC\, A_CLK => RCLOCK, A_DIN(19)
         => \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, 
        A_DIN(16) => \GND\, A_DIN(15) => \GND\, A_DIN(14) => 
        \GND\, A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11)
         => \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, 
        A_DIN(8) => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, 
        A_DIN(5) => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, 
        A_DIN(2) => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, 
        A_REN => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => DO_en, A_DOUT_ARST_N => DO_nGrst, 
        A_DOUT_SRST_N => DOUTSRSTAP, B_ADDR(13) => WADDR(10), 
        B_ADDR(12) => WADDR(9), B_ADDR(11) => WADDR(8), 
        B_ADDR(10) => WADDR(7), B_ADDR(9) => WADDR(6), B_ADDR(8)
         => WADDR(5), B_ADDR(7) => WADDR(4), B_ADDR(6) => 
        WADDR(3), B_ADDR(5) => WADDR(2), B_ADDR(4) => WADDR(1), 
        B_ADDR(3) => WADDR(0), B_ADDR(2) => \GND\, B_ADDR(1) => 
        \GND\, B_ADDR(0) => \GND\, B_BLK_EN(2) => WRB, 
        B_BLK_EN(1) => \VCC\, B_BLK_EN(0) => \VCC\, B_CLK => 
        WCLOCK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, B_DIN(17)
         => \GND\, B_DIN(16) => \GND\, B_DIN(15) => \GND\, 
        B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12) => 
        \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, B_DIN(9)
         => DI(9), B_DIN(8) => DI(8), B_DIN(7) => DI(7), B_DIN(6)
         => DI(6), B_DIN(5) => DI(5), B_DIN(4) => DI(4), B_DIN(3)
         => DI(3), B_DIN(2) => DI(2), B_DIN(1) => DI(1), B_DIN(0)
         => DI(0), B_REN => \VCC\, B_WEN(1) => \GND\, B_WEN(0)
         => \VCC\, B_DOUT_EN => DO_en, B_DOUT_ARST_N => \GND\, 
        B_DOUT_SRST_N => DOUTSRSTAP, ECC_EN => \GND\, BUSY_FB => 
        \GND\, A_WIDTH(2) => \GND\, A_WIDTH(1) => \VCC\, 
        A_WIDTH(0) => \VCC\, A_WMODE(1) => \GND\, A_WMODE(0) => 
        \GND\, A_BYPASS => \GND\, B_WIDTH(2) => \GND\, B_WIDTH(1)
         => \VCC\, B_WIDTH(0) => \VCC\, B_WMODE(1) => \GND\, 
        B_WMODE(0) => \GND\, B_BYPASS => \GND\, ECC_BYPASS => 
        \GND\);
    
    COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C5 : RAM1K20

              generic map(RAMINDEX => "core%2048-2048%64-64%SPEED%0%5%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc30, A_DOUT(18) => nc187, 
        A_DOUT(17) => nc65, A_DOUT(16) => nc7, A_DOUT(15) => 
        nc129, A_DOUT(14) => nc8, A_DOUT(13) => nc13, A_DOUT(12)
         => nc180, A_DOUT(11) => nc26, A_DOUT(10) => nc177, 
        A_DOUT(9) => DO(59), A_DOUT(8) => DO(58), A_DOUT(7) => 
        DO(57), A_DOUT(6) => DO(56), A_DOUT(5) => DO(55), 
        A_DOUT(4) => DO(54), A_DOUT(3) => DO(53), A_DOUT(2) => 
        DO(52), A_DOUT(1) => DO(51), A_DOUT(0) => DO(50), 
        B_DOUT(19) => nc139, B_DOUT(18) => nc163, B_DOUT(17) => 
        nc112, B_DOUT(16) => nc68, B_DOUT(15) => nc49, B_DOUT(14)
         => nc170, B_DOUT(13) => nc91, B_DOUT(12) => nc5, 
        B_DOUT(11) => nc20, B_DOUT(10) => nc198, B_DOUT(9) => 
        nc147, B_DOUT(8) => nc67, B_DOUT(7) => nc152, B_DOUT(6)
         => nc127, B_DOUT(5) => nc103, B_DOUT(4) => nc76, 
        B_DOUT(3) => nc208, B_DOUT(2) => nc140, B_DOUT(1) => nc86, 
        B_DOUT(0) => nc95, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][5]\, A_ADDR(13) => 
        RADDR(10), A_ADDR(12) => RADDR(9), A_ADDR(11) => RADDR(8), 
        A_ADDR(10) => RADDR(7), A_ADDR(9) => RADDR(6), A_ADDR(8)
         => RADDR(5), A_ADDR(7) => RADDR(4), A_ADDR(6) => 
        RADDR(3), A_ADDR(5) => RADDR(2), A_ADDR(4) => RADDR(1), 
        A_ADDR(3) => RADDR(0), A_ADDR(2) => \GND\, A_ADDR(1) => 
        \GND\, A_ADDR(0) => \GND\, A_BLK_EN(2) => \VCC\, 
        A_BLK_EN(1) => \VCC\, A_BLK_EN(0) => \VCC\, A_CLK => 
        RCLOCK, A_DIN(19) => \GND\, A_DIN(18) => \GND\, A_DIN(17)
         => \GND\, A_DIN(16) => \GND\, A_DIN(15) => \GND\, 
        A_DIN(14) => \GND\, A_DIN(13) => \GND\, A_DIN(12) => 
        \GND\, A_DIN(11) => \GND\, A_DIN(10) => \GND\, A_DIN(9)
         => \GND\, A_DIN(8) => \GND\, A_DIN(7) => \GND\, A_DIN(6)
         => \GND\, A_DIN(5) => \GND\, A_DIN(4) => \GND\, A_DIN(3)
         => \GND\, A_DIN(2) => \GND\, A_DIN(1) => \GND\, A_DIN(0)
         => \GND\, A_REN => \VCC\, A_WEN(1) => \GND\, A_WEN(0)
         => \GND\, A_DOUT_EN => DO_en, A_DOUT_ARST_N => DO_nGrst, 
        A_DOUT_SRST_N => DOUTSRSTAP, B_ADDR(13) => WADDR(10), 
        B_ADDR(12) => WADDR(9), B_ADDR(11) => WADDR(8), 
        B_ADDR(10) => WADDR(7), B_ADDR(9) => WADDR(6), B_ADDR(8)
         => WADDR(5), B_ADDR(7) => WADDR(4), B_ADDR(6) => 
        WADDR(3), B_ADDR(5) => WADDR(2), B_ADDR(4) => WADDR(1), 
        B_ADDR(3) => WADDR(0), B_ADDR(2) => \GND\, B_ADDR(1) => 
        \GND\, B_ADDR(0) => \GND\, B_BLK_EN(2) => WRB, 
        B_BLK_EN(1) => \VCC\, B_BLK_EN(0) => \VCC\, B_CLK => 
        WCLOCK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, B_DIN(17)
         => \GND\, B_DIN(16) => \GND\, B_DIN(15) => \GND\, 
        B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12) => 
        \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, B_DIN(9)
         => DI(59), B_DIN(8) => DI(58), B_DIN(7) => DI(57), 
        B_DIN(6) => DI(56), B_DIN(5) => DI(55), B_DIN(4) => 
        DI(54), B_DIN(3) => DI(53), B_DIN(2) => DI(52), B_DIN(1)
         => DI(51), B_DIN(0) => DI(50), B_REN => \VCC\, B_WEN(1)
         => \GND\, B_WEN(0) => \VCC\, B_DOUT_EN => DO_en, 
        B_DOUT_ARST_N => \GND\, B_DOUT_SRST_N => DOUTSRSTAP, 
        ECC_EN => \GND\, BUSY_FB => \GND\, A_WIDTH(2) => \GND\, 
        A_WIDTH(1) => \VCC\, A_WIDTH(0) => \VCC\, A_WMODE(1) => 
        \GND\, A_WMODE(0) => \GND\, A_BYPASS => \GND\, B_WIDTH(2)
         => \GND\, B_WIDTH(1) => \VCC\, B_WIDTH(0) => \VCC\, 
        B_WMODE(1) => \GND\, B_WMODE(0) => \GND\, B_BYPASS => 
        \GND\, ECC_BYPASS => \GND\);
    
    COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C1 : RAM1K20

              generic map(RAMINDEX => "core%2048-2048%64-64%SPEED%0%1%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc120, A_DOUT(18) => nc165, 
        A_DOUT(17) => nc137, A_DOUT(16) => nc64, A_DOUT(15) => 
        nc19, A_DOUT(14) => nc70, A_DOUT(13) => nc182, A_DOUT(12)
         => nc62, A_DOUT(11) => nc199, A_DOUT(10) => nc80, 
        A_DOUT(9) => DO(19), A_DOUT(8) => DO(18), A_DOUT(7) => 
        DO(17), A_DOUT(6) => DO(16), A_DOUT(5) => DO(15), 
        A_DOUT(4) => DO(14), A_DOUT(3) => DO(13), A_DOUT(2) => 
        DO(12), A_DOUT(1) => DO(11), A_DOUT(0) => DO(10), 
        B_DOUT(19) => nc130, B_DOUT(18) => nc98, B_DOUT(17) => 
        nc114, B_DOUT(16) => nc56, B_DOUT(15) => nc105, 
        B_DOUT(14) => nc63, B_DOUT(13) => nc172, B_DOUT(12) => 
        nc97, B_DOUT(11) => nc161, B_DOUT(10) => nc31, B_DOUT(9)
         => nc154, B_DOUT(8) => nc50, B_DOUT(7) => nc142, 
        B_DOUT(6) => nc94, B_DOUT(5) => nc197, B_DOUT(4) => nc122, 
        B_DOUT(3) => nc35, B_DOUT(2) => nc4, B_DOUT(1) => nc92, 
        B_DOUT(0) => nc101, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][1]\, A_ADDR(13) => 
        RADDR(10), A_ADDR(12) => RADDR(9), A_ADDR(11) => RADDR(8), 
        A_ADDR(10) => RADDR(7), A_ADDR(9) => RADDR(6), A_ADDR(8)
         => RADDR(5), A_ADDR(7) => RADDR(4), A_ADDR(6) => 
        RADDR(3), A_ADDR(5) => RADDR(2), A_ADDR(4) => RADDR(1), 
        A_ADDR(3) => RADDR(0), A_ADDR(2) => \GND\, A_ADDR(1) => 
        \GND\, A_ADDR(0) => \GND\, A_BLK_EN(2) => \VCC\, 
        A_BLK_EN(1) => \VCC\, A_BLK_EN(0) => \VCC\, A_CLK => 
        RCLOCK, A_DIN(19) => \GND\, A_DIN(18) => \GND\, A_DIN(17)
         => \GND\, A_DIN(16) => \GND\, A_DIN(15) => \GND\, 
        A_DIN(14) => \GND\, A_DIN(13) => \GND\, A_DIN(12) => 
        \GND\, A_DIN(11) => \GND\, A_DIN(10) => \GND\, A_DIN(9)
         => \GND\, A_DIN(8) => \GND\, A_DIN(7) => \GND\, A_DIN(6)
         => \GND\, A_DIN(5) => \GND\, A_DIN(4) => \GND\, A_DIN(3)
         => \GND\, A_DIN(2) => \GND\, A_DIN(1) => \GND\, A_DIN(0)
         => \GND\, A_REN => \VCC\, A_WEN(1) => \GND\, A_WEN(0)
         => \GND\, A_DOUT_EN => DO_en, A_DOUT_ARST_N => DO_nGrst, 
        A_DOUT_SRST_N => DOUTSRSTAP, B_ADDR(13) => WADDR(10), 
        B_ADDR(12) => WADDR(9), B_ADDR(11) => WADDR(8), 
        B_ADDR(10) => WADDR(7), B_ADDR(9) => WADDR(6), B_ADDR(8)
         => WADDR(5), B_ADDR(7) => WADDR(4), B_ADDR(6) => 
        WADDR(3), B_ADDR(5) => WADDR(2), B_ADDR(4) => WADDR(1), 
        B_ADDR(3) => WADDR(0), B_ADDR(2) => \GND\, B_ADDR(1) => 
        \GND\, B_ADDR(0) => \GND\, B_BLK_EN(2) => WRB, 
        B_BLK_EN(1) => \VCC\, B_BLK_EN(0) => \VCC\, B_CLK => 
        WCLOCK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, B_DIN(17)
         => \GND\, B_DIN(16) => \GND\, B_DIN(15) => \GND\, 
        B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12) => 
        \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, B_DIN(9)
         => DI(19), B_DIN(8) => DI(18), B_DIN(7) => DI(17), 
        B_DIN(6) => DI(16), B_DIN(5) => DI(15), B_DIN(4) => 
        DI(14), B_DIN(3) => DI(13), B_DIN(2) => DI(12), B_DIN(1)
         => DI(11), B_DIN(0) => DI(10), B_REN => \VCC\, B_WEN(1)
         => \GND\, B_WEN(0) => \VCC\, B_DOUT_EN => DO_en, 
        B_DOUT_ARST_N => \GND\, B_DOUT_SRST_N => DOUTSRSTAP, 
        ECC_EN => \GND\, BUSY_FB => \GND\, A_WIDTH(2) => \GND\, 
        A_WIDTH(1) => \VCC\, A_WIDTH(0) => \VCC\, A_WMODE(1) => 
        \GND\, A_WMODE(0) => \GND\, A_BYPASS => \GND\, B_WIDTH(2)
         => \GND\, B_WIDTH(1) => \VCC\, B_WIDTH(0) => \VCC\, 
        B_WMODE(1) => \GND\, B_WMODE(0) => \GND\, B_BYPASS => 
        \GND\, ECC_BYPASS => \GND\);
    
    COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C4 : RAM1K20

              generic map(RAMINDEX => "core%2048-2048%64-64%SPEED%0%4%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc184, A_DOUT(18) => nc200, 
        A_DOUT(17) => nc190, A_DOUT(16) => nc166, A_DOUT(15) => 
        nc132, A_DOUT(14) => nc21, A_DOUT(13) => nc93, A_DOUT(12)
         => nc69, A_DOUT(11) => nc206, A_DOUT(10) => nc174, 
        A_DOUT(9) => DO(49), A_DOUT(8) => DO(48), A_DOUT(7) => 
        DO(47), A_DOUT(6) => DO(46), A_DOUT(5) => DO(45), 
        A_DOUT(4) => DO(44), A_DOUT(3) => DO(43), A_DOUT(2) => 
        DO(42), A_DOUT(1) => DO(41), A_DOUT(0) => DO(40), 
        B_DOUT(19) => nc38, B_DOUT(18) => nc113, B_DOUT(17) => 
        nc106, B_DOUT(16) => nc25, B_DOUT(15) => nc1, B_DOUT(14)
         => nc37, B_DOUT(13) => nc202, B_DOUT(12) => nc144, 
        B_DOUT(11) => nc153, B_DOUT(10) => nc46, B_DOUT(9) => 
        nc71, B_DOUT(8) => nc124, B_DOUT(7) => nc81, B_DOUT(6)
         => nc201, B_DOUT(5) => nc168, B_DOUT(4) => nc34, 
        B_DOUT(3) => nc28, B_DOUT(2) => nc115, B_DOUT(1) => nc192, 
        B_DOUT(0) => nc134, DB_DETECT => OPEN, SB_CORRECT => OPEN, 
        ACCESS_BUSY => \ACCESS_BUSY[0][4]\, A_ADDR(13) => 
        RADDR(10), A_ADDR(12) => RADDR(9), A_ADDR(11) => RADDR(8), 
        A_ADDR(10) => RADDR(7), A_ADDR(9) => RADDR(6), A_ADDR(8)
         => RADDR(5), A_ADDR(7) => RADDR(4), A_ADDR(6) => 
        RADDR(3), A_ADDR(5) => RADDR(2), A_ADDR(4) => RADDR(1), 
        A_ADDR(3) => RADDR(0), A_ADDR(2) => \GND\, A_ADDR(1) => 
        \GND\, A_ADDR(0) => \GND\, A_BLK_EN(2) => \VCC\, 
        A_BLK_EN(1) => \VCC\, A_BLK_EN(0) => \VCC\, A_CLK => 
        RCLOCK, A_DIN(19) => \GND\, A_DIN(18) => \GND\, A_DIN(17)
         => \GND\, A_DIN(16) => \GND\, A_DIN(15) => \GND\, 
        A_DIN(14) => \GND\, A_DIN(13) => \GND\, A_DIN(12) => 
        \GND\, A_DIN(11) => \GND\, A_DIN(10) => \GND\, A_DIN(9)
         => \GND\, A_DIN(8) => \GND\, A_DIN(7) => \GND\, A_DIN(6)
         => \GND\, A_DIN(5) => \GND\, A_DIN(4) => \GND\, A_DIN(3)
         => \GND\, A_DIN(2) => \GND\, A_DIN(1) => \GND\, A_DIN(0)
         => \GND\, A_REN => \VCC\, A_WEN(1) => \GND\, A_WEN(0)
         => \GND\, A_DOUT_EN => DO_en, A_DOUT_ARST_N => DO_nGrst, 
        A_DOUT_SRST_N => DOUTSRSTAP, B_ADDR(13) => WADDR(10), 
        B_ADDR(12) => WADDR(9), B_ADDR(11) => WADDR(8), 
        B_ADDR(10) => WADDR(7), B_ADDR(9) => WADDR(6), B_ADDR(8)
         => WADDR(5), B_ADDR(7) => WADDR(4), B_ADDR(6) => 
        WADDR(3), B_ADDR(5) => WADDR(2), B_ADDR(4) => WADDR(1), 
        B_ADDR(3) => WADDR(0), B_ADDR(2) => \GND\, B_ADDR(1) => 
        \GND\, B_ADDR(0) => \GND\, B_BLK_EN(2) => WRB, 
        B_BLK_EN(1) => \VCC\, B_BLK_EN(0) => \VCC\, B_CLK => 
        WCLOCK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, B_DIN(17)
         => \GND\, B_DIN(16) => \GND\, B_DIN(15) => \GND\, 
        B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12) => 
        \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, B_DIN(9)
         => DI(49), B_DIN(8) => DI(48), B_DIN(7) => DI(47), 
        B_DIN(6) => DI(46), B_DIN(5) => DI(45), B_DIN(4) => 
        DI(44), B_DIN(3) => DI(43), B_DIN(2) => DI(42), B_DIN(1)
         => DI(41), B_DIN(0) => DI(40), B_REN => \VCC\, B_WEN(1)
         => \GND\, B_WEN(0) => \VCC\, B_DOUT_EN => DO_en, 
        B_DOUT_ARST_N => \GND\, B_DOUT_SRST_N => DOUTSRSTAP, 
        ECC_EN => \GND\, BUSY_FB => \GND\, A_WIDTH(2) => \GND\, 
        A_WIDTH(1) => \VCC\, A_WIDTH(0) => \VCC\, A_WMODE(1) => 
        \GND\, A_WMODE(0) => \GND\, A_BYPASS => \GND\, B_WIDTH(2)
         => \GND\, B_WIDTH(1) => \VCC\, B_WIDTH(0) => \VCC\, 
        B_WMODE(1) => \GND\, B_WMODE(0) => \GND\, B_BYPASS => 
        \GND\, ECC_BYPASS => \GND\);
    
    COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C3 : RAM1K20

              generic map(RAMINDEX => "core%2048-2048%64-64%SPEED%0%3%TWO-PORT%ECC_EN-0"
        )

      port map(A_DOUT(19) => nc32, A_DOUT(18) => nc40, A_DOUT(17)
         => nc99, A_DOUT(16) => nc75, A_DOUT(15) => nc183, 
        A_DOUT(14) => nc85, A_DOUT(13) => nc27, A_DOUT(12) => 
        nc108, A_DOUT(11) => nc16, A_DOUT(10) => nc155, A_DOUT(9)
         => DO(39), A_DOUT(8) => DO(38), A_DOUT(7) => DO(37), 
        A_DOUT(6) => DO(36), A_DOUT(5) => DO(35), A_DOUT(4) => 
        DO(34), A_DOUT(3) => DO(33), A_DOUT(2) => DO(32), 
        A_DOUT(1) => DO(31), A_DOUT(0) => DO(30), B_DOUT(19) => 
        nc51, B_DOUT(18) => nc33, B_DOUT(17) => nc204, B_DOUT(16)
         => nc173, B_DOUT(15) => nc169, B_DOUT(14) => nc78, 
        B_DOUT(13) => nc24, B_DOUT(12) => nc88, B_DOUT(11) => 
        nc111, B_DOUT(10) => nc55, B_DOUT(9) => nc10, B_DOUT(8)
         => nc22, B_DOUT(7) => nc210, B_DOUT(6) => nc185, 
        B_DOUT(5) => nc143, B_DOUT(4) => nc77, B_DOUT(3) => nc6, 
        B_DOUT(2) => nc109, B_DOUT(1) => nc87, B_DOUT(0) => nc123, 
        DB_DETECT => OPEN, SB_CORRECT => OPEN, ACCESS_BUSY => 
        \ACCESS_BUSY[0][3]\, A_ADDR(13) => RADDR(10), A_ADDR(12)
         => RADDR(9), A_ADDR(11) => RADDR(8), A_ADDR(10) => 
        RADDR(7), A_ADDR(9) => RADDR(6), A_ADDR(8) => RADDR(5), 
        A_ADDR(7) => RADDR(4), A_ADDR(6) => RADDR(3), A_ADDR(5)
         => RADDR(2), A_ADDR(4) => RADDR(1), A_ADDR(3) => 
        RADDR(0), A_ADDR(2) => \GND\, A_ADDR(1) => \GND\, 
        A_ADDR(0) => \GND\, A_BLK_EN(2) => \VCC\, A_BLK_EN(1) => 
        \VCC\, A_BLK_EN(0) => \VCC\, A_CLK => RCLOCK, A_DIN(19)
         => \GND\, A_DIN(18) => \GND\, A_DIN(17) => \GND\, 
        A_DIN(16) => \GND\, A_DIN(15) => \GND\, A_DIN(14) => 
        \GND\, A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11)
         => \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, 
        A_DIN(8) => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, 
        A_DIN(5) => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, 
        A_DIN(2) => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, 
        A_REN => \VCC\, A_WEN(1) => \GND\, A_WEN(0) => \GND\, 
        A_DOUT_EN => DO_en, A_DOUT_ARST_N => DO_nGrst, 
        A_DOUT_SRST_N => DOUTSRSTAP, B_ADDR(13) => WADDR(10), 
        B_ADDR(12) => WADDR(9), B_ADDR(11) => WADDR(8), 
        B_ADDR(10) => WADDR(7), B_ADDR(9) => WADDR(6), B_ADDR(8)
         => WADDR(5), B_ADDR(7) => WADDR(4), B_ADDR(6) => 
        WADDR(3), B_ADDR(5) => WADDR(2), B_ADDR(4) => WADDR(1), 
        B_ADDR(3) => WADDR(0), B_ADDR(2) => \GND\, B_ADDR(1) => 
        \GND\, B_ADDR(0) => \GND\, B_BLK_EN(2) => WRB, 
        B_BLK_EN(1) => \VCC\, B_BLK_EN(0) => \VCC\, B_CLK => 
        WCLOCK, B_DIN(19) => \GND\, B_DIN(18) => \GND\, B_DIN(17)
         => \GND\, B_DIN(16) => \GND\, B_DIN(15) => \GND\, 
        B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12) => 
        \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, B_DIN(9)
         => DI(39), B_DIN(8) => DI(38), B_DIN(7) => DI(37), 
        B_DIN(6) => DI(36), B_DIN(5) => DI(35), B_DIN(4) => 
        DI(34), B_DIN(3) => DI(33), B_DIN(2) => DI(32), B_DIN(1)
         => DI(31), B_DIN(0) => DI(30), B_REN => \VCC\, B_WEN(1)
         => \GND\, B_WEN(0) => \VCC\, B_DOUT_EN => DO_en, 
        B_DOUT_ARST_N => \GND\, B_DOUT_SRST_N => DOUTSRSTAP, 
        ECC_EN => \GND\, BUSY_FB => \GND\, A_WIDTH(2) => \GND\, 
        A_WIDTH(1) => \VCC\, A_WIDTH(0) => \VCC\, A_WMODE(1) => 
        \GND\, A_WMODE(0) => \GND\, A_BYPASS => \GND\, B_WIDTH(2)
         => \GND\, B_WIDTH(1) => \VCC\, B_WIDTH(0) => \VCC\, 
        B_WMODE(1) => \GND\, B_WMODE(0) => \GND\, B_BYPASS => 
        \GND\, ECC_BYPASS => \GND\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
