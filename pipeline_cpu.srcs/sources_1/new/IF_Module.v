`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/08 21:26:11
// Design Name: 
// Module Name: IF_Module
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


module IF_Module(
input clk,
input reset,
input [31:0] EX_BT,
input [31:0] ID_JT,
input PCWrite,
input [31:0] ID_JR,
output [31:0] IF_PC_add_4,
output [31:0] IF_Instruct,
output [2:0] IF_PCSrc
);
//来源：00下一条 01 exe的跳转 02 id的跳转
reg [31:0] IF_PC;
wire [31:0] IF_PC_add;
wire [31:0] ROMAddr;

assign IF_PC_add = IF_PC + 32'h4;
assign IF_PC_add_4 = {IF_PC[31], IF_PC_add[30:0]};

always@(posedge clk or negedge reset) begin
	if(~reset)
		IF_PC <= 32'h0040_0000;
	else if(PCWrite)
		case(IF_PCSrc)
			3'h0: IF_PC <= IF_PC_add_4;
			3'h1: IF_PC <= EX_BT;
			3'h2: IF_PC <= ID_JT;
			3'h3: IF_PC <= ID_JR;
			default: IF_PC <= 32'h0040_0000;
		endcase
end
//assign ROMAddr=IF_PC-32'h0040_0000;
ROM ROM_1(.a(IF_PC[12:2]), .spo(IF_Instruct));
endmodule
