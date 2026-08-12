//Microsemi Corporation Proprietary and Confidential
//Copyright 2016 Microsemi Corporation. All rights reserved.
//
//ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
//ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
//IN ADVANCE IN WRITING.
//
//Description:  CoreDDS
//              DDS common RTL modules
//
//Revision Information:
//Date         Description
//8/18/2016    Initial Release
//
//SVN Revision Information:
//SVN $Revision:
//SVN $Data: $
//
//Resolved SARs
//SAR     Date    Who         Description
//
//Notes:

`timescale 1 ns/100 ps

//                         ____  ____  __      __   _  _
//                        (  _ \( ___)(  )    /__\ ( \/ )
//                         )(_) ))__)  )(__  /(__)\ \  /
//                        (____/(____)(____)(__)(__)(__)

//----------- Register-based 1-bit Delay has only input and output ---------
module dds_kitDelay_bit_reg(nGrst, rst, clk, clkEn, inp, outp);
  parameter
    DELAY = 2;

  input  nGrst, rst, clk, clkEn;
  input  inp;
  output outp;
  // extra register to avoid error if DELAY==0
  reg delayLine [0:DELAY];
  integer i;

  generate
    if(DELAY==0)
      assign outp = inp;
    else begin
      assign outp = delayLine[DELAY-1];

      always @(posedge clk or negedge nGrst)
        if(!nGrst)
          for(i=0; i<DELAY; i=i+1)         delayLine[i] <= 1'b0;
        else
          if (clkEn)
            if (rst)
              for (i = 0; i<DELAY; i=i+1)  delayLine[i] <= 1'b0;
            else  begin
              for(i=DELAY-1; i>=1; i=i-1)  delayLine[i] <= delayLine[i-1];
              delayLine[0] <= inp;
            end  // clkEn
    end
  endgenerate
endmodule
/*
  dds_kitDelay_bit_reg # (.DELAY(DELAY)) dly_0 (
      .nGrst(NGRST), .rst(1'b0), .clk(CLK), .clkEn(1'b1),
      .inp(inp),
      .outp(outp) );
*/


//----------- Register-based Multi-bit Delay has only input and output ---------
module dds_kitDelay_reg(nGrst, rst, clk, clkEn, inp, outp);
  parameter
    BITWIDTH = 16,
    DELAY = 2;

  input  nGrst, rst, clk, clkEn;
  input  [BITWIDTH-1:0] inp;
  output   [BITWIDTH-1:0] outp;
  // extra register to avoid error if DELAY==0
  reg [BITWIDTH-1:0] delayLine [0:DELAY];
  integer i;

  generate
    if(DELAY==0)
      assign outp = inp;
    else begin
      assign outp = delayLine[DELAY-1];

      always @(posedge clk or negedge nGrst)
        if(!nGrst)
          for(i=0; i<DELAY; i=i+1)         delayLine[i] <= 'b0;
        else
          if (clkEn)
            if (rst)
              for (i = 0; i<DELAY; i=i+1)  delayLine[i] <= 'b0;
            else begin
              for(i=DELAY-1; i>=1; i=i-1)  delayLine[i] <= delayLine[i-1];
              delayLine[0] <= inp;
            end  // clkEn
    end
  endgenerate
endmodule
/*
  dds_kitDelay_reg # (.BITWIDTH(DATA_WIDTH), .DELAY(WRAP_LAYERS) ) wrap_0 (
      .nGrst(NGRST), .rst(1'b0), .clk(CLK), .clkEn(1'b1),
      .inp(DATAI),
      .outp(datai_wrap) );
*/


// speed starts
//----------- Register-based Multi-bit Delay. SynPro isn't supposed to  ---------
//-----------                     optimize it out                       ---------
module dds_kitDelay_reg_attr(nGrst, rst, clk, clkEn, inp, outp);
  parameter
    BITWIDTH = 16,
    DELAY = 2;

  input  nGrst, rst, clk, clkEn;
  input  [BITWIDTH-1:0] inp;
  output   [BITWIDTH-1:0] outp;
  // extra register to avoid error if DELAY==0
  reg [BITWIDTH-1:0] delayLine [0:DELAY-1] /* synthesis syn_preserve=1 */ ;
  integer i;

  generate
    if(DELAY==0)
      assign outp = inp;
    else begin
      assign outp = delayLine[DELAY-1];

      always @(posedge clk or negedge nGrst)
        if(!nGrst)
          for(i=0; i<DELAY; i=i+1)         delayLine[i] <= 'b0;
        else
          if (clkEn)
            if (rst)
              for (i = 0; i<DELAY; i=i+1)  delayLine[i] <= 'b0;
            else begin
              for(i=DELAY-1; i>=1; i=i-1)  delayLine[i] <= delayLine[i-1];
              delayLine[0] <= inp;
            end  // clkEn
    end
  endgenerate
endmodule
/*
  dds_kitDelay_reg_attr # (.BITWIDTH(DATA_WIDTH), .DELAY(WRAP_LAYERS) ) wrap_layer_0 (
      .nGrst(NGRST), .rst(1'b0), .clk(CLK), .clkEn(1'b1), 
      .inp(DATAI), 
      .outp(datai_wrap) );
*/
// speed ends


//                       _____                  _
//                      / ____|                | |
//                     | |     ___  _   _ _ __ | |_ ___ _ __
//                     | |    / _ \| | | | '_ \| __/ _ \ '__|
//                     | |___| (_) | |_| | | | | ||  __/ |
//                      \_____\___/ \__,_|_| |_|\__\___|_|

// simple incremental counter
module dds_kitCountS(nGrst, rst, clk, clkEn, cntEn, Q, dc);
  parameter WIDTH = 16;
  parameter DCVALUE = (1 << WIDTH) - 1; // state to decode
  parameter BUILD_DC = 1;

  input nGrst, rst, clk, clkEn, cntEn;
  output [WIDTH-1:0] Q;
  output dc;  // decoder output
  reg [WIDTH-1:0] Q;

  assign dc = (BUILD_DC==1)? (Q == DCVALUE) : 1'bx;

  always@(negedge nGrst or posedge clk)
    if(!nGrst) Q <= {WIDTH{1'b0}};
    else
      if(clkEn)
        if(rst)       Q <= {WIDTH{1'b0}};
        else
          if(cntEn)   Q <= Q + 1'b1;
endmodule
/* instance
  dds_kitCountS # ( .WIDTH(WIDTH), .DCVALUE({WIDTH{1'bx}}),
                .BUILD_DC(0) ) counter_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(clkEn),
    .cntEn(cntEn), .Q(outp), .dc() );
*/


//10/28/16  //                         _____                       _
//10/28/16  //                        |  __ \                     | |
//10/28/16  //                        | |__) |___  _   _ _ __   __| |
//10/28/16  //                        |  _  // _ \| | | | '_ \ / _` |
//10/28/16  //                        | | \ \ (_) | |_| | | | | (_| |
//10/28/16  //                        |_|  \_\___/ \__,_|_| |_|\__,_|
//10/28/16  
//10/28/16  // ----------------------------  Simple Round Up  -----------------------------
//10/28/16  // 2-clk delay to match convergent rounding
//10/28/16  // -------------------------------
//10/28/16  // INWIDTH must be >= OUTWIDTH+1.
//10/28/16  // -------------------------------
//10/28/16  module dds_kitRndUp (nGrst, rst, clk, datai_valid, inp, outp,
//10/28/16    validi, valido);  //just a bit that travels side by side with data
//10/28/16    parameter INWIDTH   = 16;
//10/28/16    parameter OUTWIDTH  = 12;
//10/28/16    parameter QUANTIZATION = 1;   // Simply truncate if QUANTIZATION==0
//10/28/16  
//10/28/16    input nGrst, rst, clk, datai_valid, validi;
//10/28/16    input[INWIDTH-1:0] inp;
//10/28/16    output valido;
//10/28/16    output [OUTWIDTH-1:0] outp;
//10/28/16  
//10/28/16    wire[OUTWIDTH:0] inp_w, inp_ww;
//10/28/16    wire[OUTWIDTH-1:0] outp_w;
//10/28/16  
//10/28/16    generate if (QUANTIZATION!=0)
//10/28/16      begin: round
//10/28/16        // drop all but one truncated LSB's
//10/28/16        assign inp_w  = inp[INWIDTH-1:INWIDTH-OUTWIDTH-1];
//10/28/16        assign inp_ww = inp_w + 'b1;
//10/28/16        assign outp_w = inp_ww[OUTWIDTH:1];
//10/28/16      end
//10/28/16    endgenerate
//10/28/16  
//10/28/16    generate if (QUANTIZATION==0)
//10/28/16      begin: truncate
//10/28/16        assign outp_w = inp[INWIDTH-1:INWIDTH-OUTWIDTH];
//10/28/16      end
//10/28/16    endgenerate
//10/28/16  
//10/28/16    dds_kitDelay_reg # (.BITWIDTH(OUTWIDTH), .DELAY(2) ) pipe_0 (
//10/28/16        .nGrst(nGrst), .rst(rst), .clk(clk),
//10/28/16        .clkEn(datai_valid),
//10/28/16        .inp(outp_w),  .outp(outp) );
//10/28/16  
//10/28/16    dds_kitDelay_bit_reg # (.DELAY(2)) pipe_1 (
//10/28/16        .nGrst(nGrst), .rst(rst), .clk(clk),
//10/28/16        .clkEn(datai_valid),
//10/28/16        .inp(validi), .outp(valido) );
//10/28/16  endmodule
//10/28/16  
//10/28/16  
//10/28/16  // ---------------------------  Convergent Rounding  --------------------------
//10/28/16  // Round-to-nearest-even  = Convergent = Round half to even = Unbiased =
//10/28/16  // statistician's rounding = Dutch rounding = Gaussian rounding =
//10/28/16  // Odd-even rounding = Bankers' rounding = broken rounding = DDR rounding
//10/28/16  // and is widely used in bookkeeping.
//10/28/16  // 2-clk delay
//10/28/16  // -------------------------------
//10/28/16  // INWIDTH must be >= OUTWIDTH+2.
//10/28/16  // -------------------------------
//10/28/16  // Overflow may occur when inp>0 only since we always add 1 or 0, never add -1
//10/28/16  module dds_kitRndEven (nGrst, clk, datai_valid, rst, inp, outp,
//10/28/16    validi, valido);  //just a bit that travels side by side with data
//10/28/16    parameter INWIDTH   = 16;
//10/28/16    parameter OUTWIDTH  = 12;
//10/28/16  
//10/28/16    input nGrst, clk, rst, datai_valid;
//10/28/16    input validi;  // input's valid
//10/28/16    input [INWIDTH-1:0]  inp;
//10/28/16    output[OUTWIDTH-1:0] outp;
//10/28/16    output valido;  // output's valid
//10/28/16  
//10/28/16    wire roundBit, roundBit_tick, stickyBit, rBit, lsBit, riskOV;
//10/28/16    wire [OUTWIDTH-1:0] inp_w, inp_tick, outp_w;
//10/28/16  
//10/28/16    // sign bit
//10/28/16    wire signBit = inp[INWIDTH-1];
//10/28/16  
//10/28/16    // the least significant remaining bit
//10/28/16    assign lsBit = inp[INWIDTH-OUTWIDTH];
//10/28/16    // the most significant truncated bit
//10/28/16    assign rBit = inp[INWIDTH-OUTWIDTH-1];
//10/28/16    assign stickyBit  = |inp[INWIDTH-OUTWIDTH-2:0];
//10/28/16    // Detect the max positive number of size OUTWIDTH: sign==0, others==1
//10/28/16    assign riskOV = (~signBit) & (&inp[INWIDTH-2:INWIDTH-OUTWIDTH]);
//10/28/16    // Calculate the bit to be added to the remaining bits
//10/28/16    assign roundBit = rBit & (stickyBit | lsBit) & ~riskOV;
//10/28/16  
//10/28/16    // Pipe the roundBit
//10/28/16    dds_kitDelay_bit_reg # (.DELAY(1)) roundBit_pipe_0 (
//10/28/16        .nGrst(nGrst), .rst(rst), .clk(clk),
//10/28/16        .clkEn(datai_valid),
//10/28/16        .inp(roundBit), .outp(roundBit_tick) );
//10/28/16  
//10/28/16    // Simply delay the bits to match the roundBit delay
//10/28/16    assign inp_w = inp[INWIDTH-1:INWIDTH-OUTWIDTH];
//10/28/16    dds_kitDelay_reg # (.BITWIDTH(OUTWIDTH), .DELAY(1) ) inp_pipe_0 (
//10/28/16        .nGrst(nGrst), .rst(rst), .clk(clk),
//10/28/16        .clkEn(datai_valid),
//10/28/16        .inp(inp_w),  .outp(inp_tick) );
//10/28/16  
//10/28/16    // Calculate the result and pipe it
//10/28/16    assign outp_w = inp_tick + roundBit_tick;
//10/28/16    dds_kitDelay_reg # (.BITWIDTH(OUTWIDTH), .DELAY(1) ) result_pipe_0 (
//10/28/16        .nGrst(nGrst), .rst(rst), .clk(clk),
//10/28/16        .clkEn(datai_valid),
//10/28/16        .inp(outp_w),  .outp(outp) );
//10/28/16  
//10/28/16    // Pipe valid bit
//10/28/16    dds_kitDelay_bit_reg # (.DELAY(2)) valid_pipe_0 (
//10/28/16        .nGrst(nGrst), .rst(rst), .clk(clk),
//10/28/16        .clkEn(datai_valid),
//10/28/16        .inp(validi), .outp(valido) );
//10/28/16  endmodule
//10/28/16  
//10/28/16  
//10/28/16  // Combine all round types depending on QUANTIZATION parameter and
//10/28/16  // INWIDTH/OUTWIDTH values:
//10/28/16  // QUANTIZATION                   Function
//10/28/16  // ---------------------------------------
//10/28/16  //  0     INWIDTH >  OUTWIDTH     Truncate
//10/28/16  //  1     INWIDTH >  OUTWIDTH     Round up
//10/28/16  //  2     INWIDTH > OUTWIDTH+1    Convergent round
//10/28/16  //  2     INWIDTH ==OUTWIDTH+1    Round up
//10/28/16  //  x     INWIDTH <= OUTWIDTH     Sign extend
//10/28/16  module dds_kitRoundTop (nGrst, rst, clk, datai_valid, inp, outp,
//10/28/16    //just bit that travels side by side with data.  No interaction with rounding
//10/28/16    validi, valido);
//10/28/16    parameter INWIDTH   = 16;
//10/28/16    parameter OUTWIDTH  = 12;
//10/28/16    parameter QUANTIZATION = 1;   // Simply truncate if QUANTIZATION==0
//10/28/16  
//10/28/16    input nGrst, rst, clk, datai_valid, validi;
//10/28/16    input[INWIDTH-1:0] inp;
//10/28/16    output valido;
//10/28/16    output [OUTWIDTH-1:0] outp;
//10/28/16  
//10/28/16    wire [OUTWIDTH-1:0] outp_w;
//10/28/16    generate if (INWIDTH <= OUTWIDTH)
//10/28/16      begin: sign_extend
//10/28/16        signExt # ( .INWIDTH(INWIDTH), .OUTWIDTH(OUTWIDTH), .UNSIGN(0)) signExt_0 (
//10/28/16        .inp(inp), .outp(outp_w)   );
//10/28/16        dds_kitDelay_reg # (.BITWIDTH(OUTWIDTH), .DELAY(2) ) pipe_0 (
//10/28/16          .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(datai_valid),
//10/28/16          .inp(outp_w),  .outp(outp) );
//10/28/16  
//10/28/16        dds_kitDelay_bit_reg # (.DELAY(2)) pipe_1 (
//10/28/16          .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(datai_valid),
//10/28/16          .inp(validi), .outp(valido) );
//10/28/16      end
//10/28/16    endgenerate
//10/28/16  
//10/28/16    // Truncate or round up
//10/28/16    generate if ( ((INWIDTH>OUTWIDTH)&&(QUANTIZATION<2))||(INWIDTH==OUTWIDTH+1) )
//10/28/16      begin: round_up
//10/28/16        dds_kitRndUp # (.INWIDTH (INWIDTH ),
//10/28/16                        .OUTWIDTH(OUTWIDTH),
//10/28/16                        .QUANTIZATION(QUANTIZATION) ) dds_kitRndUp_0 (
//10/28/16          .nGrst(nGrst), .rst(rst), .clk(clk),
//10/28/16          .datai_valid(datai_valid),
//10/28/16          .inp(inp), .outp(outp), .validi(validi), .valido(valido) );
//10/28/16      end
//10/28/16    endgenerate
//10/28/16  
//10/28/16    generate if ( (INWIDTH>OUTWIDTH+1) && (QUANTIZATION==2) )
//10/28/16      begin: converg_round
//10/28/16        dds_kitRndEven # (.INWIDTH (INWIDTH ),
//10/28/16                          .OUTWIDTH(OUTWIDTH) ) dds_kitRndEven_0 (
//10/28/16          .nGrst(nGrst), .rst(rst), .clk(clk),
//10/28/16          .datai_valid(datai_valid),
//10/28/16          .inp(inp), .outp(outp), .validi(validi), .valido(valido) );
//10/28/16      end
//10/28/16    endgenerate
//10/28/16  endmodule

