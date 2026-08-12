//****************************************************************
//Microsemi Corporation Proprietary and Confidential
//Copyright 2016 Microsemi Corporation.  All rights reserved
//
//ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
//ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
//IN ADVANCE IN WRITING.
//
//Description: CoreDDS
//             Static modules
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


//                        +-+-+-+-+ +-+-+-+ +-+-+-+-+
//                        |S|i|n|e| |L|U|T| |I|n|i|t|
//                        +-+-+-+-+ +-+-+-+ +-+-+-+-+
// Create LUT initialization sequences. Need to initialize sin/cos LUT's and
// a dithering LFSR 16-word LUT. Initialization starts on the rear end of the
// sync'ed nGrst signal
module dds_LUT_initializer (clk, nGrst, ext_rstn, ext_init, init_over, rstn,
                            slow_clk,
                            sico_wEn, sico_wA,    // to sin LUT
                            lfsr_wEn, lfsr_wA );  // to LFSR LUT
  parameter RAM_LOGDEPTH  = 8;
  parameter SLOWCLK_DIV   = 4;
  parameter LOG_SLOWCLK_DIV = 2;
  // If LFSR table depth is bigger than sin/cos LUT
  localparam LOGDEPTH_LONG = (RAM_LOGDEPTH>3)? RAM_LOGDEPTH : 4;
  localparam LOGDEPTH_SHRT = (RAM_LOGDEPTH>3)? 4 : RAM_LOGDEPTH;
  localparam DEPTH_LONG    = (1 << LOGDEPTH_LONG);
  localparam DEPTH_SHRT    = (1 << LOGDEPTH_SHRT);

  input nGrst, clk, ext_init, ext_rstn;
  output sico_wEn, lfsr_wEn, init_over, rstn, slow_clk;
  output [RAM_LOGDEPTH-1:0] sico_wA;
  output [3:0] lfsr_wA;

  wire init_nGrst, initi, last_wA_last_clk_long, last_wA_last_clk_shrt, last_wA_long;
  reg  wEn_long, wEn_shrt;
  wire [LOGDEPTH_LONG-1:0] wA;

  // Generate 1-clk wide sync'd pulse on the nGrst rising (back) edge OR
  // on the ext_rstn
  dds_kitSyncNgrst # (.PULSE_WIDTH(1) ) sync_ngrst_0 (
    .nGrst(nGrst), .clk(clk), .pulse(init_nGrst),
    .ext_rstn(ext_rstn), .rstn(rstn) );

  assign initi = init_nGrst | ext_init;

  // Slow clk generator
