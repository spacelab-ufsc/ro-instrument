//****************************************************************
//Microsemi Corporation Proprietary and Confidential
//Copyright 2016 Microsemi Corporation.  All rights reserved
//
//ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN
//ACCORDANCE WITH THE MICROSEMI LICENSE AGREEMENT AND MUST BE APPROVED
//IN ADVANCE IN WRITING.
//
//Description: CoreDDS
//             Dynamic RAM wrapper
//
//Rev:
//v3.0 8/23/2016
//
//SVN Revision Information:
//SVN$Revision:$
//SVN$Date:$
//
//Resolved SARS
//
//Notes:
//
//****************************************************************

`timescale 1 ns/100 ps






//                    ######     #    #     #
//                    #     #   # #   ##   ##  ####
//                    #     #  #   #  # # # # #
//                    ######  #     # #  #  #  ####
//                    #   #   ####### #     #      #
//                    #    #  #     # #     # #    #
//                    #     # #     # #     #  ####

module COREDDS_C0_COREDDS_C0_0_wrapRam(rClk, wClk, D, Q, wA, rA, wEn);
  parameter LOGDEPTH  = 8;
  parameter WIDTH     = 32;
  parameter FPGA_FAMILY   = 26;
  parameter URAM_MAXDEPTH = 0;
  parameter PIPE4   = 0;    //  rA pipe
  parameter PIPE4EXT = 0;                     //speed
  parameter PIPE5   = 0;
  parameter SIMUL_RAM = 0;

  localparam DEPTH = 1 << LOGDEPTH;
  localparam [LOGDEPTH-1:0] ONE = 'b1;        //01/24/17

  input rClk, wClk, wEn;
  input[WIDTH-1:0] D;
  input[LOGDEPTH-1:0] rA, wA;
  output[WIDTH-1:0] Q;
  
  // rA registered by a fabric reg 
  wire [LOGDEPTH-1:0] rA_r;                       //speed
  
  dds_kitDelay_reg_attr # (.BITWIDTH(LOGDEPTH), .DELAY(PIPE4EXT) ) rA_reg_0 (   //speed
    .nGrst(1'b1), .rst(1'b0), .clk(rClk), .clkEn(1'b1),                         //speed
      .inp(rA),                                                                 //speed
      .outp(rA_r) );                                                            //speed

  generate
    if(SIMUL_RAM==1) begin: dbg_model
      dds_kitRam_fabric # (
          .WIDTH   (WIDTH   ),
          .LOGDEPTH(LOGDEPTH),
          .DEPTH   (DEPTH   ),
          .RA_PIPE (PIPE4 ),
          .RD_PIPE (PIPE5 ) ) simul_ram_0 (
        .nGrst(1'b1), .RCLOCK(rClk), .WCLOCK(wClk),
        .WRB(wEn), .RDB(1'b1), .rstDataPipe(1'b0),
        .DI(D), 
//speed        .RADDR(rA), 
        .RADDR(rA_r),
        .WADDR(wA), .DO(Q)  );
    end
  endgenerate

  // Note: PIPE 5 is inferred in .gen file
  //    (see gen_ramGen.cpp/ram_config_file_generator)

  generate  // G4.  Use uRAM if appropriate
    if( (SIMUL_RAM==0) && (DEPTH <= URAM_MAXDEPTH) && (
        (FPGA_FAMILY==19)||(FPGA_FAMILY==24)||(FPGA_FAMILY==25) ) )
      begin: G4_uram
        COREDDS_C0_COREDDS_C0_0_dds_g4_uram uram_g4_0  (
          .rD         (Q),
          .wD         (D),
          .rA      (rA_r),
          .wA      (wA),
          .wClk       (wClk),
          .wEn        (wEn),
          .A_CLK      (rClk),
          //unused ports
//03/31/17          .pipe_rst   (1'b0),
          .B_DOUT(),
          .B_ADDR     (ONE),
          .B_BLK      (1'b0),
          .wBlk       (1'b1)  );
    end
  endgenerate

  generate  // G4.  Use Large SRAM otherwise
    if( (SIMUL_RAM==0) && (DEPTH > URAM_MAXDEPTH) && (
        (FPGA_FAMILY==19)||(FPGA_FAMILY==24)||(FPGA_FAMILY==25) ) )
      begin: G4_lsram
      COREDDS_C0_COREDDS_C0_0_dds_g4_lsram lsram_g4_0  (     
        .wClk (wClk),                           
        .rClk (rClk),                             
        .wEn   (wEn),                           
        .rEn   (1'b1),
        .DI    (D),                             
//03/31/17        .pipe_rst(1'b0),
        .RADDR (rA_r),                            
        .WADDR (wA),                            
        .DO    (Q)    );
      end
   endgenerate

  generate  // G5.  Use uRAM if appropriate
    if( (SIMUL_RAM==0) && (DEPTH<=URAM_MAXDEPTH) && ((FPGA_FAMILY==26) || (FPGA_FAMILY==27)) &&
        ((PIPE5==1) || (PIPE4==1))  )   //If any pipe's on, then rClk port is present
      begin: PF_uram_rClk
        COREDDS_C0_COREDDS_C0_0_dds_g5_uram uram_g5_0  (
          .rD         (Q),
          .wD         (D),
          .rAddr      (rA_r),
          .wAddr      (wA),
          .wClk       (wClk),
          .rClk       (rClk),
          .wEn        (wEn)  );
    end
  endgenerate

  generate  // G5 uRam with no rA or rD pipe.  rClk port is out.
            // Apparently read is controlled solely by rA
    if( (SIMUL_RAM==0) && (DEPTH<=URAM_MAXDEPTH) && ((FPGA_FAMILY==26) || (FPGA_FAMILY==27)) &&
        (PIPE5==0) && (PIPE4==0) )
      begin: PF_uram_no_rClk
        COREDDS_C0_COREDDS_C0_0_dds_g5_uram uram_g5_0  (
          .rD         (Q),
          .wD         (D),
//speed          .rAddr      (rA),
          .rAddr      (rA_r),
          .wAddr      (wA),
          .wClk       (wClk),
          .wEn        (wEn)  );
    end
  endgenerate


  // PIPE 5 is inferred in .gen file (see gen_ramGen.cpp/ram_config_file_generator)
  generate  // G5.  Use Large SRAM otherwise
    if( (SIMUL_RAM==0) && (DEPTH>URAM_MAXDEPTH) && ((FPGA_FAMILY==26) || (FPGA_FAMILY==27)) )
      begin: PF_lsram
      COREDDS_C0_COREDDS_C0_0_dds_g5_lsram lsram_g5_0  (
        .RCLOCK(rClk),
        .WCLOCK(wClk),
        .WRB   (wEn),
        .RDB   (1'b1),
        .DI    (D),
//speed        .RADDR (rA),
        .RADDR (rA_r),
        .WADDR (wA),
        .DO    (Q)   );
      end
   endgenerate

endmodule


// Quarter-wave LUT and read sample tweaking
module COREDDS_C0_COREDDS_C0_0_qrtr_lut(nGrst, wClk, rClk, wEn, wA, full_wave_addr, sino, coso);
  parameter QUANTIZER_BITS = 8;   //Logdepth for the full-wave LUT
  parameter WIDTH         = 32;
  parameter FPGA_FAMILY   = 26;
  parameter URAM_MAXDEPTH = 0;
  parameter PIPE4  = 0;
  parameter PIPE4EXT = 0;                     //speed
  parameter PIPE5  = 0;
  parameter PIPE6  = 0;
  parameter PIPE7  = 0;
  parameter SIMUL_RAM     = 0;
  parameter SIN_ON       = 1;
  parameter COS_ON       = 1;
  parameter SIN_POLARITY  = 0;
  parameter COS_POLARITY  = 0;

  input nGrst, wClk, rClk, wEn;
  input [QUANTIZER_BITS-1:0] full_wave_addr;
  input [QUANTIZER_BITS-4:0] wA;
  output [WIDTH-1:0] sino, coso;

  wire [WIDTH-1:0] sine_ww, cosine_ww, blue, red, Q_blue, Q_red, Q_blue_t, Q_red_t;
  wire [QUANTIZER_BITS-4:0] rA_qrtr_dir, rA_qrtr_rev, rA_qrtr;
  reg [WIDTH-1:0] sine_w, cosine_w;
  wire [2:0] mapBits_w, mapBits;
  wire [WIDTH-1:0] sine, cosine;
  reg [7:0] mapBits_oneHot;

  // Tables to download into RAM's.
  // If both SIN_POLARITY==1 && COS_POLARITY==1, the tables contain negative
  // data. Then read modification is the same as for positive plarities
  COREDDS_C0_COREDDS_C0_0_dds_qrtr_sin qrtr_sin_tbl_0 (.index(wA), .sine(blue) );
  COREDDS_C0_COREDDS_C0_0_dds_qrtr_cos qrtr_cos_tbl_0 (.index(wA), .cosine(red) );

  COREDDS_C0_COREDDS_C0_0_wrapRam # (
      .LOGDEPTH     (QUANTIZER_BITS-3),
      .WIDTH        (WIDTH        ),
      .FPGA_FAMILY  (FPGA_FAMILY  ),
      .URAM_MAXDEPTH(URAM_MAXDEPTH),
      .PIPE4      (PIPE4),
      .PIPE4EXT   (PIPE4EXT),                                     //speed
      .PIPE5      (PIPE5),
      .SIMUL_RAM    (SIMUL_RAM    ) ) qrtr_blue_ram_0 (
    .rClk(rClk), .wClk(wClk), .D(blue), .Q(Q_blue),
    .wA(wA), 
    .rA(rA_qrtr), 
    .wEn(wEn) );

  COREDDS_C0_COREDDS_C0_0_wrapRam # (
      .LOGDEPTH     (QUANTIZER_BITS-3),
      .WIDTH        (WIDTH        ),
      .FPGA_FAMILY  (FPGA_FAMILY  ),
      .URAM_MAXDEPTH(URAM_MAXDEPTH),
      .PIPE4      (PIPE4),
      .PIPE4EXT   (PIPE4EXT),                                     //speed
      .PIPE5      (PIPE5),
      .SIMUL_RAM    (SIMUL_RAM    ) ) qrtr_red_ram_0 (
    .rClk(rClk), .wClk(wClk), .D(red), .Q(Q_red),
    .wA(wA), 
    .rA(rA_qrtr), 
    .wEn(wEn) );

  //  ----------  Read LUT's
  //  --------  Modify addr to accomodate to quarter wave
  //  Separate three MSB's  
  assign mapBits_w = full_wave_addr[QUANTIZER_BITS-1:QUANTIZER_BITS-3];
  // mapBits controls quarter wave tweaking. Delay it to match the RAM pipes
  // but make the delay one clock less, as the mapBits_oneHot introduces the 
  // one-clk delay. Having one-hot signals improves performance. Note: It is 
  // legit to use PIPE4+PIPE5+PIPE6-1 delay, as PIPE4=1 permanently
//speed  dds_kitDelay_reg # (.BITWIDTH(3), .DELAY(PIPE4+PIPE5+PIPE6-1) ) balance_dly_0 (
  dds_kitDelay_reg # (.BITWIDTH(3), .DELAY(PIPE4+PIPE4EXT+PIPE5+PIPE6-1) ) balance_dly_0 (    //speed
    .nGrst(nGrst), .rst(1'b0), .clk(rClk), .clkEn(1'b1),
    .inp(mapBits_w), .outp(mapBits) );
   
  // EXPERIMENT
  always @(posedge rClk)
    case (mapBits)
      3'b000 :  mapBits_oneHot <= 8'b00000001;
      3'b001 :  mapBits_oneHot <= 8'b00000010;
      3'b010 :  mapBits_oneHot <= 8'b00000100;
      3'b011 :  mapBits_oneHot <= 8'b00001000;
      3'b100 :  mapBits_oneHot <= 8'b00010000;
      3'b101 :  mapBits_oneHot <= 8'b00100000;
      3'b110 :  mapBits_oneHot <= 8'b01000000;
      3'b111 :  mapBits_oneHot <= 8'b10000000;
    endcase
  // EXPERIMENT stop
   
  // qrtr_wave_addr
  assign rA_qrtr_dir = full_wave_addr[QUANTIZER_BITS-4:0];
  // octavo-1-qrtr_wave_addr
  assign rA_qrtr_rev = ~full_wave_addr[QUANTIZER_BITS-4:0];
  // Quarter-wave address
  assign rA_qrtr = (mapBits_w[0]==0)? rA_qrtr_dir : rA_qrtr_rev;

  // Optionally infer a pipeline btw RAM output and fabric
  dds_kitDelay_reg # (.BITWIDTH(WIDTH), .DELAY(PIPE6) ) pipe6_0 (
    .nGrst(nGrst), .rst(1'b0), .clk(rClk), .clkEn(1'b1),
    .inp(Q_blue), .outp(Q_blue_t) );
  dds_kitDelay_reg # (.BITWIDTH(WIDTH), .DELAY(PIPE6) ) pipe6_1 (
    .nGrst(nGrst), .rst(1'b0), .clk(rClk), .clkEn(1'b1),
    .inp(Q_red), .outp(Q_red_t) );

  //  --------  Tweak Quarter-wave LUT outputs
  generate if ((SIN_ON!=0) && (SIN_POLARITY==0))    //Positive Sine
    begin: pos_sine
      always @ (Q_blue_t or Q_red_t or mapBits_oneHot)  begin
        // EXPERIMENT
        case (mapBits_oneHot)
          8'b00000001 :  sine_w    <= Q_blue_t;
          8'b00000010 :  sine_w    <= Q_red_t;
          8'b00000100 :  sine_w    <= Q_red_t;
          8'b00001000 :  sine_w    <= Q_blue_t;
          8'b00010000 :  sine_w    <= -Q_blue_t;
          8'b00100000 :  sine_w    <= -Q_red_t;
          8'b01000000 :  sine_w    <= -Q_red_t;
          8'b10000000 :  sine_w    <= -Q_blue_t;
        endcase
        // EXPERIMENT stop
      end //always
    end
  endgenerate

  generate if ((SIN_ON!=0) && (SIN_POLARITY==1))    //Negative Sine
    begin: neg_sine
      always @ (Q_blue_t or Q_red_t or mapBits_oneHot)  begin
        // EXPERIMENT
        case (mapBits_oneHot)
          8'b00000001 :  sine_w    <= -Q_blue_t;
          8'b00000010 :  sine_w    <= -Q_red_t;
          8'b00000100 :  sine_w    <= -Q_red_t;
          8'b00001000 :  sine_w    <= -Q_blue_t;
          8'b00010000 :  sine_w    <= Q_blue_t;
          8'b00100000 :  sine_w    <= Q_red_t;
          8'b01000000 :  sine_w    <= Q_red_t;
          8'b10000000 :  sine_w    <= Q_blue_t;
        endcase
        // EXPERIMENT stop
      end //always
    end
  endgenerate

  generate if ((COS_ON!=0) && (COS_POLARITY==0))    //Positive Cosine
    begin: pos_cosine
      always @ (Q_blue_t or Q_red_t or mapBits_oneHot)  begin
        // EXPERIMENT
        case (mapBits_oneHot)
          8'b00000001 :  cosine_w  <= Q_red_t;
          8'b00000010 :  cosine_w  <= Q_blue_t;
          8'b00000100 :  cosine_w  <= -Q_blue_t;
          8'b00001000 :  cosine_w  <= -Q_red_t;
          8'b00010000 :  cosine_w  <= -Q_red_t;
          8'b00100000 :  cosine_w  <= -Q_blue_t;
          8'b01000000 :  cosine_w  <= Q_blue_t;
          8'b10000000 :  cosine_w  <= Q_red_t;
        endcase
        // EXPERIMENT stop
      end //always
    end
  endgenerate

  generate if ((COS_ON!=0) && (COS_POLARITY==1))    //Negative Cosine
    begin: neg_cosine
      always @ (Q_blue_t or Q_red_t or mapBits_oneHot)  begin
        // EXPERIMENT
        case (mapBits_oneHot)
          8'b00000001 :  cosine_w  <= -Q_red_t;
          8'b00000010 :  cosine_w  <= -Q_blue_t;
          8'b00000100 :  cosine_w  <= Q_blue_t;
          8'b00001000 :  cosine_w  <= Q_red_t;
          8'b00010000 :  cosine_w  <= Q_red_t;
          8'b00100000 :  cosine_w  <= Q_blue_t;
          8'b01000000 :  cosine_w  <= -Q_blue_t;
          8'b10000000 :  cosine_w  <= -Q_red_t;
        endcase
        // EXPERIMENT ends
      end //always
    end
  endgenerate

  // Infer Qrtr-wave Pipe7
  generate if (SIN_ON!=0)
    dds_kitDelay_reg # (.BITWIDTH(WIDTH), .DELAY(PIPE7) ) pipe7_qrtr_0 (
        .nGrst(nGrst), .rst(1'b0), .clk(rClk), .clkEn(1'b1),
        .inp(sine_w), .outp(sino) );
  endgenerate

  generate if (COS_ON!=0)
    dds_kitDelay_reg # (.BITWIDTH(WIDTH), .DELAY(PIPE7) ) pipe7_qrtr_1 (
        .nGrst(nGrst), .rst(1'b0), .clk(rClk), .clkEn(1'b1),
        .inp(cosine_w), .outp(coso) );
  endgenerate

endmodule


module COREDDS_C0_COREDDS_C0_0_sin_cos_lut(nGrst, wClk, rClk, wEn, wA, full_wave_addr, sino, coso);
  parameter QUANTIZER_BITS = 8;   //Logdepth for the full-wave LUT
  parameter WIDTH         = 32;
  parameter QUARTER_WAVE  = 1;
  parameter SIN_ON        = 1;
  parameter COS_ON        = 1;
  parameter SIN_POLARITY  = 0;
  parameter COS_POLARITY  = 0;
  parameter FPGA_FAMILY   = 26;
  parameter URAM_MAXDEPTH = 0;
  parameter PIPE4   = 0;
  parameter PIPE4EXT = 0;
  parameter PIPE5   = 0;
  parameter PIPE6   = 0;
  parameter PIPE7   = 0;
  parameter SIMUL_RAM     = 0;

  localparam LOGDEPTH = (QUARTER_WAVE==1)? QUANTIZER_BITS-3 : QUANTIZER_BITS;

  input nGrst, wClk, rClk, wEn;
  input [QUANTIZER_BITS-1:0] full_wave_addr;
  input [LOGDEPTH-1:0] wA /* synthesis syn_noclockbuf = 1 */;       //03/08/17 
  output [WIDTH-1:0] sino, coso;

  wire [WIDTH-1:0] sine_ww, cosine_ww;
  reg [WIDTH-1:0] sine_w, cosine_w;
  wire [WIDTH-1:0] sine, cosine;

  generate if((QUARTER_WAVE==0) && (SIN_ON!=0))
    begin: full_wave_sine
      // Table to download into RAM's. Full wave SIN/COS_POLARITY is
      // implemented in the tables. Nothing to do here
      COREDDS_C0_COREDDS_C0_0_dds_full_sin full_sin_tbl_0 (.index(wA), .sine(sine) );

      // RAM block
      COREDDS_C0_COREDDS_C0_0_wrapRam # (
          .LOGDEPTH     (QUANTIZER_BITS),
          .WIDTH        (WIDTH        ),
          .FPGA_FAMILY  (FPGA_FAMILY  ),
          .URAM_MAXDEPTH(URAM_MAXDEPTH),
          .PIPE4      (PIPE4),
          .PIPE4EXT   (PIPE4EXT),                 //speed
          .PIPE5      (PIPE5),
          .SIMUL_RAM    (SIMUL_RAM    ) ) full_sin_ram_0 (
        .rClk(rClk), .wClk(wClk), .D(sine), .Q(sine_ww),
        .wA(wA), .rA(full_wave_addr), .wEn(wEn) );

      // Infer Pipe6
      dds_kitDelay_reg # (.BITWIDTH(WIDTH), .DELAY(PIPE6) ) pipe6_full_0 (
        .nGrst(nGrst), .rst(1'b0), .clk(rClk), .clkEn(1'b1),
        .inp(sine_ww), .outp(sino) );
    end
  endgenerate
  
  generate if((QUARTER_WAVE==0) && (COS_ON!=0))  
    begin: full_wave_cosine
      // Table to download into RAM's. Full wave SIN/COS_POLARITY is
      // implemented in the tables. Nothing to do here
      COREDDS_C0_COREDDS_C0_0_dds_full_cos full_cos_tbl_0 (.index(wA), .cosine(cosine) );

      // RAM block
      COREDDS_C0_COREDDS_C0_0_wrapRam # (
          .LOGDEPTH     (QUANTIZER_BITS),
          .WIDTH        (WIDTH        ),
          .FPGA_FAMILY  (FPGA_FAMILY  ),
          .URAM_MAXDEPTH(URAM_MAXDEPTH),
          .PIPE4      (PIPE4),
          .PIPE4EXT   (PIPE4EXT),           //speed
          .PIPE5      (PIPE5),
          .SIMUL_RAM    (SIMUL_RAM    ) ) full_cos_ram_0 (
        .rClk(rClk), .wClk(wClk), .D(cosine), .Q(cosine_ww),
        .wA(wA), .rA(full_wave_addr), .wEn(wEn) );

      // Infer Pipe6
      dds_kitDelay_reg # (.BITWIDTH(WIDTH), .DELAY(PIPE6) ) pipe6_full_1 (
        .nGrst(nGrst), .rst(1'b0), .clk(rClk), .clkEn(1'b1),
        .inp(cosine_ww), .outp(coso) );
    end
  endgenerate

  generate if(QUARTER_WAVE==1)
    begin: qrtr_wave
      COREDDS_C0_COREDDS_C0_0_qrtr_lut # (
          .QUANTIZER_BITS(QUANTIZER_BITS),    // Full-wave Logdepth
          .WIDTH         (WIDTH         ),
          .FPGA_FAMILY   (FPGA_FAMILY   ),
          .URAM_MAXDEPTH (URAM_MAXDEPTH ),
          .PIPE4(PIPE4),
          .PIPE4EXT   (PIPE4EXT),                         //speed
          .PIPE5(PIPE5),
          .PIPE6(PIPE6),
          .PIPE7(PIPE7),
          .SIMUL_RAM     (SIMUL_RAM     ),
          .SIN_ON        (SIN_ON),
          .COS_ON        (COS_ON),
          .SIN_POLARITY  (SIN_POLARITY  ),
          .COS_POLARITY  (COS_POLARITY  )   ) grtr_lut_0  (
        .nGrst  (nGrst),
        .wClk   (wClk),
        .rClk   (rClk),
        .wEn    (wEn ),
        .wA     (wA  ),
        .full_wave_addr(full_wave_addr),
        .sino   (sino),
        .coso   (coso) );
    end
  endgenerate

endmodule

