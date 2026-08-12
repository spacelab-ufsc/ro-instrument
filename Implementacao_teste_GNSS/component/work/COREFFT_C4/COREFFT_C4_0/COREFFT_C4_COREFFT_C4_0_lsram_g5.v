`timescale 1 ns/100 ps
// Version: 2025.1 2025.1.0.14


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
input  [63:0] DI;
output [63:0] DO;
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
        \ACCESS_BUSY[0][5] , \ACCESS_BUSY[0][6] , VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%64-64%SPEED%0%6%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C6 (.A_DOUT({nc0, nc1, 
        nc2, nc3, nc4, nc5, nc6, nc7, nc8, nc9, nc10, nc11, nc12, nc13, 
        nc14, nc15, DO[63], DO[62], DO[61], DO[60]}), .B_DOUT({nc16, 
        nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, nc25, nc26, 
        nc27, nc28, nc29, nc30, nc31, nc32, nc33, nc34, nc35}), 
        .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(\ACCESS_BUSY[0][6] ), 
        .A_ADDR({RADDR[10], RADDR[9], RADDR[8], RADDR[7], RADDR[6], 
        RADDR[5], RADDR[4], RADDR[3], RADDR[2], RADDR[1], RADDR[0], 
        GND, GND, GND}), .A_BLK_EN({VCC, VCC, VCC}), .A_CLK(RCLOCK), 
        .A_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND}), .A_REN(VCC), 
        .A_WEN({GND, GND}), .A_DOUT_EN(DO_en), .A_DOUT_ARST_N(DO_nGrst)
        , .A_DOUT_SRST_N(DOUTSRSTAP), .B_ADDR({WADDR[10], WADDR[9], 
        WADDR[8], WADDR[7], WADDR[6], WADDR[5], WADDR[4], WADDR[3], 
        WADDR[2], WADDR[1], WADDR[0], GND, GND, GND}), .B_BLK_EN({WRB, 
        VCC, VCC}), .B_CLK(WCLOCK), .B_DIN({GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, DI[63], 
        DI[62], DI[61], DI[60]}), .B_REN(VCC), .B_WEN({GND, VCC}), 
        .B_DOUT_EN(DO_en), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        DOUTSRSTAP), .ECC_EN(GND), .BUSY_FB(GND), .A_WIDTH({GND, VCC, 
        VCC}), .A_WMODE({GND, GND}), .A_BYPASS(GND), .B_WIDTH({GND, 
        VCC, VCC}), .B_WMODE({GND, GND}), .B_BYPASS(GND), .ECC_BYPASS(
        GND));
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%64-64%SPEED%0%2%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C2 (.A_DOUT({nc36, nc37, 
        nc38, nc39, nc40, nc41, nc42, nc43, nc44, nc45, DO[29], DO[28], 
        DO[27], DO[26], DO[25], DO[24], DO[23], DO[22], DO[21], DO[20]})
        , .B_DOUT({nc46, nc47, nc48, nc49, nc50, nc51, nc52, nc53, 
        nc54, nc55, nc56, nc57, nc58, nc59, nc60, nc61, nc62, nc63, 
        nc64, nc65}), .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(
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
        GND, GND, GND, GND, GND, GND, GND, GND, GND, DI[29], DI[28], 
        DI[27], DI[26], DI[25], DI[24], DI[23], DI[22], DI[21], DI[20]})
        , .B_REN(VCC), .B_WEN({GND, VCC}), .B_DOUT_EN(DO_en), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(DOUTSRSTAP), .ECC_EN(GND), 
        .BUSY_FB(GND), .A_WIDTH({GND, VCC, VCC}), .A_WMODE({GND, GND}), 
        .A_BYPASS(GND), .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND})
        , .B_BYPASS(GND), .ECC_BYPASS(GND));
    CFG1 #( .INIT(2'h1) )  INVDOUTSRSTAP (.A(DO_rst), .Y(DOUTSRSTAP));
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%64-64%SPEED%0%0%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C0 (.A_DOUT({nc66, nc67, 
        nc68, nc69, nc70, nc71, nc72, nc73, nc74, nc75, DO[9], DO[8], 
        DO[7], DO[6], DO[5], DO[4], DO[3], DO[2], DO[1], DO[0]}), 
        .B_DOUT({nc76, nc77, nc78, nc79, nc80, nc81, nc82, nc83, nc84, 
        nc85, nc86, nc87, nc88, nc89, nc90, nc91, nc92, nc93, nc94, 
        nc95}), .DB_DETECT(), .SB_CORRECT(), .ACCESS_BUSY(
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
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%64-64%SPEED%0%5%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C5 (.A_DOUT({nc96, nc97, 
        nc98, nc99, nc100, nc101, nc102, nc103, nc104, nc105, DO[59], 
        DO[58], DO[57], DO[56], DO[55], DO[54], DO[53], DO[52], DO[51], 
        DO[50]}), .B_DOUT({nc106, nc107, nc108, nc109, nc110, nc111, 
        nc112, nc113, nc114, nc115, nc116, nc117, nc118, nc119, nc120, 
        nc121, nc122, nc123, nc124, nc125}), .DB_DETECT(), .SB_CORRECT(
        ), .ACCESS_BUSY(\ACCESS_BUSY[0][5] ), .A_ADDR({RADDR[10], 
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
        GND, DI[59], DI[58], DI[57], DI[56], DI[55], DI[54], DI[53], 
        DI[52], DI[51], DI[50]}), .B_REN(VCC), .B_WEN({GND, VCC}), 
        .B_DOUT_EN(DO_en), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        DOUTSRSTAP), .ECC_EN(GND), .BUSY_FB(GND), .A_WIDTH({GND, VCC, 
        VCC}), .A_WMODE({GND, GND}), .A_BYPASS(GND), .B_WIDTH({GND, 
        VCC, VCC}), .B_WMODE({GND, GND}), .B_BYPASS(GND), .ECC_BYPASS(
        GND));
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%64-64%SPEED%0%1%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C1 (.A_DOUT({nc126, 
        nc127, nc128, nc129, nc130, nc131, nc132, nc133, nc134, nc135, 
        DO[19], DO[18], DO[17], DO[16], DO[15], DO[14], DO[13], DO[12], 
        DO[11], DO[10]}), .B_DOUT({nc136, nc137, nc138, nc139, nc140, 
        nc141, nc142, nc143, nc144, nc145, nc146, nc147, nc148, nc149, 
        nc150, nc151, nc152, nc153, nc154, nc155}), .DB_DETECT(), 
        .SB_CORRECT(), .ACCESS_BUSY(\ACCESS_BUSY[0][1] ), .A_ADDR({
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
        GND, GND, GND, GND, GND, DI[19], DI[18], DI[17], DI[16], 
        DI[15], DI[14], DI[13], DI[12], DI[11], DI[10]}), .B_REN(VCC), 
        .B_WEN({GND, VCC}), .B_DOUT_EN(DO_en), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(DOUTSRSTAP), .ECC_EN(GND), .BUSY_FB(GND), 
        .A_WIDTH({GND, VCC, VCC}), .A_WMODE({GND, GND}), .A_BYPASS(GND)
        , .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND}), .B_BYPASS(
        GND), .ECC_BYPASS(GND));
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%64-64%SPEED%0%4%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C4 (.A_DOUT({nc156, 
        nc157, nc158, nc159, nc160, nc161, nc162, nc163, nc164, nc165, 
        DO[49], DO[48], DO[47], DO[46], DO[45], DO[44], DO[43], DO[42], 
        DO[41], DO[40]}), .B_DOUT({nc166, nc167, nc168, nc169, nc170, 
        nc171, nc172, nc173, nc174, nc175, nc176, nc177, nc178, nc179, 
        nc180, nc181, nc182, nc183, nc184, nc185}), .DB_DETECT(), 
        .SB_CORRECT(), .ACCESS_BUSY(\ACCESS_BUSY[0][4] ), .A_ADDR({
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
        GND, GND, GND, GND, GND, DI[49], DI[48], DI[47], DI[46], 
        DI[45], DI[44], DI[43], DI[42], DI[41], DI[40]}), .B_REN(VCC), 
        .B_WEN({GND, VCC}), .B_DOUT_EN(DO_en), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(DOUTSRSTAP), .ECC_EN(GND), .BUSY_FB(GND), 
        .A_WIDTH({GND, VCC, VCC}), .A_WMODE({GND, GND}), .A_BYPASS(GND)
        , .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND}), .B_BYPASS(
        GND), .ECC_BYPASS(GND));
    RAM1K20 #( .RAMINDEX("COREFFT_C4_0%2048-2048%64-64%SPEED%0%3%TWO-PORT%ECC_EN-0")
         )  COREFFT_C4_COREFFT_C4_0_lsram_g5_R0C3 (.A_DOUT({nc186, 
        nc187, nc188, nc189, nc190, nc191, nc192, nc193, nc194, nc195, 
        DO[39], DO[38], DO[37], DO[36], DO[35], DO[34], DO[33], DO[32], 
        DO[31], DO[30]}), .B_DOUT({nc196, nc197, nc198, nc199, nc200, 
        nc201, nc202, nc203, nc204, nc205, nc206, nc207, nc208, nc209, 
        nc210, nc211, nc212, nc213, nc214, nc215}), .DB_DETECT(), 
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
        GND, GND, GND, GND, GND, DI[39], DI[38], DI[37], DI[36], 
        DI[35], DI[34], DI[33], DI[32], DI[31], DI[30]}), .B_REN(VCC), 
        .B_WEN({GND, VCC}), .B_DOUT_EN(DO_en), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(DOUTSRSTAP), .ECC_EN(GND), .BUSY_FB(GND), 
        .A_WIDTH({GND, VCC, VCC}), .A_WMODE({GND, GND}), .A_BYPASS(GND)
        , .B_WIDTH({GND, VCC, VCC}), .B_WMODE({GND, GND}), .B_BYPASS(
        GND), .ECC_BYPASS(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