//03/08/17  dds_kitCountS # ( .WIDTH(2), .DCVALUE(3),
  dds_kitCountS # ( .WIDTH(LOG_SLOWCLK_DIV), .DCVALUE(SLOWCLK_DIV-1),
                .BUILD_DC(1) ) slow_count_0 (
    .nGrst(nGrst), .rst(initi), .clk(clk), .clkEn(1'b1),
    .cntEn(1'b1), .Q(), .dc(slow_clk) );

  // Generate two initialization-in-progress signals, wEn_shrt and wEn_long. One
  // lasts long enough to write to deeper LUT whether it is sin/cos or LFSR LUT,
  // another to shorter LUT. They will be used by LUT as wEn
  always @ (negedge nGrst or posedge clk)  begin
    if(nGrst==1'b0) begin
      wEn_shrt  <= 1'b0;
      wEn_long  <= 1'b0;
    end
    else begin
      if(slow_clk==1'b1)  begin
        if(last_wA_last_clk_long==1'b1)
          wEn_long <= 1'b0;
        if(last_wA_last_clk_shrt==1'b1)
          wEn_shrt <= 1'b0;
      end
      if(initi==1'b1) begin
        wEn_long <= 1'b1;
        wEn_shrt <= 1'b1;
      end
    end
  end

  // wA counter covers the long LUT. It counts when wEn=1.
  dds_kitCountS # ( .WIDTH(LOGDEPTH_LONG), .DCVALUE(DEPTH_LONG-1),
                    .BUILD_DC(1) ) wA_count_0 (
    .nGrst(nGrst), .rst(~wEn_long), .clk(clk), .clkEn(slow_clk),
    .cntEn(1'b1), .Q(wA), .dc(last_wA_long) );

  assign last_wA_shrt = (wA == DEPTH_SHRT-1);

  // The last clk of the last wA
  assign last_wA_last_clk_long = last_wA_long & slow_clk;
  assign last_wA_last_clk_shrt = last_wA_shrt & slow_clk;

  assign lfsr_wA = wA[3:0];
  assign lfsr_wEn = (RAM_LOGDEPTH>3)? wEn_shrt : wEn_long;
  assign sico_wA = wA[RAM_LOGDEPTH-1:0];
  assign sico_wEn = (RAM_LOGDEPTH>3)? wEn_long : wEn_shrt;

  // init_over flag is a delayed copy of the last_wA_last_clk
  // 3-clk delay is set to make sure write pipes are over
  dds_kitDelay_bit_reg # (.DELAY(3)) initOver_0 (
    .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
    .inp(last_wA_last_clk_long), .outp(init_over) ) ;

endmodule



//                      +-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+
//                      |P|h|a|s|e| |A|c|c|u|m|u|l|a|t|o|r|
//                      +-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+-+

module dds_ph_accumulator (clk, rstn, nGrst, ext_freq_offset,
                            freq_offset_we, ph_accum);
  parameter PH_INC_MODE = 0;
  parameter FREQ_OFFSET_BITS = 10;
  parameter PH_ACC_BITS = 24;
  parameter PH_INC_LOWER= 1024*1024;
  parameter PH_INC_UPPER= 0;
  parameter PIPE1       = 0;

  localparam [PH_ACC_BITS -1:0] PH_INC = (PH_ACC_BITS > 32) ? {PH_INC_UPPER[19:0], PH_INC_LOWER[27:0]} : PH_INC_LOWER;
  localparam [PH_ACC_BITS -1:0] CONST_FREQ_OFFSET_BITS = ceil_log2(PH_INC)+1;

  input nGrst, clk, rstn, freq_offset_we;
  input [FREQ_OFFSET_BITS-1:0] ext_freq_offset;
  output [PH_ACC_BITS-1:0] ph_accum;

  wire  [FREQ_OFFSET_BITS-1:0] freq_offset_r;
  wire  [PH_ACC_BITS-1:0] freq_offset, ph_adder, ph_reg, ph_reg_inp;
  wire  [CONST_FREQ_OFFSET_BITS-1:0] ph_inc_w;

  assign ph_inc_w = PH_INC;

  // Process phase increment
  generate if (PH_INC_MODE!=0)      // External variable freq_ofset
    begin: var_ph_inc_port
      dds_kitDelay_reg # (.BITWIDTH(FREQ_OFFSET_BITS), .DELAY(1)) ext_ph_inc_0 (
        .nGrst(nGrst), .rst(~rstn), .clk(clk), .clkEn(freq_offset_we),
        .inp(ext_freq_offset), .outp(freq_offset_r) );

      // Sign extend the unsigned offset
      signExt #(.INWIDTH(FREQ_OFFSET_BITS), .OUTWIDTH(PH_ACC_BITS),
                .UNSIGN(1)) signExt_0 (.inp(freq_offset_r), .outp(freq_offset));
    end
  endgenerate

  generate if (PH_INC_MODE==0)      // Internal constant freq_ofset
    begin: const_freq_offset
      // Sign extend the unsigned offset
      signExt #(.INWIDTH(CONST_FREQ_OFFSET_BITS), .OUTWIDTH(PH_ACC_BITS),
                .UNSIGN(1)) signExt_0 (.inp(ph_inc_w), .outp(freq_offset) );
    end
  endgenerate
  // Process phase increment ends

  // Phase Accumulator
  assign ph_adder = freq_offset + ph_reg;

  generate if (PIPE1 != 0) begin: ph_accum_piped
    dds_kitDelay_reg # (.BITWIDTH(PH_ACC_BITS), .DELAY(PIPE1)) ph_accum_0 (
      .nGrst(nGrst), .rst(~rstn), .clk(clk), .clkEn(1'b1),
      .inp(ph_adder), .outp(ph_reg) );
    assign ph_accum = ph_reg;
  end
  endgenerate

  // To provide 0 delay, take output right from the adder.
  // In order to reset the PH_ACC, need to load -PH_INC in accumulator register.
  // Then the reset will set the PH_ACC in 0 state
  generate if (PIPE1 == 0)  begin: ph_accum_through
    // nGrst isn't used here due to RTG4 limitation
    assign ph_reg_inp = (rstn==1'b0)? 'b0 : ph_adder;

    dds_kitDelay_reg # (.BITWIDTH(PH_ACC_BITS), .DELAY(1)) ph_accum_0 (
      .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
      .inp(ph_reg_inp), .outp(ph_reg) );

    assign ph_accum = ph_reg_inp;
    end
  endgenerate

//  --------------------
  function [63:0] ceil_log2;
      input [63:0] x;
      reg [63:0] tmp, res;
    begin
      tmp = 1;
      res = 0;
      while (tmp < x) begin
        tmp = tmp * 2;
        res = res + 1;
      end
      ceil_log2 = res;
    end
  endfunction

endmodule


//         +-+-+-+-+-+ +-+-+-+-+-+-+   +-+-+-+-+-+-+ +-+-+-+-+-+-+
//         |P|h|a|s|e| |O|f|f|s|e|t| & |D|i|t|h|e|r| |b|r|a|n|c|h|
//         +-+-+-+-+-+ +-+-+-+-+-+-+   +-+-+-+-+-+-+ +-+-+-+-+-+-+

module dds_dither_offset (clk, rstn, nGrst, ext_ph_offset,
                            ph_offset_we, dith_init, dith_offs,
                            // LFSR LUT initialization ports
                            slow_clk, lfsr_wEn, lfsr_wA);
  parameter PH_ACC_BITS     = 24;
  parameter QUANTIZER_BITS  = 8;
  parameter PH_OFFSET_MODE  = 0;
  parameter PH_OFFSET_CONST_LOWER = 0;
  parameter PH_OFFSET_CONST_UPPER = 0;
  parameter PH_OFFSET_BITS  = 10;
  // Note: if QUANTIZER_BITS==PH_ACC_BITS, the PH_CORRECTION is forced to be 0
  parameter PH_CORRECTION   = 1;
  parameter PIPE1         = 0;
  // LFSR LUT initialization params
  parameter FPGA_FAMILY = 26;
  parameter SIMUL_RAM   = 1;

  localparam [PH_ACC_BITS -1:0] PH_OFFSET_CONST = (PH_ACC_BITS > 31) ? {PH_OFFSET_CONST_UPPER[19:0], PH_OFFSET_CONST_LOWER[27:0]} : PH_OFFSET_CONST_LOWER;
  localparam TRUNCATE_BITS = ((PH_ACC_BITS-QUANTIZER_BITS) > 3)? 4 : (PH_ACC_BITS-QUANTIZER_BITS);
  // Set the minimal bitwidth of the PH_OFFSET_CONSTI = 2 to avoid HDL complaint
//04/04/17  localparam CONST_PH_OFFSET_BITS = (PH_OFFSET_CONST>3)? ceil_log2(PH_OFFSET_CONST)+1 : 2;    //03/14/17
//04/05/17  localparam CONST_PH_OFFSET_BITS = (PH_OFFSET_CONST>3)? ceil_log2(PH_OFFSET_CONST) : 2;  //04/04/17
//04/05/17  localparam [CONST_PH_OFFSET_BITS-1:0] PH_OFFSET_CONSTI = PH_OFFSET_CONST;

  input nGrst, clk, rstn, ph_offset_we, dith_init;
  input [PH_OFFSET_BITS-1:0] ext_ph_offset;
  output [PH_ACC_BITS-1:0] dith_offs;
  input slow_clk, lfsr_wEn;       // LFSR LUT initialization
  input [3:0] lfsr_wA;            // LFSR LUT initialization

  wire  [PH_OFFSET_BITS-1:0] ph_offset_r;
  wire  [PH_ACC_BITS-1:0] ph_offset, ph_adder, ph_reg, dither_ext, dith_phOffs;
  wire  [3:0] dither;
  wire  [TRUNCATE_BITS-1:0] dither_w;

  // Process phase offset
  generate if (PH_OFFSET_MODE==2)      // External variable ph_ofset
    begin: var_ph_offset_port
      dds_kitDelay_reg #(.BITWIDTH(PH_OFFSET_BITS), .DELAY(1)) ext_ph_offset_0 (
        .nGrst(nGrst), .rst(~rstn), .clk(clk), .clkEn(ph_offset_we),
        .inp(ext_ph_offset), .outp(ph_offset_r) );

      // Sign extend the unsigned offset
      signExt #(.INWIDTH(PH_OFFSET_BITS), .OUTWIDTH(PH_ACC_BITS),
                .UNSIGN(1)) signExt_0 (.inp(ph_offset_r), .outp(ph_offset));
    end
  endgenerate

  generate if (PH_OFFSET_MODE==1)      // Internal constant ph_offset
    begin: const_ph_offset
      // Sign extend the unsigned offset
//04/05/17      signExt #(.INWIDTH(CONST_PH_OFFSET_BITS),
//04/05/17                .OUTWIDTH(PH_ACC_BITS),
//04/05/17                .UNSIGN(1)) signExt_0 (.inp(PH_OFFSET_CONSTI), .outp(ph_offset));
      assign ph_offset = PH_OFFSET_CONST;
    end
  endgenerate

  generate if (PH_CORRECTION==1)
    begin: dithering
      dds_dither # (.FPGA_FAMILY(FPGA_FAMILY), .SIMUL_RAM(SIMUL_RAM)) dither_0 (
        .clk(clk), .rstn(rstn), .nGrst(nGrst), .init(dith_init), .dither(dither),
        // LFSR LUT initialization ports
        .slow_clk(slow_clk),
        .lfsr_wEn(lfsr_wEn),
        .lfsr_wA (lfsr_wA)  );

//      <- QUANTIZER_BITS -><- Truncate bits ->
//    +
//      000     ...      000<-Dither->
      assign dither_w = dither[TRUNCATE_BITS-1:0];

      signExt #(.INWIDTH(TRUNCATE_BITS), .OUTWIDTH(PH_ACC_BITS),
                .UNSIGN(1)) signExt_0 (.inp(dither_w), .outp(dither_ext) );
    end
  endgenerate

  // Only Phase Offset is on
  generate if( (PH_OFFSET_MODE!=0) && (PH_CORRECTION!=1) )
    begin: offset_only
      assign dith_phOffs = ph_offset;
    end
  endgenerate

  // Only Dither is on
  generate if( (PH_OFFSET_MODE==0) && (PH_CORRECTION==1) )
    begin: dither_only
      assign dith_phOffs = dither_ext;
    end
  endgenerate

  // Both Phase Offset and Dither are on.
  generate if( (PH_OFFSET_MODE!=0) && (PH_CORRECTION==1) )
    begin: offset_plus_dither
      assign dith_phOffs = ph_offset + dither_ext;
    end
  endgenerate

  // Infer Pipe1
  dds_kitDelay_reg # (.BITWIDTH(PH_ACC_BITS), .DELAY(PIPE1) ) pipe1_0 (
    .nGrst(nGrst),
    .rst(1'b0),
    .clk(clk), .clkEn(1'b1),
    .inp(dith_phOffs), .outp(dith_offs) );

//  --------------------
  function [31:0] ceil_log2;
      input integer x;
      integer tmp, res;
    begin
      tmp = 1;
      res = 0;
      while (tmp < x) begin
        tmp = tmp * 2;
        res = res + 1;
      end
      ceil_log2 = res;
    end
  endfunction

endmodule



//                            +-+-+-+-+-+-+-+-+-+
//                            |Q|u|a|n|t|i|z|e|r|
//                            +-+-+-+-+-+-+-+-+-+
// Final Phase adder right in front of a quantizer and the quantizer
module dds_quantizer ( clk, rstn, nGrst, ext_freq_offset, freq_offset_we,
                          ext_ph_offset, ph_offset_we, dith_init, ph_acc_s,
                          full_wave_addr,
                          // LFSR LUT initialization ports
                          slow_clk, lfsr_wEn, lfsr_wA);
  parameter PH_ACC_BITS     = 24;
  parameter PH_INC_MODE     = 0;
  parameter PH_INC_LOWER    = 1024*1024;
  parameter PH_INC_UPPER    = 0;
  parameter QUANTIZER_BITS  = 8;
  parameter FREQ_OFFSET_BITS= 3;
  parameter PH_OFFSET_MODE  = 0;
  parameter PH_OFFSET_CONST_LOWER = 0;
  parameter PH_OFFSET_CONST_UPPER = 0;
  parameter PH_OFFSET_BITS  = 10;
  parameter PH_CORRECTION   = 1;
  parameter PIPE1           = 0;
  parameter PIPE2           = 0;
  parameter PIPE3           = 0;

  parameter LATENCY         = 0;
  // LFSR LUT initialization params
  parameter FPGA_FAMILY = 26;
  parameter SIMUL_RAM   = 1;

  input clk, rstn, nGrst;
  input freq_offset_we, ph_offset_we, dith_init;
  input [PH_OFFSET_BITS-1:0] ext_ph_offset;
  input [FREQ_OFFSET_BITS-1:0] ext_freq_offset;
  output [PH_ACC_BITS-1:0] ph_acc_s;
  output [QUANTIZER_BITS-1:0] full_wave_addr;
  input slow_clk, lfsr_wEn;       // LFSR LUT initialization
  input [3:0] lfsr_wA;            // LFSR LUT initialization

  wire [PH_ACC_BITS-1:0] ph_accum, phAcc_Dith_Offs, ph_acc_s;
  wire [PH_ACC_BITS-1:0] dith_offs;
  wire [QUANTIZER_BITS-1:0] round_out;
  wire [QUANTIZER_BITS:0]   round_inp;

  dds_ph_accumulator # (
      .PH_INC_MODE      (PH_INC_MODE),
      .FREQ_OFFSET_BITS (FREQ_OFFSET_BITS),
      .PH_ACC_BITS      (PH_ACC_BITS),
      .PH_INC_LOWER     (PH_INC_LOWER ),
      .PH_INC_UPPER     (PH_INC_UPPER ),
      .PIPE1          (PIPE1) ) ph_accum_0 (
    .clk(clk), .rstn(rstn), .nGrst(nGrst),
    .ext_freq_offset(ext_freq_offset), .freq_offset_we(freq_offset_we),
    .ph_accum(ph_accum) );


  //  ------------  Add Dither and/or Phase Offset.
  // If dither or Phase Offset
  generate if((PH_OFFSET_MODE!=0)||(PH_CORRECTION==1))
    begin: dither_or_ph_offset
      dds_dither_offset # (
          .PH_ACC_BITS    (PH_ACC_BITS    ),
          .QUANTIZER_BITS (QUANTIZER_BITS ),
          .PH_OFFSET_MODE (PH_OFFSET_MODE ),
          .PH_OFFSET_CONST_LOWER(PH_OFFSET_CONST_LOWER),
          .PH_OFFSET_CONST_UPPER(PH_OFFSET_CONST_UPPER),
          .PH_OFFSET_BITS (PH_OFFSET_BITS ),
          .PH_CORRECTION  (PH_CORRECTION  ),
          .PIPE1        (PIPE1),
          .FPGA_FAMILY    (FPGA_FAMILY),
          .SIMUL_RAM(SIMUL_RAM) ) dither_offset_0 (
        .clk(clk), .rstn(rstn), .nGrst(nGrst),
        .ext_ph_offset(ext_ph_offset), .ph_offset_we(ph_offset_we),
        .dith_init(dith_init), .dith_offs(dith_offs),
         // LFSR LUT initialization ports
        .slow_clk(slow_clk),
        .lfsr_wEn(lfsr_wEn),
        .lfsr_wA (lfsr_wA)  );

      assign phAcc_Dith_Offs = ph_accum + dith_offs;
      // PIPE 2
      dds_kitDelay_reg # (.BITWIDTH(PH_ACC_BITS), .DELAY(PIPE2) ) pipe2_0 (
        .nGrst(nGrst), .rst(~rstn), .clk(clk), .clkEn(1'b1),
        .inp(phAcc_Dith_Offs), .outp(ph_acc_s) );
    end
  endgenerate

  // No Dither or Phase Offset
  generate if( (PH_OFFSET_MODE==0) && (PH_CORRECTION!=1) )
    begin: no_dither_no_ph_offset
      assign ph_acc_s = ph_accum;       //  [PH_ACC_BITS-1:PH_ACC_BITS-FINAL_ADD_BITS]
    end
  endgenerate


  // Truncate if Dither or Trigonom Correction. Keep the full acc width if
  // QUANTIZER_BITS==PH_ACC_BITS. Round otherwise
