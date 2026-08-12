`timescale 1 ns/100 ps
// Version: 2023.2 2023.2.0.8


module COREFFT_C4_COREFFT_C4_0_lsram_g5(
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
input  [41:0] DI;
output [41:0] DO;
input  [10:0] WADDR;
input  [10:0] RADDR;
input  WRB;
input  WCLOCK;
input  RCLOCK;
input  DO_nGrst;
input  DO_en;
input  DO_rst;

    wire DOUTSRSTAP, \ACCESS_BUSY[0][0] , \ACCESS_BUSY[0][1] , 
        \ACCESS_BUSY[0][2] , \ACCESS_BUSY[0][3] , \ACCESS_BUSY[0][4] , 
        VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%42-42%SPEED%0%2%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C2 (.A_DOUT({nc0, nc1, 
        nc2, nc3, nc4, nc5, nc6, nc7, nc8, nc9, nc10, DO[26], DO[25], 
        DO[24], DO[23], DO[22], DO[21], DO[20], DO[19], DO[18]}), 
        .B_DOUT({nc11, nc12, nc13, nc14, nc15, nc16, nc17, nc18, nc19, 
        nc20, nc21, nc22, nc23, nc24, nc25, nc26, nc27, nc28, nc29, 
        nc30}), .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(
        \ACCESS_BUSY[0][2] ), .A_ADDR({RADDR[10], RADDR[9], RADDR[8], 
        RADDR[7], RADDR[6], RADDR[5], RADDR[4], RADDR[3], RADDR[2], 
        RADDR[1], RADDR[0], GND, GND, GND}), .A_BLK_EN({VCC, VCC, VCC})
        , .A_CLK(RCLOCK), .A_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND}), .A_REN(VCC), .A_WEN({GND, GND}), .A_DOUT_EN(DO_en), 
        .A_DOUT_ARST_N(DO_nGrst), .A_DOUT_SRST_N(DOUTSRSTAP), .B_ADDR({
        WADDR[10], WADDR[9], WADDR[8], WADDR[7], WADDR[6], WADDR[5], 
        WADDR[4], WADDR[3], WADDR[2], WADDR[1], WADDR[0], GND, GND, 
        GND}), .B_BLK_EN({WRB, VCC, VCC}), .B_CLK(WCLOCK), .B_DIN({GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, DI[26], 
        DI[25], DI[24], DI[23], DI[22], DI[21], DI[20], DI[19], DI[18]})
        , .B_REN(VCC), .B_WEN({GND, VCC}), .B_DOUT_EN(DO_en), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(DOUTSRSTAP), .ECC_EN(GND), 
        .BUSY_FB(GND), .A_WIDTH({GND, VCC, VCC}), .A_WMODE({GND, GND}), 
        .A_BYPASS(GND), .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND})
        , .B_BYPASS(GND), .ECC_BYPASS(GND));
    CFG1 #( .INIT(2'h1) )  INVDOUTSRSTAP (.A(DO_rst), .Y(DOUTSRSTAP));
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%42-42%SPEED%0%0%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C0 (.A_DOUT({nc31, nc32, 
        nc33, nc34, nc35, nc36, nc37, nc38, nc39, nc40, nc41, DO[8], 
        DO[7], DO[6], DO[5], DO[4], DO[3], DO[2], DO[1], DO[0]}), 
        .B_DOUT({nc42, nc43, nc44, nc45, nc46, nc47, nc48, nc49, nc50, 
        nc51, nc52, nc53, nc54, nc55, nc56, nc57, nc58, nc59, nc60, 
        nc61}), .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(
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
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, DI[8], DI[7], 
        DI[6], DI[5], DI[4], DI[3], DI[2], DI[1], DI[0]}), .B_REN(VCC), 
        .B_WEN({GND, VCC}), .B_DOUT_EN(DO_en), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(DOUTSRSTAP), .ECC_EN(GND), .BUSY_FB(GND), 
        .A_WIDTH({GND, VCC, VCC}), .A_WMODE({GND, GND}), .A_BYPASS(GND)
        , .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND}), .B_BYPASS(
        GND), .ECC_BYPASS(GND));
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%42-42%SPEED%0%1%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C1 (.A_DOUT({nc62, nc63, 
        nc64, nc65, nc66, nc67, nc68, nc69, nc70, nc71, nc72, DO[17], 
        DO[16], DO[15], DO[14], DO[13], DO[12], DO[11], DO[10], DO[9]})
        , .B_DOUT({nc73, nc74, nc75, nc76, nc77, nc78, nc79, nc80, 
        nc81, nc82, nc83, nc84, nc85, nc86, nc87, nc88, nc89, nc90, 
        nc91, nc92}), .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(
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
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, DI[17], 
        DI[16], DI[15], DI[14], DI[13], DI[12], DI[11], DI[10], DI[9]})
        , .B_REN(VCC), .B_WEN({GND, VCC}), .B_DOUT_EN(DO_en), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(DOUTSRSTAP), .ECC_EN(GND), 
        .BUSY_FB(GND), .A_WIDTH({GND, VCC, VCC}), .A_WMODE({GND, GND}), 
        .A_BYPASS(GND), .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND})
        , .B_BYPASS(GND), .ECC_BYPASS(GND));
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%42-42%SPEED%0%4%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C4 (.A_DOUT({nc93, nc94, 
        nc95, nc96, nc97, nc98, nc99, nc100, nc101, nc102, nc103, 
        nc104, nc105, nc106, DO[41], DO[40], DO[39], DO[38], DO[37], 
        DO[36]}), .B_DOUT({nc107, nc108, nc109, nc110, nc111, nc112, 
        nc113, nc114, nc115, nc116, nc117, nc118, nc119, nc120, nc121, 
        nc122, nc123, nc124, nc125, nc126}), .DB_DETECT(), .SB_CORRECT(
        ), .ACCESS_BUSY(\ACCESS_BUSY[0][4] ), .A_ADDR({RADDR[10], 
        RADDR[9], RADDR[8], RADDR[7], RADDR[6], RADDR[5], RADDR[4], 
        RADDR[3], RADDR[2], RADDR[1], RADDR[0], GND, GND, GND}), 
        .A_BLK_EN({VCC, VCC, VCC}), .A_CLK(RCLOCK), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND}), .A_REN(VCC), .A_WEN({GND, GND})
        , .A_DOUT_EN(DO_en), .A_DOUT_ARST_N(DO_nGrst), .A_DOUT_SRST_N(
        DOUTSRSTAP), .B_ADDR({WADDR[10], WADDR[9], WADDR[8], WADDR[7], 
        WADDR[6], WADDR[5], WADDR[4], WADDR[3], WADDR[2], WADDR[1], 
        WADDR[0], GND, GND, GND}), .B_BLK_EN({WRB, VCC, VCC}), .B_CLK(
        WCLOCK), .B_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, DI[41], DI[40], DI[39], DI[38], 
        DI[37], DI[36]}), .B_REN(VCC), .B_WEN({GND, VCC}), .B_DOUT_EN(
        DO_en), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(DOUTSRSTAP), 
        .ECC_EN(GND), .BUSY_FB(GND), .A_WIDTH({GND, VCC, VCC}), 
        .A_WMODE({GND, GND}), .A_BYPASS(GND), .B_WIDTH({GND, VCC, VCC})
        , .B_WMODE({GND, GND}), .B_BYPASS(GND), .ECC_BYPASS(GND));
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%42-42%SPEED%0%3%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C3 (.A_DOUT({nc127, 
        nc128, nc129, nc130, nc131, nc132, nc133, nc134, nc135, nc136, 
        nc137, DO[35], DO[34], DO[33], DO[32], DO[31], DO[30], DO[29], 
        DO[28], DO[27]}), .B_DOUT({nc138, nc139, nc140, nc141, nc142, 
        nc143, nc144, nc145, nc146, nc147, nc148, nc149, nc150, nc151, 
        nc152, nc153, nc154, nc155, nc156, nc157}), .DB_DETECT(), 
        .SB_CORRECT(), .ACCESS_BUSY(\ACCESS_BUSY[0][3] ), .A_ADDR({
        RADDR[10], RADDR[9], RADDR[8], RADDR[7], RADDR[6], RADDR[5], 
        RADDR[4], RADDR[3], RADDR[2], RADDR[1], RADDR[0], GND, GND, 
        GND}), .A_BLK_EN({VCC, VCC, VCC}), .A_CLK(RCLOCK), .A_DIN({GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND}), .A_REN(VCC), .A_WEN({GND, 
        GND}), .A_DOUT_EN(DO_en), .A_DOUT_ARST_N(DO_nGrst), 
        .A_DOUT_SRST_N(DOUTSRSTAP), .B_ADDR({WADDR[10], WADDR[9], 
        WADDR[8], WADDR[7], WADDR[6], WADDR[5], WADDR[4], WADDR[3], 
        WADDR[2], WADDR[1], WADDR[0], GND, GND, GND}), .B_BLK_EN({WRB, 
        VCC, VCC}), .B_CLK(WCLOCK), .B_DIN({GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, DI[35], DI[34], DI[33], DI[32], 
        DI[31], DI[30], DI[29], DI[28], DI[27]}), .B_REN(VCC), .B_WEN({
        GND, VCC}), .B_DOUT_EN(DO_en), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(DOUTSRSTAP), .ECC_EN(GND), .BUSY_FB(GND), 
        .A_WIDTH({GND, VCC, VCC}), .A_WMODE({GND, GND}), .A_BYPASS(GND)
        , .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND}), .B_BYPASS(
        GND), .ECC_BYPASS(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
