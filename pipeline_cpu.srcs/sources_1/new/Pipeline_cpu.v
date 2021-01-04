`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/08 20:55:23
// Design Name: 
// Module Name: Pipeline_cpu
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


module Pipeline_cpu( input reset,input sysclk,input [15:0] sw,output [7:0] o_seg,output [7:0] o_sel);
wire [31:0] ReadData;
wire [31:0] WriteData;
wire [31:0] MemAddr;
wire MemRead;
wire MemWrite;

wire [31:0] rdata;
wire seg7_cs,switch_cs;
/*************clk****************/
    wire clk;
    clk_div clk_1(sysclk,clk);
    //assign clk = sysclk;
    wire rst;
    assign rst=~reset;
    wire [31:0] pc;
    wire [31:0] instruc;
/************************Core*************************/
    Pipeline_Core sccpu(.clk(clk), .reset(rst), .MemAddr(MemAddr), .WriteData(WriteData), 
    .ReadData(ReadData), .MemWrite(MemWrite), .MemRead(MemRead) );
/***********************Peripheral********************/
    Data_Mem DataMem_1(.reset(rst), .clk(clk), .rd(MemRead), .wr(MemWrite), .addr(MemAddr-32'h10010000), .wdata(WriteData), .rdata(rdata));
    seg7x16 seg7(clk, rst, seg7_cs, WriteData, o_seg, o_sel);
    io_sel io_mem(MemAddr,1,MemWrite, MemRead, seg7_cs, switch_cs);
    sw_mem_sel sw_mem(switch_cs, sw,rdata,  ReadData);
endmodule
module clk_div(
    input clk_in,
    output clk
);

	reg [31:0] q=0;

	always @(posedge clk_in )q <= q + 1;
	
	assign clk = q[2];	//近似数量级的周期

endmodule