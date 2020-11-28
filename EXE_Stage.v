module EXE_Stage (clk, EXE_CMD, MEM_R_EN, MEM_W_EN, PC, Val_Rn, Val_Rm, 
			imm, Shift_operand, signed_imm_24, SR, ALU_result, Br_addr, status);
input clk;
input [3:0] EXE_CMD;
input MEM_R_EN;
input MEM_W_EN;
input [31:0] PC;
input [31:0] Val_Rn;
input [31:0] Val_Rm;
input imm; 
input [11:0] Shift_operand;
input [23:0] signed_imm_24;
input [3:0] SR;
output [31:0] ALU_result;
output [31:0] Br_addr;
output [3:0] status;

	//Branch Address Calculator
	wire [31:0] signed_EX_imm24;
	assign signed_EX_imm24 = {{8{signed_imm_24[23]}},signed_imm_24};

	Adder32 br_addr_adder(
			.inp0(PC), 
			.inp1(signed_EX_imm24), 
			.out(Br_addr)
			);
	
	//Val2 Generator
	wire is_ldr_or_str;
	assign is_ldr_or_str = MEM_R_EN | MEM_W_EN;

	wire [31:0] Val2;
	Val2Generator val2generator(
			.Val_Rm(Val_Rm),
			.imm(imm),
			.is_lds_or_str(is_ldr_or_str),
			.Shift_operand(Shift_operand),
			.Val2out(Val2)
			);

	//ALU
	wire carry_in;
	assign carry_in = SR[1];

	ALU alu(
		.Val1(Val_Rn),
		.Val2(Val2),
		.carry_in(carry_in),
		.EXE_CMD(EXE_CMD),
		.result(ALU_result),
		.status(status)
		);
		

endmodule 