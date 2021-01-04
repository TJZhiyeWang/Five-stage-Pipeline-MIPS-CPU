`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/09 22:01:47
// Design Name: 
// Module Name: ALU
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


module ALU(
input [31:0] a,    //32 位输入，操作数 1 
input [31:0] b,    //32 位输入，操作数 2 
input [3:0] aluc, //4 位输入，控制 alu 的操作 
output reg [31:0] r   //32 位输出，由 a、b 经过 aluc 指定的操作生成 
    );
   reg zero;        //0 标志位 
   reg carry;       // 进位标志位 
   reg neg;   // 负数标志位 
   reg ovf;   // 溢出标志位 
   reg [31:0] btemp;
   reg signed [31:0] s_a;
   reg signed [31:0] s_b;
    always@(aluc or a or b) begin
       casex(aluc)
       
        4'b0000://加运算
           begin
              {carry,r}={1'b0,a}+{1'b0,b};
              zero<=(r==0)?1:0;
              neg<=r[31];
              ovf<=ovf;
           end
          4'b0001:
           begin
                   r=a-b;
                   carry<=b>a?1:0;
                   zero<=r==0?1:0;
                   neg<=r[31];
           end
           4'b0010:
            begin
                    r=a+b;
                    ovf<=(a[31]&&b[31]&&~r[31])|(~a[31]&&~b[31]&&r[31]);
                    carry<=(a[31]&&b[31]&&~r[31])|(~a[31]&&~b[31]&&r[31]);
                    zero<=r==0?1:0;
                    neg<=r[31];
             end
         4'b0011:begin
          btemp=~b+1;
          r=a+btemp;
          ovf<=(a[31]&&btemp[31]&&~r[31])|(~a[31]&&~btemp[31]&&r[31]);
          carry<=ovf;
          zero<=r==0?1:0;
          neg<=r[31];
                end
          4'b0100:begin
          r=a&b;
          zero<=r==0?1:0;
          end
          4'b0101:begin
          r=a|b;
          zero<=(r==0)?1:0;
          neg<=r[31];
          end
          4'b0110:begin
          r=a^b;
          zero<=r==0?1:0;
          neg<=r[31];
         end
         4'b0111:begin
         r=~(a|b);
         zero<=r==0?1:0;
         neg<=r[31];
         end                              
         4'b100x:begin
         r={b[15:0],16'd0};
         zero<=r==0?1:0;
         neg<=r[31];
         end
         4'b1011:begin
         r=a[31]!=b[31]?(a[31]>b[31]?1:0):(a[31]?(a>b?1:0):(a<b?1:0));
         zero<=(a-b)==0?1:0;
         neg<=r?1:0;
         end
         4'b1010:begin
         r=a<b?1:0; 
         zero<=(a-b)==0?1:0;
         carry<=r?1:0;
          neg<=r[31];
         end
         4'b1100:begin
          s_b=b;
          {carry,r}=s_b>>>a;
          zero<=r?0:1;
          neg<=r[31];
          end
         4'b1110:begin
         {carry,r}=b<<a;
         zero<=r?0:1;
         neg<=r[31];
         end
         4'b1111:begin
         r=b;
         end
         4'b1101:begin
         {carry,r}=b>>a;
         zero<=r?0:1;
         neg<=r[31];
         end
      
       endcase
     end
  
endmodule