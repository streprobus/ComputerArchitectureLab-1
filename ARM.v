module ARM (clk, rst);
input clk;
input rst;



	/*=====Wires=====*/

	//Stage IF//
	wire [31:0] IF_PC, IF_Inst;
	
	//Stage IF_ID Registers//
	wire [31:0] IF_ID_PC, IF_ID_Inst;

	//Stage ID//
	wire ID_WB_EN, ID_MEM_R_EN, ID_MEM_W_EN, ID_B, ID_S;
	wire [3:0] ID_EXE_CMD; 
	wire [31:0] ID_Val_Rn, ID_Val_Rm; 
	wire ID_imm; 
	wire [11:0] ID_Shift_operand;
	wire [23:0] ID_Signed_imm_24;
	wire [3:0] ID_Dest, ID_src1, ID_src2;
	wire ID_Two_src;

	//Stage ID_EX Registers//
	wire ID_EX_WB_EN, ID_EX_MEM_R_EN, ID_EX_MEM_W_EN, ID_EX_B, ID_EX_S;
	wire [3:0] ID_EX_EXE_CMD;
	wire [31:0] ID_EX_PC, ID_EX_Val_Rn, ID_EX_Val_Rm;
	wire ID_EX_imm; 
	wire [11:0] ID_EX_Shift_operand;
	wire [23:0] ID_EX_Signed_imm_24;
	wire [3:0] ID_EX_Dest;

	//Stage EX//
	wire [31:0] EX_PC;
	wire flush, branchTaken;
	wire [31:0] branchAddress; 
	wire [3:0] status_bits;

	assign {flush, branchTaken} = 2'b0;
	assign branchAddress = 32'b0;
	assign status_bits = 4'b0;

	//Status Register
	wire [3:0] SR;
	
	//Stage EX_MEM Registers//
	wire [31:0] EX_MEM_PC;

	//Stage MEM//
	wire [31:0] MEM_PC;

	//Stage MEM_WB Registers//
	wire [31:0] MEM_WB_PC;
	
	//Stage WB//
	wire WB_WriteBack_En;
	wire [3:0] WB_Dest;
	wire [31:0] WB_Value;
	wire [31:0] WB_PC; //just for test, must delete

	//HazardDetectionUnit
	wire freeze, hazard;
	assign {freeze, hazard} = 2'b0;


	/*=====Modules=====*/

	//Stage IF//
	IF_Stage if_stage(
		.clk(clk),
		.rst(rst),
		.freeze(freeze), 
		.branchTaken(branchTaken), 
		.branchAddress(branchAddress), 
		.PC(IF_PC), 
		.Instruction(IF_Inst)
		);
	
	//Stage IF_ID Registers//
	IF_Stage_Reg if_stage_reg(
		.clk(clk), 
		.rst(rst), 
		.freeze(freeze), 
		.flush(flush), 
		.PC_in(IF_PC), 
		.Instruction_in(IF_Inst), 
		.PC(IF_ID_PC), 
		.Instruction(IF_ID_Inst)
		);

	//Stage ID//
	ID_Stage id_stage(
		.clk(clk), 
		.rst(rst), 
		.Instruction(IF_ID_Inst), 
		.Result_WB(WB_Value), 
		.writeBackEn(WB_WriteBack_En), 
		.Dest_wb(WB_Dest), 
		.hazard(hazard), 
		.SR(SR),
		.WB_EN(ID_WB_EN), 
		.MEM_R_EN(ID_MEM_R_EN), 
		.MEM_W_EN(ID_MEM_W_EN), 
		.B(ID_B), 
		.S(ID_S), 
		.EXE_CMD(ID_EXE_CMD), 
		.Val_Rn(ID_Val_Rn), 
		.Val_Rm(ID_Val_Rm), 
		.imm(ID_imm), 
		.Shift_operand(ID_Shift_operand), 
		.Signed_imm_24(ID_Signed_imm_24), 
		.Dest(ID_Dest),
		.src1(ID_src1), 
		.src2(ID_src2), 
		.Two_src(ID_Two_src)
		);

	//Stage ID_EX Registers//
	ID_Stage_Reg id_stage_reg(
		.clk(clk), 
		.rst(rst), 
		.flush(flush), 
		.WB_EN_IN(ID_WB_EN), 
		.MEM_R_EN_IN(ID_MEM_R_EN), 
		.MEM_W_EN_IN(ID_MEM_W_EN),
		.B_IN(ID_B), 
		.S_IN(ID_S), 
		.EXE_CMD_IN(ID_EXE_CMD), 
		.PC_IN(IF_ID_PC), 
		.Val_Rn_IN(ID_Val_Rn), 
		.Val_Rm_IN(ID_Val_Rm),
		.imm_IN(ID_imm), 
		.Shift_operand_IN(ID_Shift_operand), 
		.Signed_imm_24_IN(ID_Signed_imm_24), 
		.Dest_IN(ID_Dest),
		.WB_EN(ID_EX_WB_EN), 
		.MEM_R_EN(ID_EX_MEM_R_EN), 
		.MEM_W_EN(ID_EX_MEM_W_EN), 
		.B(ID_EX_B), 
		.S(ID_EX_S), 
		.EXE_CMD(ID_EX_EXE_CMD), 
		.PC(ID_EX_PC), 
		.Val_Rn(ID_EX_Val_Rn), 
		.Val_Rm(ID_EX_Val_Rm),
		.imm(ID_EX_imm), 
		.Shift_operand(ID_EX_Shift_operand), 
		.Signed_imm_24(ID_EX_Signed_imm_24), 
		.Dest(ID_EX_Dest)
		);

	//Stage EX//
	EXE_Stage exe_stage(
		.clk(clk),
		.PCin(ID_EX_PC),
		.PCout(EX_PC)
		);

	//Status Register
	Reg #(.WIDTH(4)) status_register(
		.clk(clk),
		.rst(rst),
		.d(status_bits),
		.en(ID_EX_S),
		.q(SR)
		);

	//Stage EX_MEM Registers//
	EXE_reg exe_reg(
		.clk(clk),
		.rst(rst),
		.PCin(EX_PC),
		.PCout(EX_MEM_PC)
		);

	//Stage MEM//
	Memory memory(
		.clk(clk),
		.rst(rst),
		.PCin(EX_MEM_PC),
		.PCout(MEM_PC)
		);

	//Stage MEM_WB Registers//
	MEM_reg mem_reg(
		.clk(clk),
		.rst(rst),
		.PCin(MEM_PC),
		.PCout(MEM_WB_PC)
		);
	
	//Stage WB//
	WB_stage wb_stage(
		.clk(clk),
		.rst(rst),
		.PCin(MEM_WB_PC),
		.PCout(WB_PC)
		);


endmodule 