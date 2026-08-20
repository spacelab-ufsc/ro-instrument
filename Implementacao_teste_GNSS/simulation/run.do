quietly set ACTELLIBNAME PolarFireSoC
quietly set PROJECT_DIR "C:/Users/renat/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   file delete -force presynth 
   vlib presynth
}
vmap presynth presynth
vmap polarfire "C:/Microchip/Libero_SoC_2025.1/Libero_SoC/Designer/lib/modelsimpro/precompiled/vlog/polarfire"
vmap PolarFire "C:/Microchip/Libero_SoC_2025.1/Libero_SoC/Designer/lib/modelsimpro/precompiled/vlog/polarfire"
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
vlog -sv -work presynth "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0.v"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/Negative_Integer.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/renat/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/DDS_PNFreq.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/stimulus/DDS_PNFreq_tb.vhd"

vsim -L polarfire -L presynth -L COREFFT_LIB -L COREDDS_LIB  -t 1ps -pli C:/Microchip/Libero_SoC_2025.1/Libero_SoC/Designer/lib/modelsimpro/pli/pf_crypto_win_me_pli.dll presynth.DDS_PNFreq_tb
add wave /DDS_PNFreq_tb/*
run 1000ns
