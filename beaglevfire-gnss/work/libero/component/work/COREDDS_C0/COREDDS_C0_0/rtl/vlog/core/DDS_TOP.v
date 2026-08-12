//****************************************************************
//Microsemi Corporation Proprietary and Confidential
//Copyright 2016 Microsemi Corporation.  All rights reserved
//
//ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
//ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
//IN ADVANCE IN WRITING.
//
//Description: CoreDDS
//             Top level module
//
//Rev:
//v3.0 8/23/2016
//
//SVN Revision Information:
//SVN$Revision:$
//SVN$Date:$
//
//Resolved SARS
//
//Notes:
//
//****************************************************************

`timescale 1 ns/100 ps

module COREDDS_C0_COREDDS_C0_0_COREDDS (
  FREQ_OFFSET,
  FREQ_OFFSET_WE,
  PH_OFFSET,
  PH_OFFSET_WE,
  SINE, COSINE,
  NGRST, RSTN, CLK,
  INIT,                 // Optional external INIT
  INIT_OVER );
  parameter PH_ACC_BITS     = 24;
  parameter PH_INC_MODE     = 0;
  parameter PH_INC_LOWER    = 1000000;
  parameter PH_INC_UPPER    = 0;
  parameter SIN_ON          = 1;
  parameter COS_ON          = 1;
  parameter SIN_POLARITY    = 0;
  parameter COS_POLARITY    = 0;
  parameter FREQ_OFFSET_BITS= 3;
  parameter PH_OFFSET_MODE  = 0;
  parameter PH_OFFSET_CONST_LOWER = 1;
  parameter PH_OFFSET_CONST_UPPER = 0;
  parameter PH_OFFSET_BITS  = 3;
  parameter PH_CORRECTION   = 0;
  parameter QUANTIZER_BITS  = 8;
  parameter OUTPUT_BITS     = 18;
  parameter LATENCY         = 3;
  parameter URAM_MAXDEPTH   = 0;
  parameter FPGA_FAMILY     = 26;
  parameter DIE_SIZE        = 15;
  // Use in Standalone only
  parameter MAX_FULL_WAVE_LOGDEPTH = 9;

  localparam SIMUL_RAM = 0;
  localparam QUARTER_WAVE = (QUANTIZER_BITS > MAX_FULL_WAVE_LOGDEPTH)? 1 : 0;
  localparam RAM_LOGDEPTH = (QUARTER_WAVE==0)? QUANTIZER_BITS : QUANTIZER_BITS-3;
  
  // !!! Set Slow clk divider on RTL and backend SW !!!
  localparam SLOWCLK_DIV  = 4;
  localparam LOG_SLOWCLK_DIV  = 2;      // log2(SLOWCLK_DIV) 

  // Trigonometric correction takes both sin and cos of the quantized angle to
  // calculate the correction. Thus must build both LUT's if PH_CORRECTION==2
  localparam SIN_ONI = (PH_CORRECTION==2)? 1 : SIN_ON;
  localparam COS_ONI = (PH_CORRECTION==2)? 1 : COS_ON;

  // Calculate pipe values
  localparam PIPE1  = (LATENCY>1)? 1 : 0;
  localparam PIPE2  = (((PH_OFFSET_MODE!=0) || (PH_CORRECTION==1)) && (LATENCY>1))? 1 : 0;
  localparam PIPE3  = ((PH_CORRECTION==0) && (QUANTIZER_BITS<PH_ACC_BITS) && (LATENCY>1))? 1 : 0;
  // PIPE 4
  // LSRAM always have the rA pipe on - it cannot be turned off. To follow this
  // behavior on uRAM, where rA pipe is optional, we'll keep PIPE4 always on
  localparam PIPE4  = 1;
  // Fabric-based rA pipe in addition to the PIPE4 to speed up the design in 
  // the case of large LUT  
  localparam PIPE4EXT = (LATENCY>1)? 1 : 0;                                   //speed
  localparam PIPE5  = (LATENCY>0)? 1 : 0;
  localparam PIPE6  = (LATENCY>2)? 1 : 0;
  localparam PIPE7  = ((QUARTER_WAVE>0) && (LATENCY>1))? 1 : 0;
  // Trigonometric Correction pipes
  localparam PIPE8  = ((PH_CORRECTION==2) && (PIPE4==1))? 1 : 0;
  localparam PIPE9  = ((PH_CORRECTION==2) && (PIPE5==1))? 1 : 0;
  localparam PIPE10 = ((PH_CORRECTION==2) && (LATENCY>2))? 1 : 0;
  localparam PIPE11 = ((PH_CORRECTION==2) && (LATENCY>1))? 1 : 0;

  input [FREQ_OFFSET_BITS-1:0] FREQ_OFFSET;
  input [PH_OFFSET_BITS-1:0] PH_OFFSET;
  input FREQ_OFFSET_WE, PH_OFFSET_WE;
  input NGRST, RSTN, INIT, CLK;
  output[OUTPUT_BITS-1:0] SINE, COSINE;
  output INIT_OVER;

  wire rstni, slow_clk, lfsr_wEn, sico_wEn;
  wire rstn_full_wave_addr;
  wire[3:0] lfsr_wA, lfsr_rA;
  wire[5:0] lfsr_Q;
  wire[QUANTIZER_BITS-1:0] full_wave_addr;
  wire[RAM_LOGDEPTH-1:0] sico_wA;
  wire[OUTPUT_BITS-1:0] sino, coso;
  wire[PH_ACC_BITS-1:0] ph_acc_s;

//                      +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+
//                      |I|n|i|t|i|a|l|i|z|e| |L|U|T|s|
//                      +-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+

  dds_LUT_initializer # (.RAM_LOGDEPTH(RAM_LOGDEPTH),
      .SLOWCLK_DIV  (SLOWCLK_DIV),
      .LOG_SLOWCLK_DIV  (LOG_SLOWCLK_DIV) ) dds_initializer_0 (
    .clk(CLK), .nGrst(NGRST), .ext_rstn(RSTN), .ext_init(INIT),
    .init_over(INIT_OVER), 
    // Output rstni gets generated on nGrst as well as on ext_rstn 
    .rstn(rstni), .slow_clk(slow_clk),
    .sico_wEn(sico_wEn), .sico_wA (sico_wA ),
    .lfsr_wEn(lfsr_wEn), .lfsr_wA (lfsr_wA ) );

  // Sin and Cos LUT's
  COREDDS_C0_COREDDS_C0_0_sin_cos_lut # (
      .QUANTIZER_BITS(QUANTIZER_BITS),  // Full-wave Logdepth
      .WIDTH        (OUTPUT_BITS),
      .QUARTER_WAVE (QUARTER_WAVE ),
      .SIN_ON       (SIN_ONI),
      .COS_ON       (COS_ONI),
      .SIN_POLARITY (SIN_POLARITY),
      .COS_POLARITY (COS_POLARITY),
      .FPGA_FAMILY  (FPGA_FAMILY  ),
      .URAM_MAXDEPTH(URAM_MAXDEPTH),
      .PIPE4  (PIPE4),
      .PIPE4EXT(PIPE4EXT),                                  //speed
      .PIPE5  (PIPE5),
      .PIPE6  (PIPE6),
      .PIPE7  (PIPE7),
      .SIMUL_RAM    (SIMUL_RAM    ) ) sin_cos_lut_0 (
    .nGrst(NGRST),
    .rClk(CLK),
    .wClk(slow_clk),
    .wEn (sico_wEn),
    .wA  (sico_wA),
    // Read ports
    .full_wave_addr  (full_wave_addr),
    .sino(sino),
    .coso(coso) );

  generate if ( (PH_CORRECTION!=2) || (PH_ACC_BITS<=QUANTIZER_BITS) )
    begin: no_trig_corr
      assign SINE = sino;
      assign COSINE = coso;
    end
  endgenerate

  // To start from 0 phase, reset the rA (full_wave_addr) by the INIT_OVER
  assign rstn_full_wave_addr = rstni & (~INIT_OVER);
  dds_quantizer # (
      .PH_ACC_BITS    (PH_ACC_BITS    ),
      .PH_INC_MODE    (PH_INC_MODE),
      .PH_INC_LOWER   (PH_INC_LOWER     ),
      .PH_INC_UPPER   (PH_INC_UPPER     ),
      .QUANTIZER_BITS (QUANTIZER_BITS ),
      .FREQ_OFFSET_BITS(FREQ_OFFSET_BITS),
      .PH_OFFSET_MODE (PH_OFFSET_MODE ),
      .PH_OFFSET_CONST_LOWER(PH_OFFSET_CONST_LOWER),
      .PH_OFFSET_CONST_UPPER(PH_OFFSET_CONST_UPPER),
      .PH_OFFSET_BITS (PH_OFFSET_BITS ),
      .PH_CORRECTION  (PH_CORRECTION  ),
      .PIPE1  (PIPE1),
      .PIPE2  (PIPE2),
      .PIPE3  (PIPE3),
      // LFSR LUT initialization params
      .FPGA_FAMILY(FPGA_FAMILY),
      .SIMUL_RAM  (SIMUL_RAM  ) ) quantizer_0 (
    .clk            (CLK  ),
    .rstn           (rstn_full_wave_addr ),
    .nGrst          (NGRST),
    .ext_freq_offset(FREQ_OFFSET),
    .freq_offset_we (FREQ_OFFSET_WE ),
    .ext_ph_offset  (PH_OFFSET  ),
    .ph_offset_we   (PH_OFFSET_WE   ),
    .dith_init      (lfsr_wEn   ),
    .ph_acc_s       (ph_acc_s),
    .full_wave_addr (full_wave_addr ),
    // LFSR LUT initialization ports
    .slow_clk(slow_clk),
    .lfsr_wEn(lfsr_wEn),
    .lfsr_wA (lfsr_wA ) );


  // No Trigonom correction if QUANTIZER_BITS = PH_ACC_BITS
  generate if ((PH_CORRECTION==2) && (PH_ACC_BITS>QUANTIZER_BITS))
    begin: trgonom_corr
      trig_cor # (
            .PH_ACC_BITS   (PH_ACC_BITS   ),
            .QUANTIZER_BITS(QUANTIZER_BITS),
            .LATENCY       (LATENCY       ),
            .FPGA_FAMILY   (FPGA_FAMILY   ),
            .SIN_ON        (SIN_ON),                              //03/06/17
            .COS_ON        (COS_ON),                              //03/06/17
            .SIN_POLARITY  (SIN_POLARITY  ),
            .COS_POLARITY  (COS_POLARITY  ),
            .OUTPUT_BITS   (OUTPUT_BITS   ),
            .PIPE4EXT      (PIPE4EXT),                             //speed
            .PIPE6         (PIPE6 ),
            .PIPE7         (PIPE7 ),
            .PIPE8         (PIPE8 ),
            .PIPE9         (PIPE9 ),
            .PIPE10        (PIPE10),
            .PIPE11        (PIPE11) ) trigonom_corr_0 (
        .clk(CLK), .rstn(RSTN), .nGrst(NGRST),
        .ph_accum_in(ph_acc_s),
        .sinA(sino), .cosA(coso),
        .sin_o(SINE), .cos_o(COSINE) );
    end
  endgenerate

endmodule

