`timescale 1 ns/100 ps
// Version: 2025.1 2025.1.0.14


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
input  [3:0] DI;
output [3:0] DO;
input  [8:0] WADDR;
input  [8:0] RADDR;
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
    
    RAM1K20 #( .RAMINDEX("core%512-512%4-4%SPEED%0%0%TWO-PORT%ECC_EN-0")
         )  COREDDS_C0_COREDDS_C0_0_dds_g5_lsram_R0C0 (.A_DOUT({nc0, 
        nc1, nc2, nc3, nc4, nc5, nc6, nc7, nc8, nc9, nc10, nc11, nc12, 
        nc13, nc14, nc15, DO[3], DO[2], DO[1], DO[0]}), .B_DOUT({nc16, 
        nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, nc25, nc26, 
        nc27, nc28, nc29, nc30, nc31, nc32, nc33, nc34, nc35}), 
        .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(\ACCESS_BUSY[0][0] ), 
        .A_ADDR({GND, GND, GND, RADDR[8], RADDR[7], RADDR[6], RADDR[5], 
        RADDR[4], RADDR[3], RADDR[2], RADDR[1], RADDR[0], GND, GND}), 
        .A_BLK_EN({VCC, VCC, VCC}), .A_CLK(RCLOCK), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND}), .A_REN(RDB), .A_WEN({GND, GND})
        , .A_DOUT_EN(VCC), .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), 
        .B_ADDR({GND, GND, GND, WADDR[8], WADDR[7], WADDR[6], WADDR[5], 
        WADDR[4], WADDR[3], WADDR[2], WADDR[1], WADDR[0], GND, GND}), 
        .B_BLK_EN({WRB, VCC, VCC}), .B_CLK(WCLOCK), .B_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, DI[3], DI[2], DI[1], DI[0]}), .B_REN(VCC), .B_WEN({
        GND, VCC}), .B_DOUT_EN(VCC), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .ECC_EN(GND), .BUSY_FB(GND), .A_WIDTH({
        GND, VCC, GND}), .A_WMODE({GND, GND}), .A_BYPASS(VCC), 
        .B_WIDTH({GND, VCC, GND}), .B_WMODE({GND, GND}), .B_BYPASS(VCC)
        , .ECC_BYPASS(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
