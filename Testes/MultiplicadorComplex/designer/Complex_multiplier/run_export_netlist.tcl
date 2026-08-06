set_device -fam PolarFireSoC
read_verilog -top_module_name {Complex_multiplier} \
    -file {/home/tuzinho/Desktop/ro-instrument/Testes/MultiplicadorComplex/synthesis/Complex_multiplier.vm}
write_vhdl -file {/home/tuzinho/Desktop/ro-instrument/Testes/MultiplicadorComplex/synthesis/Complex_multiplier.vhd}
