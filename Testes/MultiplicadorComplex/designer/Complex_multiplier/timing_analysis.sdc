# Microchip Technology Inc.
# Date: 2026-Aug-07 17:15:37
# This file was generated based on the following SDC source files:
#   /home/rian/Documents/RO/Testes/MultiplicadorComplex/constraint/timing_160mhz.sdc
#

create_clock -name {clk} -period 6.25 -waveform {0 3.125 } [ get_ports { clk } ]
set_clock_jitter 0.00221119 [ get_clocks { clk } ]