//        ___  ____  ___  _  _    ____  _  _  ____  ____  _  _  ____
//       / __)(_  _)/ __)( \( )  ( ___)( \/ )(_  _)( ___)( \( )(  _ \
//       \__ \ _)(_( (_-. )  (    )__)  )  (   )(   )__)  )  (  )(_) )
//       (___/(____)\___/(_)\_)  (____)(_/\_) (__) (____)(_)\_)(____/
// Resize a vector inp to the specified size.
// When resizing to a larger vector, sign extend the inp: the new [leftmost]
// bit positions are filled with a sign bit (UNSIGN==0) or 0's (UNSIGN==1).
// When resizing to a smaller vector, account for the DROP_MSB flavor:
// - DROP_MSB==0.  Normal. Simply drop extra LSB's
// - DROP_MSB==1.  Unusual. If signed, retain the sign bit along with the LSB's
//                 If unsigned, simply drop extra MSB"s

module signExt (inp, outp);
  parameter INWIDTH = 16;
  parameter OUTWIDTH = 20;
  parameter UNSIGN   = 0;   // 0-signed conversion; 1-unsigned
  // When INWIDTH>OUTWIDTH, drop extra MSB's.  Normally extra LSB's are dropped.
  parameter DROP_MSB = 0;

  input [INWIDTH-1:0] inp;
  output[OUTWIDTH-1:0] outp;

  wire sB, u_sB;

  // Input sign bit
  assign sB   = inp[INWIDTH-1];
  generate
    if(INWIDTH == OUTWIDTH) begin: pass_thru
      assign outp = inp;
    end
  endgenerate

  generate
    if(OUTWIDTH>INWIDTH) begin: extend_sign
      assign outp[INWIDTH-1:0] = inp;
      assign u_sB = (UNSIGN==0)? sB : 1'b0;
      assign outp[OUTWIDTH-1:INWIDTH] = {(OUTWIDTH-INWIDTH){u_sB}};
    end
  endgenerate

  generate
    if((OUTWIDTH<INWIDTH) && (DROP_MSB==0)) begin: cut_lsbs
      assign outp = inp[INWIDTH-1:INWIDTH-OUTWIDTH];
    end
  endgenerate

  generate
    if((OUTWIDTH<INWIDTH) && (DROP_MSB==1)) begin: cut_msbs
      assign outp[OUTWIDTH-2:0] = inp[OUTWIDTH-2:0];
      // If signed, keep the input sign bit; otherwise just drop extra MSB's
      assign outp[OUTWIDTH-1] = (UNSIGN==0)? sB : inp[OUTWIDTH-1];
    end
  endgenerate
