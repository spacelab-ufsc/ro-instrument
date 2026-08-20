# Written by Synplify Pro version map202309act, Build 395R. Synopsys Run ID: sid1787222613 
# Top Level Design Parameters 

# Clocks 
create_clock -period 10.000 -waveform {0.000 5.000} -name {DDS_PNFreq|CLK} [get_ports {CLK}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {dds_kitCountS_2s_3s_1s|N_5_inferred_clock} [get_pins {SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/dc/Y}] 

# Virtual Clocks 

# Generated Clocks 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set Inferred_clkgroup_0 [list DDS_PNFreq|CLK]
set Inferred_clkgroup_1 [list dds_kitCountS_2s_3s_1s|N_5_inferred_clock]
set_clock_groups -asynchronous -group $Inferred_clkgroup_0
set_clock_groups -asynchronous -group $Inferred_clkgroup_1

set_clock_groups -asynchronous -group [get_clocks {DDS_PNFreq|CLK}]
set_clock_groups -asynchronous -group [get_clocks {dds_kitCountS_2s_3s_1s|N_5_inferred_clock}]

# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 


# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

