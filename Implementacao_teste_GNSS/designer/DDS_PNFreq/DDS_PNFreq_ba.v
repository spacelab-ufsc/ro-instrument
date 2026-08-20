`timescale 1 ns/100 ps
// Version: 2025.1 2025.1.0.14
// File used only for Simulation


module DDS_PNFreq(
       CLK,
       FREQ_OFFSET,
       NGRST,
       RSTN,
       PN_SIN,
       COSINE,
       SINE
    );
input  CLK;
input  [4:0] FREQ_OFFSET;
input  NGRST;
input  RSTN;
input  PN_SIN;
output [3:0] COSINE;
output [3:0] SINE;

    wire \sin_signal[2] , \sin_signal[1] , \SIN_NEG_Carry_1[3] , 
        \FREQ_OFFSET_c[4] , \FREQ_OFFSET_c[3] , \FREQ_OFFSET_c[2] , 
        \FREQ_OFFSET_c[1] , \FREQ_OFFSET_c[0] , \COSINE_c[3] , 
        \COSINE_c[2] , \COSINE_c[1] , \COSINE_c[0] , \SINE_c[3] , 
        \SINE_c[2] , \SINE_c[1] , \SINE_c[0] , \I_1/U0_Y , CLK_ibuf_Z, 
        NGRST_c, RSTN_c, PN_SIN_c, 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[11] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[10] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/INIT_OVER , 
        \SINE_GENERATOR/COREDDS_C0_0/synced_ngrst , 
        \SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_i_0_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5_inferred_clock_RNIMR4S5/U0_Y , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wEn , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_35_mux_2 , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_23 , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_2 , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_35 , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_33 , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_26_mux , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/m11_0 , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red_m[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red_m[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue_m_1[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m_0[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m_0[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_0_Z[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_0_Z[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0_Z[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0_Z[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0_Z[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_6[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_1_Z[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_1_Z[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot17_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot16_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot15_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot14_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot13_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot12_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot11_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot10_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_7_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_6_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_5_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_4_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_3_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_2_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_1_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_10 , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_8 , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_9 , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/N_23_i , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/m4_e_0 , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_28_mux , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_30_mux , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_13 , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_36_mux_i , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_32_i , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[16] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[15] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[14] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[13] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[12] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[11] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[10] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[9] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_s_1_51_FCO , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_1_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_2_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_3_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_4_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_5_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_6_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_7_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_8_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_9_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_10_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_11_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[16] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[15] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[14] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[13] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[12] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[11] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[10] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[9] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_0 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_0_0_Y , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_1 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_1_0_S , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_2 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_2_0_S , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_3 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_3_0_S , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_4 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_5 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_6 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_7 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_8 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_9 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_10 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_11 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_12 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_13 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_14 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_15 , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/delayLine_0_ , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/un1_last_wA_last_clk_long_1_i , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_1_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_5_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/initOver_0/delayLine_1_ , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/initOver_0/delayLine_0_ , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s_Z[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s_50_FCO , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_Z[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_4_Z[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_4_Z[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/CO0 , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/synced_ngrst_t1 , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/pulsei_Z , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/delayLine_2_ , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/delayLine_1_ , 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/delayLine_0_ , 
        \SINE_obuf[3]/DOUT , \SINE_obuf[3]/EOUT , 
        \FREQ_OFFSET_ibuf[3]/YIN , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[13] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[12] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[11] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[10] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[9] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[19] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[18] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[17] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[15] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[14] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[13] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[12] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[11] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[10] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[9] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[19] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[18] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[17] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[16] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[15] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[14] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[13] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[12] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[11] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[10] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[9] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/ECC_EN_net , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/BUSY_FB_net , 
        \COSINE_obuf[0]/DOUT , \COSINE_obuf[0]/EOUT , 
        \SINE_obuf[0]/DOUT , \SINE_obuf[0]/EOUT , \PN_SIN_ibuf/YIN , 
        \FREQ_OFFSET_ibuf[4]/YIN , \COSINE_obuf[3]/DOUT , 
        \COSINE_obuf[3]/EOUT , \COSINE_obuf[2]/DOUT , 
        \COSINE_obuf[2]/EOUT , \CLK_ibuf/YIN , \COSINE_obuf[1]/DOUT , 
        \COSINE_obuf[1]/EOUT , \FREQ_OFFSET_ibuf[2]/YIN , 
        \SINE_obuf[2]/DOUT , \SINE_obuf[2]/EOUT , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[13] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[12] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[11] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[10] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[9] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[19] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[18] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[17] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[15] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[14] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[13] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[12] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[11] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[10] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[9] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[19] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[18] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[17] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[16] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[15] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[14] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[13] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[12] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[11] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[10] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[9] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[0] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/ECC_EN_net , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/BUSY_FB_net , 
        \NGRST_ibuf/YIN , \FREQ_OFFSET_ibuf[1]/YIN , 
        \SINE_obuf[1]/DOUT , \SINE_obuf[1]/EOUT , 
        \FREQ_OFFSET_ibuf[0]/YIN , \RSTN_ibuf/YIN , NN_1, 
        \SINE_GENERATOR/COREDDS_C0_0/slow_clk , ADLIB_GND, ADLIB_VCC, 
        NET_CC_CONFIG, NET_CC_CONFIG0, NET_CC_CONFIG1, NET_CC_CONFIG2, 
        NET_CC_CONFIG3, NET_CC_CONFIG4, NET_CC_CONFIG5, NET_CC_CONFIG6, 
        NET_CC_CONFIG7, NET_CC_CONFIG8, NET_CC_CONFIG9, 
        NET_CC_CONFIG10, NET_CC_CONFIG11, NET_CC_CONFIG12, 
        NET_CC_CONFIG13, NET_CC_CONFIG14, NET_CC_CONFIG15, 
        NET_CC_CONFIG16, NET_CC_CONFIG17, NET_CC_CONFIG18, 
        NET_CC_CONFIG19, NET_CC_CONFIG20, NET_CC_CONFIG21, 
        NET_CC_CONFIG22, NET_CC_CONFIG23, NET_CC_CONFIG24, 
        NET_CC_CONFIG25, NET_CC_CONFIG26, NET_CC_CONFIG27, 
        NET_CC_CONFIG28, NET_CC_CONFIG29, NET_CC_CONFIG30, 
        NET_CC_CONFIG31, NET_CC_CONFIG32, NET_CC_CONFIG33, 
        NET_CC_CONFIG34, NET_CC_CONFIG35, NET_CC_CONFIG36, 
        NET_CC_CONFIG37, NET_CC_CONFIG38, CI_TO_CO, NET_CC_CONFIG39, 
        NET_CC_CONFIG40, NET_CC_CONFIG41, NET_CC_CONFIG42, 
        NET_CC_CONFIG43, NET_CC_CONFIG44, NET_CC_CONFIG45, 
        NET_CC_CONFIG46, NET_CC_CONFIG47, NET_CC_CONFIG48, 
        NET_CC_CONFIG49, NET_CC_CONFIG50, NET_CC_CONFIG51, 
        NET_CC_CONFIG52, NET_CC_CONFIG53, NET_CC_CONFIG54, 
        NET_CC_CONFIG55, NET_CC_CONFIG56, NET_CC_CONFIG57, 
        NET_CC_CONFIG58, NET_CC_CONFIG59, NET_CC_CONFIG60, 
        NET_CC_CONFIG61, NET_CC_CONFIG62, NET_CC_CONFIG63, 
        NET_CC_CONFIG64, NET_CC_CONFIG65, NET_CC_CONFIG66, 
        NET_CC_CONFIG67, NET_CC_CONFIG68, NET_CC_CONFIG69, 
        NET_CC_CONFIG70, NET_CC_CONFIG71, NET_CC_CONFIG72, 
        NET_CC_CONFIG73, NET_CC_CONFIG74, NET_CC_CONFIG75, 
        NET_CC_CONFIG76, NET_CC_CONFIG77, NET_CC_CONFIG78, 
        NET_CC_CONFIG79, NET_CC_CONFIG80, NET_CC_CONFIG81, 
        NET_CC_CONFIG82, NET_CC_CONFIG83, NET_CC_CONFIG84, 
        NET_CC_CONFIG85, NET_CC_CONFIG86, NET_CC_CONFIG87, 
        NET_CC_CONFIG88, NET_CC_CONFIG89, NET_CC_CONFIG90, 
        NET_CC_CONFIG91, NET_CC_CONFIG92, NET_CC_CONFIG93, 
        NET_CC_CONFIG94, NET_CC_CONFIG95, NET_CC_CONFIG96, 
        NET_CC_CONFIG97, NET_CC_CONFIG98, NET_CC_CONFIG99, 
        NET_CC_CONFIG100, NET_CC_CONFIG101, NET_CC_CONFIG102, 
        NET_CC_CONFIG103, NET_CC_CONFIG104, NET_CC_CONFIG105, 
        NET_CC_CONFIG106, CI_TO_CO107, NET_CC_CONFIG108, 
        NET_CC_CONFIG109, NET_CC_CONFIG110, NET_CC_CONFIG111, 
        NET_CC_CONFIG112, NET_CC_CONFIG113, NET_CC_CONFIG114, 
        NET_CC_CONFIG115, NET_CC_CONFIG116, NET_CC_CONFIG117, 
        NET_CC_CONFIG118, NET_CC_CONFIG119, NET_CC_CONFIG120, 
        NET_CC_CONFIG121, NET_CC_CONFIG122, NET_CC_CONFIG123, 
        NET_CC_CONFIG124, NET_CC_CONFIG125, NET_CC_CONFIG126, 
        NET_CC_CONFIG127, NET_CC_CONFIG128, NET_CC_CONFIG129, 
        NET_CC_CONFIG130, NET_CC_CONFIG131, NET_CC_CONFIG132, 
        NET_CC_CONFIG133, NET_CC_CONFIG134, NET_CC_CONFIG135, 
        NET_CC_CONFIG136, NET_CC_CONFIG137, NET_CC_CONFIG138, 
        NET_CC_CONFIG139, NET_CC_CONFIG140, NET_CC_CONFIG141, 
        NET_CC_CONFIG142, NET_CC_CONFIG143, NET_CC_CONFIG144, 
        NET_CC_CONFIG145, NET_CC_CONFIG146, NET_CC_CONFIG147, 
        NET_CC_CONFIG148, NET_CC_CONFIG149, NET_CC_CONFIG150, 
        NET_CC_CONFIG151, NET_CC_CONFIG152, NET_CC_CONFIG153, 
        NET_CC_CONFIG154, NET_CC_CONFIG155, NET_CC_CONFIG156, 
        NET_CC_CONFIG157, NET_CC_CONFIG158, NET_CC_CONFIG159, 
        AFLSDF_VCC, AFLSDF_GND, AFLSDF_INV_0_net_1, AFLSDF_INV_1_net_1, 
        AFLSDF_INV_2_net_1, AFLSDF_INV_3_net_1, AFLSDF_INV_4_net_1, 
        AFLSDF_INV_5_net_1, AFLSDF_INV_6_net_1, AFLSDF_INV_7_net_1, 
        AFLSDF_INV_8_net_1, AFLSDF_INV_9_net_1, AFLSDF_INV_10_net_1, 
        AFLSDF_INV_11_net_1, AFLSDF_INV_12_net_1, AFLSDF_INV_13_net_1, 
        AFLSDF_INV_14_net_1, AFLSDF_INV_15_net_1, AFLSDF_INV_16_net_1, 
        AFLSDF_INV_17_net_1, AFLSDF_INV_18_net_1, AFLSDF_INV_19_net_1, 
        AFLSDF_INV_20_net_1, AFLSDF_INV_21_net_1, AFLSDF_INV_22_net_1, 
        AFLSDF_INV_23_net_1, AFLSDF_INV_24_net_1, AFLSDF_INV_25_net_1, 
        AFLSDF_INV_26_net_1, AFLSDF_INV_27_net_1, AFLSDF_INV_28_net_1, 
        AFLSDF_INV_29_net_1, AFLSDF_INV_30_net_1, AFLSDF_INV_31_net_1, 
        AFLSDF_INV_32_net_1, AFLSDF_INV_33_net_1, AFLSDF_INV_34_net_1, 
        AFLSDF_INV_35_net_1, AFLSDF_INV_36_net_1, AFLSDF_INV_37_net_1, 
        AFLSDF_INV_38_net_1, AFLSDF_INV_39_net_1, AFLSDF_INV_40_net_1, 
        AFLSDF_INV_41_net_1, AFLSDF_INV_42_net_1, AFLSDF_INV_43_net_1, 
        AFLSDF_INV_44_net_1, AFLSDF_INV_45_net_1, AFLSDF_INV_46_net_1, 
        AFLSDF_INV_47_net_1, AFLSDF_INV_48_net_1, AFLSDF_INV_49_net_1, 
        AFLSDF_INV_50_net_1, AFLSDF_INV_51_net_1, AFLSDF_INV_52_net_1, 
        AFLSDF_INV_53_net_1, AFLSDF_INV_54_net_1, AFLSDF_INV_55_net_1, 
        AFLSDF_INV_56_net_1, AFLSDF_INV_57_net_1, AFLSDF_INV_58_net_1, 
        AFLSDF_INV_59_net_1, AFLSDF_INV_60_net_1, AFLSDF_INV_61_net_1, 
        AFLSDF_INV_62_net_1, AFLSDF_INV_63_net_1, AFLSDF_INV_64_net_1, 
        AFLSDF_INV_65_net_1, AFLSDF_INV_66_net_1, AFLSDF_INV_67_net_1, 
        AFLSDF_INV_68_net_1, AFLSDF_INV_69_net_1, AFLSDF_INV_70_net_1, 
        AFLSDF_INV_71_net_1, AFLSDF_INV_72_net_1, AFLSDF_INV_73_net_1, 
        AFLSDF_INV_74_net_1, AFLSDF_INV_75_net_1, AFLSDF_INV_76_net_1, 
        AFLSDF_INV_77_net_1, AFLSDF_INV_78_net_1, AFLSDF_INV_79_net_1, 
        AFLSDF_INV_80_net_1, AFLSDF_INV_81_net_1, AFLSDF_INV_82_net_1, 
        AFLSDF_INV_83_net_1, AFLSDF_INV_84_net_1, AFLSDF_INV_85_net_1, 
        AFLSDF_INV_86_net_1, AFLSDF_INV_87_net_1, AFLSDF_INV_88_net_1, 
        AFLSDF_INV_89_net_1, AFLSDF_INV_90_net_1, AFLSDF_INV_91_net_1, 
        AFLSDF_INV_92_net_1, AFLSDF_INV_93_net_1, AFLSDF_INV_94_net_1, 
        AFLSDF_INV_95_net_1, AFLSDF_INV_96_net_1, AFLSDF_INV_97_net_1, 
        AFLSDF_INV_98_net_1, AFLSDF_INV_99_net_1, AFLSDF_INV_100_net_1, 
        AFLSDF_INV_101_net_1, AFLSDF_INV_102_net_1, 
        AFLSDF_INV_103_net_1, AFLSDF_INV_104_net_1, 
        AFLSDF_INV_105_net_1, AFLSDF_INV_106_net_1, 
        AFLSDF_INV_107_net_1;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign ADLIB_GND = GND_power_net1;
    assign AFLSDF_GND = GND_power_net1;
    assign AFLSDF_VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_13  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[3] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[7] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[5] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[7] )
        );
    INV_BA AFLSDF_INV_67 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[1] )
        , .Y(AFLSDF_INV_67_net_1));
    IOPAD_TRI \SINE_obuf[2]/U_IOPAD  (.PAD(SINE[2]), .D(
        \SINE_obuf[2]/DOUT ), .E(\SINE_obuf[2]/EOUT ));
    IOPAD_TRI \COSINE_obuf[1]/U_IOPAD  (.PAD(COSINE[1]), .D(
        \COSINE_obuf[1]/DOUT ), .E(\COSINE_obuf[1]/EOUT ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_13  
        (.EN(ADLIB_VCC), .IPEN());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/initOver_0/genblk1.delayLine[0]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_Z )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/initOver_0/delayLine_0_ )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_26  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_17  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_GND), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[9] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/ECC_EN_net )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[9] )
        );
    ARI1_CC #( .INIT(20'h48800) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry[0]  
        (.A(ADLIB_VCC), .B(\SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[0] ), 
        .C(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .D(ADLIB_GND), 
        .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s_50_FCO )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[0] )
        , .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[0] )
        , .CC(NET_CC_CONFIG6), .P(NET_CC_CONFIG3), .Y3(NET_CC_CONFIG4), 
        .Y3A(NET_CC_CONFIG5));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q[3]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[3] )
        , .CLK(NN_1), .EN(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        , .ALn(NGRST_c), .ADn(ADLIB_VCC), .SLn(ADLIB_VCC), .SD(
        ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[3] ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_16  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4 #( .INIT(16'hF0E0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_0_iv_RNO[0]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[3] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[4] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[0] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_7_Z )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red_m[0] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_29  
        (.EN(ADLIB_VCC), .IPEN());
    CFG3 #( .INIT(8'h01) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot10  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[11] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[10] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot10_Z )
        );
    IOIN_IB_E #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \CLK_ibuf/U_IOIN  (.Y(CLK_ibuf_Z), .E(
        ADLIB_GND), .YIN(\CLK_ibuf/YIN ));
    IOPAD_IN \FREQ_OFFSET_ibuf[2]/U_IOPAD  (.PAD(FREQ_OFFSET[2]), .Y(
        \FREQ_OFFSET_ibuf[2]/YIN ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_19  
        (.EN(ADLIB_VCC), .IPEN());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q[5]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[5] )
        , .CLK(NN_1), .EN(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        , .ALn(NGRST_c), .ADn(ADLIB_VCC), .SLn(ADLIB_VCC), .SD(
        ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[5] ));
    CFG3 #( .INIT(8'hE0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_RNO[3]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[0] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[7] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[3] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red_m[3] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][7]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[7] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[7] )
        );
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s_50  
        (.A(ADLIB_VCC), .B(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(ADLIB_VCC), .S(), .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s_50_FCO )
        , .CC(NET_CC_CONFIG2), .P(NET_CC_CONFIG), .Y3(NET_CC_CONFIG0), 
        .Y3A(NET_CC_CONFIG1));
    INV_BA AFLSDF_INV_59 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[9] )
        , .Y(AFLSDF_INV_59_net_1));
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_6  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[10] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_5_Z ), 
        .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[5] ), .Y(), 
        .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_6_Z ), 
        .CC(NET_CC_CONFIG135), .P(NET_CC_CONFIG132), .Y3(
        NET_CC_CONFIG133), .Y3A(NET_CC_CONFIG134));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/genblk1.delayLine[3]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/delayLine_2_ )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/synced_ngrst ));
    CFG2 #( .INIT(4'h6) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr[5]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[5] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[5] )
        );
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_8  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[12] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_7_Z ), 
        .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[7] ), .Y(), 
        .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_8_Z ), 
        .CC(NET_CC_CONFIG143), .P(NET_CC_CONFIG140), .Y3(
        NET_CC_CONFIG141), .Y3A(NET_CC_CONFIG142));
    INV_BA AFLSDF_INV_20 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[12] )
        , .Y(AFLSDF_INV_20_net_1));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/genblk1.delayLine[0]  
        (.D(ADLIB_VCC), .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), 
        .ADn(ADLIB_VCC), .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(
        ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/delayLine_0_ )
        );
    CFG2 #( .INIT(4'h8) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/dc  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/CO0 )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_Z[1] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        );
    CFG4 #( .INIT(16'hEAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0_RNO_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[8] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] ), .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/m11_0 ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_36_mux_i )
        );
    CFG4 #( .INIT(16'h8000) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_5  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[8] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] ), .D(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[1] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_5_Z )
        );
    CFG4 #( .INIT(16'h4000) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_1_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        , .C(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[5] ), .D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_5_Z )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_Z )
        );
    INV_BA AFLSDF_INV_82 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[5] )
        , .Y(AFLSDF_INV_82_net_1));
    INV_BA AFLSDF_INV_37 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[14] )
        , .Y(AFLSDF_INV_37_net_1));
    CC_CONFIG 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_0_0_CC_1  
        (.CI(CI_TO_CO), .CO(), .P({NET_CC_CONFIG75, NET_CC_CONFIG79, 
        NET_CC_CONFIG83, NET_CC_CONFIG87, NET_CC_CONFIG91, 
        NET_CC_CONFIG95, NET_CC_CONFIG99, NET_CC_CONFIG103, ADLIB_VCC, 
        ADLIB_VCC, ADLIB_VCC, ADLIB_VCC}), .Y3({NET_CC_CONFIG76, 
        NET_CC_CONFIG80, NET_CC_CONFIG84, NET_CC_CONFIG88, 
        NET_CC_CONFIG92, NET_CC_CONFIG96, NET_CC_CONFIG100, 
        NET_CC_CONFIG104, ADLIB_VCC, ADLIB_VCC, ADLIB_VCC, ADLIB_VCC}), 
        .Y3A({NET_CC_CONFIG77, NET_CC_CONFIG81, NET_CC_CONFIG85, 
        NET_CC_CONFIG89, NET_CC_CONFIG93, NET_CC_CONFIG97, 
        NET_CC_CONFIG101, NET_CC_CONFIG105, ADLIB_VCC, ADLIB_VCC, 
        ADLIB_VCC, ADLIB_VCC}), .CC({NET_CC_CONFIG78, NET_CC_CONFIG82, 
        NET_CC_CONFIG86, NET_CC_CONFIG90, NET_CC_CONFIG94, 
        NET_CC_CONFIG98, NET_CC_CONFIG102, NET_CC_CONFIG106, nc0, nc1, 
        nc2, nc3}));
    INV_BA AFLSDF_INV_77 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[10] )
        , .Y(AFLSDF_INV_77_net_1));
    IOIN_IB_E #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \FREQ_OFFSET_ibuf[3]/U_IOIN  (.Y(
        \FREQ_OFFSET_c[3] ), .E(ADLIB_GND), .YIN(
        \FREQ_OFFSET_ibuf[3]/YIN ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_35  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_15  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[4] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[8] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[6] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[8] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot[5]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot15_Z )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(ADLIB_VCC), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[5] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][8]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[8] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[8] )
        );
    CFG2 #( .INIT(4'hE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_3  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[0] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[3] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_3_Z )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_14  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_3  
        (.A(ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_36_mux_i )
        , .C(ADLIB_GND), .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[1] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[1] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[1] )
        );
    CFG4 #( .INIT(16'h0EE0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_RNO[1]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[3] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[4] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[0] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[1] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m[1] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q[0]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[0] )
        , .CLK(NN_1), .EN(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        , .ALn(NGRST_c), .ADn(ADLIB_VCC), .SLn(ADLIB_VCC), .SD(
        ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[0] ));
    RAM1K20_IP #( .MEMORYFILE(""), .RAMINDEX("PF__COMPILE__GEN__:SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0%512-512%4-4%SPEED%0%0%TWO-PORT%ECC_EN-0")
         )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/INST_RAM1K20_IP  
        (.A_DOUT({nc4, nc5, nc6, nc7, nc8, nc9, nc10, nc11, nc12, nc13, 
        nc14, nc15, nc16, nc17, nc18, nc19, 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[0] })
        , .B_DOUT({nc20, nc21, nc22, nc23, nc24, nc25, nc26, nc27, 
        nc28, nc29, nc30, nc31, nc32, nc33, nc34, nc35, nc36, nc37, 
        nc38, nc39}), .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(), 
        .A_ADDR({AFLSDF_INV_0_net_1, AFLSDF_INV_1_net_1, 
        AFLSDF_INV_2_net_1, AFLSDF_INV_3_net_1, AFLSDF_INV_4_net_1, 
        AFLSDF_INV_5_net_1, AFLSDF_INV_6_net_1, AFLSDF_INV_7_net_1, 
        AFLSDF_INV_8_net_1, AFLSDF_INV_9_net_1, AFLSDF_INV_10_net_1, 
        AFLSDF_INV_11_net_1, AFLSDF_INV_12_net_1, AFLSDF_INV_13_net_1})
        , .A_BLK_EN({
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[0] })
        , .A_CLK(NN_1), .A_DIN({AFLSDF_INV_14_net_1, 
        AFLSDF_INV_15_net_1, AFLSDF_INV_16_net_1, ADLIB_GND, 
        AFLSDF_INV_17_net_1, AFLSDF_INV_18_net_1, AFLSDF_INV_19_net_1, 
        AFLSDF_INV_20_net_1, AFLSDF_INV_21_net_1, AFLSDF_INV_22_net_1, 
        AFLSDF_INV_23_net_1, AFLSDF_INV_24_net_1, AFLSDF_INV_25_net_1, 
        AFLSDF_INV_26_net_1, AFLSDF_INV_27_net_1, AFLSDF_INV_28_net_1, 
        ADLIB_GND, AFLSDF_INV_29_net_1, AFLSDF_INV_30_net_1, 
        AFLSDF_INV_31_net_1}), .A_REN(ADLIB_VCC), .A_WEN({ADLIB_GND, 
        ADLIB_GND}), .A_DOUT_EN(ADLIB_VCC), .A_DOUT_ARST_N(ADLIB_VCC), 
        .A_DOUT_SRST_N(ADLIB_VCC), .B_ADDR({ADLIB_GND, ADLIB_GND, 
        ADLIB_GND, \SINE_GENERATOR/COREDDS_C0_0/sico_wA[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[0] , ADLIB_GND, ADLIB_GND})
        , .B_BLK_EN({
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[0] })
        , .B_CLK(\SINE_GENERATOR/COREDDS_C0_0/slow_clk ), .B_DIN({
        AFLSDF_INV_32_net_1, AFLSDF_INV_33_net_1, AFLSDF_INV_34_net_1, 
        AFLSDF_INV_35_net_1, AFLSDF_INV_36_net_1, AFLSDF_INV_37_net_1, 
        AFLSDF_INV_38_net_1, AFLSDF_INV_39_net_1, AFLSDF_INV_40_net_1, 
        AFLSDF_INV_41_net_1, AFLSDF_INV_42_net_1, AFLSDF_INV_43_net_1, 
        AFLSDF_INV_44_net_1, AFLSDF_INV_45_net_1, AFLSDF_INV_46_net_1, 
        AFLSDF_INV_47_net_1, AFLSDF_INV_48_net_1, AFLSDF_INV_49_net_1, 
        AFLSDF_INV_50_net_1, AFLSDF_INV_51_net_1}), .B_REN(ADLIB_VCC), 
        .B_WEN({ADLIB_GND, ADLIB_VCC}), .B_DOUT_EN(ADLIB_VCC), 
        .B_DOUT_ARST_N(ADLIB_GND), .B_DOUT_SRST_N(ADLIB_VCC), .ECC_EN(
        AFLSDF_INV_52_net_1), .BUSY_FB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/BUSY_FB_net )
        , .A_WIDTH({ADLIB_GND, ADLIB_VCC, ADLIB_GND}), .A_WMODE({
        ADLIB_GND, ADLIB_GND}), .A_BYPASS(ADLIB_VCC), .B_WIDTH({
        ADLIB_GND, ADLIB_VCC, ADLIB_GND}), .B_WMODE({ADLIB_GND, 
        ADLIB_GND}), .B_BYPASS(ADLIB_VCC), .ECC_BYPASS(ADLIB_GND));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_27  
        (.EN(ADLIB_VCC), .IPEN());
    IOPAD_IN \FREQ_OFFSET_ibuf[4]/U_IOPAD  (.PAD(FREQ_OFFSET[4]), .Y(
        \FREQ_OFFSET_ibuf[4]/YIN ));
    INV_BA AFLSDF_INV_92 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[14] )
        , .Y(AFLSDF_INV_92_net_1));
    IOTRI_OB_EB #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \SINE_obuf[1]/U_IOTRI  (.D(
        \SINE_c[1] ), .E(ADLIB_VCC), .DOUT(\SINE_obuf[1]/DOUT ), .EOUT(
        \SINE_obuf[1]/EOUT ));
    INV_BA AFLSDF_INV_53 (.A(AFLSDF_INV_53_net_1), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/slow_clk ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_13  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4 #( .INIT(16'hFCFE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv[2]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_1_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0_Z[2] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m_0[2] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_9 )
        , .Y(\sin_signal[2] ));
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_4  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[8] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_3_Z ), 
        .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[3] ), .Y(), 
        .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_4_Z ), 
        .CC(NET_CC_CONFIG127), .P(NET_CC_CONFIG124), .Y3(
        NET_CC_CONFIG125), .Y3A(NET_CC_CONFIG126));
    INV_BA AFLSDF_INV_10 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[3] )
        , .Y(AFLSDF_INV_10_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_3  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_27  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_GND), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[14] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[11] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[14] )
        );
    CFG3 #( .INIT(8'h02) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot14  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[11] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[10] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot14_Z )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_27  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_2  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    INV_BA AFLSDF_INV_47 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[4] )
        , .Y(AFLSDF_INV_47_net_1));
    CFG2 #( .INIT(4'h6) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr[7]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[7] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[7] )
        );
    INV_BA AFLSDF_INV_100 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[6] )
        , .Y(AFLSDF_INV_100_net_1));
    ARI1_CC #( .INIT(20'h52288) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_1_0  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[1] )
        , .B(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[1] )
        , .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_0 )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_1_0_S )
        , .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_1 )
        , .CC(NET_CC_CONFIG46), .P(NET_CC_CONFIG43), .Y3(
        NET_CC_CONFIG44), .Y3A(NET_CC_CONFIG45));
    CFG2 #( .INIT(4'hE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_7  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[0] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[7] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_7_Z )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_24  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[0] )
        , .IPB(), .IPC(), .IPD());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_32  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    CFG3 #( .INIT(8'h14) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_4[1]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/delayLine_0_ ), 
        .B(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_Z[1] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/CO0 )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_4_Z[1] )
        );
    INV_BA AFLSDF_INV_86 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[0] )
        , .Y(AFLSDF_INV_86_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_0  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_17  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4 #( .INIT(16'h3200) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/wA_1_RNI8P1VG2[8]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_35_mux_2 ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] ), .D(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[8] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_23 ));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_10  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[2] )
        , .IPB(), .IPC(), .IPD());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot[1]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot11_Z )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(ADLIB_VCC), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[1] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_32  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_9  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[1] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[5] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[3] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[5] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot[6]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot16_Z )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(ADLIB_VCC), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[6] )
        );
    INV_BA AFLSDF_INV_55 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[13] )
        , .Y(AFLSDF_INV_55_net_1));
    CFG4 #( .INIT(16'hEA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/wA_1_RNIDA95C1[0]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[2] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[1] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[0] ), .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_26_mux ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/m11_0 ));
    IOPAD_IN \PN_SIN_ibuf/U_IOPAD  (.PAD(PN_SIN), .Y(\PN_SIN_ibuf/YIN )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_29  
        (.EN(ADLIB_VCC), .IPEN());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][4]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[4] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[4] )
        );
    INV_BA AFLSDF_INV_62 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[6] )
        , .Y(AFLSDF_INV_62_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_22  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_2  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[6] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_1_Z ), 
        .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[1] ), .Y(), 
        .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_2_Z ), 
        .CC(NET_CC_CONFIG119), .P(NET_CC_CONFIG116), .Y3(
        NET_CC_CONFIG117), .Y3A(NET_CC_CONFIG118));
    CFG2 #( .INIT(4'h4) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/genblk1.delayLine[0]_3[4]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_i_0_Z ), 
        .B(\FREQ_OFFSET_c[4] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[4] )
        );
    INV_BA AFLSDF_INV_96 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[10] )
        , .Y(AFLSDF_INV_96_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_31  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_GND), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[17] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[12] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[17] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_0  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_1  
        (.A(ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_23 ), .C(
        ADLIB_GND), .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[0] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[0] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[0] )
        );
    CFG2 #( .INIT(4'hE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_5  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[2] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[5] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_5_Z )
        );
    CFG4 #( .INIT(16'hFCFE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv[2]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_5_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m[2] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_0_Z[2] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_9 )
        , .Y(\COSINE_c[2] ));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/genblk1.delayLine[0][2]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[2] )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[2] )
        );
    IOPAD_TRI \COSINE_obuf[2]/U_IOPAD  (.PAD(COSINE[2]), .D(
        \COSINE_obuf[2]/DOUT ), .E(\COSINE_obuf[2]/EOUT ));
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_10  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[14] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_9_Z ), 
        .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .Y(), 
        .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_10_Z ), 
        .CC(NET_CC_CONFIG151), .P(NET_CC_CONFIG148), .Y3(
        NET_CC_CONFIG149), .Y3A(NET_CC_CONFIG150));
    IOTRI_OB_EB #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \SINE_obuf[0]/U_IOTRI  (.D(
        \SINE_c[0] ), .E(ADLIB_VCC), .DOUT(\SINE_obuf[0]/DOUT ), .EOUT(
        \SINE_obuf[0]/EOUT ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_32  
        (.EN(ADLIB_VCC), .IPEN());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][5]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[5] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[5] )
        );
    CFG4 #( .INIT(16'h0EE0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/pos_sine.sine_w_7_m_0[1]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[5] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[6] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[0] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[1] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m_0[1] )
        );
    CFG3 #( .INIT(8'h01) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/wA_1_RNIIGK2M[0]  (
        .A(\SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[2] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[1] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[0] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_33 ));
    INV_BA AFLSDF_INV_5 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[8] )
        , .Y(AFLSDF_INV_5_net_1));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot[0]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot10_Z )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(ADLIB_VCC), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[0] )
        );
    INV_BA AFLSDF_INV_81 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[6] )
        , .Y(AFLSDF_INV_81_net_1));
    INV_BA AFLSDF_INV_27 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[5] )
        , .Y(AFLSDF_INV_27_net_1));
    INV_BA AFLSDF_INV_0 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[13] )
        , .Y(AFLSDF_INV_0_net_1));
    INV_BA AFLSDF_INV_32 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[19] )
        , .Y(AFLSDF_INV_32_net_1));
    INV_BA AFLSDF_INV_66 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[2] )
        , .Y(AFLSDF_INV_66_net_1));
    CFG4 #( .INIT(16'hCDFF) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0_RNO  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_35_mux_2 ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] ), .D(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[8] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/N_23_i )
        );
    CFG4 #( .INIT(16'h2228) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/pos_sine.sine_w_7_m_0[2]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_2_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[2] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[1] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[0] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m_0[2] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_4  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    ARI1_CC #( .INIT(20'h48800) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_s_16  
        (.A(ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[16] )
        , .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_15 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[16] ), 
        .Y(), .FCO(), .CC(NET_CC_CONFIG106), .P(NET_CC_CONFIG103), .Y3(
        NET_CC_CONFIG104), .Y3A(NET_CC_CONFIG105));
    INV_BA AFLSDF_INV_72 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[15] )
        , .Y(AFLSDF_INV_72_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_8  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[1] )
        , .IPB(), .IPC(), .IPD());
    ARI1_CC #( .INIT(20'h48800) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry[6]  
        (.A(ADLIB_VCC), .B(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] ), 
        .C(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .D(ADLIB_GND), 
        .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[5] )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[6] )
        , .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[6] )
        , .CC(NET_CC_CONFIG30), .P(NET_CC_CONFIG27), .Y3(
        NET_CC_CONFIG28), .Y3A(NET_CC_CONFIG29));
    INV_BA AFLSDF_INV_91 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[15] )
        , .Y(AFLSDF_INV_91_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_21  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_13  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[3] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[7] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[5] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[7] )
        );
    ARI1_CC #( .INIT(20'h5AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_12_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[12] )
        , .C(ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_11 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[12] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_12 )
        , .CC(NET_CC_CONFIG90), .P(NET_CC_CONFIG87), .Y3(
        NET_CC_CONFIG88), .Y3A(NET_CC_CONFIG89));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_2  
        (.EN(ADLIB_VCC), .IPEN());
    INV_BA AFLSDF_INV_103 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[3] )
        , .Y(AFLSDF_INV_103_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_9  
        (.EN(ADLIB_VCC), .IPEN());
    ARI1_CC #( .INIT(20'h5AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_14_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[14] )
        , .C(ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_13 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[14] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_14 )
        , .CC(NET_CC_CONFIG98), .P(NET_CC_CONFIG95), .Y3(
        NET_CC_CONFIG96), .Y3A(NET_CC_CONFIG97));
    INV_BA AFLSDF_INV_42 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[9] )
        , .Y(AFLSDF_INV_42_net_1));
    INV_BA AFLSDF_INV_17 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[15] )
        , .Y(AFLSDF_INV_17_net_1));
    CFG2 #( .INIT(4'h4) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/genblk1.delayLine[0]_3[3]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_i_0_Z ), 
        .B(\FREQ_OFFSET_c[3] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[3] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_22  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_33  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_0  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    INV_BA AFLSDF_INV_54 (.A(AFLSDF_INV_54_net_1), .Y(NN_1));
    INV_BA AFLSDF_INV_36 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[15] )
        , .Y(AFLSDF_INV_36_net_1));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][12]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[12] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[12] )
        );
    INV_BA AFLSDF_INV_89 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[17] )
        , .Y(AFLSDF_INV_89_net_1));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][2]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_2_0_S )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[2] )
        );
    INV_BA AFLSDF_INV_76 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[11] )
        , .Y(AFLSDF_INV_76_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_29  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_GND), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[15] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[16] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[15] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot[4]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot14_Z )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(ADLIB_VCC), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[4] )
        );
    INV_BA AFLSDF_INV_61 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[7] )
        , .Y(AFLSDF_INV_61_net_1));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/genblk1.delayLine[0][1]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[1] )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[1] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_21  
        (.A(ADLIB_GND), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[6] )
        , .D(ADLIB_GND), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/BUSY_FB_net )
        , .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[11] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[8] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[11] )
        );
    CFG4 #( .INIT(16'hEAC0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0[2]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_3_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_Z )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[2] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[2] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0_Z[2] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_6  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[0] )
        , .IPB(), .IPC(), .IPD());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_26  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[1] )
        , .IPB(), .IPC(), .IPD());
    INV_BA AFLSDF_INV_106 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[0] )
        , .Y(AFLSDF_INV_106_net_1));
    CFG4 #( .INIT(16'h56AA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/SINE[2]  
        (.A(\sin_signal[2] ), .B(\sin_signal[1] ), .C(\SINE_c[0] ), .D(
        PN_SIN_c), .Y(\SINE_c[2] ));
    INV_BA AFLSDF_INV_99 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[7] )
        , .Y(AFLSDF_INV_99_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_4  
        (.EN(ADLIB_VCC), .IPEN());
    INV_BA AFLSDF_INV_58 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[10] )
        , .Y(AFLSDF_INV_58_net_1));
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_s_12  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[16] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_11_Z ), 
        .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[11] ), .Y(), 
        .FCO(), .CC(NET_CC_CONFIG159), .P(NET_CC_CONFIG156), .Y3(
        NET_CC_CONFIG157), .Y3A(NET_CC_CONFIG158));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][6]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[6] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[6] )
        );
    INV_BA AFLSDF_INV_46 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[5] )
        , .Y(AFLSDF_INV_46_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_28  
        (.EN(ADLIB_VCC), .IPEN());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_5  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_19  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[5] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[10] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[7] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[10] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/initOver_0/genblk1.delayLine[1]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/initOver_0/delayLine_0_ )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/initOver_0/delayLine_1_ )
        );
    CFG3 #( .INIT(8'h10) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot12  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[11] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[10] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot12_Z )
        );
    INV_BA AFLSDF_INV_83 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[4] )
        , .Y(AFLSDF_INV_83_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_26  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_27  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_GND), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[14] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[11] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[14] )
        );
    IOPAD_IN \FREQ_OFFSET_ibuf[0]/U_IOPAD  (.PAD(FREQ_OFFSET[0]), .Y(
        \FREQ_OFFSET_ibuf[0]/YIN ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_20  
        (.EN(ADLIB_VCC), .IPEN());
    IOIN_IB_E #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \FREQ_OFFSET_ibuf[4]/U_IOIN  (.Y(
        \FREQ_OFFSET_c[4] ), .E(ADLIB_GND), .YIN(
        \FREQ_OFFSET_ibuf[4]/YIN ));
    IOIN_IB_E #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \NGRST_ibuf/U_IOIN  (.Y(NGRST_c), .E(
        ADLIB_GND), .YIN(\NGRST_ibuf/YIN ));
    INV_BA AFLSDF_INV_22 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[10] )
        , .Y(AFLSDF_INV_22_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_6  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[0] )
        , .IPB(), .IPC(), .IPD());
    INV_BA AFLSDF_INV_31 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[0] )
        , .Y(AFLSDF_INV_31_net_1));
    GB I_1 (.A(CLK_ibuf_Z), .EN(ADLIB_VCC), .Y(\I_1/U0_Y ));
    ARI1_CC #( .INIT(20'h5AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_8_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[8] )
        , .C(ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_7 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[8] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_8 )
        , .CC(NET_CC_CONFIG74), .P(NET_CC_CONFIG71), .Y3(
        NET_CC_CONFIG72), .Y3A(NET_CC_CONFIG73));
    INV_BA AFLSDF_INV_71 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[17] )
        , .Y(AFLSDF_INV_71_net_1));
    ARI1_CC #( .INIT(20'h52288) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_4_0  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[4] )
        , .B(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[4] )
        , .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_3 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[4] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_4 )
        , .CC(NET_CC_CONFIG58), .P(NET_CC_CONFIG55), .Y3(
        NET_CC_CONFIG56), .Y3A(NET_CC_CONFIG57));
    CC_CONFIG 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s_50_CC_0  
        (.CI(ADLIB_VCC), .CO(), .P({NET_CC_CONFIG, NET_CC_CONFIG3, 
        NET_CC_CONFIG7, NET_CC_CONFIG11, NET_CC_CONFIG15, 
        NET_CC_CONFIG19, NET_CC_CONFIG23, NET_CC_CONFIG27, 
        NET_CC_CONFIG31, NET_CC_CONFIG35, ADLIB_VCC, ADLIB_VCC}), .Y3({
        NET_CC_CONFIG0, NET_CC_CONFIG4, NET_CC_CONFIG8, 
        NET_CC_CONFIG12, NET_CC_CONFIG16, NET_CC_CONFIG20, 
        NET_CC_CONFIG24, NET_CC_CONFIG28, NET_CC_CONFIG32, 
        NET_CC_CONFIG36, ADLIB_VCC, ADLIB_VCC}), .Y3A({NET_CC_CONFIG1, 
        NET_CC_CONFIG5, NET_CC_CONFIG9, NET_CC_CONFIG13, 
        NET_CC_CONFIG17, NET_CC_CONFIG21, NET_CC_CONFIG25, 
        NET_CC_CONFIG29, NET_CC_CONFIG33, NET_CC_CONFIG37, ADLIB_VCC, 
        ADLIB_VCC}), .CC({NET_CC_CONFIG2, NET_CC_CONFIG6, 
        NET_CC_CONFIG10, NET_CC_CONFIG14, NET_CC_CONFIG18, 
        NET_CC_CONFIG22, NET_CC_CONFIG26, NET_CC_CONFIG30, 
        NET_CC_CONFIG34, NET_CC_CONFIG38, nc40, nc41}));
    CFG3 #( .INIT(8'h40) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot13  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[11] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[10] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot13_Z )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q[8]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s_Z[8] )
        , .CLK(NN_1), .EN(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        , .ALn(NGRST_c), .ADn(ADLIB_VCC), .SLn(ADLIB_VCC), .SD(
        ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[8] ));
    INV_BA AFLSDF_INV_69 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[19] )
        , .Y(AFLSDF_INV_69_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_31  
        (.EN(ADLIB_VCC), .IPEN());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][9]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[9] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[9] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_3  
        (.EN(ADLIB_VCC), .IPEN());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_3/genblk1.delayLine[0]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/pulsei_Z )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/delayLine_0_ ));
    INV_BA AFLSDF_INV_93 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[13] )
        , .Y(AFLSDF_INV_93_net_1));
    INV_BA AFLSDF_INV_85 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[1] )
        , .Y(AFLSDF_INV_85_net_1));
    IOTRI_OB_EB #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \SINE_obuf[3]/U_IOTRI  (.D(
        \SINE_c[3] ), .E(ADLIB_VCC), .DOUT(\SINE_obuf[3]/DOUT ), .EOUT(
        \SINE_obuf[3]/EOUT ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_7  
        (.EN(ADLIB_VCC), .IPEN());
    CFG3 #( .INIT(8'h57) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0_RNO_1  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_26_mux ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_30_mux )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_14  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    CFG4 #( .INIT(16'hFEFC) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv[1]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_1_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0_Z[1] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m_0[1] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_6[1] )
        , .Y(\sin_signal[1] ));
    INV_BA AFLSDF_INV_107 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/ECC_EN_net )
        , .Y(AFLSDF_INV_107_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_9  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_11  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[2] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[6] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[4] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[6] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][3]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_3_0_S )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[3] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_7  
        (.EN(ADLIB_VCC), .IPEN());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_5  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_33  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_GND), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[18] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[13] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[18] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_16  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    IOTRI_OB_EB #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \COSINE_obuf[2]/U_IOTRI  (.D(
        \COSINE_c[2] ), .E(ADLIB_VCC), .DOUT(\COSINE_obuf[2]/DOUT ), 
        .EOUT(\COSINE_obuf[2]/EOUT ));
    INV_BA AFLSDF_INV_41 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[10] )
        , .Y(AFLSDF_INV_41_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_15  
        (.EN(ADLIB_VCC), .IPEN());
    IOPAD_TRI \SINE_obuf[0]/U_IOPAD  (.PAD(SINE[0]), .D(
        \SINE_obuf[0]/DOUT ), .E(\SINE_obuf[0]/EOUT ));
    INV_BA AFLSDF_INV_95 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[11] )
        , .Y(AFLSDF_INV_95_net_1));
    INV_BA AFLSDF_INV_12 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[1] )
        , .Y(AFLSDF_INV_12_net_1));
    CFG2 #( .INIT(4'hE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_6  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[3] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[4] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_6_Z )
        );
    INV_BA AFLSDF_INV_26 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[6] )
        , .Y(AFLSDF_INV_26_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_7  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[0] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[4] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[2] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[4] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_6  
        (.EN(ADLIB_VCC), .IPEN());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_1/genblk1.delayLine[0]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/synced_ngrst ), .CLK(NN_1), 
        .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), .SLn(ADLIB_VCC)
        , .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/synced_ngrst_t1 )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_4  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][15]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[15] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[15] )
        );
    INV_BA AFLSDF_INV_63 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[5] )
        , .Y(AFLSDF_INV_63_net_1));
    IOTRI_OB_EB #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \COSINE_obuf[1]/U_IOTRI  (.D(
        \COSINE_c[1] ), .E(ADLIB_VCC), .DOUT(\COSINE_obuf[1]/DOUT ), 
        .EOUT(\COSINE_obuf[1]/EOUT ));
    INV_BA AFLSDF_INV_39 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[12] )
        , .Y(AFLSDF_INV_39_net_1));
    CFG4 #( .INIT(16'hAAA9) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0_RNIS4HKG  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[3] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[2] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[1] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[0] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_8 )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_28  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .B(ADLIB_VCC), .C(
        ADLIB_VCC), .D(ADLIB_VCC), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[2] )
        , .IPB(), .IPC(), .IPD());
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_3  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[7] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_2_Z ), 
        .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[2] ), .Y(), 
        .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_3_Z ), 
        .CC(NET_CC_CONFIG123), .P(NET_CC_CONFIG120), .Y3(
        NET_CC_CONFIG121), .Y3A(NET_CC_CONFIG122));
    INV_BA AFLSDF_INV_8 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[5] )
        , .Y(AFLSDF_INV_8_net_1));
    CFG2 #( .INIT(4'h2) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/wA_1_RNINB3NE[6]  (
        .A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_35 ));
    INV_BA AFLSDF_INV_79 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[8] )
        , .Y(AFLSDF_INV_79_net_1));
    CC_CONFIG 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_0_0_CC_0  
        (.CI(ADLIB_VCC), .CO(CI_TO_CO), .P({ADLIB_VCC, ADLIB_VCC, 
        ADLIB_GND, NET_CC_CONFIG39, NET_CC_CONFIG43, NET_CC_CONFIG47, 
        NET_CC_CONFIG51, NET_CC_CONFIG55, NET_CC_CONFIG59, 
        NET_CC_CONFIG63, NET_CC_CONFIG67, NET_CC_CONFIG71}), .Y3({
        ADLIB_VCC, ADLIB_VCC, ADLIB_VCC, NET_CC_CONFIG40, 
        NET_CC_CONFIG44, NET_CC_CONFIG48, NET_CC_CONFIG52, 
        NET_CC_CONFIG56, NET_CC_CONFIG60, NET_CC_CONFIG64, 
        NET_CC_CONFIG68, NET_CC_CONFIG72}), .Y3A({ADLIB_VCC, ADLIB_VCC, 
        ADLIB_VCC, NET_CC_CONFIG41, NET_CC_CONFIG45, NET_CC_CONFIG49, 
        NET_CC_CONFIG53, NET_CC_CONFIG57, NET_CC_CONFIG61, 
        NET_CC_CONFIG65, NET_CC_CONFIG69, NET_CC_CONFIG73}), .CC({nc42, 
        nc43, nc44, NET_CC_CONFIG42, NET_CC_CONFIG46, NET_CC_CONFIG50, 
        NET_CC_CONFIG54, NET_CC_CONFIG58, NET_CC_CONFIG62, 
        NET_CC_CONFIG66, NET_CC_CONFIG70, NET_CC_CONFIG74}));
    CFG4 #( .INIT(16'hFEF0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_0_iv[0]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_5_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_4_Z )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red_m[0] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[0] )
        , .Y(\COSINE_c[0] ));
    CFG4 #( .INIT(16'hECA0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_0[2]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_7_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_4_Z )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[2] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[2] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_0_Z[2] )
        );
    IOPAD_IN \CLK_ibuf/U_IOPAD  (.PAD(CLK), .Y(\CLK_ibuf/YIN ));
    CFG4 #( .INIT(16'h91D5) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0_RNO_2  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/m11_0 ), .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_28_mux )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_13 )
        );
    CFG3 #( .INIT(8'hDF) )  
        \SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_i_0  (.A(
        RSTN_c), .B(\SINE_GENERATOR/COREDDS_C0_0/INIT_OVER ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/synced_ngrst ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_i_0_Z ));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_5  
        (.A(ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/N_23_i )
        , .C(ADLIB_GND), .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[2] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[3] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[2] )
        );
    IOIN_IB_E #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \RSTN_ibuf/U_IOIN  (.Y(RSTN_c), .E(
        ADLIB_GND), .YIN(\RSTN_ibuf/YIN ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_28  
        (.EN(ADLIB_VCC), .IPEN());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_25  
        (.EN(ADLIB_VCC), .IPEN());
    ARI1_CC #( .INIT(20'h5AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_13_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[13] )
        , .C(ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_12 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[13] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_13 )
        , .CC(NET_CC_CONFIG94), .P(NET_CC_CONFIG91), .Y3(
        NET_CC_CONFIG92), .Y3A(NET_CC_CONFIG93));
    IOTRI_OB_EB #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \COSINE_obuf[3]/U_IOTRI  (.D(
        \COSINE_c[3] ), .E(ADLIB_VCC), .DOUT(\COSINE_obuf[3]/DOUT ), 
        .EOUT(\COSINE_obuf[3]/EOUT ));
    INV_BA AFLSDF_INV_65 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[3] )
        , .Y(AFLSDF_INV_65_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_30  
        (.EN(ADLIB_VCC), .IPEN());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_18  
        (.EN(ADLIB_VCC), .IPEN());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_15  
        (.EN(ADLIB_VCC), .IPEN());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][16]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[16] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[16] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_15  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[4] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[8] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[6] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[8] )
        );
    INV_BA AFLSDF_INV_9 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[4] )
        , .Y(AFLSDF_INV_9_net_1));
    INV_BA AFLSDF_INV_16 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[17] )
        , .Y(AFLSDF_INV_16_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_35  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_VCC), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[19] )
        , .IPC(), .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[19] )
        );
    CFG2 #( .INIT(4'h6) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr[0]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[0] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[0] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_22  
        (.EN(ADLIB_VCC), .IPEN());
    IOPAD_TRI \SINE_obuf[3]/U_IOPAD  (.PAD(SINE[3]), .D(
        \SINE_obuf[3]/DOUT ), .E(\SINE_obuf[3]/EOUT ));
    INV_BA AFLSDF_INV_49 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[2] )
        , .Y(AFLSDF_INV_49_net_1));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/genblk1.delayLine[1]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/delayLine_0_ )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/delayLine_1_ )
        );
    INV_BA AFLSDF_INV_33 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[18] )
        , .Y(AFLSDF_INV_33_net_1));
    CFG2 #( .INIT(4'h6) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr[6]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[6] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[6] )
        );
    INV_BA AFLSDF_INV_102 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[4] )
        , .Y(AFLSDF_INV_102_net_1));
    ARI1_CC #( .INIT(20'h5AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_5_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[5] )
        , .C(ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_4 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[5] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_5 )
        , .CC(NET_CC_CONFIG62), .P(NET_CC_CONFIG59), .Y3(
        NET_CC_CONFIG60), .Y3A(NET_CC_CONFIG61));
    ARI1_CC #( .INIT(20'h52288) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_0_0  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[0] )
        , .B(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[0] )
        , .D(ADLIB_GND), .FCI(ADLIB_GND), .S(), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_0_0_Y )
        , .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_0 )
        , .CC(NET_CC_CONFIG42), .P(NET_CC_CONFIG39), .Y3(
        NET_CC_CONFIG40), .Y3A(NET_CC_CONFIG41));
    INV_BA AFLSDF_INV_21 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[11] )
        , .Y(AFLSDF_INV_21_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_20  
        (.EN(ADLIB_VCC), .IPEN());
    INV_BA AFLSDF_INV_73 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[14] )
        , .Y(AFLSDF_INV_73_net_1));
    INV_BA AFLSDF_INV_50 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[1] )
        , .Y(AFLSDF_INV_50_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_18  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    SLE \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wEn_long  (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/delayLine_0_ ), 
        .CLK(NN_1), .EN(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/un1_last_wA_last_clk_long_1_i )
        , .ALn(NGRST_c), .ADn(ADLIB_VCC), .SLn(ADLIB_VCC), .SD(
        ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wEn ));
    IOIN_IB_E #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \PN_SIN_ibuf/U_IOIN  (.Y(PN_SIN_c), 
        .E(ADLIB_GND), .YIN(\PN_SIN_ibuf/YIN ));
    IOIN_IB_E #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \FREQ_OFFSET_ibuf[2]/U_IOIN  (.Y(
        \FREQ_OFFSET_c[2] ), .E(ADLIB_GND), .YIN(
        \FREQ_OFFSET_ibuf[2]/YIN ));
    CFG2 #( .INIT(4'hE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_1  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[4] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[7] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_1_Z )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_10  
        (.EN(ADLIB_VCC), .IPEN());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot[2]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot12_Z )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(ADLIB_VCC), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[2] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][13]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[13] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[13] )
        );
    INV_BA AFLSDF_INV_84 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[2] )
        , .Y(AFLSDF_INV_84_net_1));
    CFG4 #( .INIT(16'hFFEC) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv[1]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_5_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m[1] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_6[1] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_0_Z[1] )
        , .Y(\COSINE_c[1] ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_24  
        (.EN(ADLIB_VCC), .IPEN());
    INV_BA AFLSDF_INV_35 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[16] )
        , .Y(AFLSDF_INV_35_net_1));
    INV_BA AFLSDF_INV_6 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[7] )
        , .Y(AFLSDF_INV_6_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_30  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_14  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4 #( .INIT(16'hECA0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_0[1]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_7_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_4_Z )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[1] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[1] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_0_Z[1] )
        );
    CFG2 #( .INIT(4'h6) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr[1]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[1] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[1] )
        );
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_5  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[9] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_4_Z ), 
        .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[4] ), .Y(), 
        .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_5_Z ), 
        .CC(NET_CC_CONFIG131), .P(NET_CC_CONFIG128), .Y3(
        NET_CC_CONFIG129), .Y3A(NET_CC_CONFIG130));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_23  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[7] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[12] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[9] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[12] )
        );
    INV_BA AFLSDF_INV_75 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[12] )
        , .Y(AFLSDF_INV_75_net_1));
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_s_1_51  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[4] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(ADLIB_VCC), .S(), .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_s_1_51_FCO )
        , .CC(NET_CC_CONFIG111), .P(NET_CC_CONFIG108), .Y3(
        NET_CC_CONFIG109), .Y3A(NET_CC_CONFIG110));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q[4]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[4] )
        , .CLK(NN_1), .EN(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        , .ALn(NGRST_c), .ADn(ADLIB_VCC), .SLn(ADLIB_VCC), .SD(
        ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[4] ));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q[0]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_4_Z[0] )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/CO0 )
        );
    INV_BA AFLSDF_INV_43 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[8] )
        , .Y(AFLSDF_INV_43_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_17  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_33  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_GND), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[18] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[13] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[18] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot[3]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot13_Z )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(ADLIB_VCC), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[3] )
        );
    CFG2 #( .INIT(4'h4) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/genblk1.delayLine[0]_3[1]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_i_0_Z ), 
        .B(\FREQ_OFFSET_c[1] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[1] )
        );
    ARI1_CC #( .INIT(20'h5AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_9_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[9] )
        , .C(ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_8 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[9] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_9 )
        , .CC(NET_CC_CONFIG78), .P(NET_CC_CONFIG75), .Y3(
        NET_CC_CONFIG76), .Y3A(NET_CC_CONFIG77));
    INV_BA AFLSDF_INV_94 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[12] )
        , .Y(AFLSDF_INV_94_net_1));
    INV_BA AFLSDF_INV_104 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[2] )
        , .Y(AFLSDF_INV_104_net_1));
    CFG2 #( .INIT(4'h1) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/wA_1_RNIJ73NE[4]  (
        .A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[4] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[5] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_2 ));
    IOTRI_OB_EB #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \SINE_obuf[2]/U_IOTRI  (.D(
        \SINE_c[2] ), .E(ADLIB_VCC), .DOUT(\SINE_obuf[2]/DOUT ), .EOUT(
        \SINE_obuf[2]/EOUT ));
    INV_BA AFLSDF_INV_88 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[18] )
        , .Y(AFLSDF_INV_88_net_1));
    INV_BA AFLSDF_INV_11 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[2] )
        , .Y(AFLSDF_INV_11_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_17  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_GND), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[9] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/ECC_EN_net )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[9] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/genblk1.delayLine[0][3]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[3] )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[3] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_14  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    ARI1_CC #( .INIT(20'h5AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_6_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[6] )
        , .C(ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_5 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[6] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_6 )
        , .CC(NET_CC_CONFIG66), .P(NET_CC_CONFIG63), .Y3(
        NET_CC_CONFIG64), .Y3A(NET_CC_CONFIG65));
    INV_BA AFLSDF_INV_29 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[2] )
        , .Y(AFLSDF_INV_29_net_1));
    CC_CONFIG 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_s_1_51_CC_0  
        (.CI(ADLIB_VCC), .CO(CI_TO_CO107), .P({ADLIB_VCC, ADLIB_VCC, 
        ADLIB_VCC, ADLIB_VCC, ADLIB_VCC, ADLIB_VCC, ADLIB_VCC, 
        ADLIB_GND, NET_CC_CONFIG108, NET_CC_CONFIG112, 
        NET_CC_CONFIG116, NET_CC_CONFIG120}), .Y3({ADLIB_VCC, 
        ADLIB_VCC, ADLIB_VCC, ADLIB_VCC, ADLIB_VCC, ADLIB_VCC, 
        ADLIB_VCC, ADLIB_GND, NET_CC_CONFIG109, NET_CC_CONFIG113, 
        NET_CC_CONFIG117, NET_CC_CONFIG121}), .Y3A({ADLIB_VCC, 
        ADLIB_VCC, ADLIB_VCC, ADLIB_VCC, ADLIB_VCC, ADLIB_VCC, 
        ADLIB_VCC, ADLIB_GND, NET_CC_CONFIG110, NET_CC_CONFIG114, 
        NET_CC_CONFIG118, NET_CC_CONFIG122}), .CC({nc45, nc46, nc47, 
        nc48, nc49, nc50, nc51, nc52, NET_CC_CONFIG111, 
        NET_CC_CONFIG115, NET_CC_CONFIG119, NET_CC_CONFIG123}));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_23  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[7] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[12] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[9] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[12] )
        );
    CFG4 #( .INIT(16'h7FFF) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_1  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[4] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[3] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[2] ), .D(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[0] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_1_Z )
        );
    INV_BA AFLSDF_INV_45 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[6] )
        , .Y(AFLSDF_INV_45_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_3  
        (.A(ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_23 ), .C(
        ADLIB_GND), .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[1] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[1] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[1] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_10  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[2] )
        , .IPB(), .IPC(), .IPD());
    INV_BA AFLSDF_INV_3 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[10] )
        , .Y(AFLSDF_INV_3_net_1));
    ARI1_CC #( .INIT(20'h5AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_10_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[10] )
        , .C(ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_9 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[10] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_10 )
        , .CC(NET_CC_CONFIG82), .P(NET_CC_CONFIG79), .Y3(
        NET_CC_CONFIG80), .Y3A(NET_CC_CONFIG81));
    CFG2 #( .INIT(4'h1) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0_RNO_4  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[1] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[3] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/m4_e_0 )
        );
    IOIN_IB_E #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \FREQ_OFFSET_ibuf[0]/U_IOIN  (.Y(
        \FREQ_OFFSET_c[0] ), .E(ADLIB_GND), .YIN(
        \FREQ_OFFSET_ibuf[0]/YIN ));
    INV_BA AFLSDF_INV_98 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[8] )
        , .Y(AFLSDF_INV_98_net_1));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q[1]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[1] )
        , .CLK(NN_1), .EN(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        , .ALn(NGRST_c), .ADn(ADLIB_VCC), .SLn(ADLIB_VCC), .SD(
        ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[1] ));
    INV_BA AFLSDF_INV_7 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[6] )
        , .Y(AFLSDF_INV_7_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_19  
        (.EN(ADLIB_VCC), .IPEN());
    IOPAD_IN \FREQ_OFFSET_ibuf[1]/U_IOPAD  (.PAD(FREQ_OFFSET[1]), .Y(
        \FREQ_OFFSET_ibuf[1]/YIN ));
    INV_BA AFLSDF_INV_64 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[4] )
        , .Y(AFLSDF_INV_64_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_24  
        (.EN(ADLIB_VCC), .IPEN());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_32  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4 #( .INIT(16'hAAA9) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0_RNIG2SAH  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[3] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[2] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[1] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[0] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_10 )
        );
    CFG2 #( .INIT(4'h2) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/pulsei  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/synced_ngrst ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/synced_ngrst_t1 )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/pulsei_Z )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_25  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[8] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[13] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[10] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[13] )
        );
    CFG2 #( .INIT(4'hE) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wEn_long_RNO  (
        .A(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/last_wA_last_clk_long_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/delayLine_0_ ), 
        .Y(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/un1_last_wA_last_clk_long_1_i )
        );
    ARI1_CC #( .INIT(20'h48800) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry[4]  
        (.A(ADLIB_VCC), .B(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[4] ), 
        .C(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .D(ADLIB_GND), 
        .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[3] )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[4] )
        , .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[4] )
        , .CC(NET_CC_CONFIG22), .P(NET_CC_CONFIG19), .Y3(
        NET_CC_CONFIG20), .Y3A(NET_CC_CONFIG21));
    INV_BA AFLSDF_INV_101 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[5] )
        , .Y(AFLSDF_INV_101_net_1));
    CFG3 #( .INIT(8'h80) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/wA_1_RNIRPK2M[3]  (
        .A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[5] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[4] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[3] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_26_mux ));
    CFG2 #( .INIT(4'h1) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_4[0]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/delayLine_0_ ), 
        .B(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/CO0 )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_4_Z[0] )
        );
    CFG2 #( .INIT(4'h6) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr[3]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[3] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[3] )
        );
    ARI1_CC #( .INIT(20'h48800) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[8]  
        (.A(ADLIB_VCC), .B(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[8] ), 
        .C(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .D(ADLIB_GND), 
        .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[7] )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s_Z[8] )
        , .Y(), .FCO(), .CC(NET_CC_CONFIG38), .P(NET_CC_CONFIG35), .Y3(
        NET_CC_CONFIG36), .Y3A(NET_CC_CONFIG37));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_23  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4 #( .INIT(16'hFFE0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_0_iv[0]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_2_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_Z )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[0] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue_m_1[0] )
        , .Y(\SINE_c[0] ));
    INV_BA AFLSDF_INV_23 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[9] )
        , .Y(AFLSDF_INV_23_net_1));
    CFG4 #( .INIT(16'hC400) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/wA_1_RNI4MCSQ1[3]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[3] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_35 ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_33 ), .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_2 ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/N_35_mux_2 ));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][1]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_1_0_S )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[1] )
        );
    INV_BA AFLSDF_INV_19 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[13] )
        , .Y(AFLSDF_INV_19_net_1));
    CFG2 #( .INIT(4'hE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_4  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[1] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[6] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_4_Z )
        );
    ARI1_CC #( .INIT(20'h5AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_7_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[7] )
        , .C(ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_6 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[7] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_7 )
        , .CC(NET_CC_CONFIG70), .P(NET_CC_CONFIG67), .Y3(
        NET_CC_CONFIG68), .Y3A(NET_CC_CONFIG69));
    IOPAD_TRI \COSINE_obuf[3]/U_IOPAD  (.PAD(COSINE[3]), .D(
        \COSINE_obuf[3]/DOUT ), .E(\COSINE_obuf[3]/EOUT ));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][11]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[11] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[11] )
        );
    INV_BA AFLSDF_INV_4 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[9] )
        , .Y(AFLSDF_INV_4_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_21  
        (.EN(ADLIB_VCC), .IPEN());
    INV_BA AFLSDF_INV_68 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[0] )
        , .Y(AFLSDF_INV_68_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_4  
        (.EN(ADLIB_VCC), .IPEN());
    ARI1_CC #( .INIT(20'h5AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_15_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[15] )
        , .C(ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_14 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[15] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_15 )
        , .CC(NET_CC_CONFIG102), .P(NET_CC_CONFIG99), .Y3(
        NET_CC_CONFIG100), .Y3A(NET_CC_CONFIG101));
    INV_BA AFLSDF_INV_57 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[11] )
        , .Y(AFLSDF_INV_57_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_11  
        (.EN(ADLIB_VCC), .IPEN());
    CFG2 #( .INIT(4'hE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[1] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[2] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_Z )
        );
    INV_BA AFLSDF_INV_34 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[17] )
        , .Y(AFLSDF_INV_34_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_20  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    INV_BA AFLSDF_INV_25 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[7] )
        , .Y(AFLSDF_INV_25_net_1));
    CFG4 #( .INIT(16'hF0E0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_0_iv_RNO[0]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[3] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[4] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[0] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_7_Z )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue_m_1[0] )
        );
    INV_BA AFLSDF_INV_74 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[13] )
        , .Y(AFLSDF_INV_74_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_34  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q[7]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[7] )
        , .CLK(NN_1), .EN(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        , .ALn(NGRST_c), .ADn(ADLIB_VCC), .SLn(ADLIB_VCC), .SD(
        ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] ));
    ARI1_CC #( .INIT(20'h52288) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_2_0  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[2] )
        , .B(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[2] )
        , .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_1 )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_2_0_S )
        , .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_2 )
        , .CC(NET_CC_CONFIG50), .P(NET_CC_CONFIG47), .Y3(
        NET_CC_CONFIG48), .Y3A(NET_CC_CONFIG49));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_8  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[1] )
        , .IPB(), .IPC(), .IPD());
    CFG4 #( .INIT(16'hFEFC) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv[3]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_4_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_1_Z[3] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red_m[3] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[3] )
        , .Y(\COSINE_c[3] ));
    ARI1_CC #( .INIT(20'h48800) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry[1]  
        (.A(ADLIB_VCC), .B(\SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[1] ), 
        .C(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .D(ADLIB_GND), 
        .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[0] )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[1] )
        , .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[1] )
        , .CC(NET_CC_CONFIG10), .P(NET_CC_CONFIG7), .Y3(NET_CC_CONFIG8)
        , .Y3A(NET_CC_CONFIG9));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_31  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_GND), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[17] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[12] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[17] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q[6]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[6] )
        , .CLK(NN_1), .EN(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        , .ALn(NGRST_c), .ADn(ADLIB_VCC), .SLn(ADLIB_VCC), .SD(
        ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] ));
    INV_BA AFLSDF_INV_13 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[0] )
        , .Y(AFLSDF_INV_13_net_1));
    CFG4 #( .INIT(16'h0CAE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_1[3]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_2_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_1_Z )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_10 )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_8 )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_1_Z[3] )
        );
    CFG4 #( .INIT(16'hFFA2) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0_RNO_3  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[4] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/m4_e_0 )
        , .C(\SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[2] ), .D(
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[5] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_28_mux )
        );
    CFG3 #( .INIT(8'h80) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot17  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[11] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[10] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot17_Z )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_11  
        (.EN(ADLIB_VCC), .IPEN());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/genblk1.delayLine[0][0]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[0] )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[0] )
        );
    ARI1_CC #( .INIT(20'h52288) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_3_0  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[3] )
        , .B(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[3] )
        , .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_2 )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_3_0_S )
        , .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_3 )
        , .CC(NET_CC_CONFIG54), .P(NET_CC_CONFIG51), .Y3(
        NET_CC_CONFIG52), .Y3A(NET_CC_CONFIG53));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_1  
        (.EN(ADLIB_VCC), .IPEN());
    INV_BA AFLSDF_INV_38 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[13] )
        , .Y(AFLSDF_INV_38_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_24  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[0] )
        , .IPB(), .IPC(), .IPD());
    IOPAD_TRI \SINE_obuf[1]/U_IOPAD  (.PAD(SINE[1]), .D(
        \SINE_obuf[1]/DOUT ), .E(\SINE_obuf[1]/EOUT ));
    IOIN_IB_E #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \FREQ_OFFSET_ibuf[1]/U_IOIN  (.Y(
        \FREQ_OFFSET_c[1] ), .E(ADLIB_GND), .YIN(
        \FREQ_OFFSET_ibuf[1]/YIN ));
    CFG2 #( .INIT(4'h6) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr[2]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[2] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[2] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_12  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    INV_BA AFLSDF_INV_44 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[7] )
        , .Y(AFLSDF_INV_44_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_2  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    INV_BA AFLSDF_INV_78 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[9] )
        , .Y(AFLSDF_INV_78_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_21  
        (.A(ADLIB_GND), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[6] )
        , .D(ADLIB_GND), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/BUSY_FB_net )
        , .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[11] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[8] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[11] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_8  
        (.EN(ADLIB_VCC), .IPEN());
    ARI1_CC #( .INIT(20'h48800) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry[5]  
        (.A(ADLIB_VCC), .B(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[5] ), 
        .C(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .D(ADLIB_GND), 
        .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[4] )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[5] )
        , .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[5] )
        , .CC(NET_CC_CONFIG26), .P(NET_CC_CONFIG23), .Y3(
        NET_CC_CONFIG24), .Y3A(NET_CC_CONFIG25));
    INV_BA AFLSDF_INV_15 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[18] )
        , .Y(AFLSDF_INV_15_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_34  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_7  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[0] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[4] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[2] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[4] )
        );
    INV_BA AFLSDF_INV_2 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[11] )
        , .Y(AFLSDF_INV_2_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_35  
        (.EN(ADLIB_VCC), .IPEN());
    INV_BA AFLSDF_INV_80 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[7] )
        , .Y(AFLSDF_INV_80_net_1));
    CFG2 #( .INIT(4'h6) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0_RNI81EL8  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[0] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[1] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_6[1] )
        );
    CC_CONFIG 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_s_1_51_CC_1  
        (.CI(CI_TO_CO107), .CO(), .P({NET_CC_CONFIG124, 
        NET_CC_CONFIG128, NET_CC_CONFIG132, NET_CC_CONFIG136, 
        NET_CC_CONFIG140, NET_CC_CONFIG144, NET_CC_CONFIG148, 
        NET_CC_CONFIG152, NET_CC_CONFIG156, ADLIB_VCC, ADLIB_VCC, 
        ADLIB_VCC}), .Y3({NET_CC_CONFIG125, NET_CC_CONFIG129, 
        NET_CC_CONFIG133, NET_CC_CONFIG137, NET_CC_CONFIG141, 
        NET_CC_CONFIG145, NET_CC_CONFIG149, NET_CC_CONFIG153, 
        NET_CC_CONFIG157, ADLIB_VCC, ADLIB_VCC, ADLIB_VCC}), .Y3A({
        NET_CC_CONFIG126, NET_CC_CONFIG130, NET_CC_CONFIG134, 
        NET_CC_CONFIG138, NET_CC_CONFIG142, NET_CC_CONFIG146, 
        NET_CC_CONFIG150, NET_CC_CONFIG154, NET_CC_CONFIG158, 
        ADLIB_VCC, ADLIB_VCC, ADLIB_VCC}), .CC({NET_CC_CONFIG127, 
        NET_CC_CONFIG131, NET_CC_CONFIG135, NET_CC_CONFIG139, 
        NET_CC_CONFIG143, NET_CC_CONFIG147, NET_CC_CONFIG151, 
        NET_CC_CONFIG155, NET_CC_CONFIG159, nc53, nc54, nc55}));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_11  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[2] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[6] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[4] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[6] )
        );
    CFG3 #( .INIT(8'h20) )  
        \SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr  (.A(RSTN_c), 
        .B(\SINE_GENERATOR/COREDDS_C0_0/INIT_OVER ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/synced_ngrst ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_33  
        (.EN(ADLIB_VCC), .IPEN());
    INV_BA AFLSDF_INV_48 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[3] )
        , .Y(AFLSDF_INV_48_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_1  
        (.A(ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_32_i )
        , .C(ADLIB_GND), .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[0] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[0] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[0] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][10]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[10] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[10] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_30  
        (.EN(ADLIB_VCC), .IPEN());
    INV_BA AFLSDF_INV_90 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[16] )
        , .Y(AFLSDF_INV_90_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_35  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_VCC), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[19] )
        , .IPC(), .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[19] )
        );
    CFG4 #( .INIT(16'hEAC0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0[1]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_3_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_Z )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[1] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[1] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0_Z[1] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_18  
        (.EN(ADLIB_VCC), .IPEN());
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_11  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[15] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_10_Z ), 
        .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[10] ), .Y(), 
        .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_11_Z ), 
        .CC(NET_CC_CONFIG155), .P(NET_CC_CONFIG152), .Y3(
        NET_CC_CONFIG153), .Y3A(NET_CC_CONFIG154));
    INV_BA AFLSDF_INV_1 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[12] )
        , .Y(AFLSDF_INV_1_net_1));
    RGB 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5_inferred_clock_RNIMR4S5/U0_RGB1  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5_inferred_clock_RNIMR4S5/U0_Y )
        , .EN(ADLIB_VCC), .Y(AFLSDF_INV_53_net_1));
    CFG3 #( .INIT(8'h01) )  \SIN_NEG/Carry_1[3]  (.A(\sin_signal[2] ), 
        .B(\sin_signal[1] ), .C(\SINE_c[0] ), .Y(\SIN_NEG_Carry_1[3] ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_34  
        (.EN(ADLIB_VCC), .IPEN());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_16  
        (.EN(ADLIB_VCC), .IPEN());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_10  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_12  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    ARI1_CC #( .INIT(20'h48800) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry[7]  
        (.A(ADLIB_VCC), .B(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] ), 
        .C(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .D(ADLIB_GND), 
        .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[6] )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[7] )
        , .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[7] )
        , .CC(NET_CC_CONFIG34), .P(NET_CC_CONFIG31), .Y3(
        NET_CC_CONFIG32), .Y3A(NET_CC_CONFIG33));
    IOPAD_IN \FREQ_OFFSET_ibuf[3]/U_IOPAD  (.PAD(FREQ_OFFSET[3]), .Y(
        \FREQ_OFFSET_ibuf[3]/YIN ));
    IOTRI_OB_EB #( .TX_MODE(7'h0), .RX_MODE(4'h0), .TX_OE_MODE(3'h0), .INPUT_DELAY_SEL(2'h0)
        , .DELAY_LINE_MODE(2'h0), .RX_DELAY_VAL(7'h0), .RX_DELAY_VAL_X2(1'h0)
        , .TX_DELAY_VAL(7'h0) )  \COSINE_obuf[0]/U_IOTRI  (.D(
        \COSINE_c[0] ), .E(ADLIB_VCC), .DOUT(\COSINE_obuf[0]/DOUT ), 
        .EOUT(\COSINE_obuf[0]/EOUT ));
    INV_BA AFLSDF_INV_52 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/ECC_EN_net )
        , .Y(AFLSDF_INV_52_net_1));
    INV_BA AFLSDF_INV_24 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[8] )
        , .Y(AFLSDF_INV_24_net_1));
    CFG2 #( .INIT(4'h6) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr[8]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[8] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[8] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_9  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[1] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[5] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[3] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[5] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_25  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[8] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[13] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[10] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[13] )
        );
    GB 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5_inferred_clock_RNIMR4S5  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        , .EN(ADLIB_VCC), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5_inferred_clock_RNIMR4S5/U0_Y )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_2  
        (.EN(ADLIB_VCC), .IPEN());
    IOPAD_IN \RSTN_ibuf/U_IOPAD  (.PAD(RSTN), .Y(\RSTN_ibuf/YIN ));
    ARI1_CC #( .INIT(20'h5AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_11_0  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_Z ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[11] )
        , .C(ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_10 )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[11] ), 
        .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_11 )
        , .CC(NET_CC_CONFIG86), .P(NET_CC_CONFIG83), .Y3(
        NET_CC_CONFIG84), .Y3A(NET_CC_CONFIG85));
    CFG4 #( .INIT(16'h0CAE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_1[3]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_6_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_5_Z )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_10 )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_8 )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_1_Z[3] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/initOver_0/genblk1.delayLine[2]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/initOver_0/delayLine_1_ )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/INIT_OVER ));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_1  
        (.EN(ADLIB_VCC), .IPEN());
    INV_BA AFLSDF_INV_60 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[8] )
        , .Y(AFLSDF_INV_60_net_1));
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_9  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[13] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_8_Z ), 
        .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[8] ), .Y(), 
        .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_9_Z ), 
        .CC(NET_CC_CONFIG147), .P(NET_CC_CONFIG144), .Y3(
        NET_CC_CONFIG145), .Y3A(NET_CC_CONFIG146));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_28  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .B(ADLIB_VCC), .C(
        ADLIB_VCC), .D(ADLIB_VCC), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[2] )
        , .IPB(), .IPC(), .IPD());
    CFG4 #( .INIT(16'hA9FC) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/SINE[3]  
        (.A(\SIN_NEG_Carry_1[3] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_1_Z[3] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0_Z[3] )
        , .D(PN_SIN_c), .Y(\SINE_c[3] ));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/genblk1.delayLine[2]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/delayLine_1_ )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/sync_ngrst_0/sync_ngrst_0/delayLine_2_ )
        );
    INV_BA AFLSDF_INV_28 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[4] )
        , .Y(AFLSDF_INV_28_net_1));
    CFG2 #( .INIT(4'hE) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_2  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[5] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[6] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_2_Z )
        );
    RGB \I_1/U0_RGB1  (.A(\I_1/U0_Y ), .EN(ADLIB_VCC), .Y(
        AFLSDF_INV_54_net_1));
    CFG3 #( .INIT(8'h27) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0_RNO  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/sico_wA[8] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_30_mux )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_13 )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/N_32_i )
        );
    INV_BA AFLSDF_INV_14 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[19] )
        , .Y(AFLSDF_INV_14_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_29  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_GND), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[15] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[16] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[15] )
        );
    INV_BA AFLSDF_INV_56 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[12] )
        , .Y(AFLSDF_INV_56_net_1));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot[7]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot17_Z )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(ADLIB_VCC), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot_Z[7] )
        );
    ARI1_CC #( .INIT(20'h48800) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry[3]  
        (.A(ADLIB_VCC), .B(\SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[3] ), 
        .C(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .D(ADLIB_GND), 
        .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[2] )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[3] )
        , .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[3] )
        , .CC(NET_CC_CONFIG18), .P(NET_CC_CONFIG15), .Y3(
        NET_CC_CONFIG16), .Y3A(NET_CC_CONFIG17));
    CFG3 #( .INIT(8'h6A) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/SINE[1]  
        (.A(\sin_signal[1] ), .B(\SINE_c[0] ), .C(PN_SIN_c), .Y(
        \SINE_c[1] ));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_18  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    CFG3 #( .INIT(8'h08) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot15  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[11] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[10] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot15_Z )
        );
    CFG4 #( .INIT(16'hEAC0) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0[3]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_3_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_Z )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[3] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[3] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_iv_0_Z[3] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_30  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    INV_BA AFLSDF_INV_30 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[1] )
        , .Y(AFLSDF_INV_30_net_1));
    INV_BA AFLSDF_INV_87 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[19] )
        , .Y(AFLSDF_INV_87_net_1));
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/genblk1.delayLine[0][4]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[4] )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/freq_offset[4] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_22  
        (.EN(ADLIB_VCC), .IPEN());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][0]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/un6_ph_reg_inp_cry_0_0_Y )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[0] )
        );
    INV_BA AFLSDF_INV_70 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[18] )
        , .Y(AFLSDF_INV_70_net_1));
    CFG3 #( .INIT(8'hA9) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0_RNIS150D  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[2] )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[1] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[0] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/N_9 )
        );
    IOPAD_TRI \COSINE_obuf[0]/U_IOPAD  (.PAD(COSINE[0]), .D(
        \COSINE_obuf[0]/DOUT ), .E(\COSINE_obuf[0]/EOUT ));
    CFG2 #( .INIT(4'h4) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/genblk1.delayLine[0]_3[2]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_i_0_Z ), 
        .B(\FREQ_OFFSET_c[2] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[2] )
        );
    ARI1_CC #( .INIT(20'h48800) )  
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry[2]  
        (.A(ADLIB_VCC), .B(\SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[2] ), 
        .C(\SINE_GENERATOR/COREDDS_C0_0/sico_wEn ), .D(ADLIB_GND), 
        .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[1] )
        , .S(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[2] )
        , .Y(), .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_cry_Z[2] )
        , .CC(NET_CC_CONFIG14), .P(NET_CC_CONFIG11), .Y3(
        NET_CC_CONFIG12), .Y3A(NET_CC_CONFIG13));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_12  
        (.EN(ADLIB_VCC), .IPEN());
    RAM1K20_IP #( .MEMORYFILE(""), .RAMINDEX("PF__COMPILE__GEN__:SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0%512-512%4-4%SPEED%0%0%TWO-PORT%ECC_EN-0")
         )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/INST_RAM1K20_IP  
        (.A_DOUT({nc56, nc57, nc58, nc59, nc60, nc61, nc62, nc63, nc64, 
        nc65, nc66, nc67, nc68, nc69, nc70, nc71, 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_blue[0] })
        , .B_DOUT({nc72, nc73, nc74, nc75, nc76, nc77, nc78, nc79, 
        nc80, nc81, nc82, nc83, nc84, nc85, nc86, nc87, nc88, nc89, 
        nc90, nc91}), .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(), 
        .A_ADDR({AFLSDF_INV_55_net_1, AFLSDF_INV_56_net_1, 
        AFLSDF_INV_57_net_1, AFLSDF_INV_58_net_1, AFLSDF_INV_59_net_1, 
        AFLSDF_INV_60_net_1, AFLSDF_INV_61_net_1, AFLSDF_INV_62_net_1, 
        AFLSDF_INV_63_net_1, AFLSDF_INV_64_net_1, AFLSDF_INV_65_net_1, 
        AFLSDF_INV_66_net_1, AFLSDF_INV_67_net_1, AFLSDF_INV_68_net_1})
        , .A_BLK_EN({
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_BLK_EN_net[0] })
        , .A_CLK(NN_1), .A_DIN({AFLSDF_INV_69_net_1, 
        AFLSDF_INV_70_net_1, AFLSDF_INV_71_net_1, ADLIB_GND, 
        AFLSDF_INV_72_net_1, AFLSDF_INV_73_net_1, AFLSDF_INV_74_net_1, 
        AFLSDF_INV_75_net_1, AFLSDF_INV_76_net_1, AFLSDF_INV_77_net_1, 
        AFLSDF_INV_78_net_1, AFLSDF_INV_79_net_1, AFLSDF_INV_80_net_1, 
        AFLSDF_INV_81_net_1, AFLSDF_INV_82_net_1, AFLSDF_INV_83_net_1, 
        ADLIB_GND, AFLSDF_INV_84_net_1, AFLSDF_INV_85_net_1, 
        AFLSDF_INV_86_net_1}), .A_REN(ADLIB_VCC), .A_WEN({ADLIB_GND, 
        ADLIB_GND}), .A_DOUT_EN(ADLIB_VCC), .A_DOUT_ARST_N(ADLIB_VCC), 
        .A_DOUT_SRST_N(ADLIB_VCC), .B_ADDR({ADLIB_GND, ADLIB_GND, 
        ADLIB_GND, \SINE_GENERATOR/COREDDS_C0_0/sico_wA[8] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[7] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[6] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[5] , 
        \SINE_GENERATOR/COREDDS_C0_0/sico_wA[4] , 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[3] , 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[0] , ADLIB_GND, ADLIB_GND})
        , .B_BLK_EN({
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[2] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[1] , 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[0] })
        , .B_CLK(\SINE_GENERATOR/COREDDS_C0_0/slow_clk ), .B_DIN({
        AFLSDF_INV_87_net_1, AFLSDF_INV_88_net_1, AFLSDF_INV_89_net_1, 
        AFLSDF_INV_90_net_1, AFLSDF_INV_91_net_1, AFLSDF_INV_92_net_1, 
        AFLSDF_INV_93_net_1, AFLSDF_INV_94_net_1, AFLSDF_INV_95_net_1, 
        AFLSDF_INV_96_net_1, AFLSDF_INV_97_net_1, AFLSDF_INV_98_net_1, 
        AFLSDF_INV_99_net_1, AFLSDF_INV_100_net_1, 
        AFLSDF_INV_101_net_1, AFLSDF_INV_102_net_1, 
        AFLSDF_INV_103_net_1, AFLSDF_INV_104_net_1, 
        AFLSDF_INV_105_net_1, AFLSDF_INV_106_net_1}), .B_REN(ADLIB_VCC)
        , .B_WEN({ADLIB_GND, ADLIB_VCC}), .B_DOUT_EN(ADLIB_VCC), 
        .B_DOUT_ARST_N(ADLIB_GND), .B_DOUT_SRST_N(ADLIB_VCC), .ECC_EN(
        AFLSDF_INV_107_net_1), .BUSY_FB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/BUSY_FB_net )
        , .A_WIDTH({ADLIB_GND, ADLIB_VCC, ADLIB_GND}), .A_WMODE({
        ADLIB_GND, ADLIB_GND}), .A_BYPASS(ADLIB_VCC), .B_WIDTH({
        ADLIB_GND, ADLIB_VCC, ADLIB_GND}), .B_WMODE({ADLIB_GND, 
        ADLIB_GND}), .B_BYPASS(ADLIB_VCC), .ECC_BYPASS(ADLIB_GND));
    INV_BA AFLSDF_INV_18 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[14] )
        , .Y(AFLSDF_INV_18_net_1));
    IOPAD_IN \NGRST_ibuf/U_IOPAD  (.PAD(NGRST), .Y(\NGRST_ibuf/YIN ));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_20  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_31  
        (.EN(ADLIB_VCC), .IPEN());
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_7  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[11] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_6_Z ), 
        .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[6] ), .Y(), 
        .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_7_Z ), 
        .CC(NET_CC_CONFIG139), .P(NET_CC_CONFIG136), .Y3(
        NET_CC_CONFIG137), .Y3A(NET_CC_CONFIG138));
    INV_BA AFLSDF_INV_97 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[9] )
        , .Y(AFLSDF_INV_97_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_25  
        (.EN(ADLIB_VCC), .IPEN());
    CFG3 #( .INIT(8'h04) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot11  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[11] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[10] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot11_Z )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_19  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[5] )
        , .D(ADLIB_GND), .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[10] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_ADDR_net[7] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[10] )
        );
    CFG4 #( .INIT(16'h2228) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/cosine_w_iv_RNO[2]  
        (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/un1_mapBits_oneHot_6_Z )
        , .B(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[2] )
        , .C(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[1] )
        , .D(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/Q_red[0] )
        , .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/sine_w_7_m[2] )
        );
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q[2]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/wA_count_0/Q_s[2] )
        , .CLK(NN_1), .EN(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/N_5 )
        , .ALn(NGRST_c), .ADn(ADLIB_VCC), .SLn(ADLIB_VCC), .SD(
        ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/lfsr_wA[2] ));
    INV_BA AFLSDF_INV_105 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[1] )
        , .Y(AFLSDF_INV_105_net_1));
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_12  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_26  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_BLK_EN_net[1] )
        , .IPB(), .IPC(), .IPD());
    INV_BA AFLSDF_INV_40 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[11] )
        , .Y(AFLSDF_INV_40_net_1));
    CFG3 #( .INIT(8'h20) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot16  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[11] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .C(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[10] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/mapBits_oneHot16_Z )
        );
    ARI1_CC #( .INIT(20'h4AA00) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_1  (.A(
        ADLIB_VCC), .B(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[5] ), .C(
        ADLIB_GND), .D(ADLIB_GND), .FCI(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_s_1_51_FCO )
        , .S(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[0] ), .Y(), 
        .FCO(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/round_inp_cry_1_Z ), 
        .CC(NET_CC_CONFIG115), .P(NET_CC_CONFIG112), .Y3(
        NET_CC_CONFIG113), .Y3A(NET_CC_CONFIG114));
    CFG2 #( .INIT(4'h4) )  
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/genblk1.delayLine[0]_3[0]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/rstn_full_wave_addr_i_0_Z ), 
        .B(\FREQ_OFFSET_c[0] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/var_ph_inc_port.ext_ph_inc_0/delayLine_0__3[0] )
        );
    INV_BA AFLSDF_INV_51 (.A(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[0] )
        , .Y(AFLSDF_INV_51_net_1));
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_5  
        (.A(ADLIB_VCC), .B(ADLIB_GND), .C(ADLIB_GND), .D(ADLIB_GND), 
        .Y(), .IPB(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[2] )
        , .IPC(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/B_DIN_net[3] )
        , .IPD(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/A_DIN_net[2] )
        );
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_16  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q[1]  
        (.D(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_4_Z[1] )
        , .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/dds_initializer_0/slow_count_0/Q_Z[1] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_8  
        (.EN(ADLIB_VCC), .IPEN());
    CFG4_IP_ABCD #( .INIT(16'hAAAA) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_red_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/CFG_34  
        (.A(ADLIB_VCC), .B(ADLIB_VCC), .C(ADLIB_VCC), .D(ADLIB_VCC), 
        .Y(), .IPB(), .IPC(), .IPD());
    SLE 
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_accum_through.ph_accum_0/genblk1.delayLine[0][14]  
        (.D(\SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_acc_s[14] ), 
        .CLK(NN_1), .EN(ADLIB_VCC), .ALn(NGRST_c), .ADn(ADLIB_VCC), 
        .SLn(ADLIB_VCC), .SD(ADLIB_GND), .LAT(ADLIB_GND), .Q(
        \SINE_GENERATOR/COREDDS_C0_0/quantizer_0/ph_accum_0/ph_reg[14] )
        );
    CFG2 #( .INIT(4'h6) )  
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr[4]  
        (.A(\SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[9] ), .B(
        \SINE_GENERATOR/COREDDS_C0_0/full_wave_addr[4] ), .Y(
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/rA_qrtr_Z[4] )
        );
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_0  
        (.EN(ADLIB_VCC), .IPEN());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_6  
        (.EN(ADLIB_VCC), .IPEN());
    SLE_IP_EN 
        \SINE_GENERATOR/COREDDS_C0_0/sin_cos_lut_0/qrtr_wave.grtr_lut_0/qrtr_blue_ram_0/PF_lsram.lsram_g5_0/COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0/FF_23  
        (.EN(ADLIB_VCC), .IPEN());
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
