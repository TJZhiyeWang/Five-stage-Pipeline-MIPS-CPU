`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/08 21:12:45
// Design Name: 
// Module Name: Pipeline_Core
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


module Pipeline_Core(
input clk,
input reset,
input [31:0] ReadData,
output [31:0] MemAddr,
output [31:0] WriteData,
output MemWrite,
output MemRead);
/*********************DEFINATION**********************/
parameter Ra = 5'd31;
wire [31:0]	ID_PC_add_4;
wire [31:0] ID_Instruct;
wire [4:0] ID_Rs;
wire [4:0] ID_Rt;
wire [4:0] ID_Rd;
wire [4:0] ID_Shamt;
wire [15:0] ID_Immediate;
wire [25:0] ID_JumpAddr;
wire [31:0] ID_JT;

wire [1:0] ID_RegDst;
wire [2:0] ID_PCSrc;
wire ID_MemRead;
wire ID_MemWrite;
wire [2:0] ID_MemToReg;
wire [3:0] ID_ALUFun;
wire ID_EXTOp;
wire ID_LUOp;
wire ID_ALUSrc1;
wire ID_ALUSrc2;
wire ID_RegWrite;
wire ID_Sign;
wire ID_MemWrite_new;
wire ID_RegWrite_new;



wire [31:0]	EX_PC_add_4;
wire [4:0] EX_Rs;
wire [4:0] EX_Rt;
wire [4:0] EX_Rd;
wire [4:0] EX_Shamt;
wire [4:0] EX_AddrC;
wire [31:0]	EX_ALU_A;
wire [31:0]	EX_ALU_B;
wire [31:0] EX_ALUOut;
wire [31:0] EX_DataBusA;
wire [31:0] EX_DataBusB;
wire [31:0] EX_LUOut;
wire [31:0] EX_BT;

wire EX_Sign;
wire [1:0] EX_RegDst;
wire [2:0] EX_PCSrc;
wire EX_MemRead;
wire EX_MemWrite;
wire [2:0] EX_MemToReg;
wire [3:0] EX_ALUFun;
wire EX_ALUSrc1;
wire EX_ALUSrc2;
wire EX_RegWrite;




wire [31:0] MEM_PC_add_4;
wire [4:0] MEM_Rt;
wire [4:0] MEM_Rd;
wire [31:0] MEM_DataBusB;
wire [4:0] MEM_AddrC;
wire [31:0] MEM_MemReadData;//new
wire [31:0] MEM_ALUOut;

wire [1:0] MEM_RegDst;
wire MEM_MemRead;
wire MEM_MemWrite;
wire [2:0] MEM_MemToReg;
wire MEM_RegWrite;



 wire [31:0] WB_PC_add_4;
     wire [4:0] WB_Rt;
     wire [4:0] WB_Rd;
     wire [31:0] WB_DataBusC;
     wire [31:0] WB_MemReadData;
     wire [4:0] WB_AddrC;
     wire [31:0] WB_ALUOut;
     
     wire [1:0] WB_RegDst;
     wire [2:0] WB_MemToReg;
     wire WB_RegWrite;
     
     
     wire result;
      wire PCWrite;
      wire IF_ID_write;
      
      wire [31:0] ID_EXTOut;
      wire [31:0] ID_LUOut;
      wire [31:0] ID_DataBusA;
      wire [31:0] ID_DataBusB;
/************************IF***************************/
wire [2:0] IF_PCSrc;
wire [31:0] IF_PC_add_4;
wire [31:0] IF_Instruct;
assign IF_PCSrc =  ID_PCSrc;
IF_Module IF(.clk(clk),.reset(reset),.EX_BT(EX_BT),.ID_JT(ID_JT),.PCWrite(PCWrite),
               .IF_PC_add_4(IF_PC_add_4),.IF_Instruct(IF_Instruct),.IF_PCSrc(IF_PCSrc),.ID_JR(ID_DataBusA));
/************************IF-ID***********************/

IF_ID_Reg IF_ID_Reg_0(.clk(clk), .reset(reset),  .IF_ID_write(IF_ID_write), .PC_add_4_in(IF_PC_add_4),
                      .Instruct_in(IF_Instruct), .PC_add_4_out(ID_PC_add_4), .Instruct_out(ID_Instruct));

/************************ID***************************/
wire [1:0] ID_HILOWr;
wire [1:0] EX_HILOWr;
wire [1:0] MEM_HILOWr;
wire [1:0] WB_HILOWr;

  wire [31:0] EX_LO;
  wire [31:0] EX_HI;
  wire [31:0] MEM_LO;
  wire [31:0] MEM_HI;
  wire [31:0] WB_LO;
  wire [31:0] WB_HI;
  wire [31:0] LOout;
  wire [31:0] HIout;
assign ID_Rs = ID_Instruct[25:21];
assign ID_Rt = ID_Instruct[20:16];
assign ID_Rd = ID_Instruct[15:11];
assign ID_Shamt = ID_Instruct[10:6];
assign ID_Immediate = ID_Instruct[15:0];
assign ID_JumpAddr = ID_Instruct[25:0];
assign WB_DataBusC = (WB_MemToReg == 3'b000)? WB_ALUOut: (WB_MemToReg == 3'b001)? WB_MemReadData: (WB_MemToReg == 3'b010)?WB_PC_add_4:(WB_MemToReg == 3'b011)?LOout:(WB_MemToReg == 3'b100)?HIout:32'h0000_0000;
RegFile cpu_ref(.reset(reset), .clk(clk), .addr1(ID_Rs), .data1(ID_DataBusA), .addr2(ID_Rt), .data2(ID_DataBusB), .wr(WB_RegWrite),
	.addr3(WB_AddrC), .data3(WB_DataBusC));
	wire [2:0] ID_FUNC;
	wire [2:0] EX_FUNC;
	wire [1:0] ID_SM;
	wire [2:0] ID_RM;
	wire [1:0] EX_SM;
    wire [2:0] EX_RM;
    wire [1:0] MEM_SM;
    wire [2:0] MEM_RM;
    Compartor Compartor_1(.RS(ID_DataBusA),.RT(ID_DataBusB),.result(result));
Control Control_1(.Instruct(ID_Instruct), .PC31(ID_PC_add_4[31]), .PCSrc(ID_PCSrc), .RegWr(ID_RegWrite), .RegDst(ID_RegDst),
                 .MemRd(ID_MemRead), .MemWr(ID_MemWrite), .MemToReg(ID_MemToReg), .ALUSrc1(ID_ALUSrc1), .ALUSrc2(ID_ALUSrc2),
                 .EXTOp(ID_EXTOp), .LUOp(ID_LUOp), .ALUFun(ID_ALUFun), .Sign(ID_Sign),.HILOWr(ID_HILOWr),
                 .Afunc(ID_FUNC),.StoreMode(ID_SM),.ReadMode(ID_RM),.result(result));

assign ID_EXTOut = {ID_EXTOp? {16{ID_Immediate[15]}}: 16'h0000, ID_Immediate[15:0]};
assign ID_LUOut = ID_LUOp? {ID_Immediate[15:0], 16'h0000}: ID_EXTOut;
assign ID_JT = {IF_PC_add_4[31:28], ID_JumpAddr, 2'b00};         

 Data_CONF Data_CONF_1(.wb_wr(WB_RegWrite),.reset(reset),.clk(clk),.rd(ID_Rd),.rt(ID_Rt),.rs(ID_Rs),.RegDst(ID_RegDst),.RegWr_in(ID_RegWrite),
                       .MemWr_in(ID_MemWrite),.C_Addr(WB_AddrC),.ALUSrc1(ID_ALUSrc1), .ALUSrc2(ID_ALUSrc2),.PCWrite(PCWrite),
                       .IF_ID_write(IF_ID_write),.RegWr_out(ID_RegWrite_new),.MemWr_out(ID_MemWrite_new));



LOHI LOHI_1(.clk(clk),.reset(reset),.LO_in(WB_LO),.HI_in(WB_HI),.write(WB_HILOWr),.LO_out(LOout),.HI_out(HIout));

// Jump dst for branch instruction todo:
     assign EX_BT = ID_PC_add_4 + {{14{ID_Immediate[15]}} ,ID_Immediate,2'b00};
/************************ID_EX_Reg*************************/


ID_EX_Reg ID_EX_Reg_1(.clk(clk), .reset(reset), .PC_add_4_in(ID_PC_add_4), .DataBusA_in(ID_DataBusA), 
	.DataBusB_in(ID_DataBusB), .LUOut_in(ID_LUOut), .Rs_in(ID_Rs), .Rt_in(ID_Rt), .Rd_in(ID_Rd), 
	.Shamt_in(ID_Shamt), .RegDst_in(ID_RegDst), .PCSrc_in(ID_PCSrc), .MemRead_in(ID_MemRead), .MemWrite_in(ID_MemWrite_new), 
	.MemToReg_in(ID_MemToReg), .ALUFun_in(ID_ALUFun), .ALUSrc1_in(ID_ALUSrc1), .ALUSrc2_in(ID_ALUSrc2), .RegWrite_in(ID_RegWrite_new),
	 .Sign_in(ID_Sign),.HILOWr_in(ID_HILOWr),.Afunc_in(ID_FUNC),.SM_in(ID_SM),.RM_in(ID_RM),.SM_out(EX_SM),.RM_out(EX_RM),
	.PC_add_4_out(EX_PC_add_4), .DataBusA_out(EX_DataBusA), .DataBusB_out(EX_DataBusB), .LUOut_out(EX_LUOut),
	.Rs_out(EX_Rs), .Rt_out(EX_Rt), .Rd_out(EX_Rd), .Shamt_out(EX_Shamt), .RegDst_out(EX_RegDst), .PCSrc_out(EX_PCSrc), 
	.MemRead_out(EX_MemRead), .MemWrite_out(EX_MemWrite), .MemToReg_out(EX_MemToReg), .ALUFun_out(EX_ALUFun), 
	.ALUSrc1_out(EX_ALUSrc1), .ALUSrc2_out(EX_ALUSrc2), .RegWrite_out(EX_RegWrite), .Sign_out(EX_Sign),.HILOWr_out(EX_HILOWr),
	.Afunc_out(EX_FUNC));
	 
/************************EX***************************/

     // ALU Input 
     assign EX_ALU_A = EX_ALUSrc1? {17'h00000, EX_Shamt}: EX_DataBusA;
     assign EX_ALU_B = EX_ALUSrc2? EX_LUOut: EX_DataBusB;    
     
     // AddrC will be used in WB, so it will flow to the next state
     assign EX_AddrC = (EX_RegDst == 2'b00)? EX_Rd: (EX_RegDst == 2'b01)? EX_Rt:Ra;    
  
     ALU    ALU_1(.a(EX_ALU_A), .b(EX_ALU_B), .aluc(EX_ALUFun), .r(EX_ALUOut));
     Assist_ALU ALU_2(.A(EX_ALU_A),.B(EX_ALU_B),.func(EX_FUNC),.LO(EX_LO),.HI(EX_HI));
     
/************************EX_MEM_Reg*************************/
     EX_MEM_Reg EX_MEM_Reg_1(.clk(clk), .reset(reset), .PC_add_4_in(EX_PC_add_4), .ALUOut_in(EX_ALUOut), .DataBusB_in(EX_DataBusB),
      .Rt_in(EX_Rt), .Rd_in(EX_Rd), .RegDst_in(EX_RegDst), .MemRead_in(EX_MemRead), .MemWrite_in(EX_MemWrite),
      .MemToReg_in(EX_MemToReg), .RegWrite_in(EX_RegWrite), .AddrC_in(EX_AddrC),.HILOWr_in(EX_HILOWr),.LO_in(EX_LO),
      .HI_in(EX_HI),.SM_in(EX_SM),.RM_in(EX_RM),.SM_out(MEM_SM),.RM_out(MEM_RM),
      .PC_add_4_out(MEM_PC_add_4),
      .ALUOut_out(MEM_ALUOut), .DataBusB_out(MEM_DataBusB), .Rt_out(MEM_Rt), .Rd_out(MEM_Rd), .RegDst_out(MEM_RegDst),
      .MemRead_out(MEM_MemRead), .MemWrite_out(MEM_MemWrite), .MemToReg_out(MEM_MemToReg),.RegWrite_out(MEM_RegWrite),
       .AddrC_out(MEM_AddrC),.HILOWr_out(MEM_HILOWr),.LO_out(MEM_LO),.HI_out(MEM_HI));

/************************MEM*************************/


assign MemAddr = MEM_ALUOut;
assign MemWrite = MEM_MemWrite;
assign MemRead = MEM_MemRead;
assign MEM_MemReadData = ReadData;
assign WriteData = MEM_DataBusB;
/*always@(MemAddr or MemWrite or MemRead)begin
    if(MemRead&!MemWrite)begin
        if(MEM_RM[2])begin
            if(MEM_RM[1:0]==2'b00)
                MEM_MemReadData = ReadData;
            else if(MEM_RM[1:0]==2'b01)begin
                case(MemAddr[1])
                    1'b0:MEM_MemReadData={{16{ReadData[15]}} ,ReadData[15:0]};
                    1'b1:MEM_MemReadData={{16{ReadData[31]}} ,ReadData[31:16]};
                endcase
                end
            else  if(MEM_RM[1:0]==2'b11)begin 
                case(MemAddr[1:0])
                    1'b00:MEM_MemReadData={{24{ReadData[7]}} ,ReadData[7:0]};
                    1'b01:MEM_MemReadData={{24{ReadData[15]}} ,ReadData[15:8]};
                    1'b10:MEM_MemReadData={{24{ReadData[23]}} ,ReadData[23:16]};
                    1'b11:MEM_MemReadData={{24{ReadData[31]}} ,ReadData[31:24]};
                 endcase
                 end
         end
         else if(!MEM_RM[2])begin
                     if(MEM_RM[1:0]==2'b00)
                         MEM_MemReadData = ReadData;
                     else if(MEM_RM[1:0]==2'b01)begin
                         case(MemAddr[1])
                             1'b0:MEM_MemReadData={{16'h0000} ,ReadData[15:0]};
                             1'b1:MEM_MemReadData={{16'h0000} ,ReadData[31:16]};
                         endcase
                         end
                     else  if(MEM_RM[1:0]==2'b11)begin 
                         case(MemAddr[1:0])
                             1'b00:MEM_MemReadData={{24'h0000_00} ,ReadData[7:0]};
                             1'b01:MEM_MemReadData={{24'h0000_00} ,ReadData[15:8]};
                             1'b10:MEM_MemReadData={{24'h0000_00} ,ReadData[23:16]};
                             1'b11:MEM_MemReadData={{24'h0000_00} ,ReadData[31:24]};
                          endcase
                          end
         end
    end
    else if(MemRead&MemWrite)begin
        if(MEM_SM==2'b00)
            WriteData = MEM_DataBusB;
        else if(MEM_SM==2'b01)begin
            case(MemAddr[1])
                 1'b0:WriteData ={ReadData[31:16] ,MEM_DataBusB[15:0]};
                 1'b1:WriteData ={MEM_DataBusB[31:16],ReadData[15:0]};
            endcase
        end
        else if(MEM_SM==2'b11)begin
            case(MemAddr[1:0])
                 1'b00:WriteData ={ReadData[31:8] ,MEM_DataBusB[7:0]};
                 1'b01:WriteData ={ReadData[31:16] ,MEM_DataBusB[15:8],ReadData[7:0]};
                 1'b10:WriteData ={ReadData[31:24] ,MEM_DataBusB[23:16],ReadData[15:0]};
                 1'b11:WriteData ={MEM_DataBusB[31:24],ReadData[23:0]};
            endcase    
        end
    end
end*/
/************************MEM_WB*************************/
MEM_WB_Reg MEM_WB_Reg_1(.clk(clk), .reset(reset), .PC_add_4_in(MEM_PC_add_4), .ALUOut_in(MEM_ALUOut), .MemReadData_in(MEM_MemReadData), 
                        .Rt_in(MEM_Rt), .Rd_in(MEM_Rd), .RegDst_in(MEM_RegDst), .MemToReg_in(MEM_MemToReg), .RegWrite_in(MEM_RegWrite),
                         .AddrC_in(MEM_AddrC),.LO_in(MEM_LO),.HI_in(MEM_HI),.HILOWr_in(MEM_HILOWr),
                          .PC_add_4_out(WB_PC_add_4), .ALUOut_out(WB_ALUOut), .MemReadData_out(WB_MemReadData), 
                         .Rt_out(WB_Rt), .Rd_out(WB_Rd), .RegDst_out(WB_RegDst), .MemToReg_out(WB_MemToReg),.RegWrite_out(WB_RegWrite),
                          .AddrC_out(WB_AddrC),.LO_out(WB_LO),.HI_out(WB_HI),.HILOWr_out(WB_HILOWr));
    
endmodule
