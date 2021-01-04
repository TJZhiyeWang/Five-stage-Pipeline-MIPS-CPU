`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/14 10:15:55
// Design Name: 
// Module Name: LOHI
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


module LOHI(
input clk,
input reset,
input [31:0] LO_in,
input [31:0] HI_in,
input [1:0] write,
output [31:0] LO_out,
output [31:0] HI_out);
    reg [31:0] LO;
    reg [31:0] HI;
    assign LO_out=LO;
    assign HI_out=HI;
    always @(negedge clk or negedge reset)begin
        if(~reset)begin
            LO=32'h0000_0000;
            HI=32'h0000_0000;
            end
        else begin
            if(write[0])
                LO=LO_in;
            else
                LO=LO;
            if(write[1])
                HI=HI_in;
            else
                HI=HI;
            end
     end
endmodule
