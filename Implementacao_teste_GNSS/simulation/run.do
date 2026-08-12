quietly set ACTELLIBNAME PolarFireSoC
quietly set PROJECT_DIR "/home/flatsat/Desktop/ro-instrument/Implementacao_teste_GNSS"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap polarfire "/home/flatsat/Microchip/Libero_SoC_2025.1/Libero_SoC/Designer/lib/modelsimpro/precompiled/vlog/polarfire"
vmap PolarFire "/home/flatsat/Microchip/Libero_SoC_2025.1/Libero_SoC/Designer/lib/modelsimpro/precompiled/vlog/polarfire"
if {[file exists COREFFT_LIB/_info]} {
   echo "INFO: Simulation library COREFFT_LIB already exists"
} else {
   file delete -force COREFFT_LIB 
   vlib COREFFT_LIB
}
vmap COREFFT_LIB "COREFFT_LIB"
if {[file exists COREDDS_LIB/_info]} {
   echo "INFO: Simulation library COREDDS_LIB already exists"
} else {
   file delete -force COREDDS_LIB 
   vlib COREDDS_LIB
}
vmap COREDDS_LIB "COREDDS_LIB"

vlog -sv -work COREDDS_LIB "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0_0/COREDDS_C0_COREDDS_C0_0_dds_qrtr_cos.v"
vlog -sv -work COREDDS_LIB "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0_0/COREDDS_C0_COREDDS_C0_0_dds_qrtr_sin.v"
vlog -sv -work COREDDS_LIB "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0_0/rtl/vlog/core/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram.v"
vlog -sv -work COREDDS_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREDDS/4.0.108/rtl/vlog/core/dds_kit.v"
vlog -sv -work COREDDS_LIB "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0_0/rtl/vlog/core/lut.v"
vlog -sv -work COREDDS_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREDDS/4.0.108/rtl/vlog/core/dds_module.v"
vlog -sv -work COREDDS_LIB "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0_0/rtl/vlog/core/DDS_TOP.v"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/COREDDS_C0.vhd"
vlog -sv -work COREFFT_LIB "${PROJECT_DIR}/component/work/COREFFT_C2/COREFFT_C2_0/COREFFT_C2_COREFFT_C2_0_lsram_g5.v"
vlog -sv -work COREFFT_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREFFT/8.1.100/rtl/in_place/vlog/core/kit.v"
vlog -sv -work COREFFT_LIB "${PROJECT_DIR}/component/work/COREFFT_C2/COREFFT_C2_0/rtl/in_place/vlog/core/fftDp.v"
vlog -sv -work COREFFT_LIB "${PROJECT_DIR}/component/work/COREFFT_C2/COREFFT_C2_0/twiddle32.v"
vlog -sv -work COREFFT_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREFFT/8.1.100/rtl/in_place/vlog/core/mac_lib.v"
vlog -sv -work COREFFT_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREFFT/8.1.100/rtl/in_place/vlog/core/cmplx.v"
vlog -sv -work COREFFT_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREFFT/8.1.100/rtl/in_place/vlog/core/fftSm.v"
vlog -sv -work COREFFT_LIB "${PROJECT_DIR}/component/work/COREFFT_C2/COREFFT_C2_0/rtl/in_place/vlog/core/COREFFT.v"
vlog -sv -work COREFFT_LIB "${PROJECT_DIR}/component/work/COREFFT_C2/COREFFT_C2_0/rtl/in_place/vlog/core/COREFFT_TOP.v"
vlog -sv -work presynth "${PROJECT_DIR}/component/work/COREFFT_C2/COREFFT_C2.v"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/Flip_Flop_D.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/LFSR_generator.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/L1_CA_generator.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/complex_multiplier_C0.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/Negative_Integer.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/contador.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/Acquisition-Renato.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/Acquisition.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/stimulus/Acquisition_TestBench.vhd"

vsim -L polarfire -L presynth -L COREFFT_LIB -L COREDDS_LIB  -t 1ps -pli /home/flatsat/Microchip/Libero_SoC_2025.1/Libero_SoC/Designer/lib/modelsimpro/pli/pf_crypto_lin_me_pli.so presynth.Acquisition_TestBench
add wave /Acquisition_TestBench/*
run 1000ns
