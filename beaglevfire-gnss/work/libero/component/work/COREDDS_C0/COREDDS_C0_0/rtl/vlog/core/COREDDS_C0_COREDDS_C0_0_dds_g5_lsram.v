`timescale 1 ns/100 ps
// Version: 2023.2 2023.2.0.8


module COREDDS_C0_COREDDS_C0_0_dds_g5_lsram(
       DI,
       DO,
       WADDR,
       RADDR,
       WRB,
       RDB,
       WCLOCK,
       RCLOCK
    );
input  [7:0] DI;
output [7:0] DO;
input  [7:0] WADDR;
input  [7:0] RADDR;
input  WRB;
input  RDB;
input  WCLOCK;
input  RCLOCK;

    wire \ACCESS_BUSY[0][0] , VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K20 #( .RAMINDEX("core%256-256%8-8%SPEED%0%0%TWO-PORT%ECC_EN-0")
         )  COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0 (.A_DOUT({nc0, 
        nc1, nc2, nc3, nc4, nc5, nc6, nc7, nc8, nc9, nc10, nc11, DO[7], 
        DO[6], DO[5], DO[4], DO[3], DO[2], DO[1], DO[0]}), .B_DOUT({
        nc12, nc13, nc14, nc15, nc16, nc17, nc18, nc19, nc20, nc21, 
        nc22, nc23, nc24, nc25, nc26, nc27, nc28, nc29, nc30, nc31}), 
        .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(\ACCESS_BUSY[0][0] ), 
        .A_ADDR({GND, GND, GND, RADDR[7], RADDR[6], RADDR[5], RADDR[4], 
        RADDR[3], RADDR[2], RADDR[1], RADDR[0], GND, GND, GND}), 
        .A_BLK_EN({VCC, VCC, VCC}), .A_CLK(RCLOCK), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND}), .A_REN(RDB), .A_WEN({GND, GND})
        , .A_DOUT_EN(VCC), .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), 
        .B_ADDR({GND, GND, GND, WADDR[7], WADDR[6], WADDR[5], WADDR[4], 
        WADDR[3], WADDR[2], WADDR[1], WADDR[0], GND, GND, GND}), 
        .B_BLK_EN({WRB, VCC, VCC}), .B_CLK(WCLOCK), .B_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, DI[7], DI[6], 
        DI[5], DI[4], DI[3], DI[2], DI[1], DI[0]}), .B_REN(VCC), 
        .B_WEN({GND, VCC}), .B_DOUT_EN(VCC), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .ECC_EN(GND), .BUSY_FB(GND), .A_WIDTH({
        GND, VCC, VCC}), .A_WMODE({GND, GND}), .A_BYPASS(VCC), 
        .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND}), .B_BYPASS(VCC)
        , .ECC_BYPASS(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