endmodule

/* usage:
  signExt # ( .INWIDTH(DATA_WIDTH),
              .OUTWIDTH(DATA_WIDTH_MAC),
              .UNSIGN(UNSIGN),
              .DROP_MSB(0) ) signExt_0 (
    .inp(data), .outp(data2mac)   );
*/


//                            _____            __  __
//                           |  __ \     /\   |  \/  |
//                           | |__) |   /  \  | \  / |
//                           |  _  /   / /\ \ | |\/| |
//                           | | \ \  / ____ \| |  | |
//                           |_|  \_\/_/    \_\_|  |_|
//
// --------- Two-port RAM simulation model ----------
// It has an output reg to simulate a data read hard RAM pipe
module dds_kitRam_fabric (nGrst, //nGrst for simulation only to init RAM
    RCLOCK, WCLOCK, WRB, RDB, rstDataPipe,
    DI, RADDR, WADDR, DO  );
  parameter WIDTH = 16;
  parameter LOGDEPTH = 8;
  parameter DEPTH = 1256;
  parameter RA_PIPE   = 1;
  parameter RD_PIPE   = 1;

  input  nGrst, WCLOCK, RCLOCK, WRB, RDB, rstDataPipe;
  input  [WIDTH-1:0] DI;
  input  [LOGDEPTH-1:0] RADDR, WADDR;
  output [WIDTH-1:0] DO;
