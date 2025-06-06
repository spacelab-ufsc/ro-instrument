//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Mar 17 14:00:34 2025
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of CoreGPIO_P8_UPPER to TCL
# Family: PolarFireSoC
# Part Number: MPFS025T-FCVG484E
# Create and Configure the core component CoreGPIO_P8_UPPER
create_and_configure_core -core_vlnv {Actel:DirectCore:CoreGPIO:3.2.102} -component_name {CoreGPIO_P8_UPPER} -params {\
"APB_WIDTH:32"  \
"FIXED_CONFIG_0:true"  \
"FIXED_CONFIG_1:true"  \
"FIXED_CONFIG_2:true"  \
"FIXED_CONFIG_3:true"  \
"FIXED_CONFIG_4:true"  \
"FIXED_CONFIG_5:true"  \
"FIXED_CONFIG_6:true"  \
"FIXED_CONFIG_7:true"  \
"FIXED_CONFIG_8:true"  \
"FIXED_CONFIG_9:true"  \
"FIXED_CONFIG_10:true"  \
"FIXED_CONFIG_11:true"  \
"FIXED_CONFIG_12:true"  \
"FIXED_CONFIG_13:true"  \
"FIXED_CONFIG_14:true"  \
"FIXED_CONFIG_15:true"  \
"FIXED_CONFIG_16:false"  \
"FIXED_CONFIG_17:false"  \
"FIXED_CONFIG_18:false"  \
"FIXED_CONFIG_19:false"  \
"FIXED_CONFIG_20:false"  \
"FIXED_CONFIG_21:false"  \
"FIXED_CONFIG_22:false"  \
"FIXED_CONFIG_23:false"  \
"FIXED_CONFIG_24:false"  \
"FIXED_CONFIG_25:false"  \
"FIXED_CONFIG_26:false"  \
"FIXED_CONFIG_27:false"  \
"FIXED_CONFIG_28:false"  \
"FIXED_CONFIG_29:false"  \
"FIXED_CONFIG_30:false"  \
"FIXED_CONFIG_31:false"  \
"INT_BUS:0"  \
"IO_INT_TYPE_0:7"  \
"IO_INT_TYPE_1:7"  \
"IO_INT_TYPE_2:7"  \
"IO_INT_TYPE_3:7"  \
"IO_INT_TYPE_4:7"  \
"IO_INT_TYPE_5:7"  \
"IO_INT_TYPE_6:7"  \
"IO_INT_TYPE_7:7"  \
"IO_INT_TYPE_8:7"  \
"IO_INT_TYPE_9:7"  \
"IO_INT_TYPE_10:7"  \
"IO_INT_TYPE_11:7"  \
"IO_INT_TYPE_12:7"  \
"IO_INT_TYPE_13:7"  \
"IO_INT_TYPE_14:7"  \
"IO_INT_TYPE_15:7"  \
"IO_INT_TYPE_16:7"  \
"IO_INT_TYPE_17:7"  \
"IO_INT_TYPE_18:7"  \
"IO_INT_TYPE_19:7"  \
"IO_INT_TYPE_20:7"  \
"IO_INT_TYPE_21:7"  \
"IO_INT_TYPE_22:7"  \
"IO_INT_TYPE_23:7"  \
"IO_INT_TYPE_24:7"  \
"IO_INT_TYPE_25:7"  \
"IO_INT_TYPE_26:7"  \
"IO_INT_TYPE_27:7"  \
"IO_INT_TYPE_28:7"  \
"IO_INT_TYPE_29:7"  \
"IO_INT_TYPE_30:7"  \
"IO_INT_TYPE_31:7"  \
"IO_NUM:16"  \
"IO_TYPE_0:2"  \
"IO_TYPE_1:2"  \
"IO_TYPE_2:2"  \
"IO_TYPE_3:2"  \
"IO_TYPE_4:2"  \
"IO_TYPE_5:2"  \
"IO_TYPE_6:2"  \
"IO_TYPE_7:2"  \
"IO_TYPE_8:2"  \
"IO_TYPE_9:2"  \
"IO_TYPE_10:2"  \
"IO_TYPE_11:2"  \
"IO_TYPE_12:2"  \
"IO_TYPE_13:2"  \
"IO_TYPE_14:2"  \
"IO_TYPE_15:2"  \
"IO_TYPE_16:2"  \
"IO_TYPE_17:2"  \
"IO_TYPE_18:2"  \
"IO_TYPE_19:2"  \
"IO_TYPE_20:0"  \
"IO_TYPE_21:0"  \
"IO_TYPE_22:0"  \
"IO_TYPE_23:0"  \
"IO_TYPE_24:0"  \
"IO_TYPE_25:0"  \
"IO_TYPE_26:0"  \
"IO_TYPE_27:0"  \
"IO_TYPE_28:0"  \
"IO_TYPE_29:0"  \
"IO_TYPE_30:0"  \
"IO_TYPE_31:0"  \
"IO_VAL_0:0"  \
"IO_VAL_1:0"  \
"IO_VAL_2:0"  \
"IO_VAL_3:0"  \
"IO_VAL_4:0"  \
"IO_VAL_5:0"  \
"IO_VAL_6:0"  \
"IO_VAL_7:0"  \
"IO_VAL_8:0"  \
"IO_VAL_9:0"  \
"IO_VAL_10:0"  \
"IO_VAL_11:0"  \
"IO_VAL_12:0"  \
"IO_VAL_13:0"  \
"IO_VAL_14:0"  \
"IO_VAL_15:0"  \
"IO_VAL_16:0"  \
"IO_VAL_17:0"  \
"IO_VAL_18:0"  \
"IO_VAL_19:0"  \
"IO_VAL_20:0"  \
"IO_VAL_21:0"  \
"IO_VAL_22:0"  \
"IO_VAL_23:0"  \
"IO_VAL_24:0"  \
"IO_VAL_25:0"  \
"IO_VAL_26:0"  \
"IO_VAL_27:0"  \
"IO_VAL_28:0"  \
"IO_VAL_29:0"  \
"IO_VAL_30:0"  \
"IO_VAL_31:0"  \
"OE_TYPE:0"   }
# Exporting Component Description of CoreGPIO_P8_UPPER to TCL done
*/

