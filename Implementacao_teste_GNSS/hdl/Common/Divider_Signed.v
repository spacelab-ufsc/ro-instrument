///////////////////////////////////////////////////////////////////////////////////////////////////
// Company: <Name>
//
// File: Divider_Signed.v
// File history:
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//      <Revision number>: <Date>: <Comments>
//
// Description: 
//
// <Description here>
//
// Targeted device: <Family::PolarFireSoC> <Die::MPFS025T> <Package::FCSG325>
// Author: <Name>
//
/////////////////////////////////////////////////////////////////////////////////////////////////// 

//`timescale <time_units> / <precision>

module Divider_Signed #(
    parameter WIDTH = 32
    )(
    input wire clk, 
    input wire rst, 
    input wire start, 
    input wire signed [WIDTH-1:0] num,
    input wire signed [WIDTH-1:0] den,
    
    output reg signed [WIDTH-1:0] quot,
    output reg signed [WIDTH:0]   rema,
    output reg idle
    );
//<statements>
    localparam IDLE_S = 3'd0,
               INIT   = 3'd1,
               DIV    = 3'd2,
               FIX    = 3'd3,
               DONE   = 3'd4;

    reg [2:0] state;

    reg [WIDTH-1:0] num_abs, den_abs;
    reg [WIDTH-1:0] quotient;
    reg [WIDTH:0]   remainder;
    reg             sign_q;
    reg [$clog2(WIDTH+1)-1:0] count;

    wire [WIDTH:0] rem_shifted;
    wire [WIDTH:0] rem_sub;
    wire           rem_ge_den;

    assign rem_shifted = {remainder[WIDTH-1:0], num_abs[WIDTH-1]};
    assign rem_ge_den  = (rem_shifted >= den_abs);
    assign rem_sub     = rem_shifted - den_abs;
    
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE_S;
            idle  <= 1'b1;
        end else begin
            case (state)

                /* ---------------- IDLE ---------------- */
                IDLE_S: begin
                    idle <= 1'b1;
                    if (start)
                        state <= INIT;
                end

                /* ---------------- INIT ---------------- */
                INIT: begin
                    idle <= 1'b0;
                    if (den == 0) begin
                        quot  <= {WIDTH{1'b1}};
                        rema  <= 0;
                        state <= DONE;
                    end else begin
                        sign_q    <= num[WIDTH-1] ^ den[WIDTH-1];
                        num_abs   <= num[WIDTH-1] ? -num : num;
                        den_abs   <= den[WIDTH-1] ? -den : den;
                        quotient  <= 0;
                        remainder <= 0;
                        count     <= WIDTH;
                        state     <= DIV;
                    end
                end

                /* ---------------- DIV ---------------- */
                DIV: begin
                    idle    <= 1'b0;
                    num_abs <= {num_abs[WIDTH-2:0], 1'b0};

                    if (rem_ge_den) begin
                        remainder <= rem_sub;
                        quotient  <= {quotient[WIDTH-2:0], 1'b1};
                    end else begin
                        remainder <= rem_shifted;
                        quotient  <= {quotient[WIDTH-2:0], 1'b0};
                    end

                    count <= count - 1;
                    if (count == 1)
                        state <= FIX;
                end

                /* ---------------- FIX ---------------- */
                FIX: begin
                    idle <= 1'b0;
                    quot <= sign_q ? -quotient : quotient;
                    rema <= sign_q ? -remainder : remainder;
                    state <= DONE;
                end

                /* ---------------- DONE ---------------- */
                DONE: begin
                    idle  <= 1'b0;
                    state <= IDLE_S;
                end

            endcase
        end
    end
    
endmodule

