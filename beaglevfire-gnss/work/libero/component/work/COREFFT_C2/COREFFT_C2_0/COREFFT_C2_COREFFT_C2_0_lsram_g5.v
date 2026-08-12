`timescale 1 ns/100 ps
// Version: 2023.2 2023.2.0.8


module COREFFT_C2_COREFFT_C2_0_lsram_g5(
       DI,
       DO,
       WADDR,
       RADDR,
       WRB,
       WCLOCK,
       RCLOCK,
       DO_nGrst,
       DO_en,
       DO_rst
    );
input  [19:0] DI;
output [19:0] DO;
input  [10:0] WADDR;
input  [10:0] RADDR;
input  WRB;
input  WCLOCK;
input  RCLOCK;
input  DO_nGrst;
input  DO_en;
input  DO_rst;

    wire DOUTSRSTAP, \ACCESS_BUSY[0][0] , \ACCESS_BUSY[0][1] , VCC, 
        GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    CFG1 #( .INIT(2'h1) )  INVDOUTSRSTAP (.A(DO_rst), .Y(DOUTSRSTAP));
    RAM1K20 #( .RAMINDEX("COREFFT_C2_0%2048-2048%20-20%SPEED%0%1%TWO-PORT%ECC_EN-0")
         )  COREFFT_C2_COREFFT_C2_0_lsram_g5_R0C1 (.A_DOUT({nc0, nc1, 
        nc2, nc3, nc4, nc5, nc6, nc7, nc8, nc9, DO[19], DO[18], DO[17], 
        DO[16], DO[15], DO[14], DO[13], DO[12], DO[11], DO[10]}), 
        .B_DOUT({nc10, nc11, nc12, nc13, nc14, nc15, nc16, nc17, nc18, 
        nc19, nc20, nc21, nc22, nc23, nc24, nc25, nc26, nc27, nc28, 
        nc29}), .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(
        \ACCESS_BUSY[0][1] ), .A_ADDR({RADDR[10], RADDR[9], RADDR[8], 
        RADDR[7], RADDR[6], RADDR[5], RADDR[4], RADDR[3], RADDR[2], 
        RADDR[1], RADDR[0], GND, GND, GND}), .A_BLK_EN({VCC, VCC, VCC})
        , .A_CLK(RCLOCK), .A_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND}), .A_REN(VCC), .A_WEN({GND, GND}), .A_DOUT_EN(DO_en), 
        .A_DOUT_ARST_N(DO_nGrst), .A_DOUT_SRST_N(DOUTSRSTAP), .B_ADDR({
        WADDR[10], WADDR[9], WADDR[8], WADDR[7], WADDR[6], WADDR[5], 
        WADDR[4], WADDR[3], WADDR[2], WADDR[1], WADDR[0], GND, GND, 
        GND}), .B_BLK_EN({WRB, VCC, VCC}), .B_CLK(WCLOCK), .B_DIN({GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, DI[19], DI[18], 
        DI[17], DI[16], DI[15], DI[14], DI[13], DI[12], DI[11], DI[10]})
        , .B_REN(VCC), .B_WEN({GND, VCC}), .B_DOUT_EN(DO_en), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(DOUTSRSTAP), .ECC_EN(GND), 
        .BUSY_FB(GND), .A_WIDTH({GND, VCC, VCC}), .A_WMODE({GND, GND}), 
        .A_BYPASS(GND), .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND})
        , .B_BYPASS(GND), .ECC_BYPASS(GND));
    RAM1K20 #( .RAMINDEX("COREFFT_C2_0%2048-2048%20-20%SPEED%0%0%TWO-PORT%ECC_EN-0")
         )  COREFFT_C2_COREFFT_C2_0_lsram_g5_R0C0 (.A_DOUT({nc30, nc31, 
        nc32, nc33, nc34, nc35, nc36, nc37, nc38, nc39, DO[9], DO[8], 
        DO[7], DO[6], DO[5], DO[4], DO[3], DO[2], DO[1], DO[0]}), 
        .B_DOUT({nc40, nc41, nc42, nc43, nc44, nc45, nc46, nc47, nc48, 
        nc49, nc50, nc51, nc52, nc53, nc54, nc55, nc56, nc57, nc58, 
        nc59}), .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(
        \ACCESS_BUSY[0][0] ), .A_ADDR({RADDR[10], RADDR[9], RADDR[8], 
        RADDR[7], RADDR[6], RADDR[5], RADDR[4], RADDR[3], RADDR[2], 
        RADDR[1], RADDR[0], GND, GND, GND}), .A_BLK_EN({VCC, VCC, VCC})
        , .A_CLK(RCLOCK), .A_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND}), .A_REN(VCC), .A_WEN({GND, GND}), .A_DOUT_EN(DO_en), 
        .A_DOUT_ARST_N(DO_nGrst), .A_DOUT_SRST_N(DOUTSRSTAP), .B_ADDR({
        WADDR[10], WADDR[9], WADDR[8], WADDR[7], WADDR[6], WADDR[5], 
        WADDR[4], WADDR[3], WADDR[2], WADDR[1], WADDR[0], GND, GND, 
        GND}), .B_BLK_EN({WRB, VCC, VCC}), .B_CLK(WCLOCK), .B_DIN({GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, DI[9], DI[8], 
        DI[7], DI[6], DI[5], DI[4], DI[3], DI[2], DI[1], DI[0]}), 
        .B_REN(VCC), .B_WEN({GND, VCC}), .B_DOUT_EN(DO_en), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(DOUTSRSTAP), .ECC_EN(GND), 
        .BUSY_FB(GND), .A_WIDTH({GND, VCC, VCC}), .A_WMODE({GND, GND}), 
        .A_BYPASS(GND), .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND})
        , .B_BYPASS(GND), .ECC_BYPASS(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