//01/16/17  generate if (PH_CORRECTION!=0)
  generate if ((PH_CORRECTION!=0) || (QUANTIZER_BITS==PH_ACC_BITS))
    begin: trunc_dither   // Leave the upper QUANTIZER_BITS bits
      assign full_wave_addr = ph_acc_s[PH_ACC_BITS-1:PH_ACC_BITS-QUANTIZER_BITS];
    end
  endgenerate

  // Round
  generate if ((PH_CORRECTION==0) && (QUANTIZER_BITS<PH_ACC_BITS))
    begin: round
      // Leave the upper QUANTIZER_BITS+1 bits
      assign round_inp = ph_acc_s[PH_ACC_BITS-1:PH_ACC_BITS-QUANTIZER_BITS-1] + {{QUANTIZER_BITS{1'b0}}, 1'b1};
      assign round_out = round_inp[QUANTIZER_BITS:1];

      // PIPE 3
      dds_kitDelay_reg # (.BITWIDTH(QUANTIZER_BITS), .DELAY(PIPE3) ) pipe3_0 (
        .nGrst(nGrst), .rst(~rstn), .clk(clk), .clkEn(1'b1),
        .inp(round_out), .outp(full_wave_addr) );
    end
  endgenerate
endmodule



//             +-+-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+
//             |T|r|i|g|o|n|o|m|e|t|r|i|c| |C|o|r|r|e|c|t|i|o|n|
//             +-+-+-+-+-+-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+
// trig_cor module must align in time arguments it takes:
//    (1) truncated LSB's of the phaseAccum and
//    (2) sine/cosine samples coming from the LUT.
// Each path (1) & (2) has its own configuration-dependent number of pipes but the
// componenets (1) & (2) must come to the trig_cor Mult_Add at the same time.
// This module implements a dly to be inferred in the path (1) to balance pipes
// of the paths (2)
module balance_dly (clk, nGrst, ph_lsb_in, ph_lsb_dly);
  parameter PH_ACC_BITS     = 24;
  parameter QUANTIZER_BITS  = 8;
  parameter PIPE4EXT        = 0;
  parameter PIPE6           = 0;
  parameter PIPE7           = 0;

  input clk, nGrst;
  input [PH_ACC_BITS-QUANTIZER_BITS-1:0] ph_lsb_in;
  output[PH_ACC_BITS-QUANTIZER_BITS-1:0] ph_lsb_dly;

  dds_kitDelay_reg # (.BITWIDTH(PH_ACC_BITS-QUANTIZER_BITS),
                      .DELAY(PIPE6+PIPE7+PIPE4EXT) ) dly_0 (
    .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
    .inp(ph_lsb_in),
    .outp(ph_lsb_dly) );
endmodule


module trig_cor (clk, rstn, nGrst, ph_accum_in, sinA, cosA, sin_o, cos_o);
  parameter PH_ACC_BITS     = 24;
  parameter QUANTIZER_BITS  = 8;
  parameter LATENCY         = 0;
  parameter FPGA_FAMILY     = 26;
  parameter SIN_ON          = 1;
  parameter COS_ON          = 1;
  parameter SIN_POLARITY    = 0;
  parameter COS_POLARITY    = 0;
  parameter OUTPUT_BITS     = 18;
  parameter PIPE4EXT        = 0;
  parameter PIPE6           = 0;
  parameter PIPE7           = 0;
  parameter PIPE8           = 0;
  parameter PIPE9           = 0;
  parameter PIPE10          = 0;
  parameter PIPE11          = 0;

  // Make sure the ph_lsb does not exceed 17 bits, as an unsigned mcand cannot
  // exceed that value.  If this happens, have trig_cor take reduced Phase
  // Accumulator bits
  localparam PH_ACC_BITSI = ((PH_ACC_BITS-QUANTIZER_BITS)>17)?
    QUANTIZER_BITS+17 : PH_ACC_BITS;
  localparam LSB_BITS = PH_ACC_BITSI - QUANTIZER_BITS;

  // Define MACC bitwidth
  localparam MACC_BITS = ((FPGA_FAMILY==26) || (FPGA_FAMILY==27))? 48 : 44;

  // Calculate Trigonometry Constant
  localparam RC = ((MACC_BITS-18-QUANTIZER_BITS)>=14)? 14 : MACC_BITS-18-QUANTIZER_BITS;
  localparam TRIG_CONST = trigon_const(RC);
  localparam COM_POLARITY = SIN_POLARITY + 2*COS_POLARITY + 10*SIN_ON +100*COS_ON;

  input clk, rstn, nGrst;
  input [PH_ACC_BITS-1:0] ph_accum_in;
  input [OUTPUT_BITS-1:0] sinA, cosA;
  output [OUTPUT_BITS-1:0] sin_o, cos_o;

  wire[35:0] delA_interi, sin_corri, cos_corri, sin_corrii, cos_corrii;
  wire[17:0] delA_inter, ph_lsb_18, sinA_18, cosA_18;
  wire[OUTPUT_BITS-1:0] sin_corr, cos_corr, dbg_cos;
  wire[LSB_BITS-1:0] ph_lsb, ph_lsb_dly;
  wire[MACC_BITS-1:0] sinA_ext, cosA_ext, add_sinA, add_cosA, sin48, cos48, pout;
  wire[MACC_BITS-1:0] sin48_sc, cos48_sc;
  wire[PH_ACC_BITSI-1:0] ph_accum_ini;
  wire[1:0] sub_ctrl;
  wire sin_sub, cos_sub;

  assign sin_sub = sub_ctrl[0];
  assign cos_sub = sub_ctrl[1];

  // Define constant add/sub modes for sin +/- delta*cos and cos -/+ delta*sin
  // calculations
  //                        SIN_POLARITY  COS_POLARITY  SinSub   CosSub
  // SIN_ON=1; COS_ON=0           0             0         0         1
  //                              0             1         1         x
  //                              1             0         1         x
  //                              1             1         0         x
  // SIN_ON=0; COS_ON=1           0             0         0         1
  //                              0             1         0         0
  //                              1             0         0         0
  //                              1             1         0         1
  // SIN_ON=1; COS_ON=1           0             0         0         1
  //                              0             1         1         0
  //                              1             0         1         0
  //                              1             1         0         1

  generate
    case (COM_POLARITY)
      // SIN_ON=1, COS_ON=0
      10: assign sub_ctrl = 2'b10;
      11: assign sub_ctrl = 2'b11;
      12: assign sub_ctrl = 2'b11;
      13: assign sub_ctrl = 2'b10;
      // SIN_ON=0, COS_ON=1
      100: assign sub_ctrl = 2'b10;
      101: assign sub_ctrl = 2'b00;
      102: assign sub_ctrl = 2'b00;
      103: assign sub_ctrl = 2'b10;
      // SIN_ON=1, COS_ON=1
      110: assign sub_ctrl = 2'b10;
      111: assign sub_ctrl = 2'b01;
      112: assign sub_ctrl = 2'b01;
      113: assign sub_ctrl = 2'b10;
      default: assign sub_ctrl = 2'b10;
    endcase
  endgenerate

  // Take not more than QUANTIZER_BITS+17 of the Phase Accum, that is discard
  // some LSB's if necessary
  assign ph_accum_ini = ph_accum_in[PH_ACC_BITS-1:PH_ACC_BITS-PH_ACC_BITSI];
  // If PH_ACC_BITS==QUANTIZER_BITS, the trig_cor module won't be instantiated
  assign ph_lsb = ph_accum_ini[LSB_BITS-1:0];

  // sin/cos from LUT output can be delayed regarding the phase_accum truncated
  //  LSB's. To balance the delays, delay the ph_lsb depending on the LATENCY
  //  and modes
  balance_dly # (
      .PH_ACC_BITS   (PH_ACC_BITSI ),
      .QUANTIZER_BITS(QUANTIZER_BITS),
      .PIPE4EXT(PIPE4EXT),
      .PIPE6         (PIPE6),
      .PIPE7         (PIPE7)  ) bal_dly_0 (
    .nGrst(nGrst), .clk(clk), .ph_lsb_in(ph_lsb), .ph_lsb_dly(ph_lsb_dly) );

  // Extend it to 18 bits. Note, ph_lsb is always positive
  signExt # ( .INWIDTH(LSB_BITS), .OUTWIDTH(18), .UNSIGN(1),
              .DROP_MSB(0) ) signExt_0 (
    .inp(ph_lsb_dly), .outp(ph_lsb_18)   );

  // delA_interi = TRIG_CONST*ph_lsb;
  mac18x18_dds # (
      .BYPASS_REG_A(1),
      .BYPASS_REG_B(1-PIPE8),
      .BYPASS_REG_C(1),
      .BYPASS_REG_P(1-PIPE9),
      .MULT_ADD    (0),   // Multiplier, no adder
      .FPGA_FAMILY (FPGA_FAMILY) ) const_mult_0 (
    .nGrst(nGrst), .rstn(rstn), .clk(clk),
    .en_a(1'b1),
    .en_b(1'b1),
    .en_c(1'b1),
    .en_p(1'b1),
    .mcand_a(TRIG_CONST), .mcand_b(ph_lsb_18),
    .addend_c(), .sub(1'b0),
    .pout(pout)  );
  assign delA_interi = pout[35:0];

  // Shrink delA_interi to 18 bits
  assign delA_inter = delA_interi[LSB_BITS+17:LSB_BITS];

  signExt # ( .INWIDTH(OUTPUT_BITS), .OUTWIDTH(MACC_BITS), .UNSIGN(0),
              .DROP_MSB(0) ) signExt_sin_0 (
    .inp(sinA), .outp(sinA_ext)   );
  signExt # ( .INWIDTH(OUTPUT_BITS), .OUTWIDTH(MACC_BITS), .UNSIGN(0),
              .DROP_MSB(0) ) signExt_cos_0 (
    .inp(cosA), .outp(cosA_ext)   );

  assign add_sinA = sinA_ext << (RC + QUANTIZER_BITS);
  assign add_cosA = cosA_ext << (RC + QUANTIZER_BITS);

  signExt # ( .INWIDTH(OUTPUT_BITS), .OUTWIDTH(18), .UNSIGN(0),
              .DROP_MSB(0) ) signExt_sin18_0 (
    .inp(sinA), .outp(sinA_18)   );
  signExt # ( .INWIDTH(OUTPUT_BITS), .OUTWIDTH(18), .UNSIGN(0),
              .DROP_MSB(0) ) signExt_cos18_0 (
    .inp(cosA), .outp(cosA_18)   );

  mac18x18_dds # (
      .BYPASS_REG_A(1-PIPE10),
      .BYPASS_REG_B(1-PIPE10),
      .BYPASS_REG_C(1-PIPE10),
      .BYPASS_REG_P(1-PIPE11),
      .MULT_ADD    (1),   // Multiplier + adder
      .FPGA_FAMILY (FPGA_FAMILY) ) madd_0 (
    .nGrst(nGrst), .rstn(rstn), .clk(clk),
    .en_a(1'b1),
    .en_b(1'b1),
    .en_c(1'b1),
    .en_p(1'b1),
    .mcand_a(cosA_18),
    .mcand_b(delA_inter),
    .addend_c(add_sinA),
    .sub(sin_sub),
    .pout(sin48)   );

  mac18x18_dds # (
      .BYPASS_REG_A(1-PIPE10),
      .BYPASS_REG_B(1-PIPE10),
      .BYPASS_REG_C(1-PIPE10),
      .BYPASS_REG_P(1-PIPE11),
      .MULT_ADD    (1),   // Multiplier + adder
      .FPGA_FAMILY (FPGA_FAMILY) ) madd_1 (
    .nGrst(nGrst), .rstn(rstn), .clk(clk),
    .en_a(1'b1),
    .en_b(1'b1),
    .en_c(1'b1),
    .en_p(1'b1),
    .mcand_a(sinA_18),
    .mcand_b(delA_inter),
    .addend_c(add_cosA),
    .sub(cos_sub),
    .pout(cos48)   );

  assign sin48_sc = $signed(sin48) >>> (RC + QUANTIZER_BITS);
  assign cos48_sc = $signed(cos48) >>> (RC + QUANTIZER_BITS);
  assign sin_o = sin48_sc[OUTPUT_BITS-1:0];
  assign cos_o = cos48_sc[OUTPUT_BITS-1:0];

//  ---------------------------------
  function [17:0] trigon_const;
    input integer RC_const;
    begin
        case (RC_const)
           6 :  trigon_const = 18'h192;
           7 :  trigon_const = 18'h324;
           8 :  trigon_const = 18'h648;
           9 :  trigon_const = 18'hc91;
          10 :  trigon_const = 18'h1922;
          11 :  trigon_const = 18'h3244;
          12 :  trigon_const = 18'h6488;
          13 :  trigon_const = 18'hc910;
          14 :  trigon_const = 18'h19220;
      default:  trigon_const = 18'h0;
    endcase
    end
  endfunction
endmodule




//            +-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+
//            |M|A|C| |F|o|r| |T|r|i|g|o|n|o|m| |C|o|r|r|e|c|t|i|o|n|
//            +-+-+-+ +-+-+-+ +-+-+-+-+-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+

module mac18x18_dds(nGrst, rstn, clk, en_a, en_b, en_c, en_p,
                mcand_a, mcand_b,
                addend_c,
                pout,
                sub);
  parameter BYPASS_REG_A = 0;
  parameter BYPASS_REG_B = 0;
  parameter BYPASS_REG_C = 0;
  parameter BYPASS_REG_P = 0;
  parameter MULT_ADD     = 1;   //0-Mult only
  parameter FPGA_FAMILY  = 26;

  localparam [1:0] BY_REGA = BYPASS_REG_A ? 2'b11 : 2'b00;
  localparam [1:0] BY_REGB = BYPASS_REG_B ? 2'b11 : 2'b00;
  localparam [1:0] BY_REGC = BYPASS_REG_C ? 2'b11 : 2'b00;
  localparam [1:0] BY_REGP = BYPASS_REG_P ? 2'b11 : 2'b00;

  localparam P_WIDTH = ((FPGA_FAMILY==26) || (FPGA_FAMILY==27))? 48 : 44;

  input nGrst, rstn, clk, en_a, en_b, en_c, en_p;
  input [17:0] mcand_a, mcand_b;
  input [P_WIDTH-1:0] addend_c;
  input sub;          // 0-add; 1-sub;
  output[P_WIDTH-1:0] pout;

  wire [1:0] ea_w, eb_w, ec_w, ep_w;
  wire [1:0] rstn_a_w, rstn_b_w, rstn_c_w, rstn_p_w;
  wire [1:0] arstn_a, arstn_b, arstn_c, arstn_p; // tool
  wire [1:0] sel_cdin;
  wire a_bp_g5, a_rs_g5, a_en_g5, b_bp_g5, b_rs_g5, b_en_g5;
  wire c_bp_g5, c_rs_g5, c_en_g5, c_ar_g5, p_bp_g5, p_rs_g5, p_en_g5;

  assign ea_w = BYPASS_REG_A ? 2'b11 : {en_a,en_a};
  assign eb_w = BYPASS_REG_B ? 2'b11 : {en_b,en_b};
  assign ec_w = BYPASS_REG_C ? 2'b11 : {en_c,en_c};
  assign ep_w = BYPASS_REG_P ? 2'b11 : {en_p,en_p};

  generate if (BYPASS_REG_A == 1)
    begin
      assign rstn_a_w = 2'b11;
      assign arstn_a  = 2'b11;
      assign a_bp_g5 = 1'b1;
      assign a_rs_g5 = 1'b1;
      assign a_en_g5 = 1'b1;
    end
  else
    begin
      assign rstn_a_w = {rstn,rstn};
      assign arstn_a  = {nGrst,nGrst};
      assign a_bp_g5 = 1'b0;
      assign a_rs_g5 = rstn;
      assign a_en_g5 = en_a;
    end
  endgenerate

  generate if (BYPASS_REG_B == 1)
    begin
      assign rstn_b_w = 2'b11;
      assign arstn_b  = 2'b11;
      assign b_bp_g5 = 1'b1;
      assign b_rs_g5 = 1'b1;
      assign b_en_g5 = 1'b1;
    end
  else
    begin
      assign rstn_b_w = {rstn,rstn};
      assign arstn_b  = {nGrst,nGrst};
      assign b_bp_g5 = 1'b0;
      assign b_rs_g5 = rstn;
      assign b_en_g5 = en_b;
    end
  endgenerate

  generate if (BYPASS_REG_C == 1)
    begin
      assign rstn_c_w = 2'b11;
      assign arstn_c  = 2'b11;
      assign c_bp_g5 = 1'b1;
      assign c_rs_g5 = 1'b1;
      assign c_en_g5 = 1'b1;
      assign c_ar_g5 = 1'b1;
    end
  else
    begin
      assign rstn_c_w = {rstn,rstn};
      assign arstn_c  = {nGrst,nGrst};
      assign c_bp_g5 = 1'b0;
      assign c_rs_g5 = rstn;
      assign c_en_g5 = en_c;
      assign c_ar_g5 = nGrst;
    end
  endgenerate

  generate if (BYPASS_REG_P == 1)
    begin
      assign rstn_p_w = 2'b11;
      assign arstn_p  = 2'b11;
      assign p_bp_g5 = 1'b1;
      assign p_rs_g5 = 1'b1;
      assign p_en_g5 = 1'b1;
    end
  else
    begin
      assign rstn_p_w = {rstn,rstn};
      assign arstn_p  = {nGrst,nGrst};
      assign p_bp_g5 = 1'b0;
      assign p_rs_g5 = rstn;
      assign p_en_g5 = en_p;
    end
  endgenerate

  generate
    if(((FPGA_FAMILY==19)||(FPGA_FAMILY==24)||(FPGA_FAMILY==25))&&(MULT_ADD==1))
      begin: g4_add
      MACC mac_0 (
        .CLK  ({clk,clk}),

        .A        (mcand_a),
        .A_EN     (ea_w),
        .A_ARST_N (arstn_a),
        .A_SRST_N (rstn_a_w),
        .A_BYPASS (BY_REGA),      // latch

        .B        (mcand_b),
        .B_EN     (eb_w),
        .B_ARST_N (arstn_b),
        .B_SRST_N (rstn_b_w),
        .B_BYPASS (BY_REGB),      // latch

        // Addend comes in
        .C        (addend_c),
        .C_EN     (ec_w),
        .C_ARST_N (arstn_c),
        .C_SRST_N (rstn_c_w),
        .C_BYPASS (BY_REGC),        // latch
        .CARRYIN  (1'b0),

        .P        (pout),
        .CDOUT    (),
        .P_EN     (ep_w),
        .P_ARST_N (arstn_p),
        .P_SRST_N (rstn_p_w),
        .P_BYPASS (BY_REGP),      //latch

        .OVFL_CARRYOUT  (),

        .CDIN (44'b0),

        // Transparent (bypassed) reg
        .SUB        (sub),
        .SUB_EN     (1'b1),
        .SUB_AD     (1'b0),          // async data bit
        .SUB_AL_N   (1'b1),          // async load the data bit
        .SUB_SD_N   (1'b1),          // sync data bit
        .SUB_SL_N   (1'b1),          // sync load the data bit
        .SUB_BYPASS (1'b1),          // latch

        // Transparent reg as shftsel is static 0
        .ARSHFT17         (1'b0),
        .ARSHFT17_EN      (1'b1),           // en
        .ARSHFT17_AD      (1'b0),           // async data bit
        .ARSHFT17_AL_N    (1'b1),           // async load the data bit
        .ARSHFT17_SD_N    (1'b1),           // sync data bit
        .ARSHFT17_SL_N    (1'b1),           // sync load the data bit
        .ARSHFT17_BYPASS  (1'b1),           // latch

        // Transparent reg as fdbksel is static 0
        .FDBKSEL        (1'b0),
        .FDBKSEL_EN     (1'b1),           // en
        .FDBKSEL_AD     (1'b0),           // async data bit
        .FDBKSEL_AL_N   (1'b1),           // async load the data bit
        .FDBKSEL_SD_N   (1'b1),           // sync data bit
        .FDBKSEL_SL_N   (1'b1),           // sync load the data bit
        .FDBKSEL_BYPASS (1'b1),           // latch

        // Transparent reg as cdsel is static
        .CDSEL        (1'b0),
        .CDSEL_EN     (1'b1),           // en
        .CDSEL_AD     (1'b0),           // async data bit
        .CDSEL_AL_N   (1'b1),           // async load the data bit
        .CDSEL_SD_N   (1'b1),           // sync data bit
        .CDSEL_SL_N   (1'b1),           // sync load the data bit
        .CDSEL_BYPASS (1'b1),           // latch

        .OVFL_CARRYOUT_SEL  (1'b0),

        .SIMD(1'b0),
        .DOTP(1'b0)    );
    end
  endgenerate

  generate
    if(((FPGA_FAMILY==19)||(FPGA_FAMILY==24)||(FPGA_FAMILY==25))&&(MULT_ADD!=1))
      begin: g4_mult
      MACC mac_0 (
        .CLK  ({clk,clk}),

        .A        (mcand_a),
        .A_EN     (ea_w),
        .A_ARST_N (arstn_a),
        .A_SRST_N (rstn_a_w),
        .A_BYPASS (BY_REGA),      // latch

        .B        (mcand_b),
        .B_EN     (eb_w),
        .B_ARST_N (arstn_b),
        .B_SRST_N (rstn_b_w),
        .B_BYPASS (BY_REGB),      // latch

        // Addend comes in
        .C        (44'b0),
        .C_EN     (2'b11),
        .C_ARST_N (2'b11),
        .C_SRST_N (2'b11),
        .C_BYPASS (2'b11),
        .CARRYIN  (1'b0),

        .P        (pout),
        .CDOUT    (),
        .P_EN     (ep_w),
        .P_ARST_N (arstn_p),
        .P_SRST_N (rstn_p_w),
        .P_BYPASS (BY_REGP),      //latch

        .OVFL_CARRYOUT  (),

        .CDIN (44'b0),

        // Transparent (bypassed) reg as sub isn't used
        .SUB        (1'b0),
        .SUB_EN     (1'b1),
        .SUB_AD     (1'b0),          // async data bit
        .SUB_AL_N   (1'b1),          // async load the data bit
        .SUB_SD_N   (1'b1),          // sync data bit
        .SUB_SL_N   (1'b1),          // sync load the data bit
        .SUB_BYPASS (1'b1),          // latch

        // Transparent reg as shftsel is static 0
        .ARSHFT17         (1'b0),
        .ARSHFT17_EN      (1'b1),           // en
        .ARSHFT17_AD      (1'b0),           // async data bit
        .ARSHFT17_AL_N    (1'b1),           // async load the data bit
        .ARSHFT17_SD_N    (1'b1),           // sync data bit
        .ARSHFT17_SL_N    (1'b1),           // sync load the data bit
        .ARSHFT17_BYPASS  (1'b1),           // latch

        // Transparent reg as fdbksel is static 0
        .FDBKSEL        (1'b0),
        .FDBKSEL_EN     (1'b1),           // en
        .FDBKSEL_AD     (1'b0),           // async data bit
        .FDBKSEL_AL_N   (1'b1),           // async load the data bit
        .FDBKSEL_SD_N   (1'b1),           // sync data bit
        .FDBKSEL_SL_N   (1'b1),           // sync load the data bit
        .FDBKSEL_BYPASS (1'b1),           // latch

        // Transparent reg as cdsel is static
        .CDSEL        (1'b0),
        .CDSEL_EN     (1'b1),           // en
        .CDSEL_AD     (1'b0),           // async data bit
        .CDSEL_AL_N   (1'b1),           // async load the data bit
        .CDSEL_SD_N   (1'b1),           // sync data bit
        .CDSEL_SL_N   (1'b1),           // sync load the data bit
        .CDSEL_BYPASS (1'b1),           // latch

        .OVFL_CARRYOUT_SEL  (1'b0),

        .SIMD(1'b0),
        .DOTP(1'b0)    );
    end
  endgenerate

  generate if(((FPGA_FAMILY==26) || (FPGA_FAMILY==27))&&(MULT_ADD==1))  begin: g5_add
    MACC_PA macc_0 (
      .CLK  (clk),
      .AL_N (nGrst),      // Negative async reset for all regs except C, D and B2

      .A        (mcand_a),
      .A_BYPASS (a_bp_g5),
      .A_SRST_N (a_rs_g5),
      .A_EN     (a_en_g5),


      .B        (mcand_b),
      .B_BYPASS (b_bp_g5),   // B reg on
      .B_SRST_N (b_rs_g5),
      .B_EN     (b_en_g5),

      // D reg to keep const 0
      .D        (18'h3FFFF),
      .D_ARST_N (nGrst),
      .D_BYPASS (1'b0),
      .D_SRST_N (1'b0),   // Keep the reg permanently reset
      .D_EN     (1'b1),

      .CARRYIN  (1'b0),
      .C        (addend_c),
      .C_BYPASS (c_bp_g5),
      .C_ARST_N (c_ar_g5),
      .C_SRST_N (c_rs_g5),
      .C_EN     (c_en_g5),

      .CDIN (48'b0),

      .P        (pout),
      .OVFL_CARRYOUT  (),
      .CDOUT    (),
      .P_EN     (p_en_g5),
      .P_SRST_N (p_rs_g5),
      .P_BYPASS (p_bp_g5),      //latch

      //  ----------  Ctrl inputs  ---------
      // Pre-adder isn't used on cmplx mult. Configure to be permanent 0 gen
      .PASUB        (1'b0),
      .PASUB_BYPASS (1'b0),   //Static
      .PASUB_AD_N   (1'b0),   //Static. Data to be loaded on async AL_N
      .PASUB_SL_N   (1'b0),   // Negative sync reset
      .PASUB_SD_N   (1'b0),   //Static. Data to be loaded on sync PASUB_SL_N
      .PASUB_EN     (1'b1),

      // Transparent (bypassed) reg
      .SUB        (sub),
      .SUB_EN     (1'b1),           // en
      .SUB_AD_N   (1'b1),           // Static. Data to be loaded on async rst
      .SUB_SD_N   (1'b1),           // Static. Data to be loaded on sync SL_N
      .SUB_SL_N   (1'b1),
      .SUB_BYPASS (1'b1),           // latch

      // Transparent reg, as shftsel is static 0
      .ARSHFT17         (1'b0),
      .ARSHFT17_EN      (1'b1),     // en
      .ARSHFT17_AD_N    (1'b1),     // Static. Data to be loaded on async rst
      .ARSHFT17_SD_N    (1'b1),     // Static. Data to be loaded on sync SL_N
      .ARSHFT17_SL_N    (1'b1),     // Sync reset
      .ARSHFT17_BYPASS  (1'b1),     // latch

      // Transparent reg, as Cdin_fdbk is static 0
      .CDIN_FDBK_SEL        (2'b00),
      .CDIN_FDBK_SEL_BYPASS (1'b1),   //static
      .CDIN_FDBK_SEL_AD_N   (2'b11),  //Static. Value to be loaded on async rst
      .CDIN_FDBK_SEL_SD_N   (2'b11),  //Static. Value to be loaded on sync rst CDIN_FDBK_SEL_SL_N
      .CDIN_FDBK_SEL_SL_N   (1'b1),   // Negative sync reset
      .CDIN_FDBK_SEL_EN     (1'b1),

      .OVFL_CARRYOUT_SEL  (1'b0),
      .SIMD(1'b0),
      .DOTP(1'b0)    );
    end
  endgenerate

  generate if(((FPGA_FAMILY==26) || (FPGA_FAMILY==27))&&(MULT_ADD!=1))  begin: g5_mult
    MACC_PA macc_0 (
      .CLK  (clk),
      .AL_N (nGrst),      // Negative async reset for all regs except C, D and B2

      .A        (mcand_a),
      .A_BYPASS (a_bp_g5),
      .A_SRST_N (a_rs_g5),
      .A_EN     (a_en_g5),


      .B        (mcand_b),
      .B_BYPASS (b_bp_g5),   // B reg on
      .B_SRST_N (b_rs_g5),
      .B_EN     (b_en_g5),

      // D reg to keep const 0
      .D        (18'h3FFFF),
      .D_ARST_N (nGrst),
      .D_BYPASS (1'b0),
      .D_SRST_N (1'b0),   // Keep the reg permanently reset
      .D_EN     (1'b1),

      // Constant 48'b0 generator
      .CARRYIN  (1'b1),
      .C        (48'hFFFFFFFFFFFF),
      .C_BYPASS (1'b0),   // C reg on
      .C_ARST_N (nGrst),
      .C_SRST_N (1'b0),   // Keep the reg permanently reset
      .C_EN     (1'b1),

      .CDIN (48'b0),

      .P        (pout),
      .OVFL_CARRYOUT  (),
      .CDOUT    (),
      .P_EN     (p_en_g5),
      .P_SRST_N (p_rs_g5),
      .P_BYPASS (p_bp_g5),      //latch

      //  ----------  Ctrl inputs  ---------
      // Pre-adder isn't used on cmplx mult. Configure to be permanent 0 gen
      .PASUB        (1'b0),
      .PASUB_BYPASS (1'b0),   //Static
      .PASUB_AD_N   (1'b0),   //Static. Data to be loaded on async AL_N
      .PASUB_SL_N   (1'b0),   // Negative sync reset
      .PASUB_SD_N   (1'b0),   //Static. Data to be loaded on sync PASUB_SL_N
      .PASUB_EN     (1'b1),

      // Transparent (bypassed) reg
      .SUB        (1'b0),
      .SUB_EN     (1'b1),           // en
      .SUB_AD_N   (1'b1),           // Static. Data to be loaded on async rst
      .SUB_SD_N   (1'b1),           // Static. Data to be loaded on sync SL_N
      .SUB_SL_N   (1'b1),
      .SUB_BYPASS (1'b1),           // latch

      // Transparent reg, as shftsel is static 0
      .ARSHFT17         (1'b0),
      .ARSHFT17_EN      (1'b1),     // en
      .ARSHFT17_AD_N    (1'b1),     // Static. Data to be loaded on async rst
      .ARSHFT17_SD_N    (1'b1),     // Static. Data to be loaded on sync SL_N
      .ARSHFT17_SL_N    (1'b1),     // Sync reset
      .ARSHFT17_BYPASS  (1'b1),     // latch

      // Transparent reg, as Cdin_fdbk is static 0
      .CDIN_FDBK_SEL        (2'b00),
      .CDIN_FDBK_SEL_BYPASS (1'b1),   //static
      .CDIN_FDBK_SEL_AD_N   (2'b11),  //Static. Value to be loaded on async rst
      .CDIN_FDBK_SEL_SD_N   (2'b11),  //Static. Value to be loaded on sync rst CDIN_FDBK_SEL_SL_N
      .CDIN_FDBK_SEL_SL_N   (1'b1),   // Negative sync reset
      .CDIN_FDBK_SEL_EN     (1'b1),

      .OVFL_CARRYOUT_SEL  (1'b0),
      .SIMD(1'b0),
      .DOTP(1'b0)    );
    end
  endgenerate
endmodule




///////////////////////////////////////////////////////////////////////////////
//                    ____  ____  ____  _   _  ____  ____
//                   (  _ \(_  _)(_  _)( )_( )( ___)(  _ \
//                    )(_) )_)(_   )(   ) _ (  )__)  )   /
//                   (____/(____) (__) (_) (_)(____)(_)\_)
//
///////////////////////////////////////////////////////////////////////////////

//                        +-+-+-+-+ +-+-+-+ +-+-+-+-+
//                        |L|F|S|R| |L|U|T| |I|n|i|t|
//                        +-+-+-+-+ +-+-+-+ +-+-+-+-+
module dds_lfsr_lut (clk, nGrst, slow_clk, lfsr_wEn, lfsr_wA, rA, aggr_poly);
  parameter FPGA_FAMILY = 26;
  parameter SIMUL_RAM   = 1;
  localparam DBG = 0; //1-simulation mux; 0-RAM

  input clk, nGrst;
  input [3:0] rA;
  output [5:0] aggr_poly;
  // Initialization ports
  input slow_clk, lfsr_wEn;
  input [3:0] lfsr_wA;

  reg[5:0] ap;

  generate if (DBG==0)
    lfsrRAM # (.FPGA_FAMILY(FPGA_FAMILY), .SIMUL_RAM(SIMUL_RAM) ) lfsr_lut_0 (
      .rClk(clk),
      .wClk(slow_clk),
      .wEn (lfsr_wEn),
      .wA  (lfsr_wA),
      // Read ports
      .rA  (rA),
      .Q   (aggr_poly) );
  endgenerate

//  LFSR 6-bit table; LFSR length = 21, Poly = 140000
//   0   0
//   1   28000
//   2   50000
//   3   78000
//   4   a0000
//   5   88000
//   6   f0000
//   7   d8000
//   8   140000
//   9   168000
//  10   110000
//  11   138000
//  12   1e0000
//  13   1c8000
//  14   1b0000
//  15   198000
  generate if (DBG==1) begin: simul
    // Replicate 2-clk delay to match the actual lfsrRAM
    dds_kitDelay_reg # (.BITWIDTH(6), .DELAY(2) ) dlyMatch_0 (
      .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
      .inp(ap),
      .outp(aggr_poly) );

//03/27/17    assign aggr_poly = ap;
    always @ (rA)
      case (rA)
        0:  ap <= 6'b000000;
        1:  ap = 6'b000101;
        2:  ap = 6'b001010;
        3:  ap = 6'b001111;
        4:  ap = 6'b010100;
        5:  ap = 6'b010001;
        6:  ap = 6'b011110;
        7:  ap = 6'b011011;
        8:  ap = 6'b101000;
        9:  ap = 6'b101101;
        10: ap = 6'b100010;
        11: ap = 6'b100111;
        12: ap = 6'b111100;
        13: ap = 6'b111001;
        14: ap = 6'b110110;
        15: ap = 6'b110011;
        default: ap = 6'b000000;
      endcase
    end
  endgenerate
endmodule




// 21-bit Galois LFSR updates by 4 bits per clock
module dds_lfsr(clk, nGrst, rstn, init, lfsr,
        // LFSR LUT initialization ports
        slow_clk, lfsr_wEn, lfsr_wA );
  parameter FPGA_FAMILY = 26;
  parameter SIMUL_RAM   = 1;

  input clk, rstn, nGrst, init;
  output [20:0] lfsr;
  input slow_clk, lfsr_wEn;       // LFSR LUT initialization
  input [3:0] lfsr_wA;            // LFSR LUT initialization

  reg [20:0] lfsr;
  wire[5:0] aggr_poly;
  wire[3:0] lfsr_ctrl_4bits;

  assign lfsr_ctrl_4bits = lfsr[11:8];

  // LFSR LUT has 2-clk latency: rA and rD pipes. Use the four bits output
  // advanced by 2 clk to negate the latency
  dds_lfsr_lut # (.FPGA_FAMILY(FPGA_FAMILY), .SIMUL_RAM(SIMUL_RAM)) lfsr_lut_0 (
    .clk(clk), .nGrst(nGrst),
    .rA(lfsr_ctrl_4bits),
    .aggr_poly(aggr_poly),
    // LFSR LUT initialization ports
    .slow_clk(slow_clk),
    .lfsr_wEn(lfsr_wEn),
    .lfsr_wA (lfsr_wA)  );

  // Initialize LFSR with 1; shift to the righ by 4 taps
  always @ (negedge nGrst or posedge clk)  begin
    if(nGrst==0)      lfsr <= 21'h100000;
    else
      if(init==1'b1) lfsr <= 21'h100000;
      else begin
        lfsr[20:17] <= aggr_poly[5:2];
        lfsr[16:15] <= lfsr[20:19] ^ aggr_poly[1:0];
        lfsr[14:0]  <= lfsr[18:4];
      end
  end
endmodule


module dds_dither (clk, rstn, nGrst, init, dither,
                    // LFSR LUT initialization ports
                    slow_clk, lfsr_wEn, lfsr_wA);
  parameter FPGA_FAMILY = 26;
  parameter SIMUL_RAM   = 1;

  input clk, rstn, nGrst;
  input init;             // Bring lfsr_wEn here
  output [3:0] dither;
  input slow_clk, lfsr_wEn;       // LFSR LUT initialization
  input [3:0] lfsr_wA;            // LFSR LUT initialization

  wire [20:0] lfsr;

  dds_lfsr # (.FPGA_FAMILY(FPGA_FAMILY), .SIMUL_RAM(SIMUL_RAM)) lfsr_0 (
    .clk(clk), .nGrst(nGrst), .rstn(rstn), .init(init),
    .lfsr(lfsr),
    // LFSR LUT initialization ports
    .slow_clk(slow_clk),
    .lfsr_wEn(lfsr_wEn),
    .lfsr_wA (lfsr_wA)  );

  assign dither = lfsr[3:0];
endmodule

//                             +-+-+-+-+ +-+-+-+
//                             |L|F|S|R| |L|U|T|
//                             +-+-+-+-+ +-+-+-+

// LFSR LUT is of a fixed size 16x6
module lfsrRAM(rClk, wClk, wEn, wA, rA, Q);
  parameter FPGA_FAMILY = 26;
  parameter SIMUL_RAM   = 0;
  input rClk, wClk, wEn;
  input[3:0] wA, rA;
  output[5:0] Q;

  wire [5:0] wD;

  lfsr_table lfsr_table_0 (.index(wA), .outp(wD) );

  generate if(SIMUL_RAM==1)
    begin: dbg_model
      dds_kitRam_fabric # (
          .WIDTH   (6),
          .LOGDEPTH(4),
          .DEPTH   (16   ),
          .RA_PIPE (1),
          .RD_PIPE (1) ) simul_ram_0 (
        .nGrst(1'b1), .RCLOCK(rClk), .WCLOCK(wClk),
        .WRB(wEn), .RDB(1'b1), .rstDataPipe(1'b0),
        .DI(wD), .RADDR(rA), .WADDR(wA), .DO(Q)  );
    end
  endgenerate

  generate if ( (SIMUL_RAM!=1) &&( (FPGA_FAMILY==19) || (FPGA_FAMILY==24) ))
    begin: g4_uram
      g4_lfsr_uram g4_uram_0 (
        .A_DOUT (Q),
        .B_DOUT (),
        .C_DIN  (wD),
        .A_ADDR (rA),
        .B_ADDR (),
        .C_ADDR (wA),
        .A_CLK  (rClk),
        .C_CLK  (wClk),
        .C_WEN  (wEn)  );
    end
  endgenerate

  generate if ( (SIMUL_RAM!=1) && (FPGA_FAMILY==25) )
    begin: rtg4_uram
      rtg4_lfsr_uram rtg4_uram_0 (
        .A_DOUT (Q),
        .B_DOUT (),
        .C_DIN  (wD),
        .A_ADDR (rA),
        .B_ADDR (),
        .C_ADDR (wA),
        .A_CLK  (rClk),
        .C_CLK  (wClk),
        .C_BLK  (1'b1),
        .C_WEN  (wEn)  );
    end
  endgenerate

  generate if ( (SIMUL_RAM!=1) && ((FPGA_FAMILY==26) || (FPGA_FAMILY==27)) ) begin: g5_uram
    g5_lfsr_uram g5_uram_0 (
       .rD (Q),
       .wD (wD) ,
       .rAddr (rA),
       .wAddr (wA),
       .rClk  (rClk),
       .wClk  (wClk),
       .wEn   (wEn)   );
    end
  endgenerate
endmodule




module lfsr_table (index, outp);
  input[3:0] index;
  output[5:0] outp;
  reg [5:0] outp;

  always @ (index)
    case (index)
      0 : outp = 6'b000000;    // 0x0
      1 : outp = 6'b000101;    // 0x28000
      2 : outp = 6'b001010;    // 0x50000
      3 : outp = 6'b001111;    // 0x78000
      4 : outp = 6'b010100;    // 0xa0000
      5 : outp = 6'b010001;    // 0x88000
      6 : outp = 6'b011110;    // 0xf0000
      7 : outp = 6'b011011;    // 0xd8000
      8 : outp = 6'b101000;    // 0x140000
      9 : outp = 6'b101101;    // 0x168000
     10 : outp = 6'b100010;    // 0x110000
     11 : outp = 6'b100111;    // 0x138000
     12 : outp = 6'b111100;    // 0x1e0000
     13 : outp = 6'b111001;    // 0x1c8000
     14 : outp = 6'b110110;    // 0x1b0000
     15 : outp = 6'b110011;    // 0x198000
    endcase
endmodule


// Version: v12.100 12.100.1.10
module g5_lfsr_uram(
       rD,
       wD,
       rAddr,
       wAddr,
       rClk,
       wClk,
       wEn    );
output [5:0] rD;
input  [5:0] wD;
input  [3:0] rAddr;
input  [3:0] wAddr;
input  rClk;
input  wClk;
input  wEn;

    wire \ACCESS_BUSY[0][0] , VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;

    RAM64x12 lfsr_lut_R0C0 (.BLK_EN(VCC), .BUSY_FB(GND), .R_ADDR({GND,
        GND, rAddr[3], rAddr[2], rAddr[1], rAddr[0]}), .R_ADDR_AD_N(
        VCC), .R_ADDR_AL_N(VCC), .R_ADDR_BYPASS(GND), .R_ADDR_EN(VCC),
        .R_ADDR_SD(GND), .R_ADDR_SL_N(VCC), .R_CLK(rClk), .R_DATA_AD_N(
        VCC), .R_DATA_AL_N(VCC), .R_DATA_BYPASS(GND), .R_DATA_EN(VCC),
        .R_DATA_SD(GND), .R_DATA_SL_N(VCC), .W_ADDR({GND, GND,
        wAddr[3], wAddr[2], wAddr[1], wAddr[0]}), .W_CLK(wClk),
        .W_DATA({GND, GND, GND, GND, GND, GND, wD[5], wD[4], wD[3],
        wD[2], wD[1], wD[0]}), .W_EN(wEn), .ACCESS_BUSY(
        \ACCESS_BUSY[0][0] ), .R_DATA({nc0, nc1, nc2, nc3, nc4, nc5,
        rD[5], rD[4], rD[3], rD[2], rD[1], rD[0]}));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
endmodule



// Version: v11.8 11.8.0.26
module g4_lfsr_uram(
       A_DOUT,
       B_DOUT,
       C_DIN,
       A_ADDR,
       B_ADDR,
       C_ADDR,
       A_CLK,
       C_CLK,
       C_WEN    );
output [5:0] A_DOUT;
output [5:0] B_DOUT;
input  [5:0] C_DIN;
input  [3:0] A_ADDR;
input  [3:0] B_ADDR;
input  [3:0] C_ADDR;
input  A_CLK;
input  C_CLK;
input  C_WEN;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;

    RAM64x18 lfsr_lut_R0C0 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, 
        nc5, nc6, nc7, nc8, nc9, nc10, nc11, A_DOUT[5], A_DOUT[4], 
        A_DOUT[3], A_DOUT[2], A_DOUT[1], A_DOUT[0]}), .B_DOUT({nc12, 
        nc13, nc14, nc15, nc16, nc17, nc18, nc19, nc20, nc21, nc22, 
        nc23, B_DOUT[5], B_DOUT[4], B_DOUT[3], B_DOUT[2], B_DOUT[1], 
        B_DOUT[0]}), .BUSY(), .A_ADDR_CLK(A_CLK), .A_DOUT_CLK(A_CLK), 
        .A_ADDR_SRST_N(VCC), .A_DOUT_SRST_N(VCC), .A_ADDR_ARST_N(VCC), 
        .A_DOUT_ARST_N(VCC), .A_ADDR_EN(VCC), .A_DOUT_EN(VCC), .A_BLK({
        VCC, VCC}), .A_ADDR({GND, GND, GND, A_ADDR[3], A_ADDR[2], 
        A_ADDR[1], A_ADDR[0], GND, GND, GND}), .B_ADDR_CLK(VCC), 
        .B_DOUT_CLK(VCC), .B_ADDR_SRST_N(VCC), .B_DOUT_SRST_N(VCC), 
        .B_ADDR_ARST_N(VCC), .B_DOUT_ARST_N(VCC), .B_ADDR_EN(VCC), 
        .B_DOUT_EN(VCC), .B_BLK({VCC, VCC}), .B_ADDR({GND, GND, GND, 
        B_ADDR[3], B_ADDR[2], B_ADDR[1], B_ADDR[0], GND, GND, GND}), 
        .C_CLK(C_CLK), .C_ADDR({GND, GND, GND, C_ADDR[3], C_ADDR[2], 
        C_ADDR[1], C_ADDR[0], GND, GND, GND}), .C_DIN({GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, C_DIN[5], 
        C_DIN[4], C_DIN[3], C_DIN[2], C_DIN[1], C_DIN[0]}), .C_WEN(
        C_WEN), .C_BLK({VCC, VCC}), .A_EN(VCC), .A_ADDR_LAT(GND), 
        .A_DOUT_LAT(GND), .A_WIDTH({GND, VCC, VCC}), .B_EN(VCC), 
        .B_ADDR_LAT(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, VCC}), 
        .C_EN(VCC), .C_WIDTH({GND, VCC, VCC}), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
endmodule


// Version: v11.7 SP1 11.7.1.14
module rtg4_lfsr_uram(
       A_DOUT,
       B_DOUT,
       C_DIN,
       A_ADDR,
       B_ADDR,
       C_ADDR,
       C_BLK,
       A_CLK,
       C_CLK,
       C_WEN  );
output [5:0] A_DOUT;
output [5:0] B_DOUT;
input  [5:0] C_DIN;
input  [3:0] A_ADDR;
input  [3:0] B_ADDR;
input  [3:0] C_ADDR;
input  C_BLK;
input  A_CLK;
input  C_CLK;
input  C_WEN;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;

    RAM64x18_RT sd_RTG4URAM_0_RTG4URAM_R0C0 (.BUSY(), .A_DB_DETECT(),
        .B_DB_DETECT(), .A_DOUT({nc0, nc1, nc2, nc3, nc4, nc5, nc6,
        nc7, nc8, nc9, nc10, nc11, A_DOUT[5], A_DOUT[4], A_DOUT[3],
        A_DOUT[2], A_DOUT[1], A_DOUT[0]}), .B_DOUT({nc12, nc13, nc14,
        nc15, nc16, nc17, nc18, nc19, nc20, nc21, nc22, nc23,
        B_DOUT[5], B_DOUT[4], B_DOUT[3], B_DOUT[2], B_DOUT[1],
        B_DOUT[0]}), .A_SB_CORRECT(), .B_SB_CORRECT(), .A_ADDR({GND,
        GND, GND, A_ADDR[3], A_ADDR[2], A_ADDR[1], A_ADDR[0]}),
        .B_ADDR({GND, GND, GND, B_ADDR[3], B_ADDR[2], B_ADDR[1],
        B_ADDR[0]}), .C_ADDR({GND, GND, GND, C_ADDR[3], C_ADDR[2],
        C_ADDR[1], C_ADDR[0]}), .A_BLK({VCC, VCC}), .B_BLK({VCC, VCC}),
        .C_BLK({C_BLK, VCC}), .A_CLK(A_CLK), .B_CLK(GND), .C_CLK(C_CLK)
        , .C_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, GND,
        GND, GND, C_DIN[5], C_DIN[4], C_DIN[3], C_DIN[2], C_DIN[1],
        C_DIN[0]}), .A_ADDR_EN(VCC), .B_ADDR_EN(VCC), .A_DOUT_EN(VCC),
        .B_DOUT_EN(VCC), .A_ADDR_SRST_N(VCC), .B_ADDR_SRST_N(VCC),
        .A_DOUT_SRST_N(VCC), .B_DOUT_SRST_N(VCC), .C_WEN(C_WEN),
        .DELEN(GND), .SECURITY(GND), .ECC(GND), .ECC_DOUT_BYPASS(GND),
        .A_WIDTH(GND), .B_WIDTH(GND), .C_WIDTH(GND), .A_DOUT_BYPASS(
        GND), .B_DOUT_BYPASS(VCC), .A_ADDR_BYPASS(GND), .B_ADDR_BYPASS(
        VCC), .ARST_N(VCC));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
endmodule

//                  _   _   _   _   _   _     _   _   _   _
//                 / \ / \ / \ / \ / \ / \   / \ / \ / \ / \
//                ( D | i | t | h | e | r ) ( E | n | d | s )
//                 \_/ \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/

