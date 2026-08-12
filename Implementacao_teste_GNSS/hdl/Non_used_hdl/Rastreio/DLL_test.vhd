--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: DLL_test.vhd
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

use IEEE.std_logic_1164.all;

entity DLL_test is
port (
    clk     : in std_logic;
    reset   : in std_logic;
    SAT_ID  : in integer range 0 to 31;
    IE_corr : in  signed(15 downto 0);
    QE_corr	: in  signed(15 downto 0);
    IP_corr : in  signed(15 downto 0);
    QP_corr	: in  signed(15 downto 0);
    IL_corr : in  signed(15 downto 0);
    QL_corr	: in  signed(15 downto 0);
    early   : out std_logic;
    prompt  : out std_logic;
    late    : out std_logic;
);
end DLL_test;
architecture architecture_DLL_test of DLL_test is
	signal code_error : signed(15 downto 0); -- example
	signal filtered_error : signed(15 downto 0);
    signal frequency_control: unsigned(31 downto 0);
    signal nco_out : std_logic;
    signal PRN_valid : std_logic; -- example
    
    component Code_Discriminator_test is
    generic(
		Discriminator_Type : integer := 1
        data_width : integer := 16
	);
	Port ( 
		IE_corr 	: in  signed(data_width-1 downto 0);
		QE_corr		: in  signed(data_width-1 downto 0);
		IP_corr 	: in  signed(data_width-1 downto 0);
		QP_corr		: in  signed(data_width-1 downto 0);
		IL_corr 	: in  signed(data_width-1 downto 0);
		QL_corr		: in  signed(data_width-1 downto 0);
		discriminator   : out signed(data_width-1 downto 0)
	);
    end component;
    
    component PRN_Early_Prompt_Late is
    Port ( 
        clk        	: in  std_logic;
        reset      	: in  std_logic;
        enable		: in  std_logic;
        early_code 	: out std_logic;
        prompt_code	: out std_logic;
        late_code  	: out std_logic;
        valid_out	: out std_logic;
        SAT		    : in integer range 0 to 31 
    );
    end component;
    
    component NCO_test is
    generic(
		phase_width	: integer := 32
	);
	Port ( 
		clk	        : in std_logic;
		reset		: in std_logic;
		phase_diff  : in unsigned(phase_width-1 downto 0);
		nco_out   	: out std_logic;
	);
    end component;
    
    component Code_Loop_Filter is
    generic(
		WIDTH : integer := 16;
        Kp    : integer := 0; --ajustar o ganho
        Ki    : integer := 0; --ajustar o ganho
    );
	Port ( 
		clk             : in  std_logic;
		reset           : in  std_logic;
		input_error     : in  std_logic_vector(WIDTH-1 downto 0);
		filtered_out    : out std_logic_vector(WIDTH-1 downto 0)
	);
    end component;

begin
    
end architecture_DLL_test;
