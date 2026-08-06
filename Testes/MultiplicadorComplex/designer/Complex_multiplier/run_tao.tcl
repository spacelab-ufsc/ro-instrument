set_device -family {PolarFireSoC} -die {MPFS025T} -speed {STD}
read_vhdl -mode vhdl_2008 {/home/tuzinho/Desktop/ro-instrument/Testes/MultiplicadorComplex/hdl/reg16.vhd}
read_vhdl -mode vhdl_2008 {/home/tuzinho/Desktop/ro-instrument/Testes/MultiplicadorComplex/hdl/reg_signed.vhd}
read_vhdl -mode vhdl_2008 {/home/tuzinho/Desktop/ro-instrument/Testes/MultiplicadorComplex/hdl/Complex_multiplier.vhd}
set_top_level {Complex_multiplier}
map_netlist
check_constraints {/home/tuzinho/Desktop/ro-instrument/Testes/MultiplicadorComplex/constraint/synthesis_sdc_errors.log}
write_fdc {/home/tuzinho/Desktop/ro-instrument/Testes/MultiplicadorComplex/designer/Complex_multiplier/synthesis.fdc}
