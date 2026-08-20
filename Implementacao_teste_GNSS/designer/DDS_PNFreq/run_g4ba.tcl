set_device \
    -family  PolarFireSoC \
    -die     PA5SOC025T \
    -package fcvg484 \
    -speed   STD \
    -tempr   {EXT} \
    -voltr   {EXT}
set_def {VOLTAGE} {1.0}
set_def {VCCI_1.2_VOLTR} {EXT}
set_def {VCCI_1.5_VOLTR} {EXT}
set_def {VCCI_1.8_VOLTR} {EXT}
set_def {VCCI_2.5_VOLTR} {EXT}
set_def {VCCI_3.3_VOLTR} {EXT}
set_operating_conditions -name {slow_lv_lt}
set_operating_conditions -name {slow_lv_ht}
set_operating_conditions -name {fast_hv_lt}
set_name DDS_PNFreq
set_workdir {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\designer\DDS_PNFreq}
set_filename    {C:\Users\renat\OneDrive\Documentos\ro-instrument\Implementacao_teste_GNSS\designer\DDS_PNFreq\DDS_PNFreq_ba}
set_design_state post_layout
set_language verilog
