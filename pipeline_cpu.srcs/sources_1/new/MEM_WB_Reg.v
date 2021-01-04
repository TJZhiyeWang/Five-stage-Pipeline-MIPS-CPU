`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/09 22:15:58
// Design Name: 
// Module Name: MEM_WB_Reg
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


module MEM_WB_Reg(
input clk,
input reset,
input [31:0] PC_add_4_in,
input [31:0] ALUOut_in,
input [31:0] MemReadData_in,
input [4:0] Rt_in,
input [4:0] Rd_in,
input [1:0] RegDst_in,
input [2:0] MemToReg_in,
input RegWrite_in,
input [4:0] AddrC_in,
input [1:0] HILOWr_in,
output reg [1:0] HILOWr_out,
input [31:0] LO_in,
output reg [31:0] LO_out,
input [31:0] HI_in,
output reg [31:0] HI_out,
output reg [31:0] PC_add_4_out,
output reg [31:0] ALUOut_out,
output reg [31:0] MemReadData_out,
output reg [4:0] Rt_out,
output reg [4:0] Rd_out,
output reg [1:0] RegDst_out,
output reg [2:0] MemToReg_out,
output reg RegWrite_out,
output reg [4:0] AddrC_out
    );
  always @(posedge clk or negedge reset) begin
        if (~reset) begin
            PC_add_4_out <= 32'h0000_0000;
            ALUOut_out <= 32'h0000_0000;
            MemReadData_out <= 32'h0000_0000;
            Rt_out <= 5'h00;
            Rd_out <= 5'h00;
            RegDst_out <= 2'h0;
            MemToReg_out <= 3'h0;
            RegWrite_out <= 1'h0;
            AddrC_out <= 5'h0;
            HILOWr_out<=21'b00;
            LO_out<=32'h0000_0000;
            HI_out<=32'h0000_0000;
        end
        else begin
            PC_add_4_out <= PC_add_4_in;
            ALUOut_out <= ALUOut_in;
            MemReadData_out <= MemReadData_in;
            Rt_out <= Rt_in;
            Rd_out <= Rd_in;
            RegDst_out <= RegDst_in;
            MemToReg_out <= MemToReg_in;
            RegWrite_out <= RegWrite_in;
            AddrC_out <= AddrC_in;
            HILOWr_out<=HILOWr_in;
            LO_out<=LO_in;
            HI_out<=HI_in;
        end
    end  
    
endmodule
