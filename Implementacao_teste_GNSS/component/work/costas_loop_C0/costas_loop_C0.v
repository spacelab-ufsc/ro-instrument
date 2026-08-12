//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Oct 21 10:28:06 2025
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of costas_loop_C0 to TCL
# Family: PolarFireSoC
# Part Number: MPFS025T-FCVG484E
# Create and Configure the core component costas_loop_C0
create_and_configure_core -core_vlnv {Microchip:SolutionCore:costas_loop:1.1.0} -component_name {costas_loop_C0} -params {\
"MPSK_SWITCH:0"   }
# Exporting Component Description of costas_loop_C0 to TCL done
*/

// costas_loop_C0
module costas_loop_C0(
    // Inputs
    ARSTN_I,
    IDATA_I,
    KI_I,
    KP_I,
    LIMIT_I,
    QDATA_I,
    SYS_CLK_I,
    THETA_FACTOR_I,
    // Outputs
    IDATA_O,
    PI_O,
    QDATA_O,
    THETA_O
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         ARSTN_I;
input  [15:0] IDATA_I;
input  [17:0] KI_I;
input  [17:0] KP_I;
input  [17:0] LIMIT_I;
input  [15:0] QDATA_I;
input         SYS_CLK_I;
input  [17:0] THETA_FACTOR_I;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [15:0] IDATA_O;
output [17:0] PI_O;
output [15:0] QDATA_O;
output [9:0]  THETA_O;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          ARSTN_I;
wire   [15:0] IDATA_I;
wire   [15:0] IDATA_O_net_0;
wire   [17:0] KI_I;
wire   [17:0] KP_I;
wire   [17:0] LIMIT_I;
wire   [17:0] PI_O_net_0;
wire   [15:0] QDATA_I;
wire   [15:0] QDATA_O_net_0;
wire          SYS_CLK_I;
wire   [17:0] THETA_FACTOR_I;
wire   [9:0]  THETA_O_net_0;
wire   [15:0] IDATA_O_net_1;
wire   [15:0] QDATA_O_net_1;
wire   [9:0]  THETA_O_net_1;
wire   [17:0] PI_O_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign IDATA_O_net_1 = IDATA_O_net_0;
assign IDATA_O[15:0] = IDATA_O_net_1;
assign QDATA_O_net_1 = QDATA_O_net_0;
assign QDATA_O[15:0] = QDATA_O_net_1;
assign THETA_O_net_1 = THETA_O_net_0;
assign THETA_O[9:0]  = THETA_O_net_1;
assign PI_O_net_1    = PI_O_net_0;
assign PI_O[17:0]    = PI_O_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------costas_loop   -   Microchip:SolutionCore:costas_loop:1.1.0
costas_loop #( 
        .MPSK_SWITCH ( 0 ) )
costas_loop_C0_0(
        // Inputs
        .SYS_CLK_I      ( SYS_CLK_I ),
        .ARSTN_I        ( ARSTN_I ),
        .IDATA_I        ( IDATA_I ),
        .QDATA_I        ( QDATA_I ),
        .KP_I           ( KP_I ),
        .KI_I           ( KI_I ),
        .LIMIT_I        ( LIMIT_I ),
        .THETA_FACTOR_I ( THETA_FACTOR_I ),
        // Outputs
        .IDATA_O        ( IDATA_O_net_0 ),
        .QDATA_O        ( QDATA_O_net_0 ),
        .THETA_O        ( THETA_O_net_0 ),
        .PI_O           ( PI_O_net_0 ) 
        );


endmodule
