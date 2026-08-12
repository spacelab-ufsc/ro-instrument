--------------------------------------------------------------------------------
-- Company: <Name>
--
-- File: Tracking_test.vhd
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
use ieee.numeric_std.all

entity Tracking_test is
port (
	port_name1 : IN  std_logic; -- example
    port_name2 : OUT std_logic_vector(1 downto 0)  -- example
);
end Tracking_test;
architecture architecture_Tracking_test of Tracking_test is
	signal signal_name1 : std_logic; -- example
	signal signal_name2 : std_logic_vector(1 downto 0) ; -- example
    
    component COREDDS_C1 is
    -- Port list
    port(
        -- Inputs
        CLK            : in  std_logic;
        FREQ_OFFSET    : in  std_logic_vector(4 downto 0);
        FREQ_OFFSET_WE : in  std_logic;
        INIT           : in  std_logic;
        NGRST          : in  std_logic;
        RSTN           : in  std_logic;
        -- Outputs
        COSINE         : out std_logic_vector(DDS_Width-1 downto 0);
        INIT_OVER      : out std_logic;
        SINE           : out std_logic_vector(DDS_Width-1 downto 0)
        );
    end component;
    
    component UAL is
    generic(
        data_width : integer := 64
    );
    port(
        A:	in std_logic_vector(data_width-1 downto 0);
        B:	in std_logic_vector(data_width-1 downto 0);
        Cin:	in std_logic;
        
        S:	out std_logic_vector(data_width-1 downto 0);
        Cout:	out std_logic
    );
    
    component Multiplier_simplified is
    generic(
        data_width : integer := 12
    );
    port(
        -- 	Bit_Vector Inputs
        A :	in std_logic_vector(data_width-1 downto 0);
        B :	in std_logic_vector(1 downto 0);

        --	Bit_Vector Outputs
        S :	out std_logic_vector(data_width downto 0)
    );
    end component;
    
    component Integrate_Dump is
    port (
        clk      : in std_logic;
        reset    : in std_logic;
        data_in  : in signed(15 downto 0);
        dump_en  : in std_logic;
        data_out : out signed (15 downto 0);
    );
    end component;
    
    component costas_loop_C0 is
    port(
        --Inputs
        ARSTN_I        : in std_logic;
        IDATA_I        : in std_logic_vector(15 downto 0);
        KI_I           : in std_logic_vector(17 downto 0);
        KP_I           : in std_logic_vector(17 downto 0);
        LIMIT_I        : in std_logic_vector(17 downto 0);
        QDATA_I        : in std_logic_vector(15 downto 0);
        SYS_CLK_I      : in std_logic;
        THETA_FACTOR_I : in std_logic_vector (17 downto 0);
        --Outputs
        IDATA_O        : out std_logic_vector(15 downto 0);
        PI_O           : out std_logic_vector(17 downto 0);
        QDATA_O        : out std_logic_vector(15 downto 0);
        THETA_O        : out std_logic_vector(9 downto 0);
    );
    end component;
    
    component DLL_test is
    
    end component;
    
begin
    SINE_GENERATOR: COREDDS_C1 port map();
    
    MULT1: Multiplier_simplified generic map() port map();
    MULT2: Multiplier_simplified generic map() port map();
    MULT3: Multiplier_simplified generic map() port map();
    MULT4: Multiplier_simplified generic map() port map();
    MULT5: Multiplier_simplified generic map() port map();
    MULT6: Multiplier_simplified generic map() port map();
    MULT7: Multiplier_simplified generic map() port map();
    MULT8: Multiplier_simplified generic map() port map();
    MULT9: Multiplier_simplified generic map() port map();
    MULT10: Multiplier_simplified generic map() port map();
    
    SUM1:
    SUM2:
    
    
end architecture_Tracking_test;
