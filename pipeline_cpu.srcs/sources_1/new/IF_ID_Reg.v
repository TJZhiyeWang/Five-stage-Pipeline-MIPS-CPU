`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/08 21:55:49
// Design Name: 
// Module Name: IF_ID_Reg
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


module IF_ID_Reg(
input clk,
input reset,
input IF_ID_write,
input [31:0] PC_add_4_in,
input [31:0] Instruct_in,
output reg [31:0] PC_add_4_out,
output reg [31:0] Instruct_out
);
    
    
    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            PC_add_4_out <= 32'h8000_0000;
            Instruct_out <= 32'h0000_0000;
        end
        else begin
            if (IF_ID_write) begin
                PC_add_4_out <= PC_add_4_in;
                Instruct_out <= Instruct_in;
            end
        end
     end
    
endmodule
