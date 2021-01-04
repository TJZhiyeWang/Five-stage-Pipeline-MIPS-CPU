`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/17 18:05:59
// Design Name: 
// Module Name: pipeline_tb
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


module pipeline_tb(

    );
     reg clk;
       reg rst;
       reg [15:0] sw;
       wire [7:0] sel;
       wire [7:0] seg;
             always #1 clk<=!clk;
             
         
             Pipeline_cpu CPU_inst(.reset(rst),.sysclk(clk),.sw(sw),.o_seg(seg),.o_sel(sel));
             
         
             integer counter=0;
             
             initial begin
           
                 /*file_output=$fopen("E://Vivado-projects/program/static_pipeline_cpu/test.txt");*/
                 clk=0;
                 rst=1;
                 sw=16'h8000;
                 #1
                 rst=0;
       
             end
             wire [31:0] pc;
             assign pc=CPU_inst.sccpu.IF.IF_PC;
             wire [31:0] instruc;
             assign instruc=CPU_inst.sccpu.IF_Instruct;
endmodule
