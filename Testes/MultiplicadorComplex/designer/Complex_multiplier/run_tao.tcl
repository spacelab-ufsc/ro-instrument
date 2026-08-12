set_device -family {PolarFireSoC} -die {MPFS025T} -speed {STD}
read_vhdl -mode vhdl_2008 {/home/rian/Documents/RO/Testes/MultiplicadorComplex/hdl/reg16.vhd}
read_vhdl -mode vhdl_2008 {/home/rian/Documents/RO/Testes/MultiplicadorComplex/hdl/reg_signed.vhd}
read_vhdl -mode vhdl_2008 {/home/rian/Documents/RO/Testes/MultiplicadorComplex/hdl/Complex_multiplier.vhd}
set_top_level {Complex_multiplier}
map_netlist
read_sdc {/home/rian/Documents/RO/Testes/MultiplicadorComplex/constraint/timing_160mhz.sdc}
check_constraints {/home/rian/Documents/RO/Testes/MultiplicadorComplex/constraint/synthesis_sdc_errors.log}
write_fdc {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/synthesis.fdc}
