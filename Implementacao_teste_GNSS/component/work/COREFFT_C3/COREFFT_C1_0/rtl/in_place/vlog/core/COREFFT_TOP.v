// ***************************************************************************/
//Microsemi Corporation Proprietary and Confidential
//Copyright 2011 Microsemi Corporation. All rights reserved.
//
//ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
//ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
//IN ADVANCE IN WRITING.
//
//Description:  CoreFFT
//              CoreFFT top level module
//
//Revision Information:
//Date         Description
//12Jan2010    Initial Release
//
//SVN Revision Information:
//SVN $Revision: $
//SVN $Data: $
//
//Resolved SARs
//SAR     Date    Who         Description
//
//Notes:
// 4/7/2011 //refresh Any Refresh except the initial one is transparent

`timescale 1 ns/100 ps

module COREFFT_C3_COREFFT_C1_0_COREFFT (
  DATAI_IM,
	DATAI_RE,
	DATAI_VALID,
	DATAO_IM,
	DATAO_RE,
	CLKEN,
    CLK,
	SLOWCLK,
	NGRST,
	RST,
    START,
    OUTP_READY,
	BUF_READY,
	READ_OUTP,
	PONG,
	SCALE_EXP,
    DATAO_VALID,
    RFS,     // req for START
    INVERSE_STRM,
    OVFLOW_FLAG,
    REFRESH,
	 // AXI4S DATA channels
	AXI4_S_DATAI_TVALID,
	AXI4_S_DATAI_TREADY,
	AXI4_S_TDATAI,
	AXI4_S_TLASTI,
	  
	AXI4_M_DATAO_TVALID,
	AXI4_M_DATAO_TREADY,
	AXI4_M_TDATAO ,
	AXI4_M_TLASTO,
	  // AXI4S Configuration channels
	AXI4_S_CONFIGI_TVALID,
	AXI4_S_CONFIGI_TREADY,
	AXI4_S_CONFIGI,
	  
	AXI4_M_CONFIGO_TVALID,
	AXI4_M_CONFIGO_TREADY,
	AXI4_M_CONFIGO 
	);

  parameter FPGA_FAMILY = 19; //12:RTAXD; 19,24:SF2; 25:RTG4; 26:G5
  parameter URAM_MAXDEPTH = 0;
  parameter CFG_ARCH    = 1;

  parameter DATA_BITS = 18;
  parameter TWID_BITS = 18;
  parameter FFT_SIZE  = 256;   // FFT size
  parameter SCALE_ON  = 1;
  parameter SCALE_SCH = 255;
  parameter ORDER     = 0;

  parameter INVERSE = 0;
  parameter SCALE   = 0;  //0-conditional 1-unconditional scaling
  parameter POINTS  = 256;
  parameter WIDTH   = 18;   // In-place FFT bit width
  parameter MEMBUF  = 0;
  parameter SCALE_EXP_ON = 0;

  parameter NATIV_AXI4      = 0;		    // 1=AXI4S, 0=Native
  parameter AXI4S_IN_DATA   = 24;        // for AXI4S byte boundaries
  parameter AXI4S_OUT_DATA   = 24;        // for AXI4S byte boundaries
			
//  parameter DIE_SIZE = 20;  //reserved for use with G4 dies where a row < 16 MAC
  parameter NO_RAM   = 0;   

  // In-Place params
  localparam LOG2PTS       = ceil_log2(POINTS);
  localparam LOGLOG2PTS    = ceil_log2(LOG2PTS);
  localparam FLOGLOG2PTS   = floor_log2(LOG2PTS)+1;
  // Streaming output bitwidth
  localparam STREAM_DATAO_BITS = (SCALE_ON==0)? 
                              DATA_BITS+ceil_log2(FFT_SIZE)+1 : DATA_BITS;
  localparam IN_BITS  = (CFG_ARCH==1)? WIDTH : DATA_BITS;
  localparam OUTP_BITS = (CFG_ARCH==1)? WIDTH : STREAM_DATAO_BITS;

  input DATAI_VALID, READ_OUTP;
  input [IN_BITS-1:0] DATAI_IM, DATAI_RE;
  output[OUTP_BITS-1:0] DATAO_IM, DATAO_RE;
  output BUF_READY, PONG;
  input CLK, SLOWCLK, NGRST, RST, START, CLKEN, INVERSE_STRM, REFRESH;
  output OUTP_READY, DATAO_VALID, RFS, OVFLOW_FLAG;
  output[FLOGLOG2PTS-1:0] SCALE_EXP;
  
   // AXI4S DATA channels
	input   AXI4_S_DATAI_TVALID	;
	output  AXI4_S_DATAI_TREADY ; 
	input   [2*AXI4S_IN_DATA-1:0]  AXI4_S_TDATAI ;
	input   AXI4_S_TLASTI  ;
	  
	output  AXI4_M_DATAO_TVALID ;
	input   AXI4_M_DATAO_TREADY	;  //expects always '1'
	output  [2*AXI4S_OUT_DATA-1:0] AXI4_M_TDATAO;
	output  AXI4_M_TLASTO  	;
	  // AXI4S Configuration channels
	input   AXI4_S_CONFIGI_TVALID  ;
	output  AXI4_S_CONFIGI_TREADY ;
	input   [7:0] AXI4_S_CONFIGI ;
	  
	output  AXI4_M_CONFIGO_TVALID  ;
	input   AXI4_M_CONFIGO_TREADY ; //expects always '1'
	output  [7:0] AXI4_M_CONFIGO ;
  
  reg AXI4_S_DATAI_TREADY;
  reg INVERSE_STRM_ACT_REG;
  wire [IN_BITS-1:0] DATAI_IM_ACT, DATAI_RE_ACT;
  reg [IN_BITS-1:0] DATAI_IM_ACT_AXI4S, DATAI_RE_ACT_AXI4S;
  wire [OUTP_BITS-1:0] DATAO_IM_ACT, DATAO_RE_ACT;
  //reg [2*AXI4S_OUT_DATA-1:0] AXI4_M_TDATAO;
  wire START_ACT,INVERSE_STRM_ACT, REFRESH_ACT;
  wire RFS_ACT,OUTP_READY_ACT, DATAO_VALID_ACT, OVFLOW_FLAG_ACT;
  wire AXI4_s_tlasti_mark_valid;
  reg [7:0] AXI4_S_CONFIGI_REG;
  reg [13:0] FRAME_OUT_SAMPLE_COUNT;
  
  generate
    if(CFG_ARCH == 1) begin
      COREFFT_C3_COREFFT_C1_0_COREFFT_INPLC #(
        .FPGA_FAMILY (FPGA_FAMILY),
        .URAM_MAXDEPTH(URAM_MAXDEPTH),
        .INVERSE (INVERSE),
        .SCALE   (SCALE),
        .POINTS  (POINTS),
        .WIDTH   (WIDTH),
        .MEMBUF  (MEMBUF),
        .SCALE_EXP_ON (SCALE_EXP_ON)  ) DUT_INPLACE (
            .CLK (CLK),
			.SLOWCLK(SLOWCLK),
	          .NGRST(NGRST),
            .DATAI_IM (DATAI_IM),
            .DATAI_RE (DATAI_RE),
            .DATAI_VALID (DATAI_VALID),
            .READ_OUTP (READ_OUTP),
            .DATAO_IM (DATAO_IM),
            .DATAO_RE (DATAO_RE),
            .DATAO_VALID (DATAO_VALID),
            .BUF_READY (BUF_READY),
            .OUTP_READY (OUTP_READY),
            .SCALE_EXP (SCALE_EXP),
            .PONG  (PONG)   );
    end
  endgenerate

  generate
    if((CFG_ARCH == 2)&(NATIV_AXI4 == 0)) begin
	
	assign DATAI_RE_ACT     = DATAI_RE;
    assign DATAI_IM_ACT     = DATAI_IM;
    assign DATAO_IM     	= DATAO_IM_ACT;
    assign DATAO_RE         = DATAO_RE_ACT;
    assign START_ACT        = START;
    assign OUTP_READY   	= OUTP_READY_ACT;
    assign DATAO_VALID      = DATAO_VALID_ACT;
    assign RFS          	= RFS_ACT;
    assign INVERSE_STRM_ACT = INVERSE_STRM;
    assign OVFLOW_FLAG  	= OVFLOW_FLAG_ACT;
    assign REFRESH_ACT      = REFRESH   ;
	  
      COREFFT_C3_COREFFT_C1_0_COREFFT_STRM # (
        .FPGA_FAMILY (FPGA_FAMILY),
        .URAM_MAXDEPTH(URAM_MAXDEPTH),
        .DATA_BITS(DATA_BITS),
        .TWID_BITS(TWID_BITS),
        .FFT_SIZE(FFT_SIZE),
        .SCALE_ON(SCALE_ON),
        .DATAO_BITS(STREAM_DATAO_BITS),
        .SCALE_SCH(SCALE_SCH),
        .ORDER(ORDER),
        .NO_RAM(NO_RAM) ) DUT_STRM (
            .DATAI_IM(DATAI_IM_ACT),
            .DATAI_RE(DATAI_RE_ACT),
            .DATAO_IM(DATAO_IM_ACT),
            .DATAO_RE(DATAO_RE_ACT),
            .CLKEN(CLKEN),
            .CLK(CLK),
			.SLOWCLK(SLOWCLK),
            .NGRST(NGRST),
            .RST(RST),
            .START(START_ACT),
            .OUTP_READY(OUTP_READY_ACT),    // short pilot pulse
            .DATAO_VALID(DATAO_VALID_ACT),  // long strobe covering whole FFT frame
            .RFS(RFS_ACT),
            .INVERSE(INVERSE_STRM_ACT),
            .OVFLOW_FLAG(OVFLOW_FLAG_ACT),
            .REFRESH(REFRESH_ACT)  );
    end
  endgenerate


  generate
    if((CFG_ARCH == 2)&(NATIV_AXI4 == 1)) begin
	
	  assign START_ACT             = AXI4_S_DATAI_TVALID & AXI4_S_DATAI_TREADY;
	  
	  always @ (posedge CLK or negedge NGRST)    
		if (NGRST==1'b0) begin
		  AXI4_S_DATAI_TREADY <= 1'b0;  // ready will be asserted continuously once after twid LUT is initialized
		end
		else
		  if(RFS_ACT) begin
			AXI4_S_DATAI_TREADY <= 1'b1;
		  end
	  		
	  
	   always @ (posedge CLK or negedge NGRST)    
		if (NGRST==1'b0) begin
		  DATAI_RE_ACT_AXI4S <= 0;  
		  DATAI_IM_ACT_AXI4S <= 0;  
		end
		else
		  if((AXI4_S_DATAI_TVALID == 1'b1)&&(AXI4_S_DATAI_TREADY== 1'b1)) begin
			DATAI_RE_ACT_AXI4S 		   <= AXI4_S_TDATAI[IN_BITS-1:0];
			DATAI_IM_ACT_AXI4S		   <= AXI4_S_TDATAI[AXI4S_IN_DATA+IN_BITS-1:AXI4S_IN_DATA];
		  end
		  else begin
			DATAI_RE_ACT_AXI4S 		   <= 0;
			DATAI_IM_ACT_AXI4S		   <= 0;
		  end
	  

	  
	  assign AXI4_M_DATAO_TVALID  = DATAO_VALID_ACT;
	  // AXI4_M_DATAO_TREADY  expects this input as always '1'
	   
	  assign AXI4_M_TDATAO[AXI4S_OUT_DATA-1:0] 			      =   DATAO_RE_ACT;
	  assign AXI4_M_TDATAO[2*AXI4S_OUT_DATA-1:AXI4S_OUT_DATA] =   DATAO_IM_ACT;
	 	  
	  assign AXI4_M_TLASTO  = (FRAME_OUT_SAMPLE_COUNT == (FFT_SIZE-1)) ? 1'b1 : 1'b0;
	  
	   always @ (posedge CLK or negedge NGRST)    
		if (NGRST==1'b0) begin
		  FRAME_OUT_SAMPLE_COUNT <= 0;  // ready will be asserted continuously once after twid LUT is initialized
		end
		else
		  if(FRAME_OUT_SAMPLE_COUNT == (FFT_SIZE-1)) begin
			FRAME_OUT_SAMPLE_COUNT <= 0 ;
		  end
		  else if(DATAO_VALID_ACT) begin
			FRAME_OUT_SAMPLE_COUNT <= FRAME_OUT_SAMPLE_COUNT + 1;
		  end
		  else FRAME_OUT_SAMPLE_COUNT <= 0;
	  
	   
		
	  //AXI4_S_CONFIGI_TVALID 
	  assign AXI4_S_CONFIGI_TREADY   = 1'b1;
	  assign INVERSE_STRM_ACT        = AXI4_S_CONFIGI_TVALID ? AXI4_S_CONFIGI[0] : AXI4_S_CONFIGI_REG[0] ;
	  assign REFRESH_ACT  		     = AXI4_S_CONFIGI_TVALID ? AXI4_S_CONFIGI[1] : AXI4_S_CONFIGI_REG[1];
	  
	  always @ (posedge CLK or negedge NGRST)    // count FFT cycles
		if (NGRST==1'b0) begin
		  AXI4_S_CONFIGI_REG <= 'd0;
          INVERSE_STRM_ACT_REG <= 'b0;
		end
		// increment the cycleCnt on the second and other starti
		else begin
		 INVERSE_STRM_ACT_REG <= INVERSE_STRM_ACT;
		  if(AXI4_S_CONFIGI_TVALID) begin
			AXI4_S_CONFIGI_REG <= AXI4_S_CONFIGI;
		  end
	     end
	  
	  assign AXI4_M_CONFIGO_TVALID   = 1'b1; //DATAO_VALID_ACT;
	  //AXI4_M_CONFIGO_TREADY expects this input as always '1'
	  assign AXI4_M_CONFIGO = {4'b0, AXI4_s_tlasti_mark_valid, OUTP_READY_ACT, RFS_ACT, OVFLOW_FLAG_ACT};
	  assign AXI4_s_tlasti_mark_valid = (RFS_ACT == AXI4_S_TLASTI)? 1'b1: 1'b0;
	  
      COREFFT_C3_COREFFT_C1_0_COREFFT_STRM # (
        .FPGA_FAMILY (FPGA_FAMILY),
        .URAM_MAXDEPTH(URAM_MAXDEPTH),
        .DATA_BITS(DATA_BITS),
        .TWID_BITS(TWID_BITS),
        .FFT_SIZE(FFT_SIZE),
        .SCALE_ON(SCALE_ON),
        .DATAO_BITS(STREAM_DATAO_BITS),
        .SCALE_SCH(SCALE_SCH),
        .ORDER(ORDER),
        .NO_RAM(NO_RAM) ) DUT_STRM (
            .DATAI_IM(DATAI_IM_ACT_AXI4S),
            .DATAI_RE(DATAI_RE_ACT_AXI4S),
            .DATAO_IM(DATAO_IM_ACT),
            .DATAO_RE(DATAO_RE_ACT),
            .CLKEN(CLKEN),
            .CLK(CLK),
			.SLOWCLK(SLOWCLK),
            .NGRST(NGRST),
            .RST(RST),
            .START(START_ACT),
            .OUTP_READY(OUTP_READY_ACT),    // short pilot pulse
            .DATAO_VALID(DATAO_VALID_ACT),  // long strobe covering whole FFT frame
            .RFS(RFS_ACT),
            .INVERSE(INVERSE_STRM_ACT_REG),
            .OVFLOW_FLAG(OVFLOW_FLAG_ACT),
            .REFRESH(REFRESH_ACT)  );
    end
  endgenerate
  
  // -----------------------------
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

  function [31:0] floor_log2;
      input integer x;
      integer tmp, res;
    begin
      tmp = 1;
      res = 0;
      while (2*tmp <= x) begin
        tmp = tmp * 2;
        res = res + 1;
      end
      floor_log2 = res;
    end
  endfunction

endmodule
