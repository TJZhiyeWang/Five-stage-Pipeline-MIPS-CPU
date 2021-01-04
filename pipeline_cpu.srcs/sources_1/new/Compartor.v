`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/10 17:18:32
// Design Name: 
// Module Name: Compartor
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


module Compartor(input [31:0]RS,
input [31:0]RT,
output reg result);
    always@(*)begin
        if(RS==RT)
            result=1;
        else
            result=0;
    end      
endmodule