// CoreGPIO_P8_UPPER
module CoreGPIO_P8_UPPER(
    // Inputs
    GPIO_IN,
    PADDR,
    PCLK,
    PENABLE,
    PRESETN,
    PSEL,
    PWDATA,
    PWRITE,
    // Outputs
    GPIO_OE,
    GPIO_OUT,
    INT,
    PRDATA,
    PREADY,
    PSLVERR
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [15:0] GPIO_IN;
input  [7:0]  PADDR;
input         PCLK;
input         PENABLE;
input         PRESETN;
input         PSEL;
input  [31:0] PWDATA;
input         PWRITE;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [15:0] GPIO_OE;
output [15:0] GPIO_OUT;
output [15:0] INT;
output [31:0] PRDATA;
output        PREADY;
output        PSLVERR;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [7:0]  PADDR;
wire          PENABLE;
wire   [31:0] APB_bif_PRDATA;
wire          APB_bif_PREADY;
wire          PSEL;
wire          APB_bif_PSLVERR;
wire   [31:0] PWDATA;
wire          PWRITE;
wire   [15:0] GPIO_IN;
wire   [15:0] GPIO_OE_net_0;
wire   [15:0] GPIO_OUT_net_0;
wire   [15:0] INT_net_0;
wire          PCLK;
wire          PRESETN;
wire   [15:0] INT_net_1;
wire   [15:0] GPIO_OUT_net_1;
wire   [15:0] GPIO_OE_net_1;
wire   [31:0] APB_bif_PRDATA_net_0;
wire          APB_bif_PREADY_net_0;
wire          APB_bif_PSLVERR_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign INT_net_1             = INT_net_0;
assign INT[15:0]             = INT_net_1;
assign GPIO_OUT_net_1        = GPIO_OUT_net_0;
assign GPIO_OUT[15:0]        = GPIO_OUT_net_1;
assign GPIO_OE_net_1         = GPIO_OE_net_0;
assign GPIO_OE[15:0]         = GPIO_OE_net_1;
assign APB_bif_PRDATA_net_0  = APB_bif_PRDATA;
assign PRDATA[31:0]          = APB_bif_PRDATA_net_0;
assign APB_bif_PREADY_net_0  = APB_bif_PREADY;
assign PREADY                = APB_bif_PREADY_net_0;
assign APB_bif_PSLVERR_net_0 = APB_bif_PSLVERR;
assign PSLVERR               = APB_bif_PSLVERR_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CoreGPIO_P8_UPPER_CoreGPIO_P8_UPPER_0_CoreGPIO   -   Actel:DirectCore:CoreGPIO:3.2.102
CoreGPIO_P8_UPPER_CoreGPIO_P8_UPPER_0_CoreGPIO #( 
        .APB_WIDTH       ( 32 ),
        .FIXED_CONFIG_0  ( 1 ),
        .FIXED_CONFIG_1  ( 1 ),
        .FIXED_CONFIG_2  ( 1 ),
        .FIXED_CONFIG_3  ( 1 ),
        .FIXED_CONFIG_4  ( 1 ),
        .FIXED_CONFIG_5  ( 1 ),
        .FIXED_CONFIG_6  ( 1 ),
        .FIXED_CONFIG_7  ( 1 ),
        .FIXED_CONFIG_8  ( 1 ),
        .FIXED_CONFIG_9  ( 1 ),
        .FIXED_CONFIG_10 ( 1 ),
        .FIXED_CONFIG_11 ( 1 ),
        .FIXED_CONFIG_12 ( 1 ),
        .FIXED_CONFIG_13 ( 1 ),
        .FIXED_CONFIG_14 ( 1 ),
        .FIXED_CONFIG_15 ( 1 ),
        .FIXED_CONFIG_16 ( 0 ),
        .FIXED_CONFIG_17 ( 0 ),
        .FIXED_CONFIG_18 ( 0 ),
        .FIXED_CONFIG_19 ( 0 ),
        .FIXED_CONFIG_20 ( 0 ),
        .FIXED_CONFIG_21 ( 0 ),
        .FIXED_CONFIG_22 ( 0 ),
        .FIXED_CONFIG_23 ( 0 ),
        .FIXED_CONFIG_24 ( 0 ),
        .FIXED_CONFIG_25 ( 0 ),
        .FIXED_CONFIG_26 ( 0 ),
        .FIXED_CONFIG_27 ( 0 ),
        .FIXED_CONFIG_28 ( 0 ),
        .FIXED_CONFIG_29 ( 0 ),
        .FIXED_CONFIG_30 ( 0 ),
        .FIXED_CONFIG_31 ( 0 ),
        .INT_BUS         ( 0 ),
        .IO_INT_TYPE_0   ( 7 ),
        .IO_INT_TYPE_1   ( 7 ),
        .IO_INT_TYPE_2   ( 7 ),
        .IO_INT_TYPE_3   ( 7 ),
        .IO_INT_TYPE_4   ( 7 ),
        .IO_INT_TYPE_5   ( 7 ),
        .IO_INT_TYPE_6   ( 7 ),
        .IO_INT_TYPE_7   ( 7 ),
        .IO_INT_TYPE_8   ( 7 ),
        .IO_INT_TYPE_9   ( 7 ),
        .IO_INT_TYPE_10  ( 7 ),
        .IO_INT_TYPE_11  ( 7 ),
        .IO_INT_TYPE_12  ( 7 ),
        .IO_INT_TYPE_13  ( 7 ),
        .IO_INT_TYPE_14  ( 7 ),
        .IO_INT_TYPE_15  ( 7 ),
        .IO_INT_TYPE_16  ( 7 ),
        .IO_INT_TYPE_17  ( 7 ),
        .IO_INT_TYPE_18  ( 7 ),
        .IO_INT_TYPE_19  ( 7 ),
        .IO_INT_TYPE_20  ( 7 ),
        .IO_INT_TYPE_21  ( 7 ),
        .IO_INT_TYPE_22  ( 7 ),
        .IO_INT_TYPE_23  ( 7 ),
        .IO_INT_TYPE_24  ( 7 ),
        .IO_INT_TYPE_25  ( 7 ),
        .IO_INT_TYPE_26  ( 7 ),
        .IO_INT_TYPE_27  ( 7 ),
        .IO_INT_TYPE_28  ( 7 ),
        .IO_INT_TYPE_29  ( 7 ),
        .IO_INT_TYPE_30  ( 7 ),
        .IO_INT_TYPE_31  ( 7 ),
        .IO_NUM          ( 16 ),
        .IO_TYPE_0       ( 2 ),
        .IO_TYPE_1       ( 2 ),
        .IO_TYPE_2       ( 2 ),
        .IO_TYPE_3       ( 2 ),
        .IO_TYPE_4       ( 2 ),
        .IO_TYPE_5       ( 2 ),
        .IO_TYPE_6       ( 2 ),
        .IO_TYPE_7       ( 2 ),
        .IO_TYPE_8       ( 2 ),
        .IO_TYPE_9       ( 2 ),
        .IO_TYPE_10      ( 2 ),
        .IO_TYPE_11      ( 2 ),
        .IO_TYPE_12      ( 2 ),
        .IO_TYPE_13      ( 2 ),
        .IO_TYPE_14      ( 2 ),
        .IO_TYPE_15      ( 2 ),
        .IO_TYPE_16      ( 2 ),
        .IO_TYPE_17      ( 2 ),
        .IO_TYPE_18      ( 2 ),
        .IO_TYPE_19      ( 2 ),
        .IO_TYPE_20      ( 0 ),
        .IO_TYPE_21      ( 0 ),
        .IO_TYPE_22      ( 0 ),
        .IO_TYPE_23      ( 0 ),
        .IO_TYPE_24      ( 0 ),
        .IO_TYPE_25      ( 0 ),
        .IO_TYPE_26      ( 0 ),
        .IO_TYPE_27      ( 0 ),
        .IO_TYPE_28      ( 0 ),
        .IO_TYPE_29      ( 0 ),
        .IO_TYPE_30      ( 0 ),
        .IO_TYPE_31      ( 0 ),
        .IO_VAL_0        ( 0 ),
        .IO_VAL_1        ( 0 ),
        .IO_VAL_2        ( 0 ),
        .IO_VAL_3        ( 0 ),
        .IO_VAL_4        ( 0 ),
        .IO_VAL_5        ( 0 ),
        .IO_VAL_6        ( 0 ),
        .IO_VAL_7        ( 0 ),
        .IO_VAL_8        ( 0 ),
        .IO_VAL_9        ( 0 ),
        .IO_VAL_10       ( 0 ),
        .IO_VAL_11       ( 0 ),
        .IO_VAL_12       ( 0 ),
        .IO_VAL_13       ( 0 ),
        .IO_VAL_14       ( 0 ),
        .IO_VAL_15       ( 0 ),
        .IO_VAL_16       ( 0 ),
        .IO_VAL_17       ( 0 ),
        .IO_VAL_18       ( 0 ),
        .IO_VAL_19       ( 0 ),
        .IO_VAL_20       ( 0 ),
        .IO_VAL_21       ( 0 ),
        .IO_VAL_22       ( 0 ),
        .IO_VAL_23       ( 0 ),
        .IO_VAL_24       ( 0 ),
        .IO_VAL_25       ( 0 ),
        .IO_VAL_26       ( 0 ),
        .IO_VAL_27       ( 0 ),
        .IO_VAL_28       ( 0 ),
        .IO_VAL_29       ( 0 ),
        .IO_VAL_30       ( 0 ),
        .IO_VAL_31       ( 0 ),
        .OE_TYPE         ( 0 ) )
CoreGPIO_P8_UPPER_0(
        // Inputs
        .PRESETN  ( PRESETN ),
        .PCLK     ( PCLK ),
        .PSEL     ( PSEL ),
        .PENABLE  ( PENABLE ),
        .PWRITE   ( PWRITE ),
        .PADDR    ( PADDR ),
        .PWDATA   ( PWDATA ),
        .GPIO_IN  ( GPIO_IN ),
        // Outputs
        .PSLVERR  ( APB_bif_PSLVERR ),
        .PREADY   ( APB_bif_PREADY ),
        .PRDATA   ( APB_bif_PRDATA ),
        .INT      ( INT_net_0 ),
        .INT_OR   (  ),
        .GPIO_OUT ( GPIO_OUT_net_0 ),
        .GPIO_OE  ( GPIO_OE_net_0 ) 
        );


endmodule
