// ***************************************************************************/
//Microsemi Corporation Proprietary and Confidential
//Copyright 2016 Microsemi Corporation. All rights reserved.
//
//ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
//ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
//IN ADVANCE IN WRITING.
//
//Description:  CoreDDS
//              User testbench
//
//Revision Information:
//Date         Description
//26Aug2016    Initial Release
//
//SVN Revision Information:
//SVN $Revision: $
//SVN $Data: $
//
//Resolved SARs
//SAR     Date    Who         Description
//


module testbench;
  `include "../../../../coreparameters.v"
//  `include "dds_bhvTestVectOut.v"
  localparam TST_LENGTH = 510;
  // Transfer test length from SW !

  // Replicate RTL param values
  // parameter MAX_FULL_WAVE_LOGDEPTH = 9;  Delivered via coreparameters.v/vhd
  localparam QUARTER_WAVE = (QUANTIZER_BITS > MAX_FULL_WAVE_LOGDEPTH)? 1 : 0;
  localparam RAM_LOGDEPTH = (QUARTER_WAVE==0)? QUANTIZER_BITS : QUANTIZER_BITS-3;
  localparam LOGDEPTH_LONG = (RAM_LOGDEPTH>3)? RAM_LOGDEPTH : 4;
  localparam LOGDEPTH_SHRT = (RAM_LOGDEPTH>3)? 4 : RAM_LOGDEPTH;
  localparam DEPTH_LONG    = (1 << LOGDEPTH_LONG);
  localparam DEPTH_SHRT    = (1 << LOGDEPTH_SHRT);

  // Calculate pipe values
  localparam PIPE1  = (LATENCY>1)? 1 : 0;
  localparam PIPE2  = (((PH_OFFSET_MODE!=0) || (PH_CORRECTION==1)) && (LATENCY>1))? 1 : 0;
//01/16/17  localparam PIPE3  = ((PH_CORRECTION==0) && (LATENCY>1))? 1 : 0;
  localparam PIPE3  = ((PH_CORRECTION==0) && (QUANTIZER_BITS<PH_ACC_BITS) && (LATENCY>1))? 1 : 0;   //01/16/17

//  localparam PIPE4  = (LATENCY>1)? 1 : 0;
  localparam PIPE4  = 1;
  localparam PIPE4EXT = (LATENCY>1)? 1 : 0;                                   //speed
  localparam PIPE5  = (LATENCY>0)? 1 : 0;
  localparam PIPE6  = (LATENCY>2)? 1 : 0;
  localparam PIPE7  = ((QUARTER_WAVE>0) && (LATENCY>1))? 1 : 0;
  // Trigonometric Correction pipes
  localparam PIPE8  = ((PH_CORRECTION==2) && (PIPE4==1))? 1 : 0;     //speed
  localparam PIPE9  = ((PH_CORRECTION==2) && (PIPE5==1))? 1 : 0;
  localparam PIPE10 = ((PH_CORRECTION==2) && (LATENCY>2))? 1 : 0;
  localparam PIPE11 = ((PH_CORRECTION==2) && (LATENCY>1))? 1 : 0;

  // Overall latency with regard to Phase Increment input
//speed  localparam PIPE_PH_INC  = PIPE2+PIPE3+PIPE4+PIPE5+PIPE6+PIPE7+PIPE10+PIPE11;
  localparam PIPE_PH_INC  = PIPE2+PIPE3+PIPE4+PIPE4EXT+PIPE5+PIPE6+PIPE7+PIPE10+PIPE11;
  // Overall latency with regard to Phase Offset input
  localparam PIPE_PH_OFFS = PIPE_PH_INC + PIPE1;
  
  // !!! Set Slow clk divider on RTL and backend SW !!!
  localparam SLOWCLK_DIV  = 4;
  localparam LOG_SLOWCLK_DIV  = 2;      // log2(SLOWCLK_DIV) 

  wire clk, nGrst, rst, rstn;
  wire signed [OUTPUT_BITS-1:0] uut_sin, uut_cos;
  wire [FREQ_OFFSET_BITS-1:0] freq_offset_w, freq_offset_inp;
  wire [PH_OFFSET_BITS-1:0] ph_offset_w, ph_offset_inp;
  wire [ceil_log2(TST_LENGTH):0] sample_num;
  wire freq_offset_we_inp, ph_offset_we_inp, freq_offset_we_w, ph_offset_we_w, end_test, uut_init_over;
  wire signed [OUTPUT_BITS-1:0] goldSin, goldCos, goldSin_dly, goldCos_dly;
  wire [23:0] init_timer;
  reg init_progress, watch4init_over;   // init in progress
  wire rst_sample_num, test_progress, test_progress_dly;
  reg fail_init, fail_sin, fail_cos;

  assign rstn = ~rst;

