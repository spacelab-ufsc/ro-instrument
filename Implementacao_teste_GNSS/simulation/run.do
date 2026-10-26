quietly set ACTELLIBNAME PolarFireSoC
quietly set PROJECT_DIR "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS"

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

vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/Flip_Flop_D.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/Microsemi/SolutionCore/complex_multiplier/1.0.27/obfuscate/round_sat.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/Microsemi/SolutionCore/complex_multiplier/1.0.27/obfuscate/complex_multiplier.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/complex_multiplier_C2/complex_multiplier_C2.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/Counters/contador.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/Register.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/Somador.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/Negative_Integer.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Acquisition/Acquisition_Detection.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/COREFFT_C2/COREFFT_C2.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/COREFFT_C4/COREFFT_C4.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/complex_multiplier_C0/complex_multiplier_C0.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/Clock_Control/TFF.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/Counters/counter_en_srst.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/Clock_Control/Freq_divider.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Acquisition/FFT_Correlator.vhd"
vcom -2008 -explicit  -work COREDDS_LIB "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0_0/rtl/vhdl/core/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram.vhd"
vcom -2008 -explicit  -work COREDDS_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREDDS/4.0.108/rtl/vhdl/core/dds_rtl_pack.vhd"
vcom -2008 -explicit  -work COREDDS_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREDDS/4.0.108/rtl/vhdl/core/dds_kit.vhd"
vcom -2008 -explicit  -work COREDDS_LIB "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0_0/rtl/vhdl/core/lut.vhd"
vcom -2008 -explicit  -work COREDDS_LIB "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0_0/COREDDS_C0_COREDDS_C0_0_dds_qrtr_cos.vhd"
vcom -2008 -explicit  -work COREDDS_LIB "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0_0/COREDDS_C0_COREDDS_C0_0_dds_qrtr_sin.vhd"
vcom -2008 -explicit  -work COREDDS_LIB "${PROJECT_DIR}/component/Actel/DirectCore/COREDDS/4.0.108/rtl/vhdl/core/dds_module.vhd"
vcom -2008 -explicit  -work COREDDS_LIB "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0_0/rtl/vhdl/core/DDS_TOP.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/component/work/COREDDS_C0/COREDDS_C0.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/Input_Chain/DDS_PNFreq.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/Multiplier_simplified.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/Input_Chain/Acquisition_Input.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/Input_Chain/GNSS_Input_chain.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/LFSR_generator.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/hdl/L1_CA_generator.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Common/reg16.vhd"
vcom -2008 -explicit  -work presynth "C:/Users/Renato/OneDrive/Documentos/ro-instrument/Implementacao_teste_GNSS/hdl/Acquisition/Acquisition_V3.vhd"
vcom -2008 -explicit  -work presynth "${PROJECT_DIR}/stimulus/Acquisition_TestBench.vhd"

vsim -L polarfire -L presynth -L COREFFT_LIB -L COREDDS_LIB  -t 1ps -pli C:/Microchip/Libero_SoC_2025.1/Libero_SoC/Designer/lib/modelsimpro/pli/pf_crypto_win_me_pli.dll presynth.Acquisition_TestBench
add wave /Acquisition_TestBench/*
run 1000ns
