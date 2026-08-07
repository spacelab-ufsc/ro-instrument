set_device -family {PolarFireSoC} -die {MPFS025T} -speed {STD}
read_adl {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/Complex_multiplier.adl}
read_afl {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/Complex_multiplier.afl}
map_netlist
read_sdc {/home/rian/Documents/RO/Testes/MultiplicadorComplex/constraint/timing_160mhz.sdc}
check_constraints {/home/rian/Documents/RO/Testes/MultiplicadorComplex/constraint/timing_sdc_errors.log}
estimate_jitter -report {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/timing_analysis_jitter_report.txt}
write_sdc -mode smarttime {/home/rian/Documents/RO/Testes/MultiplicadorComplex/designer/Complex_multiplier/timing_analysis.sdc}
