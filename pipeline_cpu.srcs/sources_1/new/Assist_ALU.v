`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 14:32:14
// Design Name: 
// Module Name: Assist_ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Assist_ALU(input [31:0] A,
input [31:0] B,
input [2:0] func,
output [31:0] LO,
output [31:0] HI
    );
    wire [63:0] MULOut;
    wire [63:0] MULUOut;
    assign LO=(func==3'b000)?MULOut[31:0]:(func==3'b001)?MULUOut[31:0]:(func==3'b100)?A:32'h0000_0000;
    assign HI=(func==3'b000)?MULOut[63:32]:(func==3'b001)?MULUOut[63:32]:(func==3'b011)?A:32'h0000_0000;
    MUL    MUL_1(.a(A),.b(B),.z(MULOut));
    MULU   MULU_1(.a(A),.b(B),.z(MULUOut));
endmodule
