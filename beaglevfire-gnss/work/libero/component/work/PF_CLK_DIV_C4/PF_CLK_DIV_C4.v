//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Nov 27 16:35:10 2025
// Version: 2023.2 2023.2.0.8
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

//////////////////////////////////////////////////////////////////////
// Component Description (Tcl) 
//////////////////////////////////////////////////////////////////////
/*
# Exporting Component Description of PF_CLK_DIV_C4 to TCL
# Family: PolarFireSoC
# Part Number: MPFS025T-FCVG484E
# Create and Configure the core component PF_CLK_DIV_C4
create_and_configure_core -core_vlnv {Actel:SgCore:PF_CLK_DIV:1.0.103} -component_name {PF_CLK_DIV_C4} -params {\
"DIVIDER:2"  \
"ENABLE_BIT_SLIP:false"  \
"ENABLE_SRESET:false"   }
# Exporting Component Description of PF_CLK_DIV_C4 to TCL done
*/

// PF_CLK_DIV_C4
module PF_CLK_DIV_C4(
    // Inputs
    CLK_IN,
    // Outputs
    CLK_OUT
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  CLK_IN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output CLK_OUT;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   CLK_IN;
wire   CLK_OUT_net_0;
wire   CLK_OUT_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign CLK_OUT_net_1 = CLK_OUT_net_0;
assign CLK_OUT       = CLK_OUT_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------PF_CLK_DIV_C4_PF_CLK_DIV_C4_0_PF_CLK_DIV   -   Actel:SgCore:PF_CLK_DIV:1.0.103
PF_CLK_DIV_C4_PF_CLK_DIV_C4_0_PF_CLK_DIV PF_CLK_DIV_C4_0(
        // Inputs
        .CLK_IN  ( CLK_IN ),
        // Outputs
        .CLK_OUT ( CLK_OUT_net_0 ) 
        );


endmodule
