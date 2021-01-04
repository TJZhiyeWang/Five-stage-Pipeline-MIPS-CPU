`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/09 11:50:40
// Design Name: 
// Module Name: Control
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


module Control(
input [31:0] Instruct,
input PC31,
input result,
output reg [2:0] PCSrc,
output reg RegWr,
output reg [1:0] RegDst,
output reg MemRd,
output reg MemWr,
output reg [2:0] MemToReg,
output reg ALUSrc1,
output reg ALUSrc2,
output reg EXTOp,
output reg LUOp,
output reg [3:0] ALUFun,
output reg Sign,
output reg [1:0] HILOWr,
//output reg [2:0] HILODst,
output reg [2:0] Afunc,
output reg [1:0] StoreMode,//00sw 01sh 11sb
output reg [2:0] ReadMode//0 unsign 1 sign 00lw 01lh 11lb
);
always @(*) begin
    case(Instruct[31:26])
            6'b100000:begin//lb
            StoreMode=2'b00;
                            ReadMode=3'b111;
                            PCSrc = 3'd0;
                            RegWr = 1;
                            HILOWr=0;
                            RegDst = 2'd1;
                            MemRd = 1;
                            MemWr = 0;
                            MemToReg = 3'b001;
                            ALUSrc1 = 0;
                            ALUSrc2 = 1;
                            ALUFun = 4'b0010;
                            EXTOp = 1;
                            LUOp = 0;
                end
            6'b100100:begin//lbu
            StoreMode=2'b00;
                            ReadMode=3'b011;
                            PCSrc = 3'd0;
                            RegWr = 1;
                            HILOWr=0;
                            RegDst = 2'd1;
                            MemRd = 1;
                            MemWr = 0;
                            MemToReg = 3'b001;
                            ALUSrc1 = 0;
                            ALUSrc2 = 1;
                            ALUFun = 4'b0010;
                            EXTOp = 1;
                            LUOp = 0;
                end
            6'b100101:begin//lhu
            StoreMode=2'b00;
                            ReadMode=3'b001;
                            PCSrc = 3'd0;
                            RegWr = 1;
                            HILOWr=0;
                            RegDst = 2'd1;
                            MemRd = 1;
                            MemWr = 0;
                            MemToReg = 3'b001;
                            ALUSrc1 = 0;
                            ALUSrc2 = 1;
                            ALUFun = 4'b0010;
                            EXTOp = 1;
                            LUOp = 0;
                end
            6'b101000:begin//sb
            StoreMode=2'b11;
                            ReadMode=3'b000;
                            PCSrc = 3'd0;
                            RegWr = 0;
                            HILOWr=0;
                            RegDst = 2'd1;
                            MemRd = 1;
                            MemWr = 1;
                            MemToReg = 3'b001;
                            ALUSrc1 = 0;
                            ALUSrc2 = 1;
                            ALUFun = 4'b0010;
                            EXTOp = 1;
                            LUOp = 0;
                end
            6'b101001:begin//sh
            StoreMode=2'b01;
                            ReadMode=3'b000;
                            PCSrc = 3'd0;
                            RegWr = 0;
                            HILOWr=0;
                            RegDst = 2'd1;
                            MemRd = 1;
                            MemWr = 1;
                            MemToReg = 3'b001;
                            ALUSrc1 = 0;
                            ALUSrc2 = 1;
                            ALUFun = 4'b0010;
                            EXTOp = 1;
                            LUOp = 0;
                end
            6'b100001:begin//lh
                StoreMode=2'b00;
                            ReadMode=3'b101;
                            PCSrc = 3'd0;
                            RegWr = 1;
                            HILOWr=0;
                            RegDst = 2'd1;
                            MemRd = 1;
                            MemWr = 0;
                            MemToReg = 3'b001;
                            ALUSrc1 = 0;
                            ALUSrc2 = 1;
                            ALUFun = 4'b0010;
                            EXTOp = 1;
                            LUOp = 0;
                end
			6'b10_0011: begin	//lw 0x23
			    StoreMode=2'b00;
			    ReadMode=3'b000;
				PCSrc = 3'd0;
				RegWr = 1;
				HILOWr=0;
				RegDst = 2'd1;
				MemRd = 1;
				MemWr = 0;
				MemToReg = 3'b001;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUFun = 4'b0010;
				EXTOp = 1;
				LUOp = 0;
			end
			6'b10_1011: begin	//sw 0x2b
			    StoreMode=2'b00;
                ReadMode=3'b000;
				PCSrc = 3'd0;
				RegWr = 0;
				HILOWr=0;
				RegDst = 2'd0;
				MemRd = 0;
				MemWr = 1;
				MemToReg = 3'b000;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUFun = 4'b0010;
				EXTOp = 1;
				LUOp = 0;
			end			
			6'b00_1111: begin	//lui 0x0f
				PCSrc = 3'd0;
				RegWr = 1;
				HILOWr=0;
				RegDst = 2'd1;
				MemRd = 0;
				MemWr = 0;
				MemToReg = 3'b000;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUFun = 4'b1111;
				EXTOp = 1;
				LUOp = 1;
			end
			6'b00_1000: begin	//addi 0x08
				PCSrc = 3'd0;
				RegWr = 1;
				HILOWr=0;
				RegDst = 2'd1;
				MemRd = 0;
				MemWr = 0;
				MemToReg = 3'b000;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUFun = 4'b0010;
				EXTOp = 1;
				LUOp = 0;
			end
			6'b00_1001: begin	//addiu 0x09
				PCSrc = 3'd0;
				RegWr = 1;
				HILOWr=0;
				RegDst = 2'd1;
				MemRd = 0;
				MemWr = 0;
				MemToReg = 3'b000;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUFun = 4'b0000;
				EXTOp = 1;
				LUOp = 0;
			end
			6'b00_1100: begin	//andi 0x0c
				PCSrc = 3'd0;
				RegWr = 1;
				HILOWr=0;
				RegDst = 2'd1;
				MemRd = 0;
				MemWr = 0;
				MemToReg = 3'b000;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUFun = 64'b0100;
				EXTOp = 0;
				LUOp = 0;
			end
			6'b00_1101: begin	//ori 0x0d
				PCSrc = 3'd0;
				RegWr = 1;
				HILOWr=0;
				RegDst = 2'd1;
				MemRd = 0;
				MemWr = 0;
				MemToReg = 3'b000;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUFun = 4'b0101;
				EXTOp = 0;
				LUOp = 0;
			end
			6'b00_1010: begin	//slti 0x0a
				PCSrc = 3'd0;
				RegWr = 1;
				HILOWr=0;
				RegDst = 2'd1;
				MemRd = 0;
				MemWr = 0;
				MemToReg = 3'b000;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUFun =4'b1011;
				EXTOp = 1;
				LUOp = 0;
			end
			6'b00_1011: begin	//sltiu 0x0b
				PCSrc = 3'd0;
				RegWr = 1;
				HILOWr=0;
				RegDst = 2'd1;
				MemRd = 0;
				MemWr = 0;
				MemToReg = 3'b000;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUFun = 4'b1010;
				EXTOp = 1;
				LUOp = 0;
			end
			6'b00_0100: begin	//beq 0x04
			    if(result)
				    PCSrc = 3'd1;
				else
				    PCSrc = 3'd0;
				RegWr = 0;
				HILOWr=0;
				RegDst = 2'd0;
				MemRd = 0;
				MemWr = 0;
				MemToReg = 3'b000;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUFun = 4'b0000;
				Sign = 1;
				EXTOp = 1;
				LUOp = 0;
			
			end
			6'b00_0101: begin	//bne 0x05
			    if(result)
                    PCSrc = 3'd0;
                else
                    PCSrc = 3'd1; 
				
				RegWr = 0;
				HILOWr=0;
				RegDst = 2'd0;
				MemRd = 0;
				MemWr = 0;
				MemToReg = 3'b000;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUFun = 4'b0000;
				Sign = 1;
				EXTOp = 1;
				LUOp = 0;
			end
			6'b00_0010: begin	//j 0x02
				PCSrc = 3'd2;
				RegWr = 0;
				HILOWr=0;
				RegDst = 2'd0;
				MemRd = 0;
				MemWr = 0;
				MemToReg = 3'b000;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUFun = 4'b0000;
				EXTOp = 1;
				LUOp = 0;
			end
			6'b00_0011: begin	//jal 0x03
				PCSrc = 3'd2;
				RegWr = 1;
				HILOWr=0;
				RegDst = 2'd2;
				MemRd = 0;
				MemWr = 0;
				MemToReg = 3'b010;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUFun = 4'b0000;
				EXTOp = 1;
				LUOp = 0;
			end
			6'b00_1110: begin  //xori
                PCSrc = 3'd0;
                RegWr = 1;
                HILOWr=0;
                RegDst = 2'd1;
                MemRd = 0;
                MemWr = 0;
                MemToReg = 3'b000;
                ALUSrc1 = 0;
                ALUSrc2 = 1;
                ALUFun = 4'b0110;
                EXTOp = 0;
                LUOp = 0;			
			end
			
			6'b00_0000: begin	//RÐÍ 0x00
				case(Instruct[5:0])
				    6'b010000:begin//mfhi
				        PCSrc = 3'd0;
                        RegWr = 1;
                        HILOWr=2'b00;
                        RegDst = 2'd0;
                        MemRd = 0;
                        MemWr = 0;
                        MemToReg = 3'b100;
                        ALUSrc1 = 0;
                        ALUSrc2 = 0;
                        ALUFun = 4'b1110;
                        Afunc=3'b011;
                        EXTOp = 0;
                        LUOp = 0;
				        end
				    6'b010010:begin//mflo
				        PCSrc = 3'd0;
                        RegWr = 1;
                        HILOWr=2'b00;
                        RegDst = 2'd0;
                        MemRd = 0;
                        MemWr = 0;
                        MemToReg = 3'b011;
                        ALUSrc1 = 0;
                        ALUSrc2 = 0;
                        ALUFun = 4'b1110;
                        Afunc=3'b011;
                        EXTOp = 0;
                        LUOp = 0;
				        end
				    6'b010001:begin//mthi
				        PCSrc = 3'd0;
                        RegWr = 0;
                        HILOWr=2'b10;
                        RegDst = 2'd0;
                        MemRd = 0;
                        MemWr = 0;
                        MemToReg = 3'b000;
                        ALUSrc1 = 0;
                        ALUSrc2 = 0;
                        ALUFun = 4'b1110;
                        Afunc=3'b011;
                        EXTOp = 0;
                        LUOp = 0;
				        end
				    6'b010011:begin//mtlo
				        PCSrc = 3'd0;
                        RegWr = 0;
                        HILOWr=2'b01;
                        RegDst = 2'd0;
                        MemRd = 0;
                        MemWr = 0;
                        MemToReg = 3'b000;
                        ALUSrc1 = 0;
                        ALUSrc2 = 0;
                        ALUFun = 4'b1110;
                        Afunc=3'b100;
                        EXTOp = 0;
                        LUOp = 0;
				        end
				    6'b000100:begin //sllv
				        PCSrc = 3'd0;
                        RegWr = 1;
                        HILOWr=0;
                        RegDst = 2'd0;
                        MemRd = 0;
                        MemWr = 0;
                        MemToReg = 3'b000;
                        ALUSrc1 = 0;
                        ALUSrc2 = 0;
                        ALUFun = 4'b1110;
                        EXTOp = 0;
                        LUOp = 0;
				    end
				    6'b011001:begin//multu
				        PCSrc = 3'd0;
                        RegWr = 0;
                        HILOWr=2'b11;
                        RegDst = 2'd0;
                        MemRd = 0;
                        MemWr = 0;
                        MemToReg = 3'b000;
                        ALUSrc1 = 0;
                        ALUSrc2 = 0;
                        ALUFun = 4'b0000;
                        Afunc=3'b001;
                        EXTOp = 0;
                        LUOp = 0;
                        end
				    6'b011000:begin//mult
				         PCSrc = 3'd0;
                         RegWr = 0;
                         HILOWr=2'b11;
                         RegDst = 2'd0;
                         MemRd = 0;
                         MemWr = 0;
                         MemToReg = 3'b000;
                         ALUSrc1 = 0;
                         ALUSrc2 = 0;
                         ALUFun = 4'b0000;
                         Afunc=3'b000;
                         EXTOp = 0;
                         LUOp = 0;
                         end
				    6'b000100:begin //sllv
				        PCSrc = 3'd0;
                        RegWr = 1;
                        HILOWr=0;
                        RegDst = 2'd0;
                        MemRd = 0;
                        MemWr = 0;
                        MemToReg = 3'b000;
                        ALUSrc1 = 0;
                        ALUSrc2 = 0;
                        ALUFun = 4'b1110;
                        EXTOp = 0;
                        LUOp = 0;
				    end
				    6'b000110:begin //srlv
                                            PCSrc = 3'd0;
                                            RegWr = 1;
                                            HILOWr=0;
                                            RegDst = 2'd0;
                                            MemRd = 0;
                                            MemWr = 0;
                                            MemToReg = 3'b000;
                                            ALUSrc1 = 0;
                                            ALUSrc2 = 0;
                                            ALUFun = 4'b1101;
                                            EXTOp = 0;
                                            LUOp = 0;
                                        end
				    6'b000111:begin //srav
				        PCSrc = 3'd0;
                        RegWr = 1;
                        HILOWr=0;
                        RegDst = 2'd0;
                        MemRd = 0;
                        MemWr = 0;
                        MemToReg = 3'b000;
                        ALUSrc1 = 0;
                        ALUSrc2 = 0;
                        ALUFun = 4'b1100;
                        EXTOp = 0;
                        LUOp = 0;
				    end
					6'b10_0000: begin	//add 0x20
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 4'b0010;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b10_0001: begin	//addu 0x21
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 4'b0000;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b10_0010: begin	//sub 0x22
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 4'b0011;
						Sign = 1;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b10_0011: begin	//subu 0x23
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 4'b0001;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b10_0100: begin	//and 0x24
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 4'b0100;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b10_0101: begin	//or 0x25
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 4'b0101;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b10_0110: begin	//xor 0x26
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 4'b0110;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b10_0111: begin	//nor 0x27
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 4'b0111;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b00_0000: begin	//sll 0x00
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 1;
						ALUSrc2 = 0;
						ALUFun = 4'b1110;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b00_0010: begin	//srl 0x02
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 1;
						ALUSrc2 = 0;
						ALUFun = 4'b1101;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b00_0011: begin	//sra 0x03
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 1;
						ALUSrc2 = 0;
						ALUFun = 4'b1100;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b10_1010: begin	//slt 0x2a
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 4'b1011;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b10_1011: begin	//sltu 0x2b
						PCSrc = 3'd0;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 4'b1010;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b00_1000: begin	//jr 0x08
						PCSrc = 3'd3;
						RegWr = 0;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b000;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 4'b0000;
						EXTOp = 1;
						LUOp = 0;
					end
					6'b00_1001: begin	//jalr 0x09
						PCSrc = 3'd3;
						RegWr = 1;
						HILOWr=0;
						RegDst = 2'd0;
						MemRd = 0;
						MemWr = 0;
						MemToReg = 3'b010;
						ALUSrc1 = 0;
						ALUSrc2 = 0;
						ALUFun = 6'b000000;
						EXTOp = 1;
						LUOp = 0;
					end
				endcase
			end
		endcase
	end
endmodule
