quietly set ACTELLIBNAME PolarFireSoC
quietly set PROJECT_DIR "/home/rian/Documents/RO/Testes/MultiplicadorComplex"

if {[file exists ../designer/Complex_multiplier/simulation/postlayout/_info]} {
   echo "INFO: Simulation library ../designer/Complex_multiplier/simulation/postlayout already exists"
} else {
   file delete -force ../designer/Complex_multiplier/simulation/postlayout 
   vlib ../designer/Complex_multiplier/simulation/postlayout
}
vmap postlayout ../designer/Complex_multiplier/simulation/postlayout
vmap polarfire "/home/rian/Microchip/Libero_SoC_2025.1/Libero_SoC/Designer/lib/modelsimpro/precompiled/vlog/polarfire"

vcom -2008 -explicit  -work postlayout "${PROJECT_DIR}/designer/Complex_multiplier/Complex_multiplier_ba.vhd"
vcom -2008 -explicit  -work postlayout "${PROJECT_DIR}/stimulus/Testbench_Complex_multiplier.vhd"

vsim -L polarfire -L postlayout  -t 1ps -pli /home/rian/Microchip/Libero_SoC_2025.1/Libero_SoC/Designer/lib/modelsimpro/pli/pf_crypto_lin_me_pli.so -sdfmax /Complex_multiplier_0=${PROJECT_DIR}/designer/Complex_multiplier/Complex_multiplier_slow_lv_ht_ba.sdf +transport_path_delays postlayout.Testbench_Complex_multiplier
add wave /Testbench_Complex_multiplier/*
run 1000ns
