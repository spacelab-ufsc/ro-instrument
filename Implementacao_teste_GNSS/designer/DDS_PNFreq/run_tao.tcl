set_device -family {PolarFireSoC} -die {MPFS025T} -speed {STD}
read_verilog -mode system_verilog -lib COREDDS_LIB {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\component\work\COREDDS_C0\COREDDS_C0_0\COREDDS_C0_COREDDS_C0_0_dds_qrtr_cos.v}
read_verilog -mode system_verilog -lib COREDDS_LIB {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\component\work\COREDDS_C0\COREDDS_C0_0\COREDDS_C0_COREDDS_C0_0_dds_qrtr_sin.v}
read_verilog -mode system_verilog -lib COREDDS_LIB {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\component\work\COREDDS_C0\COREDDS_C0_0\rtl\vlog\core\COREDDS_C0_COREDDS_C0_0_dds_g5_lsram.v}
read_verilog -mode system_verilog -lib COREDDS_LIB {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\component\Actel\DirectCore\COREDDS\4.0.108\rtl\vlog\core\dds_kit.v}
read_verilog -mode system_verilog -lib COREDDS_LIB {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\component\work\COREDDS_C0\COREDDS_C0_0\rtl\vlog\core\lut.v}
read_verilog -mode system_verilog -lib COREDDS_LIB {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\component\Actel\DirectCore\COREDDS\4.0.108\rtl\vlog\core\dds_module.v}
read_verilog -mode system_verilog -lib COREDDS_LIB {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\component\work\COREDDS_C0\COREDDS_C0_0\rtl\vlog\core\DDS_TOP.v}
read_verilog -mode system_verilog {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\component\work\COREDDS_C0\COREDDS_C0.v}
read_vhdl -mode vhdl_2008 {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\hdl\Negative_Integer.vhd}
read_vhdl -mode vhdl_2008 {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\hdl\Common\DDS_PNFreq.vhd}
set_top_level {DDS_PNFreq}
map_netlist
check_constraints {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\constraint\synthesis_sdc_errors.log}
write_fdc {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\designer\DDS_PNFreq\synthesis.fdc}
