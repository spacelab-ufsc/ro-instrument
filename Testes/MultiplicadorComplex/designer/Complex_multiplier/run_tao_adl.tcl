set_device -family {PolarFireSoC} -die {MPFS025T} -speed {STD}
read_adl {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/Complex_multiplier.adl}
read_afl {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/Complex_multiplier.afl}
map_netlist
read_sdc {/home/rian/Documents/RO/Testes/MultiplicadorComplex/constraint/timing_160mhz.sdc}
check_constraints {/home/rian/Documents/RO/Testes/MultiplicadorComplex/constraint/placer_sdc_errors.log}
estimate_jitter -report {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/place_and_route_jitter_report.txt}
write_sdc -mode layout {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/place_route.sdc}
