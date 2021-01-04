`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/10 15:38:48
// Design Name: 
// Module Name: Data_CONF
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


module Data_CONF(
input reset,
input clk,
input [4:0]rd,
input [4:0]rt,
input [4:0]rs,
input [1:0]RegDst,
input RegWr_in,
input MemWr_in,
input ALUSrc1,
input ALUSrc2,
input [4:0]C_Addr,
input wb_wr,
output reg PCWrite,
output reg IF_ID_write,
output reg RegWr_out,
output reg MemWr_out

    );
reg [31:0] regflag;
    always@(negedge clk or negedge reset)begin
        if(~reset)begin
            PCWrite<=1;
            IF_ID_write<=1;
            RegWr_out<=0;
            MemWr_out<=0;
            regflag=32'b0;
       
        end
        else begin
            regflag[C_Addr]=wb_wr?0:regflag[C_Addr];                   
            if((!ALUSrc1&regflag[rs]==1)|(!ALUSrc2&regflag[rt]==1)|(ALUSrc2&~ALUSrc1&regflag[rt]==1))begin
                PCWrite<=0;
                IF_ID_write<=0;
                RegWr_out<=0;
                MemWr_out<=0;
          
           
            end else begin
                PCWrite<=1;
                IF_ID_write<=1;
                RegWr_out<=RegWr_in;
                MemWr_out<= MemWr_in;
           
                if(RegDst==2'b00&RegWr_in==1)
                     regflag[rd]=1;             
                if(RegDst==2'b01&RegWr_in==1)
                     regflag[rt]=1;
                if(RegDst!=2'b00&RegDst!=2'b01&RegWr_in==1)
                     regflag[31]=1;
                 
                end
            
       end
   end
         
endmodule