//03/23/17  generate if ((PH_INC_MODE!=0) || (PH_OFFSET_MODE!=0))
  generate if ((PH_INC_MODE!=0) || (PH_OFFSET_MODE==2))
    begin: ext_freq_phase_offset
      dds_bhvTestVectIn # (.FREQ_OFFSET_BITS(FREQ_OFFSET_BITS),
          .PH_OFFSET_BITS(PH_OFFSET_BITS) ) vect_in_0 (
        .sample_num     (sample_num),
        .freq_offset    (freq_offset_inp   ),
        .freq_offset_we (freq_offset_we_inp),
        .ph_offset      (ph_offset_inp     ),
        .ph_offset_we   (ph_offset_we_inp  )  );
    end
  endgenerate

  assign freq_offset_w = (PH_INC_MODE!=0)? freq_offset_inp : 'b0;
  assign freq_offset_we_w = (PH_INC_MODE!=0)? freq_offset_we_inp : 1'b0;
//03/23/17  assign ph_offset_w = (PH_OFFSET_MODE!=0)? ph_offset_inp : 'b0;
//03/23/17  assign ph_offset_we_w = (PH_OFFSET_MODE!=0)? ph_offset_we_inp : 1'b0;
  assign ph_offset_w = (PH_OFFSET_MODE==2)? ph_offset_inp : 'b0;
  assign ph_offset_we_w = (PH_OFFSET_MODE==2)? ph_offset_we_inp : 1'b0;

  COREDDS_C0_COREDDS_C0_0_COREDDS #(
      .PH_ACC_BITS     (PH_ACC_BITS     ),
      .PH_INC_MODE     (PH_INC_MODE     ),
      .PH_INC_LOWER    (PH_INC_LOWER    ),
      .PH_INC_UPPER    (PH_INC_UPPER    ),
      .SIN_ON          (SIN_ON),
      .COS_ON          (COS_ON),
      .SIN_POLARITY    (SIN_POLARITY    ),
      .COS_POLARITY    (COS_POLARITY    ),
      .FREQ_OFFSET_BITS(FREQ_OFFSET_BITS),
      .PH_OFFSET_MODE  (PH_OFFSET_MODE  ),
      .PH_OFFSET_CONST_LOWER (PH_OFFSET_CONST_LOWER ),
      .PH_OFFSET_CONST_UPPER (PH_OFFSET_CONST_UPPER ),
      .PH_OFFSET_BITS  (PH_OFFSET_BITS  ),
      .PH_CORRECTION   (PH_CORRECTION   ),
      .QUANTIZER_BITS  (QUANTIZER_BITS  ),
      .OUTPUT_BITS     (OUTPUT_BITS     ),
      .LATENCY         (LATENCY         ),
      .URAM_MAXDEPTH   (URAM_MAXDEPTH   ),
      .FPGA_FAMILY     (FPGA_FAMILY     ),
      .DIE_SIZE        (DIE_SIZE        ),
      .MAX_FULL_WAVE_LOGDEPTH(MAX_FULL_WAVE_LOGDEPTH) ) uut_0 (
    .FREQ_OFFSET    (freq_offset_w),
    .FREQ_OFFSET_WE (freq_offset_we_w),
    .PH_OFFSET      (ph_offset_w),
    .PH_OFFSET_WE   (ph_offset_we_w),
    .SINE           (uut_sin),
    .COSINE         (uut_cos),
    .NGRST          (nGrst),
    .RSTN           (rstn),
    .INIT           (1'b0),
    .CLK            (clk),
    .INIT_OVER      (uut_init_over)  );

//                         +-+-+-+-+ +-+-+-+-+ +-+-+-+-+
//                         |I|n|i|t| |O|v|e|r| |T|r|a|p|
//                         +-+-+-+-+ +-+-+-+-+ +-+-+-+-+
  bhvCountS # ( .WIDTH(24),
      .DCVALUE(SLOWCLK_DIV*DEPTH_LONG+20),   
      .BUILD_DC(1) ) dly_count_0 (
    .nGrst(nGrst), .rst(), .clk(clk), .clkEn(clk),
    .cntEn(1'b1), .Q(init_timer), .dc(end_watch) );

  assign start_watch = (init_timer==SLOWCLK_DIV*DEPTH_LONG-1);

  // Start watching for the INIT_OVER
  always@(negedge nGrst or posedge clk)
    if(nGrst==1'b0)         watch4init_over <= 1'b0;
    else
      if(start_watch==1'b1) watch4init_over <= 1'b1;
      else
        if(uut_init_over==1'b1) watch4init_over <= 1'b0;


//  // Reset UUT on INIT_OVER
//  bhvDelay # (.DELAY(2), .WIDTH(1) ) init_over_dly_0 (
//    .nGrst(nGrst), .rst(~rstn), .clk(clk), .clkEn(1'b1),
//    .inp(uut_init_over), .outp(rst_uut) );

//  ------------------ Init Over check completed


//                     +-+-+-+-+-+-+ +-+-+-+-+-+-+ +-+-+-+
//                     |G|o|l|d|e|n| |V|e|c|t|o|r| |G|e|n|
//                     +-+-+-+-+-+-+ +-+-+-+-+-+-+ +-+-+-+

  // Keep sample_num=0 until after uut_init_over
  always @ (nGrst or posedge clk)
    if(nGrst==1'b0)           init_progress <= 1'b1;
    else
      if(uut_init_over==1'b1) init_progress <= 1'b0;

  // Output golden sample counter
  assign rst_sample_num = rst | (init_progress & ~uut_init_over);

  dds_kitCountS # (.WIDTH(ceil_log2(TST_LENGTH+110)), .DCVALUE(TST_LENGTH),
                .BUILD_DC(1) ) gold_sample_count_0 (
    .nGrst(nGrst), .rst(rst_sample_num), .clk(clk), .clkEn(1'b1),
  .cntEn(1'b1), .Q(sample_num), .dc(end_test) );

  dds_bhvTestVectOut # (.OUTPUT_BITS(OUTPUT_BITS)) gold_out_vect_0 (
    .sample_num(sample_num),
    .goldSin(goldSin), .goldCos(goldCos) );

  // Delay the golden samples by overall HW pipeline delay
  bhvDelay # (  .DELAY(PIPE_PH_INC), 
        .WIDTH(OUTPUT_BITS) ) pipe_dly_0 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(1'b1),
    .inp(goldSin), .outp(goldSin_dly) );
  bhvDelay # (  .DELAY(PIPE_PH_INC), 
        .WIDTH(OUTPUT_BITS) ) pipe_dly_1 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(1'b1),
    .inp(goldCos), .outp(goldCos_dly) );

  // Identify valid output time period that starts on uut_init_over
  assign test_progress  = (~init_progress & ~end_test) | uut_init_over;
  bhvDelay # (  .DELAY(PIPE_PH_INC+PIPE1), 
        .WIDTH(1) ) pipe_dly_2 (
    .nGrst(nGrst), .rst(rst), .clk(clk), .clkEn(1'b1),
    .inp(test_progress), .outp(test_progress_dly) );

  //      _   _   _   _   _     _   _   _   _   _   _   _
  //     / \ / \ / \ / \ / \   / \ / \ / \ / \ / \ / \ / \
  //    ( C | H | E | C | K ) ( R | E | S | U | L | T | S )
  //     \_/ \_/ \_/ \_/ \_/   \_/ \_/ \_/ \_/ \_/ \_/ \_/

  initial begin
    $display("");
    $display("---------------------------------------------------------------------------------");
    $display("DDS introduces delay of %d clock cycles", PIPE_PH_INC);
    $display("Note: The delay from PHASE_OFFSET_WE signal to the output is one clock cycle more");
    $display("---------------------------------------------------------------------------------");


    $display("");
    $display("------------------");
    $display("Testing CoreDDS");
    $display("------------------");
    $display("");
  end

  always @(posedge clk or negedge nGrst)
    if(nGrst==1'b0) begin
      fail_init = 0;
      fail_sin  = 0;
      fail_cos  = 0;
    end
    else begin
      // Watch INIT_OVER
      // If end_watch comes while watch interval is still on
      if((end_watch==1'b1) && (watch4init_over==1'b1))
        fail_init <= 1'b1;

      if(test_progress_dly==1'b1) begin
        if(SIN_ON!=0) begin
          if(^uut_sin===1'bX) begin
            fail_sin <= 1'b1;
            $display("Time:%t SINE Output ERROR: Expected value = %d, Actual = X",
                  $time, goldSin_dly);
          end
          else if(((goldSin_dly-uut_sin) > 1) || ((goldSin_dly-uut_sin) < -1)) begin
            fail_sin <= 1'b1;
            $display("Time:%t SINE Output ERROR: Expected value = %d, Actual = %d",
                  $time, goldSin_dly, uut_sin);
          end
          else
            $display("Time:%t Match: SINE value = %d",
                    $time, uut_sin);
        end

        if(COS_ON!=0) begin
          if(^uut_cos===1'bX) begin
            fail_cos <= 1'b1;
            $display("Time:%t COSINE Output ERROR: Expected value = %d, Actual = X",
                  $time, goldCos_dly);
          end
          else if(((goldCos_dly-uut_cos) > 1) || ((goldCos_dly-uut_cos) < -1)) begin
            fail_cos <= 1'b1;
            $display("Time:%t COSINE Output ERROR: Expected value = %d, Actual = %d",
                    $time, goldCos_dly, uut_cos);
          end
          else
            $display("Time:%t Match: COSINE value = %d",
                    $time, uut_cos);
        end
      end

      if(end_test==1'b1) begin
        $display("");
        if(fail_init)
          $display("UUT failed to generate INIT_OVER");
        $display("");
        $display ("##############################");
        if (fail_init || fail_sin || fail_cos)
          $display("!!!!! DDS TEST FAILED !!!!!");
        else
          $display(" DDS test passed ");
        $display("##############################");

        $stop;
      end
    end

  //---------------------------------------------------------------------------
  bhvClockGen # (.CLKPERIOD (10),
                 .NGRSTLASTS (24)  ) clock_0 (
                    .clk(clk),
                    .nGrst (nGrst),
                    .ngrst_rising_edge() );

  bhvClkGen # (.CLKPERIOD (10),
    .NGRSTLASTS (24),
    .RST_DLY    (10) ) clk_1 (
      .clk(),
      .nGrst (),
      .rst(rst) );

//  -------------------------------------------------
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
