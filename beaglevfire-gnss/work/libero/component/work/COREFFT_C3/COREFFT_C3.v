//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Nov 27 15:40:53 2025
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of COREFFT_C3 to TCL
# Family: PolarFireSoC
# Part Number: MPFS025T-FCVG484E
# Create and Configure the core component COREFFT_C3
create_and_configure_core -core_vlnv {Actel:DirectCore:COREFFT:8.1.100} -component_name {COREFFT_C3} -params {\
"AXI4S_IN_DATA:24"  \
"AXI4S_OUT_DATA:24"  \
"CFG_ARCH:1"  \
"DATA_BITS:18"  \
"FFT_SIZE:256"  \
"FPGA_FAMILY:27"  \
"INVERSE:0"  \
"MEMBUF:0"  \
"NATIV_AXI4:false"  \
"ORDER:0"  \
"POINTS:4096"  \
"SCALE:0"  \
"SCALE_EXP_ON:false"  \
"SCALE_ON:true"  \
"SCALE_SCH:255"  \
"STAGE_1:true"  \
"STAGE_2:true"  \
"STAGE_3:true"  \
"STAGE_4:true"  \
"STAGE_5:true"  \
"STAGE_6:true"  \
"STAGE_7:true"  \
"STAGE_8:true"  \
"STAGE_9:true"  \
"STAGE_10:true"  \
"STAGE_11:true"  \
"STAGE_12:true"  \
"TWID_BITS:18"  \
"URAM_MAXDEPTH:0"  \
"WIDTH:10"   }
# Exporting Component Description of COREFFT_C3 to TCL done
*/

// COREFFT_C3
module COREFFT_C3(
    // Inputs
    CLK,
    DATAI_IM,
    DATAI_RE,
    DATAI_VALID,
    NGRST,
    READ_OUTP,
    SLOWCLK,
    // Outputs
    BUF_READY,
    DATAO_IM,
    DATAO_RE,
    DATAO_VALID,
    OUTP_READY
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input        CLK;
input  [9:0] DATAI_IM;
input  [9:0] DATAI_RE;
input        DATAI_VALID;
input        NGRST;
input        READ_OUTP;
input        SLOWCLK;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output       BUF_READY;
output [9:0] DATAO_IM;
output [9:0] DATAO_RE;
output       DATAO_VALID;
output       OUTP_READY;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire         BUF_READY_net_0;
wire         CLK;
wire   [9:0] DATAI_IM;
wire   [9:0] DATAI_RE;
wire         DATAI_VALID;
wire   [9:0] DATAO_IM_net_0;
wire   [9:0] DATAO_RE_net_0;
wire         DATAO_VALID_net_0;
wire         NGRST;
wire         OUTP_READY_net_0;
wire         READ_OUTP;
wire         SLOWCLK;
wire         DATAO_VALID_net_1;
wire         BUF_READY_net_1;
wire         OUTP_READY_net_1;
wire   [9:0] DATAO_IM_net_1;
wire   [9:0] DATAO_RE_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire         VCC_net;
wire         GND_net;
wire   [47:0]AXI4_S_TDATAI_const_net_0;
wire   [7:0] AXI4_S_CONFIGI_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net                    = 1'b1;
assign GND_net                    = 1'b0;
assign AXI4_S_TDATAI_const_net_0  = 48'h000000000000;
assign AXI4_S_CONFIGI_const_net_0 = 8'h00;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign DATAO_VALID_net_1 = DATAO_VALID_net_0;
assign DATAO_VALID       = DATAO_VALID_net_1;
assign BUF_READY_net_1   = BUF_READY_net_0;
assign BUF_READY         = BUF_READY_net_1;
assign OUTP_READY_net_1  = OUTP_READY_net_0;
assign OUTP_READY        = OUTP_READY_net_1;
assign DATAO_IM_net_1    = DATAO_IM_net_0;
assign DATAO_IM[9:0]     = DATAO_IM_net_1;
assign DATAO_RE_net_1    = DATAO_RE_net_0;
assign DATAO_RE[9:0]     = DATAO_RE_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------COREFFT_C3_COREFFT_C3_0_COREFFT   -   Actel:DirectCore:COREFFT:8.1.100
COREFFT_C3_COREFFT_C3_0_COREFFT #( 
        .AXI4S_IN_DATA  ( 24 ),
        .AXI4S_OUT_DATA ( 24 ),
        .CFG_ARCH       ( 1 ),
        .DATA_BITS      ( 18 ),
        .FFT_SIZE       ( 256 ),
        .FPGA_FAMILY    ( 27 ),
        .INVERSE        ( 0 ),
        .MEMBUF         ( 0 ),
        .NATIV_AXI4     ( 0 ),
        .ORDER          ( 0 ),
        .POINTS         ( 4096 ),
        .SCALE          ( 0 ),
        .SCALE_EXP_ON   ( 0 ),
        .SCALE_ON       ( 1 ),
        .SCALE_SCH      ( 255 ),
        .TWID_BITS      ( 18 ),
        .URAM_MAXDEPTH  ( 0 ),
        .WIDTH          ( 10 ) )
COREFFT_C3_0(
        // Inputs
        .CLK                   ( CLK ),
        .SLOWCLK               ( SLOWCLK ),
        .NGRST                 ( NGRST ),
        .DATAI_VALID           ( DATAI_VALID ),
        .READ_OUTP             ( READ_OUTP ),
        .START                 ( VCC_net ), // tied to 1'b1 from definition
        .INVERSE_STRM          ( GND_net ), // tied to 1'b0 from definition
        .REFRESH               ( GND_net ), // tied to 1'b0 from definition
        .CLKEN                 ( VCC_net ), // tied to 1'b1 from definition
        .RST                   ( GND_net ), // tied to 1'b0 from definition
        .AXI4_S_DATAI_TVALID   ( GND_net ), // tied to 1'b0 from definition
        .AXI4_S_TLASTI         ( GND_net ), // tied to 1'b0 from definition
        .AXI4_M_DATAO_TREADY   ( VCC_net ), // tied to 1'b1 from definition
        .AXI4_S_CONFIGI_TVALID ( GND_net ), // tied to 1'b0 from definition
        .AXI4_M_CONFIGO_TREADY ( GND_net ), // tied to 1'b0 from definition
        .DATAI_IM              ( DATAI_IM ),
        .DATAI_RE              ( DATAI_RE ),
        .AXI4_S_TDATAI         ( AXI4_S_TDATAI_const_net_0 ), // tied to 48'h000000000000 from definition
        .AXI4_S_CONFIGI        ( AXI4_S_CONFIGI_const_net_0 ), // tied to 8'h00 from definition
        // Outputs
        .DATAO_VALID           ( DATAO_VALID_net_0 ),
        .BUF_READY             ( BUF_READY_net_0 ),
        .OUTP_READY            ( OUTP_READY_net_0 ),
        .PONG                  (  ),
        .OVFLOW_FLAG           (  ),
        .RFS                   (  ),
        .AXI4_S_DATAI_TREADY   (  ),
        .AXI4_M_DATAO_TVALID   (  ),
        .AXI4_M_TLASTO         (  ),
        .AXI4_S_CONFIGI_TREADY (  ),
        .AXI4_M_CONFIGO_TVALID (  ),
        .DATAO_IM              ( DATAO_IM_net_0 ),
        .DATAO_RE              ( DATAO_RE_net_0 ),
        .SCALE_EXP             (  ),
        .AXI4_M_TDATAO         (  ),
        .AXI4_M_CONFIGO        (  ) 
        );


endmodule
