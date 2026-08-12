# Microchip Technology Inc.
# Date: 2026-Aug-07 17:13:50
# This file was generated based on the following SDC source files:
#   /home/rian/Documents/RO/Testes/MultiplicadorComplex/constraint/timing_160mhz.sdc
#

create_clock -name {clk} -period 6.25 -waveform {0 3.125 } [ get_ports { clk } ]
set_clock_uncertainty 0.00221119 [ get_clocks { clk } ]
set_clock_uncertainty -hold 0 -rise_from [ get_clocks { clk } ] -rise_to [ get_clocks { clk } ]
set_clock_uncertainty -hold 0 -fall_from [ get_clocks { clk } ] -fall_to [ get_clocks { clk } ]
