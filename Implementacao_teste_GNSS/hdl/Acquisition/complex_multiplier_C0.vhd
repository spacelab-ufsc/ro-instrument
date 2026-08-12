----------------------------------------------------------------------
-- Created by SmartDesign Sun Oct  5 12:17:37 2025
-- Version: 2024.2 2024.2.0.13
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Component Description (Tcl) 
----------------------------------------------------------------------
--# Exporting Component Description of complex_multiplier_C0 to TCL
--# Family: PolarFireSoC
--# Part Number: MPFS025T-1FCSG325E
--# Create and Configure the core component complex_multiplier_C0
--create_and_configure_core -core_vlnv {Microsemi:SolutionCore:complex_multiplier:1.0.27} -component_name {complex_multiplier_C0} -params {\
--"g_3DSP:true"  \
--"g_AWIDTH:10"  \
--"g_BWIDTH:10"  \
--"g_CWIDTH:33"  \
--"g_DOROUND:false"   }
--# Exporting Component Description of complex_multiplier_C0 to TCL done

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library polarfire;
use polarfire.all;
----------------------------------------------------------------------
-- complex_multiplier_C0 entity declaration
----------------------------------------------------------------------
entity complex_multiplier_C0 is
    -- Port list
    port(
        -- Inputs
        aimag_i  : in  std_logic_vector(9 downto 0);
        areal_i  : in  std_logic_vector(9 downto 0);
        bimag_i  : in  std_logic_vector(9 downto 0);
        breal_i  : in  std_logic_vector(9 downto 0);
        clock_i  : in  std_logic;
        nreset_i : in  std_logic;
        -- Outputs
        cimag_o  : out std_logic_vector(20 downto 0);
        creal_o  : out std_logic_vector(20 downto 0)
        );
end complex_multiplier_C0;
----------------------------------------------------------------------
-- complex_multiplier_C0 architecture body
----------------------------------------------------------------------
architecture RTL of complex_multiplier_C0 is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- complex_multiplier   -   Microsemi:SolutionCore:complex_multiplier:1.0.27
component complex_multiplier
    generic( 
        g_3DSP    : integer := 1 ;
        g_AWIDTH  : integer := 10 ;
        g_BWIDTH  : integer := 10 ;
        g_CWIDTH  : integer := 21 ;
        g_DOROUND : integer := 0 
        );
    -- Port list
    port(
        -- Inputs
        aimag_i  : in  std_logic_vector(9 downto 0);
        areal_i  : in  std_logic_vector(9 downto 0);
        bimag_i  : in  std_logic_vector(9 downto 0);
        breal_i  : in  std_logic_vector(9 downto 0);
        clock_i  : in  std_logic;
        nreset_i : in  std_logic;
        -- Outputs
        cimag_o  : out std_logic_vector(20 downto 0);
        creal_o  : out std_logic_vector(20 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal cimag_o_net_0 : std_logic_vector(20 downto 0);
signal creal_o_net_0 : std_logic_vector(20 downto 0);
signal creal_o_net_1 : std_logic_vector(20 downto 0);
signal cimag_o_net_1 : std_logic_vector(20 downto 0);

begin
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 creal_o_net_1        <= creal_o_net_0;
 creal_o(20 downto 0) <= creal_o_net_1;
 cimag_o_net_1        <= cimag_o_net_0;
 cimag_o(20 downto 0) <= cimag_o_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- complex_multiplier_C0_0   -   Microsemi:SolutionCore:complex_multiplier:1.0.27
complex_multiplier_C0_0 : complex_multiplier
    generic map( 
        g_3DSP    => ( 1 ),
        g_AWIDTH  => ( 10 ),
        g_BWIDTH  => ( 10 ),
        g_CWIDTH  => ( 21 ),
        g_DOROUND => ( 0 )
        )
    port map( 
        -- Inputs
        clock_i  => clock_i,
        nreset_i => nreset_i,
        areal_i  => areal_i,
        aimag_i  => aimag_i,
        breal_i  => breal_i,
        bimag_i  => bimag_i,
        -- Outputs
        creal_o  => creal_o_net_0,
        cimag_o  => cimag_o_net_0 
        );

end RTL;
