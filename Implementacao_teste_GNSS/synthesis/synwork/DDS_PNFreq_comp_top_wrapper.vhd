--
-- Synopsys
-- Vhdl wrapper for top level design, written on Thu Aug 20 07:43:03 2026
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity wrapper_for_DDS_PNFreq is
   port (
      CLK : in std_logic;
      FREQ_OFFSET : in std_logic_vector(4 downto 0);
      NGRST : in std_logic;
      RSTN : in std_logic;
      PN_SIN : in std_logic;
      COSINE : out std_logic_vector(3 downto 0);
      SINE : out std_logic_vector(3 downto 0)
   );
end wrapper_for_DDS_PNFreq;

architecture behavioral of wrapper_for_DDS_PNFreq is

component DDS_PNFreq
 port (
   CLK : in std_logic;
   FREQ_OFFSET : in std_logic_vector (4 downto 0);
   NGRST : in std_logic;
   RSTN : in std_logic;
   PN_SIN : in std_logic;
   COSINE : out std_logic_vector (3 downto 0);
   SINE : out std_logic_vector (3 downto 0)
 );
end component;

signal tmp_CLK : std_logic;
signal tmp_FREQ_OFFSET : std_logic_vector (4 downto 0);
signal tmp_NGRST : std_logic;
signal tmp_RSTN : std_logic;
signal tmp_PN_SIN : std_logic;
signal tmp_COSINE : std_logic_vector (3 downto 0);
signal tmp_SINE : std_logic_vector (3 downto 0);

begin

tmp_CLK <= CLK;

tmp_FREQ_OFFSET <= FREQ_OFFSET;

tmp_NGRST <= NGRST;

tmp_RSTN <= RSTN;

tmp_PN_SIN <= PN_SIN;

COSINE <= tmp_COSINE;

SINE <= tmp_SINE;



u1:   DDS_PNFreq port map (
		CLK => tmp_CLK,
		FREQ_OFFSET => tmp_FREQ_OFFSET,
		NGRST => tmp_NGRST,
		RSTN => tmp_RSTN,
		PN_SIN => tmp_PN_SIN,
		COSINE => tmp_COSINE,
		SINE => tmp_SINE
       );
end behavioral;