//  reg [WIDTH-1:0] DO;

  reg [WIDTH-1:0] ramArray [0:DEPTH-1] /* synthesis syn_ramstyle="registers" */;
  wire [WIDTH-1:0] arrOut, wD;
  wire [LOGDEPTH-1:0] raddr_i, waddr_i, rAi, wAi;
  wire rEn, wEn;
  integer i;

  assign raddr_i = (DEPTH>1)? RADDR : 'b0;
  assign waddr_i = (DEPTH>1)? WADDR : 'b0;

  // DI, rEn, wEn, wA, rA pipes
  // rA internal reg
  generate if(RA_PIPE==1)
    dds_kitDelay_reg # (.BITWIDTH(LOGDEPTH), .DELAY(1) ) rA_pipe_0 (
        .nGrst(1'b1), .rst(1'b0), .clk(RCLOCK), .clkEn(1'b1),
        .inp(raddr_i),
        .outp(rAi) );
  endgenerate

  generate if(RA_PIPE!=1)
    assign rAi = raddr_i;
  endgenerate

  // wA internal reg
  dds_kitDelay_reg # (.BITWIDTH(LOGDEPTH), .DELAY(1) ) wA_pipe_0 (
      .nGrst(1'b1), .rst(1'b0), .clk(WCLOCK), .clkEn(1'b1),
      .inp(waddr_i),
      .outp(wAi) );

  dds_kitDelay_reg # (.BITWIDTH(WIDTH), .DELAY(1) ) DI_pipe_0 (
      .nGrst(1'b1), .rst(1'b0), .clk(WCLOCK), .clkEn(1'b1),
      .inp(DI),
      .outp(wD) );

  dds_kitDelay_bit_reg # (.DELAY(1)) rEn_pipe_0 (
      .nGrst(nGrst), .rst(1'b0), .clk(RCLOCK), .clkEn(1'b1),
      .inp(RDB), .outp(rEn) );
  dds_kitDelay_bit_reg # (.DELAY(1)) wEn_pipe_0 (
      .nGrst(nGrst), .rst(1'b0), .clk(WCLOCK), .clkEn(1'b1),
      .inp(WRB), .outp(wEn) );

  // WRITE
  always @(posedge WCLOCK or negedge nGrst)
    if(!nGrst)
      for(i=0; i<DEPTH; i=i+1)
        ramArray[i] <= 'bx;
    else
      if (wEn==1'b1) ramArray[wAi] <= wD;
  // READ
  assign arrOut = (rEn==1'b1)? ramArray[rAi] : 'bx;

  // Hard RAM data read pipe
  generate if(RD_PIPE==1)
    dds_kitDelay_reg # (.BITWIDTH(WIDTH), .DELAY(1) ) rD_pipe_0 (
      .nGrst(nGrst), .rst(rstDataPipe), .clk(RCLOCK), .clkEn(1'b1),
        .inp(arrOut),
        .outp(DO) );
  endgenerate

  generate if(RD_PIPE==0)
    assign DO = arrOut;
  endgenerate

endmodule


//10/28/16  module ddsKit_decoder(code, onehot, en);
//10/28/16    parameter CODEW = 3;
//10/28/16    parameter ONEHOTW = 8;
//10/28/16  
//10/28/16    input [CODEW-1:0] code;
//10/28/16    input en;
//10/28/16    output[ONEHOTW-1:0] onehot;
//10/28/16    reg [ONEHOTW-1:0] onehot;
//10/28/16  
//10/28/16    always @ (code or en ) begin
//10/28/16      onehot        = 'b0;
//10/28/16      onehot[code]  = en;
//10/28/16    end
//10/28/16  endmodule




// Async global reset synchronizer generates a 1 or 2-clk wide sync'ed
// pulse on rising edge of the async reset
// -  Output 'pulse' is a 1 or 2-clk pulse at nGrst back edge 
// -  Output rstn = ext_rstn OR 1-clk pulse  
module dds_kitSyncNgrst (nGrst, clk, pulse, ext_rstn, rstn);
  parameter PULSE_WIDTH = 1;

  input nGrst, clk, ext_rstn;
  output pulse, rstn;

  wire synced_ngrst, synced_ngrst_t1, synced_ngrst_t2, pulsei;

  // Synchronize nGrst
  dds_kitDelay_bit_reg # (.DELAY(4)) sync_ngrst_0 (
    .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
    .inp(1'b1), .outp(synced_ngrst) ) ;

  // Delay synced_ngrst by a clock
  dds_kitDelay_bit_reg # (.DELAY(1)) sync_ngrst_1 (
    .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
    .inp(synced_ngrst), .outp(synced_ngrst_t1) ) ;

  generate if (PULSE_WIDTH==2)
    begin: two_clk
      dds_kitDelay_bit_reg # (.DELAY(1)) sync_ngrst_2 (
        .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
        .inp(synced_ngrst_t1), .outp(synced_ngrst_t2) ) ;

      assign pulsei = synced_ngrst & ~synced_ngrst_t2;
    end
  endgenerate

  generate if (PULSE_WIDTH!=2)
    begin: one_clk
      assign pulsei = synced_ngrst & ~synced_ngrst_t1;
    end
  endgenerate

  dds_kitDelay_bit_reg # (.DELAY(1)) sync_ngrst_3 (
    .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
    .inp(pulsei), .outp(pulse) ) ;

  // Sync rstn signal for the major design part not involed in LUT init
  assign rstn = ext_rstn & synced_ngrst;
endmodule



