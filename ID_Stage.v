module ID_Stage (clk, rst, Instruction, Result_WB, writeBackEn, Dest_wb, hazard, SR,
			WB_EN, MEM_R_EN, MEM_W_EN, B, S, EXE_CMD, 
			Val_Rn, Val_Rm, 
			imm, Shift_operand, signed_imm_24, Dest,
			src1, src2, Two_src);
input clk;
input rst;
//from IF Reg
input [31:0] Instruction;
//from WB stage
input [31:0] Result_WB;
input writeBackEn;
input [3:0] Dest_wb;
//from hazard detect module
input hazard;
//from Status register
input [3:0] SR;
//to next stage
output WB_EN;
output MEM_R_EN;
output MEM_W_EN;
output B;
output S;
output [3:0] EXE_CMD;
output [31:0] Val_Rn;
output [31:0] Val_Rm;
output imm;
output [11:0] Shift_operand;
output [23:0] signed_imm_24;
output [3:0] Dest;
//to hazard detect module
output [3:0] src1;
output [3:0] src2;
output Two_src;

endmodule
