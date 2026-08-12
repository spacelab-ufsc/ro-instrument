// ***************************************************************************/
//Microsemi Corporation Proprietary and Confidential
//Copyright 2016 Microsemi Corporation. All rights reserved.
//
//ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
//ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
//IN ADVANCE IN WRITING.
//
//Description:  User Test Bench
//              Generic behavioral modules
//
//Revision Information:
//Date         Description
//28Jul2016    Initial Release
//
//SVN Revision Information:
//SVN $Revision: $
//SVN $Data: $
//
//Resolved SARs
//SAR     Date    Who         Description
//
//Notes:
//

 `timescale 1 ns/100 ps

module bhvDelay (nGrst, rst, clk, clkEn,
            inp,
            outp );
  parameter DELAY = 2;
  parameter WIDTH = 2;

  input nGrst, rst, clk, clkEn;
  input [WIDTH-1:0] inp;
  output[WIDTH-1:0] outp;

  integer i;
  // extra register to avoid error/warning if DELAY==0
  reg[WIDTH-1:0] delayLine [0:DELAY];

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
/* Use
  bhvDelay # (  .DELAY(1)
                .WIDTH(1) ) pulse_dly_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(1'b1),
    .inp(inp),
    .outp(outp) );
*/

// Generate clock, nGrst and the first clk period after nGrst.
// nGrst is longer than a clock period
module bhvClockGen(clk, nGrst, ngrst_rising_edge);
  parameter
    CLKPERIOD  = 20,
    NGRSTLASTS = 24;
  output reg clk;
  output reg nGrst;
  output ngrst_rising_edge;

  initial begin
    clk = 0;
    nGrst = 0;
    #(NGRSTLASTS);  nGrst = 1;
  end

  always
    #(CLKPERIOD/2) clk = ~clk;

  bhvEdge # (.REDGE(1) ) rising_edge_0 (
    .nGrst(nGrst), .rst(1'b0), .clk(clk),
    .inp(nGrst), .outp(ngrst_rising_edge) );
endmodule



// generate clock, rst and nGrst.  nGrst is longer than a clock period.
// clk only starts after nGrst ends
module bhvClkGen(clk, rst, nGrst);
  parameter
    CLKPERIOD  = 20,
    NGRSTLASTS = 24,
    RST_DLY    = 10;
  output clk, nGrst, rst;

  reg clki, nGrst;
  reg nGrst_tick, nGrst_tick2;
  wire rsti;

  initial begin
    clki =   1'b0;
    nGrst = 1'b0;
    nGrst_tick  <= 1'b0;
    nGrst_tick2 <= 1'b0;
    #(NGRSTLASTS);  nGrst = 1'b1;
  end

  always
    #(CLKPERIOD/2) clki = ~clki;

  always @ (posedge clki)  begin
    nGrst_tick  <= nGrst;
    nGrst_tick2 <= nGrst_tick;
  end

  assign rsti = nGrst_tick & ~nGrst_tick2;
  assign clk = clki & nGrst;

  bhvDelay # (.DELAY(RST_DLY), .WIDTH(1) ) dly_0 (
    .nGrst(nGrst), .rst(1'b0), .clk(clk), .clkEn(1'b1),
    .inp(rsti), .outp(rst) );
endmodule



module bhvEdge (nGrst, rst, clk, inp, outp);
  parameter REDGE = 1;   // 1 - rising edge, or 0 - falling edge

  input  nGrst, clk, rst;
  input inp;
  output outp;

  reg inp_tick;
  wire rise_edge, fall_edge;

  assign rise_edge = inp & ~inp_tick;
  assign fall_edge = ~inp & inp_tick;
  assign    outp      = (REDGE) ? rise_edge : fall_edge;

  always @(posedge clk or negedge nGrst) begin
    if(!nGrst)    inp_tick <= 1'b0;
    else
      if (rst)    inp_tick <= 1'b0;
      else        inp_tick <= inp;

  end
endmodule
/*  -- usage
bhvEdge # (.REDGE(1)) edge_detect_0 (   // 1 - rising edge, or 0 - falling edge
     .nGrst(nGrst), .rst(rst), .clk(clk),
     .inp(in),
     .outp(out) );
*/  // ------------------------------------------------------------------------



// Synchronize two same-clk-domain pulses, whose clkEn are different
// inp              ____|______________________
// receiver_clkEn   _|______|______|_____|_____
//                           ______
// outp             ________|      |___________
//
module bhv_fEdge_ce(nGrst, rst, clk, receiver_clkEn, inp, outp);
  input nGrst, rst, clk, receiver_clkEn;
  input inp;
  output outp;

  reg async_flop;
  reg flop;

  assign outp = flop;
  always @ (posedge clk or negedge nGrst)
    if(!nGrst)  begin
      async_flop  <= 0;
      flop        <= 0;
    end
    else  begin
      if(inp) async_flop  <= 1;
      else
        if(flop) async_flop  <= 0;

      if(receiver_clkEn)
        if(rst)   flop  <= 0;
        else      flop  <= async_flop;
    end
endmodule


//     #####
//    #     #   ####   #    #  #    #  #####  ######  #####
//    #        #    #  #    #  ##   #    #    #       #    #
//    #        #    #  #    #  # #  #    #    #####   #    #
//    #        #    #  #    #  #  # #    #    #       #####
//    #     #  #    #  #    #  #   ##    #    #       #   #
//     #####    ####    ####   #    #    #    ######  #    #

// simple incremental counter
module bhvCountS(nGrst, rst, clk, clkEn, cntEn, Q, dc);
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
      if(clkEn) begin
        if(rst)       Q <= {WIDTH{1'b0}};
        else
          if(cntEn)   Q <= Q + 1'b1;
      end
endmodule
/* instance
  bhvCountS # ( .WIDTH(WIDTH), .DCVALUE({WIDTH{1'bx}}),
                .BUILD_DC(0) ) counter_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(clkEn),
    .cntEn(cntEn), .Q(outp), .dc() );
*/


// Generate another random sample on every clock if clkEn is active
module bhv_lfsr (nGrst, rst, clk, clkEn, outp, start, term);
  // Douglas J. Smith, p.185
  parameter WIDTH  = 10;
  parameter LENGTH = 100;

  input nGrst, rst, clk, clkEn;
  input start;
  output reg term;    // terminate a particular test sequence
  output[WIDTH-1:0] outp;

  reg  [31:0] tap_arr [2:32];
  wire [31:0] taps_w;
  integer N;
  reg feedback, allZeros;
  reg  [WIDTH-1:0] lfsr_r, next_r;
  integer timer;

  assign taps_w[WIDTH-1:0] = tap_arr[WIDTH];

  always @ (nGrst or posedge clk)
    if(nGrst==1'b0)begin
      timer <= 0;
      term  <= 0;
    end
    else
      if(clkEn==1'b1)   begin
        if(rst || start)begin
          timer <= 0;
          term  <= 0;
        end
        else  begin
          timer <= timer + 1;
          term  <= (timer==10+LENGTH);
        end
      end

  always @ (nGrst or posedge clk)
    if(nGrst==1'b0)     lfsr_r <= 0;
    else
      if(clkEn==1'b1)
        if(rst || start)  lfsr_r <= 0;
        else              lfsr_r <= next_r;

  always @ (lfsr_r) begin
    allZeros = ~|(lfsr_r[WIDTH-2:0]);
    feedback = lfsr_r[WIDTH-1] ^ allZeros;
    for(N=WIDTH-1; N>=1; N=N-1)
      if(taps_w[N-1]==1)
        next_r[N] = lfsr_r[N-1] ^ feedback;
      else
        next_r[N] = lfsr_r[N-1];
    next_r[0] = feedback;
  end

  assign outp = lfsr_r;

  initial begin
    tap_arr[ 2] =  2'b11;
    tap_arr[ 3] =  3'b101;
    tap_arr[ 4] =  4'b1001;
    tap_arr[ 5] =  5'b10010;
    tap_arr[ 6] =  6'b100001;
    tap_arr[ 7] =  7'b1000001;
    tap_arr[ 8] =  8'b10001110;
    tap_arr[ 9] =  9'b100001000;
    tap_arr[10] = 10'b1000000100;
    tap_arr[11] = 11'b10000000010;
    tap_arr[12] = 12'b100000101001;
    tap_arr[13] = 13'b1000000001101;
    tap_arr[14] = 14'b10000000010101;
    tap_arr[15] = 15'b100000000000001;
    tap_arr[16] = 16'b1000000000010110;
    tap_arr[17] = 17'b10000000000000100;
    tap_arr[18] = 18'b100000000001000000;
    tap_arr[19] = 19'b1000000000000010011;
    tap_arr[20] = 20'b10000000000000000100;
    tap_arr[21] = 21'b100000000000000000010;
    tap_arr[22] = 22'b1000000000000000000001;
    tap_arr[23] = 23'b10000000000000000010000;
    tap_arr[24] = 24'b100000000000000000001101;
    tap_arr[25] = 25'b1000000000000000000000100;
    tap_arr[26] = 26'b10000000000000000000100011;
    tap_arr[27] = 27'b100000000000000000000010011;
    tap_arr[28] = 28'b1000000000000000000000000100;
    tap_arr[29] = 29'b10000000000000000000000000010;
    tap_arr[30] = 30'b100000000000000000000000101001;
    tap_arr[31] = 31'b1000000000000000000000000000100;
    tap_arr[32] = 32'b10000000000000000000000001100010;
  end
endmodule

// Dirac delta function: _______|_____________
// Generate another Dirac sample on every clock if clkEn is active
// 0 0 0 .. 0 0 1 0 0 0 0 .. 0 0
module bhv_dirac (nGrst, rst, clk, clkEn, outp, start, term);
  parameter WIDTH = 8;
  parameter AMPL  = 0;    // 0 - classic amplitude=1; 1-ampl=2^(WIDTH-1)
  parameter LENGTH = 100;

  input nGrst, rst, clk, clkEn;
  input start;
  output term;    // terminate a particular test sequence
  output[WIDTH-1:0] outp;

  reg [WIDTH-1:0] outp;
  reg term;
  integer timer;
  wire signed [WIDTH-1:0] amplitude;

  // Negative -2^(WIDTH-1) = 1000..00 or positive 2^(WIDTH-1)-1 = 0111..11
  assign amplitude = AMPL ? {1'b0, {(WIDTH-1){1'b1}}} : {{(WIDTH-1){1'b0}}, 1'b1 };

  always @ (nGrst or posedge clk)
    if(nGrst==1'b0)   begin
      timer <= 0;
      term  <= 0;
    end
    else
      if(clkEn==1'b1)   begin
        if(rst || start)  timer <= 0;
        else              timer <= timer + 1;

        term    <=  (timer==10+2*LENGTH);
      end

  always @ (timer) begin
    if(timer==10)           outp =  amplitude;
    else
      if(timer==10+LENGTH)
        outp = -amplitude;
      else                  outp = 0;
  end
endmodule

//           ________
// Step: ___|
// Generate Step function sample on every clock if clkEn is active
// 0 0 0 .. 0 0 1 0 0 0 0 .. 0 0
module bhv_step (nGrst, rst, clk, clkEn, outp, start, term);
  parameter WIDTH = 8;
  parameter AMPL  = 0;    // 0 - classic amplitude=1; 1-ampl=2^(WIDTH-1)
  parameter NEG_AMPL = 0; // negative amplitude
  parameter LENGTH = 100;

  input nGrst, rst, clk, clkEn;
  input start;
  output term;    // terminate a particular test sequence
  output[WIDTH-1:0] outp;

  reg [WIDTH-1:0] outp;
  reg term;
  integer timer;
  wire signed [WIDTH-1:0] ampl, amplitude;

  // ampl = 0111..11 or 000..001
  assign ampl = AMPL ? {1'b0, {(WIDTH-1){1'b1}}} : {{(WIDTH-1){1'b0}}, 1'b1 };
  assign amplitude = NEG_AMPL ? -ampl : ampl;

  always @ (nGrst or posedge clk)
    if(nGrst==1'b0)     begin
      timer <= 0;
      term  <= 0;
    end
    else
      if(clkEn==1'b1) begin
        if(rst || start)  begin
          timer <= 0;
          term  <= 0;
        end
        else  begin
          timer <= timer + 1;
          term  <= (timer==10+LENGTH);
        end
      end

  always @ (timer)
    if((timer>=0) && (timer<=10+LENGTH))
      outp =  amplitude;
    else
      outp = 0;

endmodule


module bhv_gen (nGrst, rst, clk, clkEn, outp, start, term);
  parameter TYPE  = 0;  //0-Dirac, 1-step, 2-random
  parameter WIDTH = 8;
  parameter AMPL  = 0;    // 0 - classic amplitude=1; 1-ampl=2^(WIDTH-1)
  parameter LENGTH = 100;
  parameter NEG_AMPL = 0; // negative amplitude

  input nGrst, rst, clk, clkEn;
  input start;
  output term;    // terminate a particular test sequence
  output[WIDTH-1:0] outp;

  wire starti, termi;

  // Detect start if it falls in btw clkEn
  bhv_fEdge_ce detect_start_0(
      .nGrst(nGrst), .clk(clk), .receiver_clkEn(clkEn), .rst(1'b0),
      .inp(start),
      .outp(starti) );

  generate
    case (TYPE)
      0: bhv_dirac # (.WIDTH(WIDTH),
                      .AMPL(AMPL),
                      .LENGTH(LENGTH)  ) dirac_0 (
            .nGrst(nGrst),
            .rst  (rst),
            .clk  (clk),
            .clkEn(clkEn),
            .start(starti),
            .term(termi),
            .outp (outp)    );

      1: bhv_step # (.WIDTH(WIDTH),
                     .AMPL(AMPL),
                     .NEG_AMPL(NEG_AMPL),
                     .LENGTH(LENGTH)  ) step_0 (
            .nGrst(nGrst),
            .rst  (rst),
            .clk  (clk),
            .clkEn(clkEn),
            .start(starti),
            .term(termi),
            .outp (outp)    );

      2: bhv_lfsr # (.WIDTH(WIDTH),
                     .LENGTH(LENGTH) ) lfsr_0 (
            .nGrst(nGrst),
            .rst  (rst),
            .clk  (clk),
            .clkEn(clkEn),
            .start(starti),
            .term(termi),
            .outp (outp)    );
      default:  bhv_dirac # (.WIDTH(WIDTH),
                             .AMPL(AMPL),
                             .LENGTH(LENGTH)  ) dirac_0 (
            .nGrst(nGrst),
            .rst  (rst),
            .clk  (clk),
            .clkEn(clkEn),
            .start(starti),
            .term(termi),
            .outp (outp)    );

    endcase
  endgenerate

  // Narrow term to 1 clk
  bhvEdge # (.REDGE(1)) edge_detect_0 (
     .nGrst(nGrst), .rst(rst), .clk(clk),
     .inp(termi),
     .outp(term) );
endmodule


module bhv_coef_gen (nGrst, rst, clk, clkEn, coef, coef_valid, start, term);
  parameter TAPS        = 100;
  parameter COEF_WIDTH  = 12;
  parameter COEF_SETS   = 1;
  parameter COEF_TYPE   = 0;  //1 - reloadable

  input nGrst, rst, clk, clkEn;
  input start;
  output term;    // terminate a particular test sequence
  output[COEF_WIDTH-1:0] coef;
  output coef_valid;

  reg gate, gate_tick;
  integer coef_count, timer, sequence1, i, j, seed;
  reg [COEF_WIDTH-1:0] coef_rand; // use it to simulate reloadable coefs
  wire coef_valid_w1;

  wire [COEF_WIDTH-1:0] coef_arr [0:15][0:TAPS-1];

  // reloadable coef array
  reg [COEF_WIDTH-1:0] reload_coef_arr [0:15][0:TAPS-1];
  initial begin
    seed = 2;
    for(i=0; i<15; i=i+1)
      for(j=0; j<TAPS; j=j+1)
        reload_coef_arr[i][j] = $random(seed);
  end

  // Generate only reloadable coefs
  assign coef = reload_coef_arr[sequence1][coef_count];

  assign coef_valid_w1 =
            ((timer[2:0]<3'b101)) | (timer[2:0]==3'b110);

  assign coef_valid = coef_valid_w1 & gate;
  // rear end of the gate
  assign term = gate_tick & ~gate;

  always @ (nGrst or posedge clk)
    if(nGrst==1'b0) begin
      sequence1    <= 0;
      coef_count  <= 0;
      gate_tick   <= 1'b0;
      gate        <= 1'b0;
      coef_rand   <= 'b0;
    end
    else
      if(clkEn==1'b1)
        if(rst) begin
          sequence1    <= 0;
          coef_count  <= 0;
          gate_tick   <= 1'b0;
          gate        <= 1'b0;
          coef_rand   <= 'b0;
        end
        else  begin
          coef_rand   <= $random;

          if(start) begin
            if(sequence1 == COEF_SETS-1)  sequence1  <= 0;
            else                         sequence1  <= sequence1 + 1;
            coef_count  <= 0;
            gate_tick   <= 1'b0;
            gate        <= 1'b1;
          end
          else  begin
            gate_tick   <= gate;
            if(coef_valid_w1) begin
              if(coef_count==TAPS-1)  begin
                coef_count  <= 0;
                gate  <= 1'b0;
              end
              else if(gate)
                coef_count  <= coef_count+1;
            end   // coef_valid_w1
          end
        end
  // Free running timer
  always @ (nGrst or posedge clk)
    if(nGrst==1'b0)     timer       <= 0;
    else
      if(clkEn==1'b1)
        if(rst | start) timer       <= 0;
        else            timer       <= timer + 1;
endmodule







//                     ########      ###     ##     ##
//                     ##     ##    ## ##    ###   ###
//                     ##     ##   ##   ##   #### ####
//                     ########   ##     ##  ## ### ##
//                     ##   ##    #########  ##     ##
//                     ##    ##   ##     ##  ##     ##
//                     ##     ##  ##     ##  ##     ##
//
// --------- Two-port RAM simulation model ----------
// It has an extra reg simulating an output hard RAM register
module bhvRAM_fabric (nGrst, RCLOCK, WCLOCK,
       WRB, RDB,
       DI,
       RADDR, WADDR,
       DO       );
  parameter
    BITWIDTH  = 16,
    RAM_DEPTH = 256,
    RAM_LOGDEPTH = 8;

  input  nGrst, WCLOCK, RCLOCK;
  input  WRB, RDB;
  input  [BITWIDTH-1:0] DI;
  input  [RAM_LOGDEPTH-1:0] RADDR, WADDR;
  output [BITWIDTH-1:0] DO;

  reg [BITWIDTH-1:0] ramArray [0:RAM_DEPTH-1];
  reg [BITWIDTH-1:0] arrOut;
  integer i;

  assign DO = arrOut;
  // write
  always @(posedge WCLOCK or negedge nGrst)
    if(!nGrst)
      for(i=0; i<RAM_DEPTH; i=i+1)
        ramArray[i] <= 'bx;
    else
      if (WRB) ramArray[WADDR] <= DI;

  // read
  always @(posedge RCLOCK)                // RAM block output register
    if (RDB) arrOut <= ramArray[RADDR];

endmodule