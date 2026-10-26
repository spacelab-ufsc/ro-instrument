----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Sun Oct 25 19:02:53 2026
-- Parameters for COREDDS
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant COS_ON : integer := 1;
    constant COS_POLARITY : integer := 0;
    constant DIE_SIZE : integer := 15;
    constant FAMILY : integer := 27;
    constant FPGA_FAMILY : integer := 27;
    constant FREQ_OFFSET_BITS : integer := 5;
    constant LATENCY : integer := 0;
    constant MAX_FULL_WAVE_LOGDEPTH : integer := 9;
    constant OUTPUT_BITS : integer := 4;
    constant PH_ACC_BITS : integer := 20;
    constant PH_CORRECTION : integer := 0;
    constant PH_INC_LOWER : integer := 1000000;
    constant PH_INC_MODE : integer := 1;
    constant PH_INC_UPPER : integer := 0;
    constant PH_OFFSET_BITS : integer := 3;
    constant PH_OFFSET_CONST_LOWER : integer := 1;
    constant PH_OFFSET_CONST_UPPER : integer := 0;
    constant PH_OFFSET_MODE : integer := 0;
    constant QUANTIZER_BITS : integer := 12;
    constant SIN_ON : integer := 1;
    constant SIN_POLARITY : integer := 0;
    constant testbench : integer := 1;
    constant URAM_MAXDEPTH : integer := 0;
end coreparameters;
