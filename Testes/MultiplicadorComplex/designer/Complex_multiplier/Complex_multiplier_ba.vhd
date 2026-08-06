-- Version: 2025.1 2025.1.0.14
-- File used only for Simulation

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

  component SLE_IP_EN
    port( EN   : in    std_logic := 'U';
          IPEN : out   std_logic
        );
  end component;

  component IOIN_IB_E
    generic (TX_MODE:std_logic_vector(6 downto 0) := "000" & x"0"; 
        RX_MODE:std_logic_vector(3 downto 0) := x"0"; 
        TX_OE_MODE:std_logic_vector(2 downto 0) := "000"; 
        INPUT_DELAY_SEL:std_logic_vector(1 downto 0) := "00"; 
        DELAY_LINE_MODE:std_logic_vector(1 downto 0) := "00"; 
        RX_DELAY_VAL:std_logic_vector(6 downto 0) := "000" & x"0"; 
        RX_DELAY_VAL_X2:std_logic_vector(0 downto 0) := "0"; 
        TX_DELAY_VAL:std_logic_vector(6 downto 0) := "000" & x"0"
        );

    port( Y   : out   std_logic;
          E   : in    std_logic := 'U';
          YIN : in    std_logic := 'U'
        );
  end component;

  component INV_BA
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component IOPAD_TRI
    port( PAD : out   std_logic;
          D   : in    std_logic := 'U';
          E   : in    std_logic := 'U'
        );
  end component;

  component CFG4_IP_ABCD
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          D   : in    std_logic := 'U';
          Y   : out   std_logic;
          IPB : out   std_logic;
          IPC : out   std_logic;
          IPD : out   std_logic
        );
  end component;

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

  component IOTRI_OB_EB
    generic (TX_MODE:std_logic_vector(6 downto 0) := "000" & x"0"; 
        RX_MODE:std_logic_vector(3 downto 0) := x"0"; 
        TX_OE_MODE:std_logic_vector(2 downto 0) := "000"; 
        INPUT_DELAY_SEL:std_logic_vector(1 downto 0) := "00"; 
        DELAY_LINE_MODE:std_logic_vector(1 downto 0) := "00"; 
        RX_DELAY_VAL:std_logic_vector(6 downto 0) := "000" & x"0"; 
        RX_DELAY_VAL_X2:std_logic_vector(0 downto 0) := "0"; 
        TX_DELAY_VAL:std_logic_vector(6 downto 0) := "000" & x"0"
        );

    port( D    : in    std_logic := 'U';
          E    : in    std_logic := 'U';
          DOUT : out   std_logic;
          EOUT : out   std_logic
        );
  end component;

  component IOPAD_IN
    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component ARI1_CC
    generic (INIT:std_logic_vector(19 downto 0) := x"00000");

    port( A   : in    std_logic := 'U';
          B   : in    std_logic := 'U';
          C   : in    std_logic := 'U';
          D   : in    std_logic := 'U';
          FCI : in    std_logic := 'U';
          S   : out   std_logic;
          Y   : out   std_logic;
          FCO : out   std_logic;
          CC  : in    std_logic := 'U';
          P   : out   std_logic;
          Y3  : out   std_logic;
          Y3A : out   std_logic
        );
  end component;

  component RGB
    port( A  : in    std_logic := 'U';
          EN : in    std_logic := 'U';
          Y  : out   std_logic
        );
  end component;

  component CC_CONFIG
    port( CI  : in    std_logic := 'U';
          CO  : out   std_logic;
          P   : in    std_logic_vector(0 to 11) := (others => 'U');
          Y3  : in    std_logic_vector(0 to 11) := (others => 'U');
          Y3A : in    std_logic_vector(0 to 11) := (others => 'U');
          CC  : out   std_logic_vector(0 to 11)
        );
  end component;

  component MACC_IP
    port( OVFL_CARRYOUT        : out   std_logic;
          P                    : out   std_logic_vector(47 downto 0);
          A_ADDR_D_SH          : out   std_logic;
          B2_EN_SH             : out   std_logic;
          BCOUT                : out   std_logic_vector(17 downto 0);
          B1                   : out   std_logic_vector(17 downto 0);
          A_ADDR_D             : in    std_logic := 'U';
          CARRYIN              : in    std_logic := 'U';
          CLK                  : in    std_logic := 'U';
          AL_N                 : in    std_logic := 'U';
          A                    : in    std_logic_vector(17 downto 0) := (others => 'U');
          A_EN                 : in    std_logic := 'U';
          A_SRST_N             : in    std_logic := 'U';
          B                    : in    std_logic_vector(17 downto 0) := (others => 'U');
          B_EN                 : in    std_logic := 'U';
          B_SRST_N             : in    std_logic := 'U';
          C                    : in    std_logic_vector(47 downto 0) := (others => 'U');
          C_EN                 : in    std_logic := 'U';
          C_SRST_N             : in    std_logic := 'U';
          C_ARST_N             : in    std_logic := 'U';
          D                    : in    std_logic_vector(17 downto 0) := (others => 'U');
          D_EN                 : in    std_logic := 'U';
          D_SRST_N             : in    std_logic := 'U';
          D_ARST_N             : in    std_logic := 'U';
          P_EN                 : in    std_logic := 'U';
          P_SRST_N             : in    std_logic := 'U';
          ARSHFT17             : in    std_logic := 'U';
          ARSHFT17_EN          : in    std_logic := 'U';
          ARSHFT17_SL_N        : in    std_logic := 'U';
          SUB                  : in    std_logic := 'U';
          SUB_EN               : in    std_logic := 'U';
          SUB_SL_N             : in    std_logic := 'U';
          PASUB                : in    std_logic := 'U';
          PASUB_EN             : in    std_logic := 'U';
          PASUB_SL_N           : in    std_logic := 'U';
          CDIN_FDBK_SEL        : in    std_logic_vector(1 downto 0) := (others => 'U');
          CDIN_FDBK_SEL_EN     : in    std_logic := 'U';
          CDIN_FDBK_SEL_SL_N   : in    std_logic := 'U';
          B2                   : in    std_logic_vector(17 downto 0) := (others => 'U');
          B2_EN                : in    std_logic := 'U';
          SIMD                 : in    std_logic := 'U';
          DOTP                 : in    std_logic := 'U';
          OVFL_CARRYOUT_SEL    : in    std_logic := 'U';
          A_BYPASS             : in    std_logic := 'U';
          B_BYPASS             : in    std_logic := 'U';
          C_BYPASS             : in    std_logic := 'U';
          D_BYPASS             : in    std_logic := 'U';
          P_BYPASS             : in    std_logic := 'U';
          SUB_BYPASS           : in    std_logic := 'U';
          SUB_SD_N             : in    std_logic := 'U';
          SUB_AD_N             : in    std_logic := 'U';
          ARSHFT17_BYPASS      : in    std_logic := 'U';
          ARSHFT17_SD_N        : in    std_logic := 'U';
          ARSHFT17_AD_N        : in    std_logic := 'U';
          CDIN_FDBK_SEL_BYPASS : in    std_logic := 'U';
          CDIN_FDBK_SEL_SD_N   : in    std_logic_vector(1 downto 0) := (others => 'U');
          CDIN_FDBK_SEL_AD_N   : in    std_logic_vector(1 downto 0) := (others => 'U');
          PASUB_SD_N           : in    std_logic := 'U';
          PASUB_AD_N           : in    std_logic := 'U';
          PASUB_BYPASS         : in    std_logic := 'U';
          CDIN                 : in    std_logic_vector(47 downto 0) := (others => 'U');
          CDOUT                : out   std_logic_vector(47 downto 0)
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

  component GB
    port( A  : in    std_logic := 'U';
          EN : in    std_logic := 'U';
          Y  : out   std_logic
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

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal \a[7]\, \a[6]\, \a[5]\, \a[4]\, \a[3]\, \a[2]\, \a[1]\, 
        \a[0]\, \ai[7]\, \ai[6]\, \ai[5]\, \ai[4]\, \ai[3]\, 
        \ai[2]\, \ai[1]\, \ai[0]\, \b[7]\, \b[6]\, \b[5]\, \b[4]\, 
        \b[3]\, \b[2]\, \b[1]\, \b[0]\, \bi[7]\, \bi[6]\, \bi[5]\, 
        \bi[4]\, \bi[3]\, \bi[2]\, \bi[1]\, \bi[0]\, \aai[7]\, 
        \aai[6]\, \aai[5]\, \aai[4]\, \aai[3]\, \aai[2]\, 
        \aai[1]\, \bbi[7]\, \bbi[6]\, \bbi[5]\, \bbi[4]\, 
        \bbi[3]\, \bbi[2]\, \bbi[1]\, \k1r[15]\, \k1r[14]\, 
        \k1r[13]\, \k1r[12]\, \k1r[11]\, \k1r[10]\, \k1r[9]\, 
        \k1r[8]\, \k1r[7]\, \k1r[6]\, \k1r[5]\, \k1r[4]\, 
        \k1r[3]\, \k1r[2]\, \k1r[1]\, \k2r[15]\, \k2r[14]\, 
        \k2r[13]\, \k2r[12]\, \k2r[11]\, \k2r[10]\, \k2r[9]\, 
        \k2r[8]\, \k2r[7]\, \k2r[6]\, \k2r[5]\, \k2r[4]\, 
        \k2r[3]\, \k2r[2]\, \k2r[1]\, \k2r[0]\, \k3r[15]\, 
        \k3r[14]\, \k3r[13]\, \k3r[12]\, \k3r[11]\, \k3r[10]\, 
        \k3r[9]\, \k3r[8]\, \k3r[7]\, \k3r[6]\, \k3r[5]\, 
        \k3r[4]\, \k3r[3]\, \k3r[2]\, \k3r[1]\, \k3r[0]\, 
        \pi[15]\, \pi[14]\, \pi[13]\, \pi[12]\, \pi[11]\, 
        \pi[10]\, \pi[9]\, \pi[8]\, \pi[7]\, \pi[6]\, \pi[5]\, 
        \pi[4]\, \pi[3]\, \pi[2]\, \pi[1]\, \a_real_c[7]\, 
        \a_real_c[6]\, \a_real_c[5]\, \a_real_c[4]\, 
        \a_real_c[3]\, \a_real_c[2]\, \a_real_c[1]\, 
        \a_real_c[0]\, \a_imag_c[7]\, \a_imag_c[6]\, 
        \a_imag_c[5]\, \a_imag_c[4]\, \a_imag_c[3]\, 
        \a_imag_c[2]\, \a_imag_c[1]\, \a_imag_c[0]\, 
        \b_real_c[7]\, \b_real_c[6]\, \b_real_c[5]\, 
        \b_real_c[4]\, \b_real_c[3]\, \b_real_c[2]\, 
        \b_real_c[1]\, \b_real_c[0]\, \b_imag_c[7]\, 
        \b_imag_c[6]\, \b_imag_c[5]\, \b_imag_c[4]\, 
        \b_imag_c[3]\, \b_imag_c[2]\, \b_imag_c[1]\, 
        \b_imag_c[0]\, \p_real_c[15]\, \p_real_c[14]\, 
        \p_real_c[13]\, \p_real_c[12]\, \p_real_c[11]\, 
        \p_real_c[10]\, \p_real_c[9]\, \p_real_c[8]\, 
        \p_real_c[7]\, \p_real_c[6]\, \p_real_c[5]\, 
        \p_real_c[4]\, \p_real_c[3]\, \p_real_c[2]\, 
        \p_real_c[1]\, \p_real_c[0]\, \p_imag_c[15]\, 
        \p_imag_c[14]\, \p_imag_c[13]\, \p_imag_c[12]\, 
        \p_imag_c[11]\, \p_imag_c[10]\, \p_imag_c[9]\, 
        \p_imag_c[8]\, \p_imag_c[7]\, \p_imag_c[6]\, 
        \p_imag_c[5]\, \p_imag_c[4]\, \p_imag_c[3]\, 
        \p_imag_c[2]\, \p_imag_c[1]\, \p_imag_c[0]\, \p[15]\, 
        \p[14]\, \p[13]\, \p[12]\, \p[11]\, \p[10]\, \p[9]\, 
        \p[8]\, \p[7]\, \p[6]\, \p[5]\, \p[4]\, \p[3]\, \p[2]\, 
        \p[1]\, \aia[7]\, \aia[6]\, \aia[5]\, \aia[4]\, \aia[3]\, 
        \aia[2]\, \aia[1]\, \I_1/U0_Y\, p_0, ov_Z, of_p_Z, 
        clk_ibuf_Z, en_c, rst_c, overflow_c, p_0_cry_0_Z, 
        p_0_cry_1_Z, p_0_cry_2_Z, p_0_cry_3_Z, p_0_cry_4_Z, 
        p_0_cry_5_Z, p_0_cry_6_Z, p_0_cry_7_Z, p_0_cry_8_Z, 
        p_0_cry_9_Z, p_0_cry_10_Z, p_0_cry_11_Z, p_0_cry_12_Z, 
        p_0_cry_13_Z, p_0_cry_14_Z, pi_0_cry_0_Z, pi_0_cry_1_Z, 
        pi_0_cry_2_Z, pi_0_cry_3_Z, pi_0_cry_4_Z, pi_0_cry_5_Z, 
        pi_0_cry_6_Z, pi_0_cry_7_Z, pi_0_cry_8_Z, pi_0_cry_9_Z, 
        pi_0_cry_10_Z, pi_0_cry_11_Z, pi_0_cry_12_Z, 
        pi_0_cry_13_Z, pi_0_cry_14_Z, aia_0_cry_0_Z, 
        aia_0_cry_1_Z, aia_0_cry_2_Z, aia_0_cry_3_Z, 
        aia_0_cry_4_Z, aia_0_cry_5_Z, aia_0_cry_6_Z, 
        bbi_0_cry_0_Z, bbi_0_cry_1_Z, bbi_0_cry_2_Z, 
        bbi_0_cry_3_Z, bbi_0_cry_4_Z, bbi_0_cry_5_Z, 
        bbi_0_cry_6_Z, aai_0_cry_0_Z, aai_0_cry_1_Z, 
        aai_0_cry_2_Z, aai_0_cry_3_Z, aai_0_cry_4_Z, 
        aai_0_cry_5_Z, aai_0_cry_6_Z, ov_0_Z, ov_1_Z, ov_2_Z, 
        p_0_axb_0_i, pi_0_cry_0_Y, bbi_0_cry_0_Y, aai_0_cry_0_Y, 
        \p_real_obuf[8]/DOUT\, \p_real_obuf[8]/EOUT\, 
        \p_real_obuf[6]/DOUT\, \p_real_obuf[6]/EOUT\, 
        \p_imag_obuf[10]/DOUT\, \p_imag_obuf[10]/EOUT\, 
        \p_imag_obuf[14]/DOUT\, \p_imag_obuf[14]/EOUT\, 
        \p_imag_obuf[7]/DOUT\, \p_imag_obuf[7]/EOUT\, 
        \p_imag_obuf[6]/DOUT\, \p_imag_obuf[6]/EOUT\, 
        \a_real_ibuf[4]/YIN\, \a_real_ibuf[5]/YIN\, 
        \b_imag_ibuf[4]/YIN\, \b_real_ibuf[2]/YIN\, 
        \p_real_obuf[5]/DOUT\, \p_real_obuf[5]/EOUT\, 
        \p_imag_obuf[0]/DOUT\, \p_imag_obuf[0]/EOUT\, 
        \p_real_obuf[15]/DOUT\, \p_real_obuf[15]/EOUT\, 
        \p_real_obuf[0]/DOUT\, \p_real_obuf[0]/EOUT\, 
        \p_real_obuf[11]/DOUT\, \p_real_obuf[11]/EOUT\, 
        \b_real_ibuf[4]/YIN\, \p_real_obuf[3]/DOUT\, 
        \p_real_obuf[3]/EOUT\, \b_imag_ibuf[0]/YIN\, 
        \a_real_ibuf[7]/YIN\, \p_real_obuf[7]/DOUT\, 
        \p_real_obuf[7]/EOUT\, \p_real_obuf[10]/DOUT\, 
        \p_real_obuf[10]/EOUT\, \p_imag_obuf[1]/DOUT\, 
        \p_imag_obuf[1]/EOUT\, \p_imag_obuf[12]/DOUT\, 
        \p_imag_obuf[12]/EOUT\, \overflow_obuf/DOUT\, 
        \overflow_obuf/EOUT\, \p_real_obuf[4]/DOUT\, 
        \p_real_obuf[4]/EOUT\, \p_real_obuf[13]/DOUT\, 
        \p_real_obuf[13]/EOUT\, \p_imag_obuf[3]/DOUT\, 
        \p_imag_obuf[3]/EOUT\, \a_real_ibuf[2]/YIN\, 
        \p_imag_obuf[13]/DOUT\, \p_imag_obuf[13]/EOUT\, 
        \a_imag_ibuf[6]/YIN\, \p_imag_obuf[2]/DOUT\, 
        \p_imag_obuf[2]/EOUT\, \p_imag_obuf[11]/DOUT\, 
        \p_imag_obuf[11]/EOUT\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[17]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[16]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[15]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[14]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[13]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[12]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[11]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[10]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[9]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[8]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[7]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[6]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[5]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[4]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[3]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[2]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[1]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[0]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[17]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[16]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[15]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[14]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[13]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[12]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[11]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[10]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[9]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[8]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[7]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[6]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[5]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[4]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[3]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[2]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[1]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[0]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[47]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[46]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[44]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[43]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[41]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[40]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[38]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[37]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[35]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[34]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[32]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[31]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[29]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[28]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[26]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[25]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[23]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[22]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[20]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[19]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[17]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[16]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[14]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[13]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[11]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[10]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[9]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[8]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[7]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[6]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[5]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[4]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[3]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[2]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[1]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[0]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[17]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[16]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[15]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[14]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[13]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[12]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[11]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[10]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[9]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[8]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[7]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[6]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[5]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[4]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[3]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[2]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[1]\, 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[0]\, 
        \rst_ibuf/YIN\, \b_real_ibuf[3]/YIN\, \clk_ibuf/YIN\, 
        \a_real_ibuf[0]/YIN\, \b_real_ibuf[5]/YIN\, \en_ibuf/YIN\, 
        \b_real_ibuf[1]/YIN\, \b_imag_ibuf[6]/YIN\, 
        \p_imag_obuf[9]/DOUT\, \p_imag_obuf[9]/EOUT\, 
        \a_imag_ibuf[7]/YIN\, \p_real_obuf[9]/DOUT\, 
        \p_real_obuf[9]/EOUT\, \p_real_obuf[1]/DOUT\, 
        \p_real_obuf[1]/EOUT\, \p_imag_obuf[4]/DOUT\, 
        \p_imag_obuf[4]/EOUT\, \p_imag_obuf[15]/DOUT\, 
        \p_imag_obuf[15]/EOUT\, \a_real_ibuf[6]/YIN\, 
        \p_real_obuf[2]/DOUT\, \p_real_obuf[2]/EOUT\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[17]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[16]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[15]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[14]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[13]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[12]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[11]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[10]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[9]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[8]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[7]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[6]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[5]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[4]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[3]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[2]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[1]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[0]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[17]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[16]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[15]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[14]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[13]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[12]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[11]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[10]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[9]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[8]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[7]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[6]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[5]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[4]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[3]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[2]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[1]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[0]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[47]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[46]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[44]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[43]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[41]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[40]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[38]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[37]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[35]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[34]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[32]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[31]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[29]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[28]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[26]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[25]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[23]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[22]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[20]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[19]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[17]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[16]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[14]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[13]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[11]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[10]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[9]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[8]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[7]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[6]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[5]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[4]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[3]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[2]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[1]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[0]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[17]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[16]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[15]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[14]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[13]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[12]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[11]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[10]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[9]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[8]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[7]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[6]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[5]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[4]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[3]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[2]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[1]\, 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[0]\, 
        \b_imag_ibuf[2]/YIN\, \p_imag_obuf[8]/DOUT\, 
        \p_imag_obuf[8]/EOUT\, \b_imag_ibuf[3]/YIN\, 
        \p_real_obuf[12]/DOUT\, \p_real_obuf[12]/EOUT\, 
        \p_imag_obuf[5]/DOUT\, \p_imag_obuf[5]/EOUT\, 
        \a_real_ibuf[3]/YIN\, \a_imag_ibuf[0]/YIN\, 
        \a_imag_ibuf[5]/YIN\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[17]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[16]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[15]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[14]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[13]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[12]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[11]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[10]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[9]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[8]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[7]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[6]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[5]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[4]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[3]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[2]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[1]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[0]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[17]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[16]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[15]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[14]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[13]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[12]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[11]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[10]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[9]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[8]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[7]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[6]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[5]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[4]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[3]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[2]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[1]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[0]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[47]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[46]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[44]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[43]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[41]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[40]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[38]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[37]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[35]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[34]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[32]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[31]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[29]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[28]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[26]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[25]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[23]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[22]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[20]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[19]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[17]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[16]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[14]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[13]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[11]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[10]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[9]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[8]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[7]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[6]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[5]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[4]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[3]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[2]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[1]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[0]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[17]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[16]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[15]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[14]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[13]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[12]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[11]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[10]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[9]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[8]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[7]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[6]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[5]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[4]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[3]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[2]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[1]\, 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[0]\, 
        \p_real_obuf[14]/DOUT\, \p_real_obuf[14]/EOUT\, 
        \a_imag_ibuf[1]/YIN\, \a_imag_ibuf[3]/YIN\, 
        \b_imag_ibuf[7]/YIN\, \b_real_ibuf[7]/YIN\, 
        \b_imag_ibuf[5]/YIN\, \a_imag_ibuf[2]/YIN\, 
        \b_imag_ibuf[1]/YIN\, \b_real_ibuf[6]/YIN\, 
        \b_real_ibuf[0]/YIN\, \a_real_ibuf[1]/YIN\, 
        \a_imag_ibuf[4]/YIN\, NN_1, \I_1/U0_RGB1_RGB0_rgb_net_1\, 
        ADLIB_GND, ADLIB_VCC, CI_TO_CO, NET_CC_CONFIG, 
        NET_CC_CONFIG0, NET_CC_CONFIG1, NET_CC_CONFIG2, 
        NET_CC_CONFIG3, NET_CC_CONFIG4, NET_CC_CONFIG5, 
        NET_CC_CONFIG6, NET_CC_CONFIG7, NET_CC_CONFIG8, 
        NET_CC_CONFIG9, NET_CC_CONFIG10, NET_CC_CONFIG11, 
        NET_CC_CONFIG12, NET_CC_CONFIG13, NET_CC_CONFIG14, 
        NET_CC_CONFIG15, NET_CC_CONFIG16, NET_CC_CONFIG17, 
        NET_CC_CONFIG18, NET_CC_CONFIG19, NET_CC_CONFIG20, 
        NET_CC_CONFIG21, NET_CC_CONFIG22, NET_CC_CONFIG23, 
        NET_CC_CONFIG24, NET_CC_CONFIG25, NET_CC_CONFIG26, 
        NET_CC_CONFIG27, NET_CC_CONFIG28, NET_CC_CONFIG29, 
        NET_CC_CONFIG30, NET_CC_CONFIG31, NET_CC_CONFIG32, 
        NET_CC_CONFIG33, NET_CC_CONFIG34, NET_CC_CONFIG35, 
        NET_CC_CONFIG36, NET_CC_CONFIG37, NET_CC_CONFIG38, 
        NET_CC_CONFIG39, NET_CC_CONFIG40, NET_CC_CONFIG41, 
        NET_CC_CONFIG42, NET_CC_CONFIG43, NET_CC_CONFIG44, 
        NET_CC_CONFIG45, NET_CC_CONFIG46, NET_CC_CONFIG47, 
        NET_CC_CONFIG48, NET_CC_CONFIG49, NET_CC_CONFIG50, 
        NET_CC_CONFIG51, NET_CC_CONFIG52, NET_CC_CONFIG53, 
        NET_CC_CONFIG54, NET_CC_CONFIG55, NET_CC_CONFIG56, 
        NET_CC_CONFIG57, NET_CC_CONFIG58, NET_CC_CONFIG59, 
        NET_CC_CONFIG60, NET_CC_CONFIG61, NET_CC_CONFIG62, 
        CI_TO_CO63, NET_CC_CONFIG64, NET_CC_CONFIG65, 
        NET_CC_CONFIG66, NET_CC_CONFIG67, NET_CC_CONFIG68, 
        NET_CC_CONFIG69, NET_CC_CONFIG70, NET_CC_CONFIG71, 
        NET_CC_CONFIG72, NET_CC_CONFIG73, NET_CC_CONFIG74, 
        NET_CC_CONFIG75, NET_CC_CONFIG76, NET_CC_CONFIG77, 
        NET_CC_CONFIG78, NET_CC_CONFIG79, NET_CC_CONFIG80, 
        NET_CC_CONFIG81, NET_CC_CONFIG82, NET_CC_CONFIG83, 
        NET_CC_CONFIG84, NET_CC_CONFIG85, NET_CC_CONFIG86, 
        NET_CC_CONFIG87, NET_CC_CONFIG88, NET_CC_CONFIG89, 
        NET_CC_CONFIG90, NET_CC_CONFIG91, NET_CC_CONFIG92, 
        NET_CC_CONFIG93, NET_CC_CONFIG94, NET_CC_CONFIG95, 
        NET_CC_CONFIG96, NET_CC_CONFIG97, NET_CC_CONFIG98, 
        NET_CC_CONFIG99, NET_CC_CONFIG100, NET_CC_CONFIG101, 
        NET_CC_CONFIG102, NET_CC_CONFIG103, NET_CC_CONFIG104, 
        NET_CC_CONFIG105, NET_CC_CONFIG106, NET_CC_CONFIG107, 
        NET_CC_CONFIG108, NET_CC_CONFIG109, NET_CC_CONFIG110, 
        NET_CC_CONFIG111, NET_CC_CONFIG112, NET_CC_CONFIG113, 
        NET_CC_CONFIG114, NET_CC_CONFIG115, NET_CC_CONFIG116, 
        NET_CC_CONFIG117, NET_CC_CONFIG118, NET_CC_CONFIG119, 
        NET_CC_CONFIG120, NET_CC_CONFIG121, NET_CC_CONFIG122, 
        NET_CC_CONFIG123, NET_CC_CONFIG124, NET_CC_CONFIG125, 
        NET_CC_CONFIG126, NET_CC_CONFIG127, NET_CC_CONFIG128, 
        NET_CC_CONFIG129, NET_CC_CONFIG130, NET_CC_CONFIG131, 
        NET_CC_CONFIG132, NET_CC_CONFIG133, NET_CC_CONFIG134, 
        NET_CC_CONFIG135, NET_CC_CONFIG136, NET_CC_CONFIG137, 
        NET_CC_CONFIG138, NET_CC_CONFIG139, NET_CC_CONFIG140, 
        NET_CC_CONFIG141, NET_CC_CONFIG142, NET_CC_CONFIG143, 
        NET_CC_CONFIG144, NET_CC_CONFIG145, NET_CC_CONFIG146, 
        NET_CC_CONFIG147, NET_CC_CONFIG148, NET_CC_CONFIG149, 
        NET_CC_CONFIG150, NET_CC_CONFIG151, NET_CC_CONFIG152, 
        NET_CC_CONFIG153, NET_CC_CONFIG154, NET_CC_CONFIG155, 
        NET_CC_CONFIG156, NET_CC_CONFIG157, NET_CC_CONFIG158, 
        NET_CC_CONFIG159, CI_TO_CO160, NET_CC_CONFIG161, 
        NET_CC_CONFIG162, NET_CC_CONFIG163, NET_CC_CONFIG164, 
        NET_CC_CONFIG165, NET_CC_CONFIG166, NET_CC_CONFIG167, 
        NET_CC_CONFIG168, NET_CC_CONFIG169, NET_CC_CONFIG170, 
        NET_CC_CONFIG171, NET_CC_CONFIG172, NET_CC_CONFIG173, 
        NET_CC_CONFIG174, NET_CC_CONFIG175, NET_CC_CONFIG176, 
        NET_CC_CONFIG177, NET_CC_CONFIG178, NET_CC_CONFIG179, 
        NET_CC_CONFIG180, NET_CC_CONFIG181, NET_CC_CONFIG182, 
        NET_CC_CONFIG183, NET_CC_CONFIG184, NET_CC_CONFIG185, 
        NET_CC_CONFIG186, NET_CC_CONFIG187, NET_CC_CONFIG188, 
        NET_CC_CONFIG189, NET_CC_CONFIG190, NET_CC_CONFIG191, 
        NET_CC_CONFIG192, NET_CC_CONFIG193, NET_CC_CONFIG194, 
        NET_CC_CONFIG195, NET_CC_CONFIG196, NET_CC_CONFIG197, 
        NET_CC_CONFIG198, NET_CC_CONFIG199, NET_CC_CONFIG200, 
        NET_CC_CONFIG201, NET_CC_CONFIG202, NET_CC_CONFIG203, 
        NET_CC_CONFIG204, NET_CC_CONFIG205, NET_CC_CONFIG206, 
        NET_CC_CONFIG207, NET_CC_CONFIG208, NET_CC_CONFIG209, 
        NET_CC_CONFIG210, NET_CC_CONFIG211, NET_CC_CONFIG212, 
        NET_CC_CONFIG213, NET_CC_CONFIG214, NET_CC_CONFIG215, 
        NET_CC_CONFIG216, NET_CC_CONFIG217, NET_CC_CONFIG218, 
        NET_CC_CONFIG219, NET_CC_CONFIG220, NET_CC_CONFIG221, 
        NET_CC_CONFIG222, NET_CC_CONFIG223, NET_CC_CONFIG224, 
        AFLSDF_VCC, AFLSDF_GND, \AFLSDF_INV_0\, \AFLSDF_INV_1\, 
        \AFLSDF_INV_2\, \AFLSDF_INV_3\, \AFLSDF_INV_4\, 
        \AFLSDF_INV_5\, \AFLSDF_INV_6\, \AFLSDF_INV_7\, 
        \AFLSDF_INV_8\, \AFLSDF_INV_9\, \AFLSDF_INV_10\, 
        \AFLSDF_INV_11\, \AFLSDF_INV_12\, \AFLSDF_INV_13\, 
        \AFLSDF_INV_14\, \AFLSDF_INV_15\, \AFLSDF_INV_16\, 
        \AFLSDF_INV_17\, \AFLSDF_INV_18\, \AFLSDF_INV_19\, 
        \AFLSDF_INV_20\, \AFLSDF_INV_21\, \AFLSDF_INV_22\, 
        \AFLSDF_INV_23\, \AFLSDF_INV_24\, \AFLSDF_INV_25\, 
        \AFLSDF_INV_26\, \AFLSDF_INV_27\, \AFLSDF_INV_28\, 
        \AFLSDF_INV_29\, \AFLSDF_INV_30\, \AFLSDF_INV_31\, 
        \AFLSDF_INV_32\, \AFLSDF_INV_33\, \AFLSDF_INV_34\, 
        \AFLSDF_INV_35\, \AFLSDF_INV_36\, \AFLSDF_INV_37\, 
        \AFLSDF_INV_38\, \AFLSDF_INV_39\, \AFLSDF_INV_40\, 
        \AFLSDF_INV_41\, \AFLSDF_INV_42\, \AFLSDF_INV_43\, 
        \AFLSDF_INV_44\, \AFLSDF_INV_45\, \AFLSDF_INV_46\, 
        \AFLSDF_INV_47\, \AFLSDF_INV_48\, \AFLSDF_INV_49\, 
        \AFLSDF_INV_50\, \AFLSDF_INV_51\, \AFLSDF_INV_52\, 
        \AFLSDF_INV_53\, \AFLSDF_INV_54\, \AFLSDF_INV_55\, 
        \AFLSDF_INV_56\, \AFLSDF_INV_57\, \AFLSDF_INV_58\, 
        \AFLSDF_INV_59\, \AFLSDF_INV_60\, \AFLSDF_INV_61\, 
        \AFLSDF_INV_62\, \AFLSDF_INV_63\, \AFLSDF_INV_64\, 
        \AFLSDF_INV_65\, \AFLSDF_INV_66\, \AFLSDF_INV_67\, 
        \AFLSDF_INV_68\, \AFLSDF_INV_69\, \AFLSDF_INV_70\, 
        \AFLSDF_INV_71\, \AFLSDF_INV_72\, \AFLSDF_INV_73\, 
        \AFLSDF_INV_74\, \AFLSDF_INV_75\, \AFLSDF_INV_76\, 
        \AFLSDF_INV_77\, \AFLSDF_INV_78\, \AFLSDF_INV_79\, 
        \AFLSDF_INV_80\, \AFLSDF_INV_81\, \AFLSDF_INV_82\, 
        \AFLSDF_INV_83\, \AFLSDF_INV_84\, \AFLSDF_INV_85\, 
        \AFLSDF_INV_86\, \AFLSDF_INV_87\, \AFLSDF_INV_88\, 
        \AFLSDF_INV_89\, \AFLSDF_INV_90\, \AFLSDF_INV_91\, 
        \AFLSDF_INV_92\, \AFLSDF_INV_93\, \AFLSDF_INV_94\, 
        \AFLSDF_INV_95\, \AFLSDF_INV_96\, \AFLSDF_INV_97\, 
        \AFLSDF_INV_98\, \AFLSDF_INV_99\, \AFLSDF_INV_100\, 
        \AFLSDF_INV_101\, \AFLSDF_INV_102\, \AFLSDF_INV_103\, 
        \AFLSDF_INV_104\, \AFLSDF_INV_105\, \AFLSDF_INV_106\, 
        \AFLSDF_INV_107\, \AFLSDF_INV_108\, \AFLSDF_INV_109\, 
        \AFLSDF_INV_110\, \AFLSDF_INV_111\, \AFLSDF_INV_112\, 
        \AFLSDF_INV_113\, \AFLSDF_INV_114\, \AFLSDF_INV_115\, 
        \AFLSDF_INV_116\, \AFLSDF_INV_117\, \AFLSDF_INV_118\, 
        \AFLSDF_INV_119\, \AFLSDF_INV_120\, \AFLSDF_INV_121\, 
        \AFLSDF_INV_122\, \AFLSDF_INV_123\, \AFLSDF_INV_124\, 
        \AFLSDF_INV_125\, \AFLSDF_INV_126\, \AFLSDF_INV_127\, 
        \AFLSDF_INV_128\, \AFLSDF_INV_129\, \AFLSDF_INV_130\, 
        \AFLSDF_INV_131\, \AFLSDF_INV_132\, \AFLSDF_INV_133\, 
        \AFLSDF_INV_134\, \AFLSDF_INV_135\, \AFLSDF_INV_136\, 
        \AFLSDF_INV_137\, \AFLSDF_INV_138\, \AFLSDF_INV_139\, 
        \AFLSDF_INV_140\, \AFLSDF_INV_141\, \AFLSDF_INV_142\, 
        \AFLSDF_INV_143\, \AFLSDF_INV_144\, \AFLSDF_INV_145\, 
        \AFLSDF_INV_146\, \AFLSDF_INV_147\, \AFLSDF_INV_148\, 
        \AFLSDF_INV_149\, \AFLSDF_INV_150\, \AFLSDF_INV_151\, 
        \AFLSDF_INV_152\, \AFLSDF_INV_153\, \AFLSDF_INV_154\, 
        \AFLSDF_INV_155\, \AFLSDF_INV_156\, \AFLSDF_INV_157\, 
        \AFLSDF_INV_158\, \AFLSDF_INV_159\, \AFLSDF_INV_160\, 
        \AFLSDF_INV_161\, \AFLSDF_INV_162\, \AFLSDF_INV_163\, 
        \AFLSDF_INV_164\, \AFLSDF_INV_165\, \AFLSDF_INV_166\, 
        \AFLSDF_INV_167\, \AFLSDF_INV_168\, \AFLSDF_INV_169\, 
        \AFLSDF_INV_170\, \AFLSDF_INV_171\, \AFLSDF_INV_172\, 
        \AFLSDF_INV_173\, \AFLSDF_INV_174\, \AFLSDF_INV_175\, 
        \AFLSDF_INV_176\, \AFLSDF_INV_177\, \AFLSDF_INV_178\, 
        \AFLSDF_INV_179\, \AFLSDF_INV_180\, \AFLSDF_INV_181\, 
        \AFLSDF_INV_182\, \AFLSDF_INV_183\, \AFLSDF_INV_184\, 
        \AFLSDF_INV_185\, \AFLSDF_INV_186\, \AFLSDF_INV_187\, 
        \AFLSDF_INV_188\, \AFLSDF_INV_189\, \AFLSDF_INV_190\, 
        \AFLSDF_INV_191\, \AFLSDF_INV_192\, \AFLSDF_INV_193\, 
        \AFLSDF_INV_194\, \AFLSDF_INV_195\, \AFLSDF_INV_196\, 
        \AFLSDF_INV_197\, \AFLSDF_INV_198\, \AFLSDF_INV_199\, 
        \AFLSDF_INV_200\, \AFLSDF_INV_201\, \AFLSDF_INV_202\, 
        \AFLSDF_INV_203\, \AFLSDF_INV_204\, \AFLSDF_INV_205\, 
        \AFLSDF_INV_206\, \AFLSDF_INV_207\, \AFLSDF_INV_208\, 
        \AFLSDF_INV_209\, \AFLSDF_INV_210\, \AFLSDF_INV_211\, 
        \AFLSDF_INV_212\, \AFLSDF_INV_213\, \AFLSDF_INV_214\, 
        \AFLSDF_INV_215\, \AFLSDF_INV_216\, \AFLSDF_INV_217\, 
        \AFLSDF_INV_218\, \AFLSDF_INV_219\, \AFLSDF_INV_220\, 
        \AFLSDF_INV_221\, \AFLSDF_INV_222\, \AFLSDF_INV_223\, 
        \AFLSDF_INV_224\, \AFLSDF_INV_225\, \AFLSDF_INV_226\, 
        \AFLSDF_INV_227\, \AFLSDF_INV_228\, \AFLSDF_INV_229\, 
        \AFLSDF_INV_230\, \AFLSDF_INV_231\ : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;
    signal nc228, nc203, nc265, nc216, nc194, nc151, nc23, nc175, 
        nc250, nc58, nc379, nc116, nc74, nc133, nc238, nc167, 
        nc84, nc39, nc72, nc256, nc212, nc205, nc82, nc367, nc145, 
        nc181, nc160, nc57, nc349, nc156, nc280, nc125, nc211, 
        nc73, nc107, nc329, nc66, nc83, nc9, nc252, nc171, nc54, 
        nc286, nc307, nc135, nc41, nc100, nc270, nc339, nc52, 
        nc251, nc186, nc29, nc269, nc118, nc60, nc141, nc311, 
        nc276, nc193, nc214, nc298, nc282, nc240, nc45, nc53, 
        nc121, nc176, nc360, nc220, nc158, nc281, nc209, nc246, 
        nc368, nc351, nc162, nc11, nc272, nc131, nc364, nc254, 
        nc267, nc96, nc79, nc226, nc146, nc230, nc89, nc119, nc48, 
        nc271, nc213, nc366, nc300, nc126, nc195, nc188, nc242, 
        nc15, nc308, nc236, nc102, nc381, nc304, nc3, nc207, nc47, 
        nc90, nc284, nc222, nc159, nc136, nc241, nc253, nc178, 
        nc306, nc215, nc59, nc362, nc221, nc371, nc232, nc274, 
        nc18, nc44, nc117, nc189, nc164, nc148, nc42, nc231, 
        nc191, nc255, nc283, nc363, nc341, nc317, nc290, nc17, 
        nc2, nc302, nc110, nc128, nc244, nc321, nc43, nc179, 
        nc157, nc36, nc224, nc296, nc273, nc61, nc104, nc138, 
        nc14, nc357, nc285, nc303, nc150, nc365, nc331, nc196, 
        nc234, nc149, nc12, nc219, nc30, nc243, nc187, nc65, nc7, 
        nc292, nc129, nc275, nc8, nc223, nc13, nc387, nc305, 
        nc180, nc26, nc291, nc177, nc139, nc310, nc259, nc245, 
        nc233, nc163, nc318, nc268, nc112, nc68, nc49, nc377, 
        nc314, nc217, nc170, nc91, nc225, nc5, nc20, nc198, nc147, 
        nc350, nc316, nc67, nc289, nc358, nc294, nc152, nc127, 
        nc103, nc235, nc76, nc347, nc208, nc354, nc140, nc257, 
        nc86, nc95, nc327, nc120, nc165, nc356, nc279, nc137, 
        nc64, nc19, nc380, nc369, nc312, nc70, nc388, nc182, nc62, 
        nc337, nc199, nc80, nc130, nc384, nc287, nc98, nc293, 
        nc249, nc114, nc56, nc370, nc105, nc386, nc63, nc352, 
        nc313, nc309, nc378, nc172, nc229, nc374, nc277, nc97, 
        nc161, nc31, nc340, nc295, nc154, nc376, nc50, nc260, 
        nc239, nc353, nc348, nc142, nc320, nc344, nc315, nc382, 
        nc247, nc94, nc197, nc328, nc122, nc266, nc35, nc324, nc4, 
        nc227, nc92, nc101, nc346, nc330, nc184, nc200, nc190, 
        nc166, nc372, nc355, nc338, nc326, nc132, nc383, nc334, 
        nc21, nc237, nc93, nc262, nc69, nc206, nc174, nc38, nc113, 
        nc336, nc218, nc342, nc373, nc106, nc261, nc25, nc1, 
        nc385, nc322, nc299, nc37, nc202, nc144, nc153, nc46, 
        nc258, nc343, nc71, nc124, nc332, nc81, nc375, nc201, 
        nc168, nc323, nc34, nc28, nc361, nc115, nc264, nc192, 
        nc319, nc134, nc32, nc40, nc297, nc99, nc75, nc183, nc345, 
        nc333, nc288, nc85, nc27, nc108, nc325, nc16, nc155, nc51, 
        nc301, nc33, nc359, nc204, nc173, nc278, nc169, nc78, 
        nc263, nc335, nc24, nc88, nc111, nc55, nc10, nc22, nc210, 
        nc185, nc143, nc248, nc77, nc6, nc109, nc87, nc123
         : std_logic;

begin 

    ADLIB_GND <= GND_power_net1;
    AFLSDF_GND <= GND_power_net1;
    AFLSDF_VCC <= VCC_power_net1;
    ADLIB_VCC <= VCC_power_net1;

    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_28\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_29\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_11\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \b_real_ibuf[5]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_real_c[5]\, E => ADLIB_GND, YIN => 
        \b_real_ibuf[5]/YIN\);
    
    AFLSDF_INV_161 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_161\);
    
    AFLSDF_INV_64 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[0]\, 
        Y => \AFLSDF_INV_64\);
    
    \p_imag_obuf[9]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(9), D => \p_imag_obuf[9]/DOUT\, E
         => \p_imag_obuf[9]/EOUT\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_13\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_19\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[9]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[9]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[22]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[23]\);
    
    \REG_OUT_R/Q[6]\ : SLE
      port map(D => \p[6]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_5\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[6]\);
    
    \a_imag_ibuf[6]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_imag_c[6]\, E => ADLIB_GND, YIN => 
        \a_imag_ibuf[6]/YIN\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_8\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \a_imag_ibuf[4]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_imag_c[4]\, E => ADLIB_GND, YIN => 
        \a_imag_ibuf[4]/YIN\);
    
    \b_real_ibuf[6]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_real_c[6]\, E => ADLIB_GND, YIN => 
        \b_real_ibuf[6]/YIN\);
    
    \p_imag_obuf[9]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[9]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[9]/DOUT\, EOUT => \p_imag_obuf[9]/EOUT\);
    
    \REG_OUT_R/Q[4]\ : SLE
      port map(D => \p[4]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_95\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[4]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_20\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[10]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_53 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[11]\, 
        Y => \AFLSDF_INV_53\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_22\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[11]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \b_imag_ibuf[6]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_imag(6), Y => \b_imag_ibuf[6]/YIN\);
    
    \a_real_ibuf[2]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_real_c[2]\, E => ADLIB_GND, YIN => 
        \a_real_ibuf[2]/YIN\);
    
    \REG_OUT_R/Q[13]\ : SLE
      port map(D => \p[13]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_163\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[13]\);
    
    \REG_OUT_I/Q[13]\ : SLE
      port map(D => \pi[13]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_230\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[13]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_34\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[17]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \p_imag_obuf[14]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(14), D => \p_imag_obuf[14]/DOUT\, E
         => \p_imag_obuf[14]/EOUT\);
    
    \REG_IN_AI/Q[5]\ : SLE
      port map(D => \a_imag_c[5]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_86\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \ai[5]\);
    
    \en_ibuf/U_IOPAD\ : IOPAD_IN
      port map(PAD => en, Y => \en_ibuf/YIN\);
    
    \p_imag_obuf[10]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(10), D => \p_imag_obuf[10]/DOUT\, E
         => \p_imag_obuf[10]/EOUT\);
    
    AFLSDF_INV_55 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[9]\, 
        Y => \AFLSDF_INV_55\);
    
    AFLSDF_INV_207 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[17]\, 
        Y => \AFLSDF_INV_207\);
    
    AFLSDF_INV_20 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_20\);
    
    AFLSDF_INV_162 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_162\);
    
    AFLSDF_INV_140 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[17]\, 
        Y => \AFLSDF_INV_140\);
    
    \clk_ibuf/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => clk_ibuf_Z, E => ADLIB_GND, YIN => 
        \clk_ibuf/YIN\);
    
    \REG_IN_B/Q[5]\ : SLE
      port map(D => \b_real_c[5]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_231\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \b[5]\);
    
    AFLSDF_INV_47 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[20]\, 
        Y => \AFLSDF_INV_47\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_13\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_1\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    bbi_0_cry_0 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \b[0]\, B => \bi[0]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => ADLIB_GND, S => OPEN, Y => 
        bbi_0_cry_0_Y, FCO => bbi_0_cry_0_Z, CC => 
        NET_CC_CONFIG131, P => NET_CC_CONFIG128, Y3 => 
        NET_CC_CONFIG129, Y3A => NET_CC_CONFIG130);
    
    AFLSDF_INV_9 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_9\);
    
    \clk_ibuf/U_IOPAD\ : IOPAD_IN
      port map(PAD => clk, Y => \clk_ibuf/YIN\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_29\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[14]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[14]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[37]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[38]\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_18\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_76 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[6]\, 
        Y => \AFLSDF_INV_76\);
    
    \REG_IN_BI/Q[0]\ : SLE
      port map(D => \b_imag_c[0]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_19\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \bi[0]\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_5\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \a_imag_ibuf[4]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_imag(4), Y => \a_imag_ibuf[4]/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_31\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[15]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[15]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[40]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[41]\);
    
    AFLSDF_INV_168 : INV_BA
      port map(A => \AFLSDF_INV_168\, Y => NN_1);
    
    \I_1/U0_RGB1_RGB0\ : RGB
      port map(A => \I_1/U0_Y\, EN => ADLIB_VCC, Y => 
        \AFLSDF_INV_227\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_32\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_225 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_225\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_4\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_49 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[17]\, 
        Y => \AFLSDF_INV_49\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_22\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    aai_0_cry_0 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \a[0]\, B => \ai[0]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => ADLIB_GND, S => OPEN, Y => 
        aai_0_cry_0_Y, FCO => aai_0_cry_0_Z, CC => 
        NET_CC_CONFIG196, P => NET_CC_CONFIG193, Y3 => 
        NET_CC_CONFIG194, Y3A => NET_CC_CONFIG195);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_10\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_3\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[1]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[1]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[1]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[2]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[3]\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_14\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[7]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \p_real_obuf[11]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[11]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[11]/DOUT\, EOUT => \p_real_obuf[11]/EOUT\);
    
    \b_real_ibuf[1]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_real_c[1]\, E => ADLIB_GND, YIN => 
        \b_real_ibuf[1]/YIN\);
    
    \p_real_obuf[2]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(2), D => \p_real_obuf[2]/DOUT\, E
         => \p_real_obuf[2]/EOUT\);
    
    AFLSDF_INV_203 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[3]\, 
        Y => \AFLSDF_INV_203\);
    
    AFLSDF_INV_106 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[44]\, 
        Y => \AFLSDF_INV_106\);
    
    \p_real_obuf[1]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(1), D => \p_real_obuf[1]/DOUT\, E
         => \p_real_obuf[1]/EOUT\);
    
    \a_imag_ibuf[2]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_imag(2), Y => \a_imag_ibuf[2]/YIN\);
    
    AFLSDF_INV_52 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[13]\, 
        Y => \AFLSDF_INV_52\);
    
    p_0_cry_4 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[4]\, B => \k2r[4]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_3_Z, S => \p[4]\, Y => OPEN, 
        FCO => p_0_cry_4_Z, CC => NET_CC_CONFIG18, P => 
        NET_CC_CONFIG15, Y3 => NET_CC_CONFIG16, Y3A => 
        NET_CC_CONFIG17);
    
    \REG_OUT_R/Q[12]\ : SLE
      port map(D => \p[12]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_0\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[12]\);
    
    \REG_OUT_I/Q[12]\ : SLE
      port map(D => \pi[12]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_9\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[12]\);
    
    AFLSDF_INV_179 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[35]\, 
        Y => \AFLSDF_INV_179\);
    
    AFLSDF_INV_16 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_16\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_30\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[15]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \p_real_obuf[0]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[0]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[0]/DOUT\, EOUT => \p_real_obuf[0]/EOUT\);
    
    AFLSDF_INV_104 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[47]\, 
        Y => \AFLSDF_INV_104\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_12\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[6]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[6]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_208 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[16]\, 
        Y => \AFLSDF_INV_208\);
    
    AFLSDF_INV_215 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[9]\, 
        Y => \AFLSDF_INV_215\);
    
    AFLSDF_INV_185 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[26]\, 
        Y => \AFLSDF_INV_185\);
    
    AFLSDF_INV_66 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[16]\, 
        Y => \AFLSDF_INV_66\);
    
    AFLSDF_INV_101 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_101\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_18\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \p_real_obuf[10]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(10), D => \p_real_obuf[10]/DOUT\, E
         => \p_real_obuf[10]/EOUT\);
    
    \a_real_ibuf[0]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_real_c[0]\, E => ADLIB_GND, YIN => 
        \a_real_ibuf[0]/YIN\);
    
    \REG_IN_AI/Q[1]\ : SLE
      port map(D => \a_imag_c[1]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_96\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \ai[1]\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_4\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[2]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[2]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \REG_IN_BI/Q[4]\ : SLE
      port map(D => \b_imag_c[4]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_167\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \bi[4]\);
    
    AFLSDF_INV_199 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[7]\, 
        Y => \AFLSDF_INV_199\);
    
    AFLSDF_INV_44 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[25]\, 
        Y => \AFLSDF_INV_44\);
    
    AFLSDF_INV_97 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_97\);
    
    AFLSDF_INV_51 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[14]\, 
        Y => \AFLSDF_INV_51\);
    
    AFLSDF_INV_38 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[34]\, 
        Y => \AFLSDF_INV_38\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_17\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_24\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[12]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_3\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \p_real_obuf[13]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(13), D => \p_real_obuf[13]/DOUT\, E
         => \p_real_obuf[13]/EOUT\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_12\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_135 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[4]\, 
        Y => \AFLSDF_INV_135\);
    
    \p_real_obuf[12]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(12), D => \p_real_obuf[12]/DOUT\, E
         => \p_real_obuf[12]/EOUT\);
    
    aia_0_cry_0_CC_0 : CC_CONFIG
      port map(CI => ADLIB_VCC, CO => CI_TO_CO160, P(0) => 
        ADLIB_VCC, P(1) => ADLIB_VCC, P(2) => ADLIB_VCC, P(3) => 
        ADLIB_VCC, P(4) => ADLIB_VCC, P(5) => ADLIB_VCC, P(6) => 
        ADLIB_VCC, P(7) => ADLIB_VCC, P(8) => ADLIB_VCC, P(9) => 
        ADLIB_GND, P(10) => NET_CC_CONFIG161, P(11) => 
        NET_CC_CONFIG165, Y3(0) => ADLIB_VCC, Y3(1) => ADLIB_VCC, 
        Y3(2) => ADLIB_VCC, Y3(3) => ADLIB_VCC, Y3(4) => 
        ADLIB_VCC, Y3(5) => ADLIB_VCC, Y3(6) => ADLIB_VCC, Y3(7)
         => ADLIB_VCC, Y3(8) => ADLIB_VCC, Y3(9) => ADLIB_GND, 
        Y3(10) => NET_CC_CONFIG162, Y3(11) => NET_CC_CONFIG166, 
        Y3A(0) => ADLIB_VCC, Y3A(1) => ADLIB_VCC, Y3A(2) => 
        ADLIB_VCC, Y3A(3) => ADLIB_VCC, Y3A(4) => ADLIB_VCC, 
        Y3A(5) => ADLIB_VCC, Y3A(6) => ADLIB_VCC, Y3A(7) => 
        ADLIB_VCC, Y3A(8) => ADLIB_VCC, Y3A(9) => ADLIB_GND, 
        Y3A(10) => NET_CC_CONFIG163, Y3A(11) => NET_CC_CONFIG167, 
        CC(0) => nc228, CC(1) => nc203, CC(2) => nc265, CC(3) => 
        nc216, CC(4) => nc194, CC(5) => nc151, CC(6) => nc23, 
        CC(7) => nc175, CC(8) => nc250, CC(9) => nc58, CC(10) => 
        NET_CC_CONFIG164, CC(11) => NET_CC_CONFIG168);
    
    \REG_IN_AI/Q[7]\ : SLE
      port map(D => \a_imag_c[7]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_1\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \ai[7]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_11\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    p_0_cry_9 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[9]\, B => \k2r[9]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_8_Z, S => \p[9]\, Y => OPEN, 
        FCO => p_0_cry_9_Z, CC => NET_CC_CONFIG38, P => 
        NET_CC_CONFIG35, Y3 => NET_CC_CONFIG36, Y3A => 
        NET_CC_CONFIG37);
    
    AFLSDF_INV_99 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_99\);
    
    AFLSDF_INV_160 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_160\);
    
    AFLSDF_INV_102 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_102\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_5\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[2]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[2]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[2]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[4]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[5]\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_25\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_22\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[11]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \REG_IN_A/Q[0]\ : SLE
      port map(D => \a_real_c[0]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_166\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \a[0]\);
    
    \a_real_ibuf[6]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_real(6), Y => \a_real_ibuf[6]/YIN\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_30\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_33 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[41]\, 
        Y => \AFLSDF_INV_33\);
    
    AFLSDF_INV_226 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_226\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_3\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_155 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[2]\, 
        Y => \AFLSDF_INV_155\);
    
    p_0_cry_0_CC_1 : CC_CONFIG
      port map(CI => CI_TO_CO, CO => OPEN, P(0) => 
        NET_CC_CONFIG47, P(1) => NET_CC_CONFIG51, P(2) => 
        NET_CC_CONFIG55, P(3) => NET_CC_CONFIG59, P(4) => 
        ADLIB_VCC, P(5) => ADLIB_VCC, P(6) => ADLIB_VCC, P(7) => 
        ADLIB_VCC, P(8) => ADLIB_VCC, P(9) => ADLIB_VCC, P(10)
         => ADLIB_VCC, P(11) => ADLIB_VCC, Y3(0) => 
        NET_CC_CONFIG48, Y3(1) => NET_CC_CONFIG52, Y3(2) => 
        NET_CC_CONFIG56, Y3(3) => NET_CC_CONFIG60, Y3(4) => 
        ADLIB_VCC, Y3(5) => ADLIB_VCC, Y3(6) => ADLIB_VCC, Y3(7)
         => ADLIB_VCC, Y3(8) => ADLIB_VCC, Y3(9) => ADLIB_VCC, 
        Y3(10) => ADLIB_VCC, Y3(11) => ADLIB_VCC, Y3A(0) => 
        NET_CC_CONFIG49, Y3A(1) => NET_CC_CONFIG53, Y3A(2) => 
        NET_CC_CONFIG57, Y3A(3) => NET_CC_CONFIG61, Y3A(4) => 
        ADLIB_VCC, Y3A(5) => ADLIB_VCC, Y3A(6) => ADLIB_VCC, 
        Y3A(7) => ADLIB_VCC, Y3A(8) => ADLIB_VCC, Y3A(9) => 
        ADLIB_VCC, Y3A(10) => ADLIB_VCC, Y3A(11) => ADLIB_VCC, 
        CC(0) => NET_CC_CONFIG50, CC(1) => NET_CC_CONFIG54, CC(2)
         => NET_CC_CONFIG58, CC(3) => NET_CC_CONFIG62, CC(4) => 
        nc379, CC(5) => nc116, CC(6) => nc74, CC(7) => nc133, 
        CC(8) => nc238, CC(9) => nc167, CC(10) => nc84, CC(11)
         => nc39);
    
    \p_imag_obuf[8]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(8), D => \p_imag_obuf[8]/DOUT\, E
         => \p_imag_obuf[8]/EOUT\);
    
    AFLSDF_INV_70 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[12]\, 
        Y => \AFLSDF_INV_70\);
    
    AFLSDF_INV_149 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[8]\, 
        Y => \AFLSDF_INV_149\);
    
    \a_imag_ibuf[6]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_imag(6), Y => \a_imag_ibuf[6]/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/INST_MACC_IP\ : MACC_IP
      port map(OVFL_CARRYOUT => OPEN, P(47) => nc72, P(46) => 
        nc256, P(45) => nc212, P(44) => nc205, P(43) => nc82, 
        P(42) => nc367, P(41) => nc145, P(40) => nc181, P(39) => 
        nc160, P(38) => nc57, P(37) => nc349, P(36) => nc156, 
        P(35) => nc280, P(34) => nc125, P(33) => nc211, P(32) => 
        nc73, P(31) => nc107, P(30) => nc329, P(29) => nc66, 
        P(28) => nc83, P(27) => nc9, P(26) => nc252, P(25) => 
        nc171, P(24) => nc54, P(23) => nc286, P(22) => nc307, 
        P(21) => nc135, P(20) => nc41, P(19) => nc100, P(18) => 
        nc270, P(17) => nc339, P(16) => nc52, P(15) => \k2r[15]\, 
        P(14) => \k2r[14]\, P(13) => \k2r[13]\, P(12) => 
        \k2r[12]\, P(11) => \k2r[11]\, P(10) => \k2r[10]\, P(9)
         => \k2r[9]\, P(8) => \k2r[8]\, P(7) => \k2r[7]\, P(6)
         => \k2r[6]\, P(5) => \k2r[5]\, P(4) => \k2r[4]\, P(3)
         => \k2r[3]\, P(2) => \k2r[2]\, P(1) => \k2r[1]\, P(0)
         => \k2r[0]\, A_ADDR_D_SH => OPEN, B2_EN_SH => OPEN, 
        BCOUT(17) => nc251, BCOUT(16) => nc186, BCOUT(15) => nc29, 
        BCOUT(14) => nc269, BCOUT(13) => nc118, BCOUT(12) => nc60, 
        BCOUT(11) => nc141, BCOUT(10) => nc311, BCOUT(9) => nc276, 
        BCOUT(8) => nc193, BCOUT(7) => nc214, BCOUT(6) => nc298, 
        BCOUT(5) => nc282, BCOUT(4) => nc240, BCOUT(3) => nc45, 
        BCOUT(2) => nc53, BCOUT(1) => nc121, BCOUT(0) => nc176, 
        B1(17) => nc360, B1(16) => nc220, B1(15) => nc158, B1(14)
         => nc281, B1(13) => nc209, B1(12) => nc246, B1(11) => 
        nc368, B1(10) => nc351, B1(9) => nc162, B1(8) => nc11, 
        B1(7) => nc272, B1(6) => nc131, B1(5) => nc364, B1(4) => 
        nc254, B1(3) => nc267, B1(2) => nc96, B1(1) => nc79, 
        B1(0) => nc226, A_ADDR_D => ADLIB_VCC, CARRYIN => 
        ADLIB_GND, CLK => NN_1, AL_N => \AFLSDF_INV_170\, A(17)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[17]\, A(16)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[16]\, A(15)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[15]\, A(14)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[14]\, A(13)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[13]\, A(12)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[12]\, A(11)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[11]\, A(10)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[10]\, A(9)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[9]\, A(8)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[8]\, A(7)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[7]\, A(6)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[6]\, A(5)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[5]\, A(4)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[4]\, A(3)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[3]\, A(2)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[2]\, A(1)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[1]\, A(0)
         => \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[0]\, A_EN
         => en_c, A_SRST_N => ADLIB_VCC, B(17) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[17]\, B(16) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[16]\, B(15) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[15]\, B(14) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[14]\, B(13) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[13]\, B(12) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[12]\, B(11) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[11]\, B(10) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[10]\, B(9) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[9]\, B(8) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[8]\, B(7) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[7]\, B(6) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[6]\, B(5) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[5]\, B(4) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[4]\, B(3) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[3]\, B(2) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[2]\, B(1) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[1]\, B(0) => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[0]\, B_EN => 
        en_c, B_SRST_N => ADLIB_VCC, C(47) => \AFLSDF_INV_171\, 
        C(46) => \AFLSDF_INV_172\, C(45) => ADLIB_GND, C(44) => 
        \AFLSDF_INV_173\, C(43) => \AFLSDF_INV_174\, C(42) => 
        ADLIB_GND, C(41) => \AFLSDF_INV_175\, C(40) => 
        \AFLSDF_INV_176\, C(39) => ADLIB_GND, C(38) => 
        \AFLSDF_INV_177\, C(37) => \AFLSDF_INV_178\, C(36) => 
        ADLIB_GND, C(35) => \AFLSDF_INV_179\, C(34) => 
        \AFLSDF_INV_180\, C(33) => ADLIB_GND, C(32) => 
        \AFLSDF_INV_181\, C(31) => \AFLSDF_INV_182\, C(30) => 
        ADLIB_GND, C(29) => \AFLSDF_INV_183\, C(28) => 
        \AFLSDF_INV_184\, C(27) => ADLIB_GND, C(26) => 
        \AFLSDF_INV_185\, C(25) => \AFLSDF_INV_186\, C(24) => 
        ADLIB_GND, C(23) => \AFLSDF_INV_187\, C(22) => 
        \AFLSDF_INV_188\, C(21) => ADLIB_GND, C(20) => 
        \AFLSDF_INV_189\, C(19) => \AFLSDF_INV_190\, C(18) => 
        ADLIB_GND, C(17) => \AFLSDF_INV_191\, C(16) => 
        \AFLSDF_INV_192\, C(15) => ADLIB_GND, C(14) => 
        \AFLSDF_INV_193\, C(13) => \AFLSDF_INV_194\, C(12) => 
        ADLIB_GND, C(11) => \AFLSDF_INV_195\, C(10) => 
        \AFLSDF_INV_196\, C(9) => \AFLSDF_INV_197\, C(8) => 
        \AFLSDF_INV_198\, C(7) => \AFLSDF_INV_199\, C(6) => 
        \AFLSDF_INV_200\, C(5) => \AFLSDF_INV_201\, C(4) => 
        \AFLSDF_INV_202\, C(3) => \AFLSDF_INV_203\, C(2) => 
        \AFLSDF_INV_204\, C(1) => \AFLSDF_INV_205\, C(0) => 
        \AFLSDF_INV_206\, C_EN => ADLIB_VCC, C_SRST_N => 
        ADLIB_VCC, C_ARST_N => ADLIB_VCC, D(17) => 
        \AFLSDF_INV_207\, D(16) => \AFLSDF_INV_208\, D(15) => 
        \AFLSDF_INV_209\, D(14) => \AFLSDF_INV_210\, D(13) => 
        \AFLSDF_INV_211\, D(12) => \AFLSDF_INV_212\, D(11) => 
        \AFLSDF_INV_213\, D(10) => \AFLSDF_INV_214\, D(9) => 
        \AFLSDF_INV_215\, D(8) => \AFLSDF_INV_216\, D(7) => 
        \AFLSDF_INV_217\, D(6) => \AFLSDF_INV_218\, D(5) => 
        \AFLSDF_INV_219\, D(4) => \AFLSDF_INV_220\, D(3) => 
        \AFLSDF_INV_221\, D(2) => \AFLSDF_INV_222\, D(1) => 
        \AFLSDF_INV_223\, D(0) => \AFLSDF_INV_224\, D_EN => 
        ADLIB_VCC, D_SRST_N => ADLIB_VCC, D_ARST_N => ADLIB_VCC, 
        P_EN => en_c, P_SRST_N => ADLIB_VCC, ARSHFT17 => 
        ADLIB_GND, ARSHFT17_EN => ADLIB_VCC, ARSHFT17_SL_N => 
        ADLIB_VCC, SUB => ADLIB_GND, SUB_EN => ADLIB_VCC, 
        SUB_SL_N => ADLIB_VCC, PASUB => ADLIB_GND, PASUB_EN => 
        ADLIB_VCC, PASUB_SL_N => ADLIB_VCC, CDIN_FDBK_SEL(1) => 
        ADLIB_GND, CDIN_FDBK_SEL(0) => ADLIB_GND, 
        CDIN_FDBK_SEL_EN => ADLIB_VCC, CDIN_FDBK_SEL_SL_N => 
        ADLIB_VCC, B2(17) => ADLIB_VCC, B2(16) => ADLIB_VCC, 
        B2(15) => ADLIB_VCC, B2(14) => ADLIB_VCC, B2(13) => 
        ADLIB_VCC, B2(12) => ADLIB_VCC, B2(11) => ADLIB_VCC, 
        B2(10) => ADLIB_VCC, B2(9) => ADLIB_VCC, B2(8) => 
        ADLIB_VCC, B2(7) => ADLIB_VCC, B2(6) => ADLIB_VCC, B2(5)
         => ADLIB_VCC, B2(4) => ADLIB_VCC, B2(3) => ADLIB_VCC, 
        B2(2) => ADLIB_VCC, B2(1) => ADLIB_VCC, B2(0) => 
        ADLIB_VCC, B2_EN => ADLIB_VCC, SIMD => ADLIB_GND, DOTP
         => ADLIB_GND, OVFL_CARRYOUT_SEL => ADLIB_GND, A_BYPASS
         => ADLIB_GND, B_BYPASS => ADLIB_GND, C_BYPASS => 
        ADLIB_VCC, D_BYPASS => ADLIB_VCC, P_BYPASS => ADLIB_GND, 
        SUB_BYPASS => ADLIB_VCC, SUB_SD_N => ADLIB_VCC, SUB_AD_N
         => ADLIB_VCC, ARSHFT17_BYPASS => ADLIB_VCC, 
        ARSHFT17_SD_N => ADLIB_GND, ARSHFT17_AD_N => ADLIB_VCC, 
        CDIN_FDBK_SEL_BYPASS => ADLIB_VCC, CDIN_FDBK_SEL_SD_N(1)
         => ADLIB_GND, CDIN_FDBK_SEL_SD_N(0) => ADLIB_GND, 
        CDIN_FDBK_SEL_AD_N(1) => ADLIB_VCC, CDIN_FDBK_SEL_AD_N(0)
         => ADLIB_VCC, PASUB_SD_N => ADLIB_GND, PASUB_AD_N => 
        ADLIB_VCC, PASUB_BYPASS => ADLIB_VCC, CDIN(47) => 
        ADLIB_GND, CDIN(46) => ADLIB_GND, CDIN(45) => ADLIB_GND, 
        CDIN(44) => ADLIB_GND, CDIN(43) => ADLIB_GND, CDIN(42)
         => ADLIB_GND, CDIN(41) => ADLIB_GND, CDIN(40) => 
        ADLIB_GND, CDIN(39) => ADLIB_GND, CDIN(38) => ADLIB_GND, 
        CDIN(37) => ADLIB_GND, CDIN(36) => ADLIB_GND, CDIN(35)
         => ADLIB_GND, CDIN(34) => ADLIB_GND, CDIN(33) => 
        ADLIB_GND, CDIN(32) => ADLIB_GND, CDIN(31) => ADLIB_GND, 
        CDIN(30) => ADLIB_GND, CDIN(29) => ADLIB_GND, CDIN(28)
         => ADLIB_GND, CDIN(27) => ADLIB_GND, CDIN(26) => 
        ADLIB_GND, CDIN(25) => ADLIB_GND, CDIN(24) => ADLIB_GND, 
        CDIN(23) => ADLIB_GND, CDIN(22) => ADLIB_GND, CDIN(21)
         => ADLIB_GND, CDIN(20) => ADLIB_GND, CDIN(19) => 
        ADLIB_GND, CDIN(18) => ADLIB_GND, CDIN(17) => ADLIB_GND, 
        CDIN(16) => ADLIB_GND, CDIN(15) => ADLIB_GND, CDIN(14)
         => ADLIB_GND, CDIN(13) => ADLIB_GND, CDIN(12) => 
        ADLIB_GND, CDIN(11) => ADLIB_GND, CDIN(10) => ADLIB_GND, 
        CDIN(9) => ADLIB_GND, CDIN(8) => ADLIB_GND, CDIN(7) => 
        ADLIB_GND, CDIN(6) => ADLIB_GND, CDIN(5) => ADLIB_GND, 
        CDIN(4) => ADLIB_GND, CDIN(3) => ADLIB_GND, CDIN(2) => 
        ADLIB_GND, CDIN(1) => ADLIB_GND, CDIN(0) => ADLIB_GND, 
        CDOUT(47) => nc146, CDOUT(46) => nc230, CDOUT(45) => nc89, 
        CDOUT(44) => nc119, CDOUT(43) => nc48, CDOUT(42) => nc271, 
        CDOUT(41) => nc213, CDOUT(40) => nc366, CDOUT(39) => 
        nc300, CDOUT(38) => nc126, CDOUT(37) => nc195, CDOUT(36)
         => nc188, CDOUT(35) => nc242, CDOUT(34) => nc15, 
        CDOUT(33) => nc308, CDOUT(32) => nc236, CDOUT(31) => 
        nc102, CDOUT(30) => nc381, CDOUT(29) => nc304, CDOUT(28)
         => nc3, CDOUT(27) => nc207, CDOUT(26) => nc47, CDOUT(25)
         => nc90, CDOUT(24) => nc284, CDOUT(23) => nc222, 
        CDOUT(22) => nc159, CDOUT(21) => nc136, CDOUT(20) => 
        nc241, CDOUT(19) => nc253, CDOUT(18) => nc178, CDOUT(17)
         => nc306, CDOUT(16) => nc215, CDOUT(15) => nc59, 
        CDOUT(14) => nc362, CDOUT(13) => nc221, CDOUT(12) => 
        nc371, CDOUT(11) => nc232, CDOUT(10) => nc274, CDOUT(9)
         => nc18, CDOUT(8) => nc44, CDOUT(7) => nc117, CDOUT(6)
         => nc189, CDOUT(5) => nc164, CDOUT(4) => nc148, CDOUT(3)
         => nc42, CDOUT(2) => nc231, CDOUT(1) => nc191, CDOUT(0)
         => nc255);
    
    AFLSDF_INV_108 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[41]\, 
        Y => \AFLSDF_INV_108\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_26\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_15\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[7]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[7]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[16]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[17]\);
    
    \p_imag_obuf[7]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(7), D => \p_imag_obuf[7]/DOUT\, E
         => \p_imag_obuf[7]/EOUT\);
    
    bbi_0_cry_4 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \b[4]\, B => \bi[4]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => bbi_0_cry_3_Z, S => \bbi[4]\, Y => OPEN, 
        FCO => bbi_0_cry_4_Z, CC => NET_CC_CONFIG147, P => 
        NET_CC_CONFIG144, Y3 => NET_CC_CONFIG145, Y3A => 
        NET_CC_CONFIG146);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_12\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \p_imag_obuf[2]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[2]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[2]/DOUT\, EOUT => \p_imag_obuf[2]/EOUT\);
    
    AFLSDF_INV_35 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[38]\, 
        Y => \AFLSDF_INV_35\);
    
    p_0_cry_12 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[12]\, B => \k2r[12]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_11_Z, S => \p[12]\, Y => 
        OPEN, FCO => p_0_cry_12_Z, CC => NET_CC_CONFIG50, P => 
        NET_CC_CONFIG47, Y3 => NET_CC_CONFIG48, Y3A => 
        NET_CC_CONFIG49);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_30\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \b_real_ibuf[7]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_real(7), Y => \b_real_ibuf[7]/YIN\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_6\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_9\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[4]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[4]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[4]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[8]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[9]\);
    
    \b_imag_ibuf[5]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_imag_c[5]\, E => ADLIB_GND, YIN => 
        \b_imag_ibuf[5]/YIN\);
    
    AFLSDF_INV_216 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[8]\, 
        Y => \AFLSDF_INV_216\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_13\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \b_imag_ibuf[0]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_imag(0), Y => \b_imag_ibuf[0]/YIN\);
    
    aia_0_cry_6 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \ai[6]\, B => \a[6]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aia_0_cry_5_Z, S => \aia[6]\, Y => OPEN, 
        FCO => aia_0_cry_6_Z, CC => NET_CC_CONFIG188, P => 
        NET_CC_CONFIG185, Y3 => NET_CC_CONFIG186, Y3A => 
        NET_CC_CONFIG187);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_6\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_94 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_94\);
    
    \p_imag_obuf[8]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[8]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[8]/DOUT\, EOUT => \p_imag_obuf[8]/EOUT\);
    
    AFLSDF_INV_10 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_10\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_8\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_30\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[15]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_32\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[16]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_60 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[4]\, 
        Y => \AFLSDF_INV_60\);
    
    AFLSDF_INV_125 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[16]\, 
        Y => \AFLSDF_INV_125\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_34\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \a_real_ibuf[4]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_real(4), Y => \a_real_ibuf[4]/YIN\);
    
    \p_imag_obuf[6]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(6), D => \p_imag_obuf[6]/DOUT\, E
         => \p_imag_obuf[6]/EOUT\);
    
    bbi_0_cry_2 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \b[2]\, B => \bi[2]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => bbi_0_cry_1_Z, S => \bbi[2]\, Y => OPEN, 
        FCO => bbi_0_cry_2_Z, CC => NET_CC_CONFIG139, P => 
        NET_CC_CONFIG136, Y3 => NET_CC_CONFIG137, Y3A => 
        NET_CC_CONFIG138);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_12\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[6]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[6]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \REG_OUT_R/Q[10]\ : SLE
      port map(D => \p[10]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_10\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[10]\);
    
    \REG_OUT_I/Q[10]\ : SLE
      port map(D => \pi[10]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_24\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[10]\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_24\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    p_0_cry_2 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[2]\, B => \k2r[2]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_1_Z, S => \p[2]\, Y => OPEN, 
        FCO => p_0_cry_2_Z, CC => NET_CC_CONFIG10, P => 
        NET_CC_CONFIG7, Y3 => NET_CC_CONFIG8, Y3A => 
        NET_CC_CONFIG9);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_17\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[8]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[8]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[19]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[20]\);
    
    \b_real_ibuf[3]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_real_c[3]\, E => ADLIB_GND, YIN => 
        \b_real_ibuf[3]/YIN\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_31\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_46 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[22]\, 
        Y => \AFLSDF_INV_46\);
    
    AFLSDF_INV_183 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[29]\, 
        Y => \AFLSDF_INV_183\);
    
    \REG_IN_B/Q[7]\ : SLE
      port map(D => \b_real_c[7]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_22\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \b[7]\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_0\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_25\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[12]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[12]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[31]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[32]\);
    
    AFLSDF_INV_32 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[43]\, 
        Y => \AFLSDF_INV_32\);
    
    AFLSDF_INV_202 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[4]\, 
        Y => \AFLSDF_INV_202\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_5\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[2]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[2]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[2]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[4]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[5]\);
    
    \b_imag_ibuf[7]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_imag(7), Y => \b_imag_ibuf[7]/YIN\);
    
    AFLSDF_INV_5 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_5\);
    
    \REG_IN_AI/Q[0]\ : SLE
      port map(D => \a_imag_c[0]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_169\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \ai[0]\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_17\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[8]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[8]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[19]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[20]\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_16\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_200 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[6]\, 
        Y => \AFLSDF_INV_200\);
    
    AFLSDF_INV_115 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[31]\, 
        Y => \AFLSDF_INV_115\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_18\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \b_real_ibuf[4]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_real_c[4]\, E => ADLIB_GND, YIN => 
        \b_real_ibuf[4]/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_29\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    bbi_0_cry_3 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \b[3]\, B => \bi[3]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => bbi_0_cry_2_Z, S => \bbi[3]\, Y => OPEN, 
        FCO => bbi_0_cry_3_Z, CC => NET_CC_CONFIG143, P => 
        NET_CC_CONFIG140, Y3 => NET_CC_CONFIG141, Y3A => 
        NET_CC_CONFIG142);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_2\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_100 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_100\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_31\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    pi_0_cry_14 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[14]\, B => \k3r[14]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_13_Z, S => \pi[14]\, Y => 
        OPEN, FCO => pi_0_cry_14_Z, CC => NET_CC_CONFIG123, P => 
        NET_CC_CONFIG120, Y3 => NET_CC_CONFIG121, Y3A => 
        NET_CC_CONFIG122);
    
    \b_real_ibuf[1]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_real(1), Y => \b_real_ibuf[1]/YIN\);
    
    AFLSDF_INV_133 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[6]\, 
        Y => \AFLSDF_INV_133\);
    
    aia_0_cry_0_CC_1 : CC_CONFIG
      port map(CI => CI_TO_CO160, CO => OPEN, P(0) => 
        NET_CC_CONFIG169, P(1) => NET_CC_CONFIG173, P(2) => 
        NET_CC_CONFIG177, P(3) => NET_CC_CONFIG181, P(4) => 
        NET_CC_CONFIG185, P(5) => NET_CC_CONFIG189, P(6) => 
        ADLIB_VCC, P(7) => ADLIB_VCC, P(8) => ADLIB_VCC, P(9) => 
        ADLIB_VCC, P(10) => ADLIB_VCC, P(11) => ADLIB_VCC, Y3(0)
         => NET_CC_CONFIG170, Y3(1) => NET_CC_CONFIG174, Y3(2)
         => NET_CC_CONFIG178, Y3(3) => NET_CC_CONFIG182, Y3(4)
         => NET_CC_CONFIG186, Y3(5) => NET_CC_CONFIG190, Y3(6)
         => ADLIB_VCC, Y3(7) => ADLIB_VCC, Y3(8) => ADLIB_VCC, 
        Y3(9) => ADLIB_VCC, Y3(10) => ADLIB_VCC, Y3(11) => 
        ADLIB_VCC, Y3A(0) => NET_CC_CONFIG171, Y3A(1) => 
        NET_CC_CONFIG175, Y3A(2) => NET_CC_CONFIG179, Y3A(3) => 
        NET_CC_CONFIG183, Y3A(4) => NET_CC_CONFIG187, Y3A(5) => 
        NET_CC_CONFIG191, Y3A(6) => ADLIB_VCC, Y3A(7) => 
        ADLIB_VCC, Y3A(8) => ADLIB_VCC, Y3A(9) => ADLIB_VCC, 
        Y3A(10) => ADLIB_VCC, Y3A(11) => ADLIB_VCC, CC(0) => 
        NET_CC_CONFIG172, CC(1) => NET_CC_CONFIG176, CC(2) => 
        NET_CC_CONFIG180, CC(3) => NET_CC_CONFIG184, CC(4) => 
        NET_CC_CONFIG188, CC(5) => NET_CC_CONFIG192, CC(6) => 
        nc283, CC(7) => nc363, CC(8) => nc341, CC(9) => nc317, 
        CC(10) => nc290, CC(11) => nc17);
    
    AFLSDF_INV_31 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[44]\, 
        Y => \AFLSDF_INV_31\);
    
    \p_real_obuf[2]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[2]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[2]/DOUT\, EOUT => \p_real_obuf[2]/EOUT\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_10\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[5]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[5]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_9\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[4]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[4]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[4]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[8]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[9]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_22\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[11]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    ov_2 : CFG4
      generic map(INIT => x"F1F8")

      port map(A => \a[7]\, B => \ai[7]\, C => ov_1_Z, D => 
        \aai[7]\, Y => ov_2_Z);
    
    \REG_OUT_I/Q[7]\ : SLE
      port map(D => \pi[7]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_225\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[7]\);
    
    AFLSDF_INV_169 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_169\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_33\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_27\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[13]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[13]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[34]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[35]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_20\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    bbi_0_cry_6 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \b[6]\, B => \bi[6]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => bbi_0_cry_5_Z, S => \bbi[6]\, Y => OPEN, 
        FCO => bbi_0_cry_6_Z, CC => NET_CC_CONFIG155, P => 
        NET_CC_CONFIG152, Y3 => NET_CC_CONFIG153, Y3A => 
        NET_CC_CONFIG154);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_14\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \REG_IN_BI/Q[3]\ : SLE
      port map(D => \b_imag_c[3]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_158\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \bi[3]\);
    
    \a_imag_ibuf[5]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_imag(5), Y => \a_imag_ibuf[5]/YIN\);
    
    \a_imag_ibuf[3]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_imag(3), Y => \a_imag_ibuf[3]/YIN\);
    
    \REG_IN_AI/Q[4]\ : SLE
      port map(D => \a_imag_c[4]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_87\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \ai[4]\);
    
    \REG_IN_B/Q[0]\ : SLE
      port map(D => \b_real_c[0]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_88\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \b[0]\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_16\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_153 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[4]\, 
        Y => \AFLSDF_INV_153\);
    
    \p_imag_obuf[12]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[12]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[12]/DOUT\, EOUT => \p_imag_obuf[12]/EOUT\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_1\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => bbi_0_cry_0_Y, B => ADLIB_GND, C => ADLIB_GND, 
        D => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[0]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[0]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[0]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[1]\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_27\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[13]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[13]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[34]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[35]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_16\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[8]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    p_0_cry_3 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[3]\, B => \k2r[3]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_2_Z, S => \p[3]\, Y => OPEN, 
        FCO => p_0_cry_3_Z, CC => NET_CC_CONFIG14, P => 
        NET_CC_CONFIG11, Y3 => NET_CC_CONFIG12, Y3A => 
        NET_CC_CONFIG13);
    
    I_1 : GB
      port map(A => clk_ibuf_Z, EN => ADLIB_VCC, Y => \I_1/U0_Y\);
    
    pi_0_cry_13 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[13]\, B => \k3r[13]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_12_Z, S => \pi[13]\, Y => 
        OPEN, FCO => pi_0_cry_13_Z, CC => NET_CC_CONFIG119, P => 
        NET_CC_CONFIG116, Y3 => NET_CC_CONFIG117, Y3A => 
        NET_CC_CONFIG118);
    
    \p_imag_obuf[11]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[11]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[11]/DOUT\, EOUT => \p_imag_obuf[11]/EOUT\);
    
    AFLSDF_INV_96 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_96\);
    
    AFLSDF_INV_57 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[7]\, 
        Y => \AFLSDF_INV_57\);
    
    \b_imag_ibuf[2]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_imag(2), Y => \b_imag_ibuf[2]/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_33\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_15\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[7]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[7]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[16]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[17]\);
    
    \REG_OUT_R/Q[0]\ : SLE
      port map(D => p_0_axb_0_i, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_164\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[0]\);
    
    ov_0 : CFG4
      generic map(INIT => x"FF18")

      port map(A => \k3r[15]\, B => \k1r[15]\, C => \pi[15]\, D
         => of_p_Z, Y => ov_0_Z);
    
    \overflow_obuf/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => overflow_c, E => ADLIB_VCC, DOUT => 
        \overflow_obuf/DOUT\, EOUT => \overflow_obuf/EOUT\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_20\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[10]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_187 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[23]\, 
        Y => \AFLSDF_INV_187\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_34\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[17]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_7\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[3]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[3]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[3]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[6]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[7]\);
    
    AFLSDF_INV_59 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[5]\, 
        Y => \AFLSDF_INV_59\);
    
    \p_real_obuf[14]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[14]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[14]/DOUT\, EOUT => \p_real_obuf[14]/EOUT\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_12\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/INST_MACC_IP\ : MACC_IP
      port map(OVFL_CARRYOUT => OPEN, P(47) => nc2, P(46) => 
        nc302, P(45) => nc110, P(44) => nc128, P(43) => nc244, 
        P(42) => nc321, P(41) => nc43, P(40) => nc179, P(39) => 
        nc157, P(38) => nc36, P(37) => nc224, P(36) => nc296, 
        P(35) => nc273, P(34) => nc61, P(33) => nc104, P(32) => 
        nc138, P(31) => nc14, P(30) => nc357, P(29) => nc285, 
        P(28) => nc303, P(27) => nc150, P(26) => nc365, P(25) => 
        nc331, P(24) => nc196, P(23) => nc234, P(22) => nc149, 
        P(21) => nc12, P(20) => nc219, P(19) => nc30, P(18) => 
        nc243, P(17) => nc187, P(16) => nc65, P(15) => \k3r[15]\, 
        P(14) => \k3r[14]\, P(13) => \k3r[13]\, P(12) => 
        \k3r[12]\, P(11) => \k3r[11]\, P(10) => \k3r[10]\, P(9)
         => \k3r[9]\, P(8) => \k3r[8]\, P(7) => \k3r[7]\, P(6)
         => \k3r[6]\, P(5) => \k3r[5]\, P(4) => \k3r[4]\, P(3)
         => \k3r[3]\, P(2) => \k3r[2]\, P(1) => \k3r[1]\, P(0)
         => \k3r[0]\, A_ADDR_D_SH => OPEN, B2_EN_SH => OPEN, 
        BCOUT(17) => nc7, BCOUT(16) => nc292, BCOUT(15) => nc129, 
        BCOUT(14) => nc275, BCOUT(13) => nc8, BCOUT(12) => nc223, 
        BCOUT(11) => nc13, BCOUT(10) => nc387, BCOUT(9) => nc305, 
        BCOUT(8) => nc180, BCOUT(7) => nc26, BCOUT(6) => nc291, 
        BCOUT(5) => nc177, BCOUT(4) => nc139, BCOUT(3) => nc310, 
        BCOUT(2) => nc259, BCOUT(1) => nc245, BCOUT(0) => nc233, 
        B1(17) => nc163, B1(16) => nc318, B1(15) => nc268, B1(14)
         => nc112, B1(13) => nc68, B1(12) => nc49, B1(11) => 
        nc377, B1(10) => nc314, B1(9) => nc217, B1(8) => nc170, 
        B1(7) => nc91, B1(6) => nc225, B1(5) => nc5, B1(4) => 
        nc20, B1(3) => nc198, B1(2) => nc147, B1(1) => nc350, 
        B1(0) => nc316, A_ADDR_D => ADLIB_VCC, CARRYIN => 
        ADLIB_GND, CLK => NN_1, AL_N => \AFLSDF_INV_28\, A(17)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[17]\, A(16)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[16]\, A(15)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[15]\, A(14)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[14]\, A(13)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[13]\, A(12)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[12]\, A(11)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[11]\, A(10)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[10]\, A(9)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[9]\, A(8)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[8]\, A(7)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[7]\, A(6)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[6]\, A(5)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[5]\, A(4)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[4]\, A(3)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[3]\, A(2)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[2]\, A(1)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[1]\, A(0)
         => \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[0]\, A_EN
         => en_c, A_SRST_N => ADLIB_VCC, B(17) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[17]\, B(16) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[16]\, B(15) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[15]\, B(14) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[14]\, B(13) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[13]\, B(12) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[12]\, B(11) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[11]\, B(10) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[10]\, B(9) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[9]\, B(8) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[8]\, B(7) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[7]\, B(6) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[6]\, B(5) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[5]\, B(4) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[4]\, B(3) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[3]\, B(2) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[2]\, B(1) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[1]\, B(0) => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[0]\, B_EN => 
        en_c, B_SRST_N => ADLIB_VCC, C(47) => \AFLSDF_INV_29\, 
        C(46) => \AFLSDF_INV_30\, C(45) => ADLIB_GND, C(44) => 
        \AFLSDF_INV_31\, C(43) => \AFLSDF_INV_32\, C(42) => 
        ADLIB_GND, C(41) => \AFLSDF_INV_33\, C(40) => 
        \AFLSDF_INV_34\, C(39) => ADLIB_GND, C(38) => 
        \AFLSDF_INV_35\, C(37) => \AFLSDF_INV_36\, C(36) => 
        ADLIB_GND, C(35) => \AFLSDF_INV_37\, C(34) => 
        \AFLSDF_INV_38\, C(33) => ADLIB_GND, C(32) => 
        \AFLSDF_INV_39\, C(31) => \AFLSDF_INV_40\, C(30) => 
        ADLIB_GND, C(29) => \AFLSDF_INV_41\, C(28) => 
        \AFLSDF_INV_42\, C(27) => ADLIB_GND, C(26) => 
        \AFLSDF_INV_43\, C(25) => \AFLSDF_INV_44\, C(24) => 
        ADLIB_GND, C(23) => \AFLSDF_INV_45\, C(22) => 
        \AFLSDF_INV_46\, C(21) => ADLIB_GND, C(20) => 
        \AFLSDF_INV_47\, C(19) => \AFLSDF_INV_48\, C(18) => 
        ADLIB_GND, C(17) => \AFLSDF_INV_49\, C(16) => 
        \AFLSDF_INV_50\, C(15) => ADLIB_GND, C(14) => 
        \AFLSDF_INV_51\, C(13) => \AFLSDF_INV_52\, C(12) => 
        ADLIB_GND, C(11) => \AFLSDF_INV_53\, C(10) => 
        \AFLSDF_INV_54\, C(9) => \AFLSDF_INV_55\, C(8) => 
        \AFLSDF_INV_56\, C(7) => \AFLSDF_INV_57\, C(6) => 
        \AFLSDF_INV_58\, C(5) => \AFLSDF_INV_59\, C(4) => 
        \AFLSDF_INV_60\, C(3) => \AFLSDF_INV_61\, C(2) => 
        \AFLSDF_INV_62\, C(1) => \AFLSDF_INV_63\, C(0) => 
        \AFLSDF_INV_64\, C_EN => ADLIB_VCC, C_SRST_N => ADLIB_VCC, 
        C_ARST_N => ADLIB_GND, D(17) => \AFLSDF_INV_65\, D(16)
         => \AFLSDF_INV_66\, D(15) => \AFLSDF_INV_67\, D(14) => 
        \AFLSDF_INV_68\, D(13) => \AFLSDF_INV_69\, D(12) => 
        \AFLSDF_INV_70\, D(11) => \AFLSDF_INV_71\, D(10) => 
        \AFLSDF_INV_72\, D(9) => \AFLSDF_INV_73\, D(8) => 
        \AFLSDF_INV_74\, D(7) => \AFLSDF_INV_75\, D(6) => 
        \AFLSDF_INV_76\, D(5) => \AFLSDF_INV_77\, D(4) => 
        \AFLSDF_INV_78\, D(3) => \AFLSDF_INV_79\, D(2) => 
        \AFLSDF_INV_80\, D(1) => \AFLSDF_INV_81\, D(0) => 
        \AFLSDF_INV_82\, D_EN => ADLIB_VCC, D_SRST_N => ADLIB_VCC, 
        D_ARST_N => ADLIB_VCC, P_EN => en_c, P_SRST_N => 
        ADLIB_VCC, ARSHFT17 => ADLIB_GND, ARSHFT17_EN => 
        ADLIB_VCC, ARSHFT17_SL_N => ADLIB_VCC, SUB => ADLIB_GND, 
        SUB_EN => ADLIB_VCC, SUB_SL_N => ADLIB_VCC, PASUB => 
        ADLIB_GND, PASUB_EN => ADLIB_VCC, PASUB_SL_N => ADLIB_VCC, 
        CDIN_FDBK_SEL(1) => ADLIB_GND, CDIN_FDBK_SEL(0) => 
        ADLIB_GND, CDIN_FDBK_SEL_EN => ADLIB_VCC, 
        CDIN_FDBK_SEL_SL_N => ADLIB_VCC, B2(17) => ADLIB_VCC, 
        B2(16) => ADLIB_VCC, B2(15) => ADLIB_VCC, B2(14) => 
        ADLIB_VCC, B2(13) => ADLIB_VCC, B2(12) => ADLIB_VCC, 
        B2(11) => ADLIB_VCC, B2(10) => ADLIB_VCC, B2(9) => 
        ADLIB_VCC, B2(8) => ADLIB_VCC, B2(7) => ADLIB_VCC, B2(6)
         => ADLIB_VCC, B2(5) => ADLIB_VCC, B2(4) => ADLIB_VCC, 
        B2(3) => ADLIB_VCC, B2(2) => ADLIB_VCC, B2(1) => 
        ADLIB_VCC, B2(0) => ADLIB_VCC, B2_EN => ADLIB_VCC, SIMD
         => ADLIB_GND, DOTP => ADLIB_GND, OVFL_CARRYOUT_SEL => 
        ADLIB_GND, A_BYPASS => ADLIB_GND, B_BYPASS => ADLIB_GND, 
        C_BYPASS => ADLIB_GND, D_BYPASS => ADLIB_VCC, P_BYPASS
         => ADLIB_GND, SUB_BYPASS => ADLIB_VCC, SUB_SD_N => 
        ADLIB_VCC, SUB_AD_N => ADLIB_VCC, ARSHFT17_BYPASS => 
        ADLIB_VCC, ARSHFT17_SD_N => ADLIB_GND, ARSHFT17_AD_N => 
        ADLIB_VCC, CDIN_FDBK_SEL_BYPASS => ADLIB_VCC, 
        CDIN_FDBK_SEL_SD_N(1) => ADLIB_GND, CDIN_FDBK_SEL_SD_N(0)
         => ADLIB_GND, CDIN_FDBK_SEL_AD_N(1) => ADLIB_VCC, 
        CDIN_FDBK_SEL_AD_N(0) => ADLIB_VCC, PASUB_SD_N => 
        ADLIB_GND, PASUB_AD_N => ADLIB_VCC, PASUB_BYPASS => 
        ADLIB_VCC, CDIN(47) => ADLIB_GND, CDIN(46) => ADLIB_GND, 
        CDIN(45) => ADLIB_GND, CDIN(44) => ADLIB_GND, CDIN(43)
         => ADLIB_GND, CDIN(42) => ADLIB_GND, CDIN(41) => 
        ADLIB_GND, CDIN(40) => ADLIB_GND, CDIN(39) => ADLIB_GND, 
        CDIN(38) => ADLIB_GND, CDIN(37) => ADLIB_GND, CDIN(36)
         => ADLIB_GND, CDIN(35) => ADLIB_GND, CDIN(34) => 
        ADLIB_GND, CDIN(33) => ADLIB_GND, CDIN(32) => ADLIB_GND, 
        CDIN(31) => ADLIB_GND, CDIN(30) => ADLIB_GND, CDIN(29)
         => ADLIB_GND, CDIN(28) => ADLIB_GND, CDIN(27) => 
        ADLIB_GND, CDIN(26) => ADLIB_GND, CDIN(25) => ADLIB_GND, 
        CDIN(24) => ADLIB_GND, CDIN(23) => ADLIB_GND, CDIN(22)
         => ADLIB_GND, CDIN(21) => ADLIB_GND, CDIN(20) => 
        ADLIB_GND, CDIN(19) => ADLIB_GND, CDIN(18) => ADLIB_GND, 
        CDIN(17) => ADLIB_GND, CDIN(16) => ADLIB_GND, CDIN(15)
         => ADLIB_GND, CDIN(14) => ADLIB_GND, CDIN(13) => 
        ADLIB_GND, CDIN(12) => ADLIB_GND, CDIN(11) => ADLIB_GND, 
        CDIN(10) => ADLIB_GND, CDIN(9) => ADLIB_GND, CDIN(8) => 
        ADLIB_GND, CDIN(7) => ADLIB_GND, CDIN(6) => ADLIB_GND, 
        CDIN(5) => ADLIB_GND, CDIN(4) => ADLIB_GND, CDIN(3) => 
        ADLIB_GND, CDIN(2) => ADLIB_GND, CDIN(1) => ADLIB_GND, 
        CDIN(0) => ADLIB_GND, CDOUT(47) => nc67, CDOUT(46) => 
        nc289, CDOUT(45) => nc358, CDOUT(44) => nc294, CDOUT(43)
         => nc152, CDOUT(42) => nc127, CDOUT(41) => nc103, 
        CDOUT(40) => nc235, CDOUT(39) => nc76, CDOUT(38) => nc347, 
        CDOUT(37) => nc208, CDOUT(36) => nc354, CDOUT(35) => 
        nc140, CDOUT(34) => nc257, CDOUT(33) => nc86, CDOUT(32)
         => nc95, CDOUT(31) => nc327, CDOUT(30) => nc120, 
        CDOUT(29) => nc165, CDOUT(28) => nc356, CDOUT(27) => 
        nc279, CDOUT(26) => nc137, CDOUT(25) => nc64, CDOUT(24)
         => nc19, CDOUT(23) => nc380, CDOUT(22) => nc369, 
        CDOUT(21) => nc312, CDOUT(20) => nc70, CDOUT(19) => nc388, 
        CDOUT(18) => nc182, CDOUT(17) => nc62, CDOUT(16) => nc337, 
        CDOUT(15) => nc199, CDOUT(14) => nc80, CDOUT(13) => nc130, 
        CDOUT(12) => nc384, CDOUT(11) => nc287, CDOUT(10) => nc98, 
        CDOUT(9) => nc293, CDOUT(8) => nc249, CDOUT(7) => nc114, 
        CDOUT(6) => nc56, CDOUT(5) => nc370, CDOUT(4) => nc105, 
        CDOUT(3) => nc386, CDOUT(2) => nc63, CDOUT(1) => nc352, 
        CDOUT(0) => nc313);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_14\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_40 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[31]\, 
        Y => \AFLSDF_INV_40\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_27\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_201 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[5]\, 
        Y => \AFLSDF_INV_201\);
    
    AFLSDF_INV_123 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[19]\, 
        Y => \AFLSDF_INV_123\);
    
    pi_0_cry_8 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[8]\, B => \k3r[8]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_7_Z, S => \pi[8]\, Y => 
        OPEN, FCO => pi_0_cry_8_Z, CC => NET_CC_CONFIG99, P => 
        NET_CC_CONFIG96, Y3 => NET_CC_CONFIG97, Y3A => 
        NET_CC_CONFIG98);
    
    \REG_IN_BI/Q[6]\ : SLE
      port map(D => \b_imag_c[6]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_162\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \bi[6]\);
    
    aia_0_cry_5 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \ai[5]\, B => \a[5]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aia_0_cry_4_Z, S => \aia[5]\, Y => OPEN, 
        FCO => aia_0_cry_5_Z, CC => NET_CC_CONFIG184, P => 
        NET_CC_CONFIG181, Y3 => NET_CC_CONFIG182, Y3A => 
        NET_CC_CONFIG183);
    
    AFLSDF_INV_229 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_229\);
    
    aai_0_cry_6 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \a[6]\, B => \ai[6]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aai_0_cry_5_Z, S => \aai[6]\, Y => OPEN, 
        FCO => aai_0_cry_6_Z, CC => NET_CC_CONFIG220, P => 
        NET_CC_CONFIG217, Y3 => NET_CC_CONFIG218, Y3A => 
        NET_CC_CONFIG219);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_2\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[1]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[1]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_88 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_88\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_26\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[13]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \REG_OUT_I/Q[3]\ : SLE
      port map(D => \pi[3]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_229\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[3]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_21\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_32\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[16]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_6\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[3]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[3]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_137 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[2]\, 
        Y => \AFLSDF_INV_137\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_25\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[12]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[12]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[31]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[32]\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_7\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \a_imag_ibuf[2]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_imag_c[2]\, E => ADLIB_GND, YIN => 
        \a_imag_ibuf[2]/YIN\);
    
    \a_imag_ibuf[0]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_imag(0), Y => \a_imag_ibuf[0]/YIN\);
    
    bbi_0_cry_1 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \b[1]\, B => \bi[1]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => bbi_0_cry_0_Z, S => \bbi[1]\, Y => OPEN, 
        FCO => bbi_0_cry_1_Z, CC => NET_CC_CONFIG135, P => 
        NET_CC_CONFIG132, Y3 => NET_CC_CONFIG133, Y3A => 
        NET_CC_CONFIG134);
    
    pi_0_cry_0 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k3r[0]\, B => p_0, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => ADLIB_GND, S => OPEN, Y => pi_0_cry_0_Y, 
        FCO => pi_0_cry_0_Z, CC => NET_CC_CONFIG67, P => 
        NET_CC_CONFIG64, Y3 => NET_CC_CONFIG65, Y3A => 
        NET_CC_CONFIG66);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_16\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[8]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \a_real_ibuf[5]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_real(5), Y => \a_real_ibuf[5]/YIN\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_1\ : CFG4_IP_ABCD
      generic map(INIT => x"5A5A")

      port map(A => \a[0]\, B => ADLIB_GND, C => \ai[0]\, D => 
        ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[0]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[0]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[0]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[1]\);
    
    AFLSDF_INV_113 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[34]\, 
        Y => \AFLSDF_INV_113\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_13\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[6]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[6]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[6]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[13]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[14]\);
    
    AFLSDF_INV_3 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_3\);
    
    AFLSDF_INV_219 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[5]\, 
        Y => \AFLSDF_INV_219\);
    
    p_0_s_15 : ARI1_CC
      generic map(INIT => x"49900")

      port map(A => ADLIB_VCC, B => \k1r[15]\, C => \k2r[15]\, D
         => ADLIB_GND, FCI => p_0_cry_14_Z, S => \p[15]\, Y => 
        OPEN, FCO => OPEN, CC => NET_CC_CONFIG62, P => 
        NET_CC_CONFIG59, Y3 => NET_CC_CONFIG60, Y3A => 
        NET_CC_CONFIG61);
    
    AFLSDF_INV_54 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[10]\, 
        Y => \AFLSDF_INV_54\);
    
    AFLSDF_INV_83 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_83\);
    
    AFLSDF_INV_109 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[40]\, 
        Y => \AFLSDF_INV_109\);
    
    p_0_cry_0_CC_0 : CC_CONFIG
      port map(CI => ADLIB_VCC, CO => CI_TO_CO, P(0) => 
        NET_CC_CONFIG, P(1) => NET_CC_CONFIG3, P(2) => 
        NET_CC_CONFIG7, P(3) => NET_CC_CONFIG11, P(4) => 
        NET_CC_CONFIG15, P(5) => NET_CC_CONFIG19, P(6) => 
        NET_CC_CONFIG23, P(7) => NET_CC_CONFIG27, P(8) => 
        NET_CC_CONFIG31, P(9) => NET_CC_CONFIG35, P(10) => 
        NET_CC_CONFIG39, P(11) => NET_CC_CONFIG43, Y3(0) => 
        NET_CC_CONFIG0, Y3(1) => NET_CC_CONFIG4, Y3(2) => 
        NET_CC_CONFIG8, Y3(3) => NET_CC_CONFIG12, Y3(4) => 
        NET_CC_CONFIG16, Y3(5) => NET_CC_CONFIG20, Y3(6) => 
        NET_CC_CONFIG24, Y3(7) => NET_CC_CONFIG28, Y3(8) => 
        NET_CC_CONFIG32, Y3(9) => NET_CC_CONFIG36, Y3(10) => 
        NET_CC_CONFIG40, Y3(11) => NET_CC_CONFIG44, Y3A(0) => 
        NET_CC_CONFIG1, Y3A(1) => NET_CC_CONFIG5, Y3A(2) => 
        NET_CC_CONFIG9, Y3A(3) => NET_CC_CONFIG13, Y3A(4) => 
        NET_CC_CONFIG17, Y3A(5) => NET_CC_CONFIG21, Y3A(6) => 
        NET_CC_CONFIG25, Y3A(7) => NET_CC_CONFIG29, Y3A(8) => 
        NET_CC_CONFIG33, Y3A(9) => NET_CC_CONFIG37, Y3A(10) => 
        NET_CC_CONFIG41, Y3A(11) => NET_CC_CONFIG45, CC(0) => 
        NET_CC_CONFIG2, CC(1) => NET_CC_CONFIG6, CC(2) => 
        NET_CC_CONFIG10, CC(3) => NET_CC_CONFIG14, CC(4) => 
        NET_CC_CONFIG18, CC(5) => NET_CC_CONFIG22, CC(6) => 
        NET_CC_CONFIG26, CC(7) => NET_CC_CONFIG30, CC(8) => 
        NET_CC_CONFIG34, CC(9) => NET_CC_CONFIG38, CC(10) => 
        NET_CC_CONFIG42, CC(11) => NET_CC_CONFIG46);
    
    AFLSDF_INV_157 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[0]\, 
        Y => \AFLSDF_INV_157\);
    
    \REG_OUT_R/Q[5]\ : SLE
      port map(D => \p[5]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_17\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[5]\);
    
    \REG_OUT_R/Q[8]\ : SLE
      port map(D => \p[8]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_16\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[8]\);
    
    p_0_cry_7 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[7]\, B => \k2r[7]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_6_Z, S => \p[7]\, Y => OPEN, 
        FCO => p_0_cry_7_Z, CC => NET_CC_CONFIG30, P => 
        NET_CC_CONFIG27, Y3 => NET_CC_CONFIG28, Y3A => 
        NET_CC_CONFIG29);
    
    \p_real_obuf[4]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(4), D => \p_real_obuf[4]/DOUT\, E
         => \p_real_obuf[4]/EOUT\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_23\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_7\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \p_imag_obuf[13]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[13]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[13]/DOUT\, EOUT => \p_imag_obuf[13]/EOUT\);
    
    p_0_axb_0_i_0 : CFG2
      generic map(INIT => x"6")

      port map(A => p_0, B => \k2r[0]\, Y => p_0_axb_0_i);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_0\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_85 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_85\);
    
    \a_real_ibuf[1]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_real_c[1]\, E => ADLIB_GND, YIN => 
        \a_real_ibuf[1]/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_6\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \b_imag_ibuf[4]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_imag_c[4]\, E => ADLIB_GND, YIN => 
        \b_imag_ibuf[4]/YIN\);
    
    AFLSDF_INV_90 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_90\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_32\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \b_real_ibuf[2]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_real(2), Y => \b_real_ibuf[2]/YIN\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_0\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[0]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[0]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    aia_0_cry_0 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \ai[0]\, B => \a[0]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => ADLIB_VCC, S => OPEN, Y => OPEN, FCO
         => aia_0_cry_0_Z, CC => NET_CC_CONFIG164, P => 
        NET_CC_CONFIG161, Y3 => NET_CC_CONFIG162, Y3A => 
        NET_CC_CONFIG163);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_26\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[13]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_2\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[1]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[1]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_35\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[17]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[17]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[46]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[47]\);
    
    AFLSDF_INV_175 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[41]\, 
        Y => \AFLSDF_INV_175\);
    
    \p_real_obuf[14]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(14), D => \p_real_obuf[14]/DOUT\, E
         => \p_real_obuf[14]/EOUT\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_6\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[3]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[3]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_23\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[11]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[11]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[28]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[29]\);
    
    \b_imag_ibuf[6]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_imag_c[6]\, E => ADLIB_GND, YIN => 
        \b_imag_ibuf[6]/YIN\);
    
    AFLSDF_INV_127 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[13]\, 
        Y => \AFLSDF_INV_127\);
    
    \p_real_obuf[6]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[6]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[6]/DOUT\, EOUT => \p_real_obuf[6]/EOUT\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_13\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[6]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[6]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[6]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[13]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[14]\);
    
    \REG_OUT_R/Q[7]\ : SLE
      port map(D => \p[7]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_85\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[7]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_35\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_16\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \REG_OUT_I/Q[2]\ : SLE
      port map(D => \pi[2]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_7\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[2]\);
    
    AFLSDF_INV_28 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_28\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_25\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_32\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    pi_0_cry_11 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[11]\, B => \k3r[11]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_10_Z, S => \pi[11]\, Y => 
        OPEN, FCO => pi_0_cry_11_Z, CC => NET_CC_CONFIG111, P => 
        NET_CC_CONFIG108, Y3 => NET_CC_CONFIG109, Y3A => 
        NET_CC_CONFIG110);
    
    \REG_OUT_OV/Q[0]\ : SLE
      port map(D => ov_Z, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_11\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => overflow_c);
    
    \REG_OUT_I/Q[0]\ : SLE
      port map(D => pi_0_cry_0_Y, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_6\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[0]\);
    
    pi_0_cry_1 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[1]\, B => \k3r[1]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_0_Z, S => \pi[1]\, Y => 
        OPEN, FCO => pi_0_cry_1_Z, CC => NET_CC_CONFIG71, P => 
        NET_CC_CONFIG68, Y3 => NET_CC_CONFIG69, Y3A => 
        NET_CC_CONFIG70);
    
    pi_0_cry_2 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[2]\, B => \k3r[2]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_1_Z, S => \pi[2]\, Y => 
        OPEN, FCO => pi_0_cry_2_Z, CC => NET_CC_CONFIG75, P => 
        NET_CC_CONFIG72, Y3 => NET_CC_CONFIG73, Y3A => 
        NET_CC_CONFIG74);
    
    aia_0_cry_4 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \ai[4]\, B => \a[4]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aia_0_cry_3_Z, S => \aia[4]\, Y => OPEN, 
        FCO => aia_0_cry_4_Z, CC => NET_CC_CONFIG180, P => 
        NET_CC_CONFIG177, Y3 => NET_CC_CONFIG178, Y3A => 
        NET_CC_CONFIG179);
    
    AFLSDF_INV_37 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[35]\, 
        Y => \AFLSDF_INV_37\);
    
    AFLSDF_INV_195 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[11]\, 
        Y => \AFLSDF_INV_195\);
    
    AFLSDF_INV_204 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[2]\, 
        Y => \AFLSDF_INV_204\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_14\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[7]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_8\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[4]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[4]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \b_imag_ibuf[3]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_imag_c[3]\, E => ADLIB_GND, YIN => 
        \b_imag_ibuf[3]/YIN\);
    
    AFLSDF_INV_82 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[0]\, 
        Y => \AFLSDF_INV_82\);
    
    \REG_IN_AI/Q[3]\ : SLE
      port map(D => \a_imag_c[3]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_27\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \ai[3]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_28\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \p_real_obuf[3]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(3), D => \p_real_obuf[3]/DOUT\, E
         => \p_real_obuf[3]/EOUT\);
    
    AFLSDF_INV_117 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[28]\, 
        Y => \AFLSDF_INV_117\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_32\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[16]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \REG_OUT_R/Q[11]\ : SLE
      port map(D => \p[11]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_101\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[11]\);
    
    \REG_OUT_I/Q[11]\ : SLE
      port map(D => \pi[11]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_161\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[11]\);
    
    AFLSDF_INV_39 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[32]\, 
        Y => \AFLSDF_INV_39\);
    
    AFLSDF_INV_23 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_23\);
    
    \b_real_ibuf[3]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_real(3), Y => \b_real_ibuf[3]/YIN\);
    
    \REG_IN_B/Q[3]\ : SLE
      port map(D => \b_real_c[3]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_15\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \b[3]\);
    
    \b_imag_ibuf[1]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_imag(1), Y => \b_imag_ibuf[1]/YIN\);
    
    aia_0_cry_2 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \ai[2]\, B => \a[2]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aia_0_cry_1_Z, S => \aia[2]\, Y => OPEN, 
        FCO => aia_0_cry_2_Z, CC => NET_CC_CONFIG172, P => 
        NET_CC_CONFIG169, Y3 => NET_CC_CONFIG170, Y3A => 
        NET_CC_CONFIG171);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_14\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    pi_0_cry_0_CC_1 : CC_CONFIG
      port map(CI => CI_TO_CO63, CO => OPEN, P(0) => 
        NET_CC_CONFIG112, P(1) => NET_CC_CONFIG116, P(2) => 
        NET_CC_CONFIG120, P(3) => NET_CC_CONFIG124, P(4) => 
        ADLIB_VCC, P(5) => ADLIB_VCC, P(6) => ADLIB_VCC, P(7) => 
        ADLIB_VCC, P(8) => ADLIB_VCC, P(9) => ADLIB_VCC, P(10)
         => ADLIB_VCC, P(11) => ADLIB_VCC, Y3(0) => 
        NET_CC_CONFIG113, Y3(1) => NET_CC_CONFIG117, Y3(2) => 
        NET_CC_CONFIG121, Y3(3) => NET_CC_CONFIG125, Y3(4) => 
        ADLIB_VCC, Y3(5) => ADLIB_VCC, Y3(6) => ADLIB_VCC, Y3(7)
         => ADLIB_VCC, Y3(8) => ADLIB_VCC, Y3(9) => ADLIB_VCC, 
        Y3(10) => ADLIB_VCC, Y3(11) => ADLIB_VCC, Y3A(0) => 
        NET_CC_CONFIG114, Y3A(1) => NET_CC_CONFIG118, Y3A(2) => 
        NET_CC_CONFIG122, Y3A(3) => NET_CC_CONFIG126, Y3A(4) => 
        ADLIB_VCC, Y3A(5) => ADLIB_VCC, Y3A(6) => ADLIB_VCC, 
        Y3A(7) => ADLIB_VCC, Y3A(8) => ADLIB_VCC, Y3A(9) => 
        ADLIB_VCC, Y3A(10) => ADLIB_VCC, Y3A(11) => ADLIB_VCC, 
        CC(0) => NET_CC_CONFIG115, CC(1) => NET_CC_CONFIG119, 
        CC(2) => NET_CC_CONFIG123, CC(3) => NET_CC_CONFIG127, 
        CC(4) => nc309, CC(5) => nc378, CC(6) => nc172, CC(7) => 
        nc229, CC(8) => nc374, CC(9) => nc277, CC(10) => nc97, 
        CC(11) => nc161);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_9\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    aai_0_cry_5 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \a[5]\, B => \ai[5]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aai_0_cry_4_Z, S => \aai[5]\, Y => OPEN, 
        FCO => aai_0_cry_5_Z, CC => NET_CC_CONFIG216, P => 
        NET_CC_CONFIG213, Y3 => NET_CC_CONFIG214, Y3A => 
        NET_CC_CONFIG215);
    
    AFLSDF_INV_186 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[25]\, 
        Y => \AFLSDF_INV_186\);
    
    AFLSDF_INV_56 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[8]\, 
        Y => \AFLSDF_INV_56\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_23\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[11]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[11]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[28]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[29]\);
    
    \p_imag_obuf[15]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(15), D => \p_imag_obuf[15]/DOUT\, E
         => \p_imag_obuf[15]/EOUT\);
    
    \b_imag_ibuf[7]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_imag_c[7]\, E => ADLIB_GND, YIN => 
        \b_imag_ibuf[7]/YIN\);
    
    AFLSDF_INV_81 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[1]\, 
        Y => \AFLSDF_INV_81\);
    
    \p_imag_obuf[2]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(2), D => \p_imag_obuf[2]/DOUT\, E
         => \p_imag_obuf[2]/EOUT\);
    
    AFLSDF_INV_184 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[28]\, 
        Y => \AFLSDF_INV_184\);
    
    aai_0_cry_2 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \a[2]\, B => \ai[2]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aai_0_cry_1_Z, S => \aai[2]\, Y => OPEN, 
        FCO => aai_0_cry_2_Z, CC => NET_CC_CONFIG204, P => 
        NET_CC_CONFIG201, Y3 => NET_CC_CONFIG202, Y3A => 
        NET_CC_CONFIG203);
    
    \REG_IN_A/Q[2]\ : SLE
      port map(D => \a_real_c[2]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_2\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \a[2]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_0\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[0]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[0]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \REG_OUT_R/Q[14]\ : SLE
      port map(D => \p[14]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_90\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[14]\);
    
    \REG_OUT_I/Q[14]\ : SLE
      port map(D => \pi[14]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_100\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[14]\);
    
    \en_ibuf/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => en_c, E => ADLIB_GND, YIN => \en_ibuf/YIN\);
    
    AFLSDF_INV_25 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_25\);
    
    AFLSDF_INV_181 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[32]\, 
        Y => \AFLSDF_INV_181\);
    
    \REG_IN_A/Q[3]\ : SLE
      port map(D => \a_real_c[3]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_18\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \a[3]\);
    
    aai_0_cry_3 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \a[3]\, B => \ai[3]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aai_0_cry_2_Z, S => \aai[3]\, Y => OPEN, 
        FCO => aai_0_cry_3_Z, CC => NET_CC_CONFIG208, P => 
        NET_CC_CONFIG205, Y3 => NET_CC_CONFIG206, Y3A => 
        NET_CC_CONFIG207);
    
    AFLSDF_INV_145 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[12]\, 
        Y => \AFLSDF_INV_145\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_15\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \a_imag_ibuf[0]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_imag_c[0]\, E => ADLIB_GND, YIN => 
        \a_imag_ibuf[0]/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_24\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[12]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \p_real_obuf[13]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[13]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[13]/DOUT\, EOUT => \p_real_obuf[13]/EOUT\);
    
    \p_real_obuf[6]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(6), D => \p_real_obuf[6]/DOUT\, E
         => \p_real_obuf[6]/EOUT\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_2\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \REG_IN_AI/Q[6]\ : SLE
      port map(D => \a_imag_c[6]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_84\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \ai[6]\);
    
    \p_real_obuf[15]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[15]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[15]/DOUT\, EOUT => \p_real_obuf[15]/EOUT\);
    
    AFLSDF_INV_136 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[3]\, 
        Y => \AFLSDF_INV_136\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_30\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[15]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    p_0_cry_5 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[5]\, B => \k2r[5]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_4_Z, S => \p[5]\, Y => OPEN, 
        FCO => p_0_cry_5_Z, CC => NET_CC_CONFIG22, P => 
        NET_CC_CONFIG19, Y3 => NET_CC_CONFIG20, Y3A => 
        NET_CC_CONFIG21);
    
    \p_imag_obuf[1]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[1]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[1]/DOUT\, EOUT => \p_imag_obuf[1]/EOUT\);
    
    \overflow_obuf/U_IOPAD\ : IOPAD_TRI
      port map(PAD => overflow, D => \overflow_obuf/DOUT\, E => 
        \overflow_obuf/EOUT\);
    
    AFLSDF_INV_34 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[40]\, 
        Y => \AFLSDF_INV_34\);
    
    AFLSDF_INV_134 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[5]\, 
        Y => \AFLSDF_INV_134\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_11\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[5]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[5]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[5]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[10]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[11]\);
    
    \REG_IN_A/Q[7]\ : SLE
      port map(D => \a_real_c[7]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_226\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \a[7]\);
    
    \p_real_obuf[5]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[5]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[5]/DOUT\, EOUT => \p_real_obuf[5]/EOUT\);
    
    p_0_cry_1 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[1]\, B => \k2r[1]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_0_Z, S => \p[1]\, Y => OPEN, 
        FCO => p_0_cry_1_Z, CC => NET_CC_CONFIG6, P => 
        NET_CC_CONFIG3, Y3 => NET_CC_CONFIG4, Y3A => 
        NET_CC_CONFIG5);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_22\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_131 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[8]\, 
        Y => \AFLSDF_INV_131\);
    
    \REG_IN_B/Q[1]\ : SLE
      port map(D => \b_real_c[1]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_93\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \b[1]\);
    
    p_0_cry_10 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[10]\, B => \k2r[10]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_9_Z, S => \p[10]\, Y => 
        OPEN, FCO => p_0_cry_10_Z, CC => NET_CC_CONFIG42, P => 
        NET_CC_CONFIG39, Y3 => NET_CC_CONFIG40, Y3A => 
        NET_CC_CONFIG41);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_20\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_29\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_3\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[1]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[1]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[1]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[2]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[3]\);
    
    AFLSDF_INV_156 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[1]\, 
        Y => \AFLSDF_INV_156\);
    
    AFLSDF_INV_227 : INV_BA
      port map(A => \AFLSDF_INV_227\, Y => 
        \I_1/U0_RGB1_RGB0_rgb_net_1\);
    
    AFLSDF_INV_182 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[31]\, 
        Y => \AFLSDF_INV_182\);
    
    AFLSDF_INV_22 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_22\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_15\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \a_imag_ibuf[1]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_imag(1), Y => \a_imag_ibuf[1]/YIN\);
    
    AFLSDF_INV_154 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[3]\, 
        Y => \AFLSDF_INV_154\);
    
    AFLSDF_INV_173 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[44]\, 
        Y => \AFLSDF_INV_173\);
    
    \b_real_ibuf[6]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_real(6), Y => \b_real_ibuf[6]/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_35\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[17]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[17]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[46]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[47]\);
    
    \rst_ibuf/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => rst_c, E => ADLIB_GND, YIN => \rst_ibuf/YIN\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_34\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_151 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[6]\, 
        Y => \AFLSDF_INV_151\);
    
    \b_real_ibuf[0]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_real_c[0]\, E => ADLIB_GND, YIN => 
        \b_real_ibuf[0]/YIN\);
    
    AFLSDF_INV_78 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[4]\, 
        Y => \AFLSDF_INV_78\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_11\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[5]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[5]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[5]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[10]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[11]\);
    
    AFLSDF_INV_188 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[22]\, 
        Y => \AFLSDF_INV_188\);
    
    AFLSDF_INV_205 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[1]\, 
        Y => \AFLSDF_INV_205\);
    
    \p_imag_obuf[1]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(1), D => \p_imag_obuf[1]/DOUT\, E
         => \p_imag_obuf[1]/EOUT\);
    
    \REG_OUT_I/Q[5]\ : SLE
      port map(D => \pi[5]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_25\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[5]\);
    
    AFLSDF_INV_193 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[14]\, 
        Y => \AFLSDF_INV_193\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_4\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[2]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[2]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_217 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[7]\, 
        Y => \AFLSDF_INV_217\);
    
    AFLSDF_INV_132 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[7]\, 
        Y => \AFLSDF_INV_132\);
    
    \REG_OUT_R/Q[9]\ : SLE
      port map(D => \p[9]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_89\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[9]\);
    
    \p_real_obuf[12]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[12]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[12]/DOUT\, EOUT => \p_real_obuf[12]/EOUT\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_21\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[10]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[10]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[25]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[26]\);
    
    AFLSDF_INV_21 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_21\);
    
    \REG_IN_A/Q[6]\ : SLE
      port map(D => \a_real_c[6]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_99\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \a[6]\);
    
    AFLSDF_INV_223 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[1]\, 
        Y => \AFLSDF_INV_223\);
    
    \REG_OUT_I/Q[9]\ : SLE
      port map(D => \pi[9]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_97\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[9]\);
    
    \p_real_obuf[15]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(15), D => \p_real_obuf[15]/DOUT\, E
         => \p_real_obuf[15]/EOUT\);
    
    AFLSDF_INV_126 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[14]\, 
        Y => \AFLSDF_INV_126\);
    
    pi_0_cry_4 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[4]\, B => \k3r[4]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_3_Z, S => \pi[4]\, Y => 
        OPEN, FCO => pi_0_cry_4_Z, CC => NET_CC_CONFIG83, P => 
        NET_CC_CONFIG80, Y3 => NET_CC_CONFIG81, Y3A => 
        NET_CC_CONFIG82);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_34\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_50 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[16]\, 
        Y => \AFLSDF_INV_50\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_27\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \p_real_obuf[9]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(9), D => \p_real_obuf[9]/DOUT\, E
         => \p_real_obuf[9]/EOUT\);
    
    AFLSDF_INV_18 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_18\);
    
    AFLSDF_INV_73 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[9]\, 
        Y => \AFLSDF_INV_73\);
    
    AFLSDF_INV_8 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_8\);
    
    AFLSDF_INV_124 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[17]\, 
        Y => \AFLSDF_INV_124\);
    
    \REG_OUT_R/Q[15]\ : SLE
      port map(D => \p[15]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_3\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[15]\);
    
    \REG_OUT_I/Q[15]\ : SLE
      port map(D => \pi[15]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_13\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[15]\);
    
    \p_real_obuf[8]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(8), D => \p_real_obuf[8]/DOUT\, E
         => \p_real_obuf[8]/EOUT\);
    
    AFLSDF_INV_138 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[1]\, 
        Y => \AFLSDF_INV_138\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_19\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_228 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_228\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_21\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_152 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[5]\, 
        Y => \AFLSDF_INV_152\);
    
    \a_real_ibuf[7]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_real(7), Y => \a_real_ibuf[7]/YIN\);
    
    AFLSDF_INV_68 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[14]\, 
        Y => \AFLSDF_INV_68\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_13\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[6]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[6]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[6]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[13]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[14]\);
    
    AFLSDF_INV_165 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_165\);
    
    AFLSDF_INV_121 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[22]\, 
        Y => \AFLSDF_INV_121\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_5\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \p_real_obuf[0]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(0), D => \p_real_obuf[0]/DOUT\, E
         => \p_real_obuf[0]/EOUT\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_7\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_213 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[11]\, 
        Y => \AFLSDF_INV_213\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_3\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[1]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[1]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[1]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[2]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[3]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_21\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[10]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[10]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[25]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[26]\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_33\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[16]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[16]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[43]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[44]\);
    
    AFLSDF_INV_116 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[29]\, 
        Y => \AFLSDF_INV_116\);
    
    AFLSDF_INV_75 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[7]\, 
        Y => \AFLSDF_INV_75\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_19\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[9]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[9]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[22]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[23]\);
    
    AFLSDF_INV_36 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[37]\, 
        Y => \AFLSDF_INV_36\);
    
    AFLSDF_INV_158 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_158\);
    
    AFLSDF_INV_143 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[14]\, 
        Y => \AFLSDF_INV_143\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_15\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[7]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[7]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[16]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[17]\);
    
    p_0_cry_8 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[8]\, B => \k2r[8]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_7_Z, S => \p[8]\, Y => OPEN, 
        FCO => p_0_cry_8_Z, CC => NET_CC_CONFIG34, P => 
        NET_CC_CONFIG31, Y3 => NET_CC_CONFIG32, Y3A => 
        NET_CC_CONFIG33);
    
    AFLSDF_INV_13 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_13\);
    
    \b_imag_ibuf[0]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_imag_c[0]\, E => ADLIB_GND, YIN => 
        \b_imag_ibuf[0]/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_0\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_114 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[32]\, 
        Y => \AFLSDF_INV_114\);
    
    pi_0_cry_0_CC_0 : CC_CONFIG
      port map(CI => ADLIB_GND, CO => CI_TO_CO63, P(0) => 
        NET_CC_CONFIG64, P(1) => NET_CC_CONFIG68, P(2) => 
        NET_CC_CONFIG72, P(3) => NET_CC_CONFIG76, P(4) => 
        NET_CC_CONFIG80, P(5) => NET_CC_CONFIG84, P(6) => 
        NET_CC_CONFIG88, P(7) => NET_CC_CONFIG92, P(8) => 
        NET_CC_CONFIG96, P(9) => NET_CC_CONFIG100, P(10) => 
        NET_CC_CONFIG104, P(11) => NET_CC_CONFIG108, Y3(0) => 
        NET_CC_CONFIG65, Y3(1) => NET_CC_CONFIG69, Y3(2) => 
        NET_CC_CONFIG73, Y3(3) => NET_CC_CONFIG77, Y3(4) => 
        NET_CC_CONFIG81, Y3(5) => NET_CC_CONFIG85, Y3(6) => 
        NET_CC_CONFIG89, Y3(7) => NET_CC_CONFIG93, Y3(8) => 
        NET_CC_CONFIG97, Y3(9) => NET_CC_CONFIG101, Y3(10) => 
        NET_CC_CONFIG105, Y3(11) => NET_CC_CONFIG109, Y3A(0) => 
        NET_CC_CONFIG66, Y3A(1) => NET_CC_CONFIG70, Y3A(2) => 
        NET_CC_CONFIG74, Y3A(3) => NET_CC_CONFIG78, Y3A(4) => 
        NET_CC_CONFIG82, Y3A(5) => NET_CC_CONFIG86, Y3A(6) => 
        NET_CC_CONFIG90, Y3A(7) => NET_CC_CONFIG94, Y3A(8) => 
        NET_CC_CONFIG98, Y3A(9) => NET_CC_CONFIG102, Y3A(10) => 
        NET_CC_CONFIG106, Y3A(11) => NET_CC_CONFIG110, CC(0) => 
        NET_CC_CONFIG67, CC(1) => NET_CC_CONFIG71, CC(2) => 
        NET_CC_CONFIG75, CC(3) => NET_CC_CONFIG79, CC(4) => 
        NET_CC_CONFIG83, CC(5) => NET_CC_CONFIG87, CC(6) => 
        NET_CC_CONFIG91, CC(7) => NET_CC_CONFIG95, CC(8) => 
        NET_CC_CONFIG99, CC(9) => NET_CC_CONFIG103, CC(10) => 
        NET_CC_CONFIG107, CC(11) => NET_CC_CONFIG111);
    
    AFLSDF_INV_63 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[1]\, 
        Y => \AFLSDF_INV_63\);
    
    AFLSDF_INV_218 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[6]\, 
        Y => \AFLSDF_INV_218\);
    
    \p_imag_obuf[4]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[4]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[4]/DOUT\, EOUT => \p_imag_obuf[4]/EOUT\);
    
    pi_0_cry_9 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[9]\, B => \k3r[9]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_8_Z, S => \pi[9]\, Y => 
        OPEN, FCO => pi_0_cry_9_Z, CC => NET_CC_CONFIG103, P => 
        NET_CC_CONFIG100, Y3 => NET_CC_CONFIG101, Y3A => 
        NET_CC_CONFIG102);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_26\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_111 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[37]\, 
        Y => \AFLSDF_INV_111\);
    
    bbi_0_cry_5 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \b[5]\, B => \bi[5]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => bbi_0_cry_4_Z, S => \bbi[5]\, Y => OPEN, 
        FCO => bbi_0_cry_5_Z, CC => NET_CC_CONFIG151, P => 
        NET_CC_CONFIG148, Y3 => NET_CC_CONFIG149, Y3A => 
        NET_CC_CONFIG150);
    
    AFLSDF_INV_177 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[38]\, 
        Y => \AFLSDF_INV_177\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_19\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \REG_OUT_I/Q[6]\ : SLE
      port map(D => \pi[6]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_102\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[6]\);
    
    AFLSDF_INV_180 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[34]\, 
        Y => \AFLSDF_INV_180\);
    
    aai_0_s_7 : ARI1_CC
      generic map(INIT => x"46600")

      port map(A => ADLIB_VCC, B => \a[7]\, C => \ai[7]\, D => 
        ADLIB_GND, FCI => aai_0_cry_6_Z, S => \aai[7]\, Y => OPEN, 
        FCO => OPEN, CC => NET_CC_CONFIG224, P => 
        NET_CC_CONFIG221, Y3 => NET_CC_CONFIG222, Y3A => 
        NET_CC_CONFIG223);
    
    AFLSDF_INV_122 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[20]\, 
        Y => \AFLSDF_INV_122\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_23\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_15 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_15\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_4\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[2]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[2]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_23\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[11]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[11]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[28]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[29]\);
    
    \a_imag_ibuf[3]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_imag_c[3]\, E => ADLIB_GND, YIN => 
        \a_imag_ibuf[3]/YIN\);
    
    AFLSDF_INV_206 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[0]\, 
        Y => \AFLSDF_INV_206\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_18\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[9]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_65 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[17]\, 
        Y => \AFLSDF_INV_65\);
    
    \REG_OUT_I/Q[4]\ : SLE
      port map(D => \pi[4]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_4\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[4]\);
    
    AFLSDF_INV_197 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[9]\, 
        Y => \AFLSDF_INV_197\);
    
    AFLSDF_INV_87 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_87\);
    
    AFLSDF_INV_230 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_230\);
    
    AFLSDF_INV_72 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[10]\, 
        Y => \AFLSDF_INV_72\);
    
    AFLSDF_INV_128 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[11]\, 
        Y => \AFLSDF_INV_128\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_29\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[14]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[14]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[37]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[38]\);
    
    \b_real_ibuf[0]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_real(0), Y => \b_real_ibuf[0]/YIN\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_33\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[16]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[16]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[43]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[44]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_25\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[12]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[12]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[31]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[32]\);
    
    \a_real_ibuf[0]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_real(0), Y => \a_real_ibuf[0]/YIN\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_24\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \b_real_ibuf[4]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_real(4), Y => \b_real_ibuf[4]/YIN\);
    
    \p_real_obuf[7]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[7]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[7]/DOUT\, EOUT => \p_real_obuf[7]/EOUT\);
    
    AFLSDF_INV_130 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[9]\, 
        Y => \AFLSDF_INV_130\);
    
    \p_imag_obuf[0]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(0), D => \p_imag_obuf[0]/DOUT\, E
         => \p_imag_obuf[0]/EOUT\);
    
    \I_1/U0_RGB1\ : RGB
      port map(A => \I_1/U0_Y\, EN => ADLIB_VCC, Y => 
        \AFLSDF_INV_168\);
    
    AFLSDF_INV_112 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[35]\, 
        Y => \AFLSDF_INV_112\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_4\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    bbi_0_cry_0_CC_0 : CC_CONFIG
      port map(CI => ADLIB_GND, CO => OPEN, P(0) => 
        NET_CC_CONFIG128, P(1) => NET_CC_CONFIG132, P(2) => 
        NET_CC_CONFIG136, P(3) => NET_CC_CONFIG140, P(4) => 
        NET_CC_CONFIG144, P(5) => NET_CC_CONFIG148, P(6) => 
        NET_CC_CONFIG152, P(7) => NET_CC_CONFIG156, P(8) => 
        ADLIB_VCC, P(9) => ADLIB_VCC, P(10) => ADLIB_VCC, P(11)
         => ADLIB_VCC, Y3(0) => NET_CC_CONFIG129, Y3(1) => 
        NET_CC_CONFIG133, Y3(2) => NET_CC_CONFIG137, Y3(3) => 
        NET_CC_CONFIG141, Y3(4) => NET_CC_CONFIG145, Y3(5) => 
        NET_CC_CONFIG149, Y3(6) => NET_CC_CONFIG153, Y3(7) => 
        NET_CC_CONFIG157, Y3(8) => ADLIB_VCC, Y3(9) => ADLIB_VCC, 
        Y3(10) => ADLIB_VCC, Y3(11) => ADLIB_VCC, Y3A(0) => 
        NET_CC_CONFIG130, Y3A(1) => NET_CC_CONFIG134, Y3A(2) => 
        NET_CC_CONFIG138, Y3A(3) => NET_CC_CONFIG142, Y3A(4) => 
        NET_CC_CONFIG146, Y3A(5) => NET_CC_CONFIG150, Y3A(6) => 
        NET_CC_CONFIG154, Y3A(7) => NET_CC_CONFIG158, Y3A(8) => 
        ADLIB_VCC, Y3A(9) => ADLIB_VCC, Y3A(10) => ADLIB_VCC, 
        Y3A(11) => ADLIB_VCC, CC(0) => NET_CC_CONFIG131, CC(1)
         => NET_CC_CONFIG135, CC(2) => NET_CC_CONFIG139, CC(3)
         => NET_CC_CONFIG143, CC(4) => NET_CC_CONFIG147, CC(5)
         => NET_CC_CONFIG151, CC(6) => NET_CC_CONFIG155, CC(7)
         => NET_CC_CONFIG159, CC(8) => nc31, CC(9) => nc340, 
        CC(10) => nc295, CC(11) => nc154);
    
    AFLSDF_INV_2 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_2\);
    
    \a_imag_ibuf[5]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_imag_c[5]\, E => ADLIB_GND, YIN => 
        \a_imag_ibuf[5]/YIN\);
    
    AFLSDF_INV_89 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_89\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_5\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[2]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[2]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[2]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[4]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[5]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_15\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \a_real_ibuf[4]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_real_c[4]\, E => ADLIB_GND, YIN => 
        \a_real_ibuf[4]/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_34\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[17]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \REG_IN_B/Q[4]\ : SLE
      port map(D => \b_real_c[4]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_98\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \b[4]\);
    
    \b_imag_ibuf[2]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_imag_c[2]\, E => ADLIB_GND, YIN => 
        \b_imag_ibuf[2]/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_9\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_12 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_12\);
    
    \p_imag_obuf[15]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[15]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[15]/DOUT\, EOUT => \p_imag_obuf[15]/EOUT\);
    
    AFLSDF_INV_71 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[11]\, 
        Y => \AFLSDF_INV_71\);
    
    AFLSDF_INV_150 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[7]\, 
        Y => \AFLSDF_INV_150\);
    
    AFLSDF_INV_118 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[26]\, 
        Y => \AFLSDF_INV_118\);
    
    AFLSDF_INV_105 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[46]\, 
        Y => \AFLSDF_INV_105\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_28\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_62 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[2]\, 
        Y => \AFLSDF_INV_62\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_28\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[14]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_147 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[10]\, 
        Y => \AFLSDF_INV_147\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_18\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[9]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \p_real_obuf[8]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[8]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[8]/DOUT\, EOUT => \p_real_obuf[8]/EOUT\);
    
    AFLSDF_INV_48 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[19]\, 
        Y => \AFLSDF_INV_48\);
    
    \REG_OUT_R/Q[2]\ : SLE
      port map(D => \p[2]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_21\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[2]\);
    
    AFLSDF_INV_163 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_163\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_9\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[4]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[4]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[4]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[8]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[9]\);
    
    AFLSDF_INV_30 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[46]\, 
        Y => \AFLSDF_INV_30\);
    
    AFLSDF_INV_222 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[2]\, 
        Y => \AFLSDF_INV_222\);
    
    AFLSDF_INV_11 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_11\);
    
    AFLSDF_INV_0 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_0\);
    
    \REG_IN_A/Q[4]\ : SLE
      port map(D => \a_real_c[4]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_20\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \a[4]\);
    
    \p_imag_obuf[5]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[5]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[5]/DOUT\, EOUT => \p_imag_obuf[5]/EOUT\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_5\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_84 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_84\);
    
    AFLSDF_INV_220 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[4]\, 
        Y => \AFLSDF_INV_220\);
    
    AFLSDF_INV_61 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[3]\, 
        Y => \AFLSDF_INV_61\);
    
    AFLSDF_INV_120 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[23]\, 
        Y => \AFLSDF_INV_120\);
    
    \p_real_obuf[7]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(7), D => \p_real_obuf[7]/DOUT\, E
         => \p_real_obuf[7]/EOUT\);
    
    \a_imag_ibuf[7]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_imag(7), Y => \a_imag_ibuf[7]/YIN\);
    
    pi_0_cry_6 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[6]\, B => \k3r[6]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_5_Z, S => \pi[6]\, Y => 
        OPEN, FCO => pi_0_cry_6_Z, CC => NET_CC_CONFIG91, P => 
        NET_CC_CONFIG88, Y3 => NET_CC_CONFIG89, Y3A => 
        NET_CC_CONFIG90);
    
    AFLSDF_INV_43 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[26]\, 
        Y => \AFLSDF_INV_43\);
    
    AFLSDF_INV_27 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_27\);
    
    pi_0_cry_10 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[10]\, B => \k3r[10]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_9_Z, S => \pi[10]\, Y => 
        OPEN, FCO => pi_0_cry_10_Z, CC => NET_CC_CONFIG107, P => 
        NET_CC_CONFIG104, Y3 => NET_CC_CONFIG105, Y3A => 
        NET_CC_CONFIG106);
    
    p_0_cry_14 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[14]\, B => \k2r[14]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_13_Z, S => \p[14]\, Y => 
        OPEN, FCO => p_0_cry_14_Z, CC => NET_CC_CONFIG58, P => 
        NET_CC_CONFIG55, Y3 => NET_CC_CONFIG56, Y3A => 
        NET_CC_CONFIG57);
    
    AFLSDF_INV_231 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_231\);
    
    AFLSDF_INV_212 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[12]\, 
        Y => \AFLSDF_INV_212\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_16\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[8]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_31\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[15]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[15]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[40]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[41]\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_28\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[14]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_189 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[20]\, 
        Y => \AFLSDF_INV_189\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_35\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    pi_0_s_15 : ARI1_CC
      generic map(INIT => x"46600")

      port map(A => ADLIB_VCC, B => \k1r[15]\, C => \k3r[15]\, D
         => ADLIB_GND, FCI => pi_0_cry_14_Z, S => \pi[15]\, Y => 
        OPEN, FCO => OPEN, CC => NET_CC_CONFIG127, P => 
        NET_CC_CONFIG124, Y3 => NET_CC_CONFIG125, Y3A => 
        NET_CC_CONFIG126);
    
    AFLSDF_INV_210 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[14]\, 
        Y => \AFLSDF_INV_210\);
    
    AFLSDF_INV_29 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[47]\, 
        Y => \AFLSDF_INV_29\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_18\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[9]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_14\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[7]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_45 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[23]\, 
        Y => \AFLSDF_INV_45\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_7\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \bbi[3]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[3]\, IPB => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[3]\, IPC => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[6]\, IPD => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[7]\);
    
    \p_imag_obuf[3]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[3]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[3]/DOUT\, EOUT => \p_imag_obuf[3]/EOUT\);
    
    \a_real_ibuf[2]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_real(2), Y => \a_real_ibuf[2]/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_22\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \b_imag_ibuf[1]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_imag_c[1]\, E => ADLIB_GND, YIN => 
        \b_imag_ibuf[1]/YIN\);
    
    \p_imag_obuf[7]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[7]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[7]/DOUT\, EOUT => \p_imag_obuf[7]/EOUT\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_3\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_110 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[38]\, 
        Y => \AFLSDF_INV_110\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_19\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_2\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \a_real_ibuf[6]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_real_c[6]\, E => ADLIB_GND, YIN => 
        \a_real_ibuf[6]/YIN\);
    
    \p_imag_obuf[5]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(5), D => \p_imag_obuf[5]/DOUT\, E
         => \p_imag_obuf[5]/EOUT\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_19\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[9]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[9]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[22]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[23]\);
    
    \a_imag_ibuf[1]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_imag_c[1]\, E => ADLIB_GND, YIN => 
        \a_imag_ibuf[1]/YIN\);
    
    AFLSDF_INV_98 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_98\);
    
    AFLSDF_INV_176 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[40]\, 
        Y => \AFLSDF_INV_176\);
    
    \rst_ibuf/U_IOPAD\ : IOPAD_IN
      port map(PAD => rst, Y => \rst_ibuf/YIN\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_35\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \b_imag_ibuf[5]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_imag(5), Y => \b_imag_ibuf[5]/YIN\);
    
    \REG_IN_BI/Q[2]\ : SLE
      port map(D => \b_imag_c[2]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_12\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \bi[2]\);
    
    AFLSDF_INV_139 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[0]\, 
        Y => \AFLSDF_INV_139\);
    
    aai_0_cry_1 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \a[1]\, B => \ai[1]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aai_0_cry_0_Z, S => \aai[1]\, Y => OPEN, 
        FCO => aai_0_cry_1_Z, CC => NET_CC_CONFIG200, P => 
        NET_CC_CONFIG197, Y3 => NET_CC_CONFIG198, Y3A => 
        NET_CC_CONFIG199);
    
    \a_real_ibuf[7]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_real_c[7]\, E => ADLIB_GND, YIN => 
        \a_real_ibuf[7]/YIN\);
    
    ov_1 : CFG4
      generic map(INIT => x"F1F8")

      port map(A => \b[7]\, B => \bi[7]\, C => ov_0_Z, D => 
        \bbi[7]\, Y => ov_1_Z);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_31\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[15]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[15]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[40]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[41]\);
    
    AFLSDF_INV_174 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[43]\, 
        Y => \AFLSDF_INV_174\);
    
    pi_0_cry_7 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[7]\, B => \k3r[7]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_6_Z, S => \pi[7]\, Y => 
        OPEN, FCO => pi_0_cry_7_Z, CC => NET_CC_CONFIG95, P => 
        NET_CC_CONFIG92, Y3 => NET_CC_CONFIG93, Y3A => 
        NET_CC_CONFIG94);
    
    AFLSDF_INV_7 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_7\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_30\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_11\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[5]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[5]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[5]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[10]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[11]\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_20\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    aia_0_cry_1 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \ai[1]\, B => \a[1]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aia_0_cry_0_Z, S => \aia[1]\, Y => OPEN, 
        FCO => aia_0_cry_1_Z, CC => NET_CC_CONFIG168, P => 
        NET_CC_CONFIG165, Y3 => NET_CC_CONFIG166, Y3A => 
        NET_CC_CONFIG167);
    
    AFLSDF_INV_171 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[47]\, 
        Y => \AFLSDF_INV_171\);
    
    p_0_cry_6 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[6]\, B => \k2r[6]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_5_Z, S => \p[6]\, Y => OPEN, 
        FCO => p_0_cry_6_Z, CC => NET_CC_CONFIG26, P => 
        NET_CC_CONFIG23, Y3 => NET_CC_CONFIG24, Y3A => 
        NET_CC_CONFIG25);
    
    AFLSDF_INV_196 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[10]\, 
        Y => \AFLSDF_INV_196\);
    
    AFLSDF_INV_167 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_167\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_26\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[13]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \b_real_ibuf[2]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_real_c[2]\, E => ADLIB_GND, YIN => 
        \b_real_ibuf[2]/YIN\);
    
    \p_real_obuf[10]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[10]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[10]/DOUT\, EOUT => \p_real_obuf[10]/EOUT\);
    
    \REG_IN_A/Q[1]\ : SLE
      port map(D => \a_real_c[1]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_23\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \a[1]\);
    
    ov : CFG4
      generic map(INIT => x"F4F2")

      port map(A => \a[7]\, B => \ai[7]\, C => ov_2_Z, D => 
        \aia[7]\, Y => ov_Z);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_1\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => aai_0_cry_0_Y, B => ADLIB_GND, C => ADLIB_GND, 
        D => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[0]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[0]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[0]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[1]\);
    
    aia_0_cry_3 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \ai[3]\, B => \a[3]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aia_0_cry_2_Z, S => \aia[3]\, Y => OPEN, 
        FCO => aia_0_cry_3_Z, CC => NET_CC_CONFIG176, P => 
        NET_CC_CONFIG173, Y3 => NET_CC_CONFIG174, Y3A => 
        NET_CC_CONFIG175);
    
    \b_real_ibuf[5]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_real(5), Y => \b_real_ibuf[5]/YIN\);
    
    AFLSDF_INV_42 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[28]\, 
        Y => \AFLSDF_INV_42\);
    
    AFLSDF_INV_159 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_159\);
    
    AFLSDF_INV_24 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_24\);
    
    AFLSDF_INV_93 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_93\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_28\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[14]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_194 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[13]\, 
        Y => \AFLSDF_INV_194\);
    
    AFLSDF_INV_221 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[3]\, 
        Y => \AFLSDF_INV_221\);
    
    AFLSDF_INV_103 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_103\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_24\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[12]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    p_0_cry_0 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => p_0, B => \k2r[0]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => ADLIB_VCC, S => OPEN, Y => OPEN, FCO
         => p_0_cry_0_Z, CC => NET_CC_CONFIG2, P => NET_CC_CONFIG, 
        Y3 => NET_CC_CONFIG0, Y3A => NET_CC_CONFIG1);
    
    AFLSDF_INV_209 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[15]\, 
        Y => \AFLSDF_INV_209\);
    
    AFLSDF_INV_191 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[17]\, 
        Y => \AFLSDF_INV_191\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_8\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_86 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_86\);
    
    AFLSDF_INV_1 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_1\);
    
    \p_imag_obuf[3]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(3), D => \p_imag_obuf[3]/DOUT\, E
         => \p_imag_obuf[3]/EOUT\);
    
    \p_real_obuf[5]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(5), D => \p_real_obuf[5]/DOUT\, E
         => \p_real_obuf[5]/EOUT\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_33\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[16]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[16]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[43]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[44]\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_10\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[5]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[5]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_29\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[14]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[14]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[37]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[38]\);
    
    \p_imag_obuf[13]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(13), D => \p_imag_obuf[13]/DOUT\, E
         => \p_imag_obuf[13]/EOUT\);
    
    AFLSDF_INV_6 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_6\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_1\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_95 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_95\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_17\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[8]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[8]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[19]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[20]\);
    
    \REG_IN_BI/Q[5]\ : SLE
      port map(D => \b_imag_c[5]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_165\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \bi[5]\);
    
    \p_imag_obuf[10]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[10]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[10]/DOUT\, EOUT => \p_imag_obuf[10]/EOUT\);
    
    p_0_cry_11 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[11]\, B => \k2r[11]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_10_Z, S => \p[11]\, Y => 
        OPEN, FCO => p_0_cry_11_Z, CC => NET_CC_CONFIG46, P => 
        NET_CC_CONFIG43, Y3 => NET_CC_CONFIG44, Y3A => 
        NET_CC_CONFIG45);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_7\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[3]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[3]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[3]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[6]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[7]\);
    
    AFLSDF_INV_172 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[46]\, 
        Y => \AFLSDF_INV_172\);
    
    bbi_0_s_7 : ARI1_CC
      generic map(INIT => x"46600")

      port map(A => ADLIB_VCC, B => \b[7]\, C => \bi[7]\, D => 
        ADLIB_GND, FCI => bbi_0_cry_6_Z, S => \bbi[7]\, Y => OPEN, 
        FCO => OPEN, CC => NET_CC_CONFIG159, P => 
        NET_CC_CONFIG156, Y3 => NET_CC_CONFIG157, Y3A => 
        NET_CC_CONFIG158);
    
    AFLSDF_INV_41 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[29]\, 
        Y => \AFLSDF_INV_41\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_21\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aai[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/B_net[10]\, IPB => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[10]\, IPC => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[25]\, IPD => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[26]\);
    
    AFLSDF_INV_211 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[13]\, 
        Y => \AFLSDF_INV_211\);
    
    \REG_IN_A/Q[5]\ : SLE
      port map(D => \a_real_c[5]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_94\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \a[5]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_35\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[17]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[17]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[46]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[47]\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_27\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_146 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[11]\, 
        Y => \AFLSDF_INV_146\);
    
    \a_real_ibuf[3]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_real(3), Y => \a_real_ibuf[3]/YIN\);
    
    AFLSDF_INV_129 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[10]\, 
        Y => \AFLSDF_INV_129\);
    
    \REG_OUT_I/Q[8]\ : SLE
      port map(D => \pi[8]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_14\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[8]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_31\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_2\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[1]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[1]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_10\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_77 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[5]\, 
        Y => \AFLSDF_INV_77\);
    
    AFLSDF_INV_192 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[16]\, 
        Y => \AFLSDF_INV_192\);
    
    AFLSDF_INV_144 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[13]\, 
        Y => \AFLSDF_INV_144\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_6\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[3]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[3]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_21\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_178 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[37]\, 
        Y => \AFLSDF_INV_178\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_4\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_26\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/INST_MACC_IP\ : MACC_IP
      port map(OVFL_CARRYOUT => OPEN, P(47) => nc376, P(46) => 
        nc50, P(45) => nc260, P(44) => nc239, P(43) => nc353, 
        P(42) => nc348, P(41) => nc142, P(40) => nc320, P(39) => 
        nc344, P(38) => nc315, P(37) => nc382, P(36) => nc247, 
        P(35) => nc94, P(34) => nc197, P(33) => nc328, P(32) => 
        nc122, P(31) => nc266, P(30) => nc35, P(29) => nc324, 
        P(28) => nc4, P(27) => nc227, P(26) => nc92, P(25) => 
        nc101, P(24) => nc346, P(23) => nc330, P(22) => nc184, 
        P(21) => nc200, P(20) => nc190, P(19) => nc166, P(18) => 
        nc372, P(17) => nc355, P(16) => nc338, P(15) => \k1r[15]\, 
        P(14) => \k1r[14]\, P(13) => \k1r[13]\, P(12) => 
        \k1r[12]\, P(11) => \k1r[11]\, P(10) => \k1r[10]\, P(9)
         => \k1r[9]\, P(8) => \k1r[8]\, P(7) => \k1r[7]\, P(6)
         => \k1r[6]\, P(5) => \k1r[5]\, P(4) => \k1r[4]\, P(3)
         => \k1r[3]\, P(2) => \k1r[2]\, P(1) => \k1r[1]\, P(0)
         => p_0, A_ADDR_D_SH => OPEN, B2_EN_SH => OPEN, BCOUT(17)
         => nc326, BCOUT(16) => nc132, BCOUT(15) => nc383, 
        BCOUT(14) => nc334, BCOUT(13) => nc21, BCOUT(12) => nc237, 
        BCOUT(11) => nc93, BCOUT(10) => nc262, BCOUT(9) => nc69, 
        BCOUT(8) => nc206, BCOUT(7) => nc174, BCOUT(6) => nc38, 
        BCOUT(5) => nc113, BCOUT(4) => nc336, BCOUT(3) => nc218, 
        BCOUT(2) => nc342, BCOUT(1) => nc373, BCOUT(0) => nc106, 
        B1(17) => nc261, B1(16) => nc25, B1(15) => nc1, B1(14)
         => nc385, B1(13) => nc322, B1(12) => nc299, B1(11) => 
        nc37, B1(10) => nc202, B1(9) => nc144, B1(8) => nc153, 
        B1(7) => nc46, B1(6) => nc258, B1(5) => nc343, B1(4) => 
        nc71, B1(3) => nc124, B1(2) => nc332, B1(1) => nc81, 
        B1(0) => nc375, A_ADDR_D => ADLIB_VCC, CARRYIN => 
        ADLIB_GND, CLK => \I_1/U0_RGB1_RGB0_rgb_net_1\, AL_N => 
        \AFLSDF_INV_103\, A(17) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[17]\, A(16) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[16]\, A(15) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[15]\, A(14) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[14]\, A(13) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[13]\, A(12) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[12]\, A(11) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[11]\, A(10) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[10]\, A(9) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[9]\, A(8) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[8]\, A(7) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[7]\, A(6) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[6]\, A(5) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[5]\, A(4) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[4]\, A(3) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[3]\, A(2) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[2]\, A(1) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[1]\, A(0) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[0]\, A_EN => 
        en_c, A_SRST_N => ADLIB_VCC, B(17) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[17]\, B(16) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[16]\, B(15) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[15]\, B(14) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[14]\, B(13) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[13]\, B(12) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[12]\, B(11) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[11]\, B(10) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[10]\, B(9) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[9]\, B(8) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[8]\, B(7) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[7]\, B(6) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[6]\, B(5) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[5]\, B(4) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[4]\, B(3) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[3]\, B(2) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[2]\, B(1) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[1]\, B(0) => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/B_net[0]\, B_EN => 
        en_c, B_SRST_N => ADLIB_VCC, C(47) => \AFLSDF_INV_104\, 
        C(46) => \AFLSDF_INV_105\, C(45) => ADLIB_GND, C(44) => 
        \AFLSDF_INV_106\, C(43) => \AFLSDF_INV_107\, C(42) => 
        ADLIB_GND, C(41) => \AFLSDF_INV_108\, C(40) => 
        \AFLSDF_INV_109\, C(39) => ADLIB_GND, C(38) => 
        \AFLSDF_INV_110\, C(37) => \AFLSDF_INV_111\, C(36) => 
        ADLIB_GND, C(35) => \AFLSDF_INV_112\, C(34) => 
        \AFLSDF_INV_113\, C(33) => ADLIB_GND, C(32) => 
        \AFLSDF_INV_114\, C(31) => \AFLSDF_INV_115\, C(30) => 
        ADLIB_GND, C(29) => \AFLSDF_INV_116\, C(28) => 
        \AFLSDF_INV_117\, C(27) => ADLIB_GND, C(26) => 
        \AFLSDF_INV_118\, C(25) => \AFLSDF_INV_119\, C(24) => 
        ADLIB_GND, C(23) => \AFLSDF_INV_120\, C(22) => 
        \AFLSDF_INV_121\, C(21) => ADLIB_GND, C(20) => 
        \AFLSDF_INV_122\, C(19) => \AFLSDF_INV_123\, C(18) => 
        ADLIB_GND, C(17) => \AFLSDF_INV_124\, C(16) => 
        \AFLSDF_INV_125\, C(15) => ADLIB_GND, C(14) => 
        \AFLSDF_INV_126\, C(13) => \AFLSDF_INV_127\, C(12) => 
        ADLIB_GND, C(11) => \AFLSDF_INV_128\, C(10) => 
        \AFLSDF_INV_129\, C(9) => \AFLSDF_INV_130\, C(8) => 
        \AFLSDF_INV_131\, C(7) => \AFLSDF_INV_132\, C(6) => 
        \AFLSDF_INV_133\, C(5) => \AFLSDF_INV_134\, C(4) => 
        \AFLSDF_INV_135\, C(3) => \AFLSDF_INV_136\, C(2) => 
        \AFLSDF_INV_137\, C(1) => \AFLSDF_INV_138\, C(0) => 
        \AFLSDF_INV_139\, C_EN => ADLIB_VCC, C_SRST_N => 
        ADLIB_VCC, C_ARST_N => ADLIB_VCC, D(17) => 
        \AFLSDF_INV_140\, D(16) => \AFLSDF_INV_141\, D(15) => 
        \AFLSDF_INV_142\, D(14) => \AFLSDF_INV_143\, D(13) => 
        \AFLSDF_INV_144\, D(12) => \AFLSDF_INV_145\, D(11) => 
        \AFLSDF_INV_146\, D(10) => \AFLSDF_INV_147\, D(9) => 
        \AFLSDF_INV_148\, D(8) => \AFLSDF_INV_149\, D(7) => 
        \AFLSDF_INV_150\, D(6) => \AFLSDF_INV_151\, D(5) => 
        \AFLSDF_INV_152\, D(4) => \AFLSDF_INV_153\, D(3) => 
        \AFLSDF_INV_154\, D(2) => \AFLSDF_INV_155\, D(1) => 
        \AFLSDF_INV_156\, D(0) => \AFLSDF_INV_157\, D_EN => 
        ADLIB_VCC, D_SRST_N => ADLIB_VCC, D_ARST_N => ADLIB_VCC, 
        P_EN => en_c, P_SRST_N => ADLIB_VCC, ARSHFT17 => 
        ADLIB_GND, ARSHFT17_EN => ADLIB_VCC, ARSHFT17_SL_N => 
        ADLIB_VCC, SUB => ADLIB_GND, SUB_EN => ADLIB_VCC, 
        SUB_SL_N => ADLIB_VCC, PASUB => ADLIB_GND, PASUB_EN => 
        ADLIB_VCC, PASUB_SL_N => ADLIB_VCC, CDIN_FDBK_SEL(1) => 
        ADLIB_GND, CDIN_FDBK_SEL(0) => ADLIB_GND, 
        CDIN_FDBK_SEL_EN => ADLIB_VCC, CDIN_FDBK_SEL_SL_N => 
        ADLIB_VCC, B2(17) => ADLIB_VCC, B2(16) => ADLIB_VCC, 
        B2(15) => ADLIB_VCC, B2(14) => ADLIB_VCC, B2(13) => 
        ADLIB_VCC, B2(12) => ADLIB_VCC, B2(11) => ADLIB_VCC, 
        B2(10) => ADLIB_VCC, B2(9) => ADLIB_VCC, B2(8) => 
        ADLIB_VCC, B2(7) => ADLIB_VCC, B2(6) => ADLIB_VCC, B2(5)
         => ADLIB_VCC, B2(4) => ADLIB_VCC, B2(3) => ADLIB_VCC, 
        B2(2) => ADLIB_VCC, B2(1) => ADLIB_VCC, B2(0) => 
        ADLIB_VCC, B2_EN => ADLIB_VCC, SIMD => ADLIB_GND, DOTP
         => ADLIB_GND, OVFL_CARRYOUT_SEL => ADLIB_GND, A_BYPASS
         => ADLIB_GND, B_BYPASS => ADLIB_GND, C_BYPASS => 
        ADLIB_VCC, D_BYPASS => ADLIB_VCC, P_BYPASS => ADLIB_GND, 
        SUB_BYPASS => ADLIB_VCC, SUB_SD_N => ADLIB_VCC, SUB_AD_N
         => ADLIB_VCC, ARSHFT17_BYPASS => ADLIB_VCC, 
        ARSHFT17_SD_N => ADLIB_GND, ARSHFT17_AD_N => ADLIB_VCC, 
        CDIN_FDBK_SEL_BYPASS => ADLIB_VCC, CDIN_FDBK_SEL_SD_N(1)
         => ADLIB_GND, CDIN_FDBK_SEL_SD_N(0) => ADLIB_GND, 
        CDIN_FDBK_SEL_AD_N(1) => ADLIB_VCC, CDIN_FDBK_SEL_AD_N(0)
         => ADLIB_VCC, PASUB_SD_N => ADLIB_GND, PASUB_AD_N => 
        ADLIB_VCC, PASUB_BYPASS => ADLIB_VCC, CDIN(47) => 
        ADLIB_GND, CDIN(46) => ADLIB_GND, CDIN(45) => ADLIB_GND, 
        CDIN(44) => ADLIB_GND, CDIN(43) => ADLIB_GND, CDIN(42)
         => ADLIB_GND, CDIN(41) => ADLIB_GND, CDIN(40) => 
        ADLIB_GND, CDIN(39) => ADLIB_GND, CDIN(38) => ADLIB_GND, 
        CDIN(37) => ADLIB_GND, CDIN(36) => ADLIB_GND, CDIN(35)
         => ADLIB_GND, CDIN(34) => ADLIB_GND, CDIN(33) => 
        ADLIB_GND, CDIN(32) => ADLIB_GND, CDIN(31) => ADLIB_GND, 
        CDIN(30) => ADLIB_GND, CDIN(29) => ADLIB_GND, CDIN(28)
         => ADLIB_GND, CDIN(27) => ADLIB_GND, CDIN(26) => 
        ADLIB_GND, CDIN(25) => ADLIB_GND, CDIN(24) => ADLIB_GND, 
        CDIN(23) => ADLIB_GND, CDIN(22) => ADLIB_GND, CDIN(21)
         => ADLIB_GND, CDIN(20) => ADLIB_GND, CDIN(19) => 
        ADLIB_GND, CDIN(18) => ADLIB_GND, CDIN(17) => ADLIB_GND, 
        CDIN(16) => ADLIB_GND, CDIN(15) => ADLIB_GND, CDIN(14)
         => ADLIB_GND, CDIN(13) => ADLIB_GND, CDIN(12) => 
        ADLIB_GND, CDIN(11) => ADLIB_GND, CDIN(10) => ADLIB_GND, 
        CDIN(9) => ADLIB_GND, CDIN(8) => ADLIB_GND, CDIN(7) => 
        ADLIB_GND, CDIN(6) => ADLIB_GND, CDIN(5) => ADLIB_GND, 
        CDIN(4) => ADLIB_GND, CDIN(3) => ADLIB_GND, CDIN(2) => 
        ADLIB_GND, CDIN(1) => ADLIB_GND, CDIN(0) => ADLIB_GND, 
        CDOUT(47) => nc201, CDOUT(46) => nc168, CDOUT(45) => 
        nc323, CDOUT(44) => nc34, CDOUT(43) => nc28, CDOUT(42)
         => nc361, CDOUT(41) => nc115, CDOUT(40) => nc264, 
        CDOUT(39) => nc192, CDOUT(38) => nc319, CDOUT(37) => 
        nc134, CDOUT(36) => nc32, CDOUT(35) => nc40, CDOUT(34)
         => nc297, CDOUT(33) => nc99, CDOUT(32) => nc75, 
        CDOUT(31) => nc183, CDOUT(30) => nc345, CDOUT(29) => 
        nc333, CDOUT(28) => nc288, CDOUT(27) => nc85, CDOUT(26)
         => nc27, CDOUT(25) => nc108, CDOUT(24) => nc325, 
        CDOUT(23) => nc16, CDOUT(22) => nc155, CDOUT(21) => nc51, 
        CDOUT(20) => nc301, CDOUT(19) => nc33, CDOUT(18) => nc359, 
        CDOUT(17) => nc204, CDOUT(16) => nc173, CDOUT(15) => 
        nc278, CDOUT(14) => nc169, CDOUT(13) => nc78, CDOUT(12)
         => nc263, CDOUT(11) => nc335, CDOUT(10) => nc24, 
        CDOUT(9) => nc88, CDOUT(8) => nc111, CDOUT(7) => nc55, 
        CDOUT(6) => nc10, CDOUT(5) => nc22, CDOUT(4) => nc210, 
        CDOUT(3) => nc185, CDOUT(2) => nc143, CDOUT(1) => nc248, 
        CDOUT(0) => nc77);
    
    AFLSDF_INV_141 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[16]\, 
        Y => \AFLSDF_INV_141\);
    
    \a_real_ibuf[5]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_real_c[5]\, E => ADLIB_GND, YIN => 
        \a_real_ibuf[5]/YIN\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_25\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    aia_0_s_7 : ARI1_CC
      generic map(INIT => x"49900")

      port map(A => ADLIB_VCC, B => \a[7]\, C => \ai[7]\, D => 
        ADLIB_GND, FCI => aia_0_cry_6_Z, S => \aia[7]\, Y => OPEN, 
        FCO => OPEN, CC => NET_CC_CONFIG192, P => 
        NET_CC_CONFIG189, Y3 => NET_CC_CONFIG190, Y3A => 
        NET_CC_CONFIG191);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_20\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[7]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[10]\, IPB => 
        OPEN, IPC => OPEN, IPD => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_1\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_79 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[3]\, 
        Y => \AFLSDF_INV_79\);
    
    \p_real_obuf[4]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[4]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[4]/DOUT\, EOUT => \p_real_obuf[4]/EOUT\);
    
    AFLSDF_INV_92 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_92\);
    
    AFLSDF_INV_198 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[8]\, 
        Y => \AFLSDF_INV_198\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/CFG_8\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \a_real_c[4]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k1_mulonly_0[15:0]/MACC_PHYS_INST/A_net[4]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_27\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \aia[7]\, B => ADLIB_GND, C => ADLIB_GND, D
         => ADLIB_GND, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/B_net[13]\, IPB => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[13]\, IPC => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[34]\, IPD => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[35]\);
    
    AFLSDF_INV_119 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[25]\, 
        Y => \AFLSDF_INV_119\);
    
    AFLSDF_INV_17 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_17\);
    
    \a_real_ibuf[3]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_real_c[3]\, E => ADLIB_GND, YIN => 
        \a_real_ibuf[3]/YIN\);
    
    \p_imag_obuf[14]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[14]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[14]/DOUT\, EOUT => \p_imag_obuf[14]/EOUT\);
    
    AFLSDF_INV_67 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[15]\, 
        Y => \AFLSDF_INV_67\);
    
    AFLSDF_INV_107 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/C_net[43]\, 
        Y => \AFLSDF_INV_107\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_10\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \p_real_obuf[9]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[9]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[9]/DOUT\, EOUT => \p_real_obuf[9]/EOUT\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_33\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_24\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \b_imag_ibuf[4]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_imag(4), Y => \b_imag_ibuf[4]/YIN\);
    
    p_0_cry_13 : ARI1_CC
      generic map(INIT => x"5AA55")

      port map(A => \k1r[13]\, B => \k2r[13]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => p_0_cry_12_Z, S => \p[13]\, Y => 
        OPEN, FCO => p_0_cry_13_Z, CC => NET_CC_CONFIG54, P => 
        NET_CC_CONFIG51, Y3 => NET_CC_CONFIG52, Y3A => 
        NET_CC_CONFIG53);
    
    pi_0_cry_5 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[5]\, B => \k3r[5]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_4_Z, S => \pi[5]\, Y => 
        OPEN, FCO => pi_0_cry_5_Z, CC => NET_CC_CONFIG87, P => 
        NET_CC_CONFIG84, Y3 => NET_CC_CONFIG85, Y3A => 
        NET_CC_CONFIG86);
    
    aai_0_cry_0_CC_0 : CC_CONFIG
      port map(CI => ADLIB_GND, CO => OPEN, P(0) => 
        NET_CC_CONFIG193, P(1) => NET_CC_CONFIG197, P(2) => 
        NET_CC_CONFIG201, P(3) => NET_CC_CONFIG205, P(4) => 
        NET_CC_CONFIG209, P(5) => NET_CC_CONFIG213, P(6) => 
        NET_CC_CONFIG217, P(7) => NET_CC_CONFIG221, P(8) => 
        ADLIB_VCC, P(9) => ADLIB_VCC, P(10) => ADLIB_VCC, P(11)
         => ADLIB_VCC, Y3(0) => NET_CC_CONFIG194, Y3(1) => 
        NET_CC_CONFIG198, Y3(2) => NET_CC_CONFIG202, Y3(3) => 
        NET_CC_CONFIG206, Y3(4) => NET_CC_CONFIG210, Y3(5) => 
        NET_CC_CONFIG214, Y3(6) => NET_CC_CONFIG218, Y3(7) => 
        NET_CC_CONFIG222, Y3(8) => ADLIB_VCC, Y3(9) => ADLIB_VCC, 
        Y3(10) => ADLIB_VCC, Y3(11) => ADLIB_VCC, Y3A(0) => 
        NET_CC_CONFIG195, Y3A(1) => NET_CC_CONFIG199, Y3A(2) => 
        NET_CC_CONFIG203, Y3A(3) => NET_CC_CONFIG207, Y3A(4) => 
        NET_CC_CONFIG211, Y3A(5) => NET_CC_CONFIG215, Y3A(6) => 
        NET_CC_CONFIG219, Y3A(7) => NET_CC_CONFIG223, Y3A(8) => 
        ADLIB_VCC, Y3A(9) => ADLIB_VCC, Y3A(10) => ADLIB_VCC, 
        Y3A(11) => ADLIB_VCC, CC(0) => NET_CC_CONFIG196, CC(1)
         => NET_CC_CONFIG200, CC(2) => NET_CC_CONFIG204, CC(3)
         => NET_CC_CONFIG208, CC(4) => NET_CC_CONFIG212, CC(5)
         => NET_CC_CONFIG216, CC(6) => NET_CC_CONFIG220, CC(7)
         => NET_CC_CONFIG224, CC(8) => nc6, CC(9) => nc109, 
        CC(10) => nc87, CC(11) => nc123);
    
    AFLSDF_INV_26 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_26\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_23\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_17\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_19 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_19\);
    
    AFLSDF_INV_142 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[15]\, 
        Y => \AFLSDF_INV_142\);
    
    \p_imag_obuf[11]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(11), D => \p_imag_obuf[11]/DOUT\, E
         => \p_imag_obuf[11]/EOUT\);
    
    \REG_IN_BI/Q[1]\ : SLE
      port map(D => \b_imag_c[1]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_228\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \bi[1]\);
    
    AFLSDF_INV_91 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_91\);
    
    \REG_OUT_R/Q[1]\ : SLE
      port map(D => \p[1]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_159\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[1]\);
    
    \b_real_ibuf[7]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \b_real_c[7]\, E => ADLIB_GND, YIN => 
        \b_real_ibuf[7]/YIN\);
    
    AFLSDF_INV_69 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[13]\, 
        Y => \AFLSDF_INV_69\);
    
    \p_imag_obuf[6]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[6]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[6]/DOUT\, EOUT => \p_imag_obuf[6]/EOUT\);
    
    \p_imag_obuf[4]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(4), D => \p_imag_obuf[4]/DOUT\, E
         => \p_imag_obuf[4]/EOUT\);
    
    \p_imag_obuf[12]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_imag(12), D => \p_imag_obuf[12]/DOUT\, E
         => \p_imag_obuf[12]/EOUT\);
    
    AFLSDF_INV_224 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[0]\, 
        Y => \AFLSDF_INV_224\);
    
    \p_imag_obuf[0]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_imag_c[0]\, E => ADLIB_VCC, DOUT => 
        \p_imag_obuf[0]/DOUT\, EOUT => \p_imag_obuf[0]/EOUT\);
    
    \k1_mulonly_0[15:0]/MACC_PHYS_INST/FF_11\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_80 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[2]\, 
        Y => \AFLSDF_INV_80\);
    
    \p_real_obuf[11]/U_IOPAD\ : IOPAD_TRI
      port map(PAD => p_real(11), D => \p_real_obuf[11]/DOUT\, E
         => \p_real_obuf[11]/EOUT\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_0\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[0]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[0]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_74 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/D_net[8]\, 
        Y => \AFLSDF_INV_74\);
    
    \p_real_obuf[3]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[3]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[3]/DOUT\, EOUT => \p_real_obuf[3]/EOUT\);
    
    \a_imag_ibuf[7]/U_IOIN\ : IOIN_IB_E
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(Y => \a_imag_c[7]\, E => ADLIB_GND, YIN => 
        \a_imag_ibuf[7]/YIN\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_10\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[5]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[5]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    AFLSDF_INV_148 : INV_BA
      port map(A => \k1_mulonly_0[15:0]/MACC_PHYS_INST/D_net[9]\, 
        Y => \AFLSDF_INV_148\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/CFG_12\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_imag_c[6]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k2_mulonly_0[15:0]/MACC_PHYS_INST/A_net[6]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    \b_imag_ibuf[3]/U_IOPAD\ : IOPAD_IN
      port map(PAD => b_imag(3), Y => \b_imag_ibuf[3]/YIN\);
    
    of_p : CFG3
      generic map(INIT => x"42")

      port map(A => \k1r[15]\, B => \p[15]\, C => \k2r[15]\, Y
         => of_p_Z);
    
    \p_real_obuf[1]/U_IOTRI\ : IOTRI_OB_EB
      generic map(TX_MODE => "000" & x"0", RX_MODE => x"0",
         TX_OE_MODE => "000", INPUT_DELAY_SEL => "00",
         DELAY_LINE_MODE => "00", RX_DELAY_VAL => "000" & x"0",
         RX_DELAY_VAL_X2 => "0", TX_DELAY_VAL => "000" & x"0")

      port map(D => \p_real_c[1]\, E => ADLIB_VCC, DOUT => 
        \p_real_obuf[1]/DOUT\, EOUT => \p_real_obuf[1]/EOUT\);
    
    AFLSDF_INV_170 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_170\);
    
    \REG_IN_BI/Q[7]\ : SLE
      port map(D => \b_imag_c[7]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_83\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \bi[7]\);
    
    \REG_OUT_I/Q[1]\ : SLE
      port map(D => \pi[1]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_8\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_imag_c[1]\);
    
    pi_0_cry_12 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[12]\, B => \k3r[12]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_11_Z, S => \pi[12]\, Y => 
        OPEN, FCO => pi_0_cry_12_Z, CC => NET_CC_CONFIG115, P => 
        NET_CC_CONFIG112, Y3 => NET_CC_CONFIG113, Y3A => 
        NET_CC_CONFIG114);
    
    \a_real_ibuf[1]/U_IOPAD\ : IOPAD_IN
      port map(PAD => a_real(1), Y => \a_real_ibuf[1]/YIN\);
    
    AFLSDF_INV_4 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_4\);
    
    \REG_IN_AI/Q[2]\ : SLE
      port map(D => \a_imag_c[2]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_160\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \ai[2]\);
    
    aai_0_cry_4 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \a[4]\, B => \ai[4]\, C => ADLIB_GND, D => 
        ADLIB_GND, FCI => aai_0_cry_3_Z, S => \aai[4]\, Y => OPEN, 
        FCO => aai_0_cry_4_Z, CC => NET_CC_CONFIG212, P => 
        NET_CC_CONFIG209, Y3 => NET_CC_CONFIG210, Y3A => 
        NET_CC_CONFIG211);
    
    AFLSDF_INV_166 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_166\);
    
    pi_0_cry_3 : ARI1_CC
      generic map(INIT => x"555AA")

      port map(A => \k1r[3]\, B => \k3r[3]\, C => ADLIB_GND, D
         => ADLIB_GND, FCI => pi_0_cry_2_Z, S => \pi[3]\, Y => 
        OPEN, FCO => pi_0_cry_3_Z, CC => NET_CC_CONFIG79, P => 
        NET_CC_CONFIG76, Y3 => NET_CC_CONFIG77, Y3A => 
        NET_CC_CONFIG78);
    
    AFLSDF_INV_58 : INV_BA
      port map(A => \k3_mulonly_0[15:0]/MACC_PHYS_INST/C_net[6]\, 
        Y => \AFLSDF_INV_58\);
    
    \REG_IN_B/Q[2]\ : SLE
      port map(D => \b_real_c[2]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_26\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \b[2]\);
    
    \k2_mulonly_0[15:0]/MACC_PHYS_INST/FF_17\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_214 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/D_net[10]\, 
        Y => \AFLSDF_INV_214\);
    
    \REG_IN_B/Q[6]\ : SLE
      port map(D => \b_real_c[6]\, CLK => NN_1, EN => en_c, ALn
         => \AFLSDF_INV_91\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, 
        SD => ADLIB_GND, LAT => ADLIB_GND, Q => \b[6]\);
    
    \REG_OUT_R/Q[3]\ : SLE
      port map(D => \p[3]\, CLK => NN_1, EN => en_c, ALn => 
        \AFLSDF_INV_92\, ADn => ADLIB_VCC, SLn => ADLIB_VCC, SD
         => ADLIB_GND, LAT => ADLIB_GND, Q => \p_real_c[3]\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/FF_9\ : SLE_IP_EN
      port map(EN => ADLIB_VCC, IPEN => OPEN);
    
    AFLSDF_INV_164 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_164\);
    
    AFLSDF_INV_14 : INV_BA
      port map(A => rst_c, Y => \AFLSDF_INV_14\);
    
    AFLSDF_INV_190 : INV_BA
      port map(A => \k2_mulonly_0[15:0]/MACC_PHYS_INST/C_net[19]\, 
        Y => \AFLSDF_INV_190\);
    
    \k3_mulonly_0[15:0]/MACC_PHYS_INST/CFG_8\ : CFG4_IP_ABCD
      generic map(INIT => x"AAAA")

      port map(A => \b_real_c[4]\, B => ADLIB_VCC, C => ADLIB_VCC, 
        D => ADLIB_VCC, Y => 
        \k3_mulonly_0[15:0]/MACC_PHYS_INST/A_net[4]\, IPB => OPEN, 
        IPC => OPEN, IPD => OPEN);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
