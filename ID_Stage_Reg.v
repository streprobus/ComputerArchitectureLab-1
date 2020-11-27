module ID_Stage_Reg (clk, rst, flush, WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN,B_IN, S_IN, 
			EXEC_CMD_in, PC_IN, Val_Rn_IN, Val_Rm_IN,
			imm_IN, Shift_operand_IN, Signed_imm_24_IN, Dest_IN,
			WB_EN, MEM_R_EN, MEM_W_EN, B, S, EXE_CMD, PC, Val_Rn, Val_Rm,
			imm, Shift_operand, Signed_imm_24, Dest);
input clk;
input rst;
input [31:0] PCin;
output [31:0] PCout;

	Reg32 PC_Reg (
		.clk(clk),
		.rst(rst),
		.d(PCin),
		.en(1'b1),
		.q(PCout)
		);

endmodule 
