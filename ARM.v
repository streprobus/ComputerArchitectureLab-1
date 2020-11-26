module ARM (clk, rst);
input clk;
input rst;



	/*=====Wires=====*/

	//Stage IF//
	wire [31:0] IF_PC, IF_Inst;
	
	//Stage IF_ID Registers//
	wire [31:0] IF_ID_PC, IF_ID_Inst;

	//Stage ID//
	wire [31:0] ID_PC;

	//Stage ID_EX Registers//
	wire [31:0] ID_EX_PC;

	//Stage EX//
	wire [31:0] EX_PC;

	//Stage EX_MEM Registers//
	wire [31:0] EX_MEM_PC;

	//Stage MEM//
	wire [31:0] MEM_PC;

	//Stage MEM_WB Registers//
	wire [31:0] MEM_WB_PC;
	
	//Stage WB//
	wire [31:0] WB_PC;

	//Others
	wire freeze, flush, branchTaken;
	wire [31:0] branchAddress; 

	assign {freeze, flush, branchTaken} = 3'b0;
	assign branchAddress = 32'b0;

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
		.PCin(IF_ID_PC),
		.PCout(ID_PC)
		);

	//Stage ID_EX Registers//
	ID_Stage_Reg id_stage_reg(
		.clk(clk),
		.rst(rst),
		.PCin(ID_PC),
		.PCout(ID_EX_PC)
		);

	//Stage EX//
	EXE_Stage exe_stage(
		.clk(clk),
		.PCin(ID_EX_PC),
		.PCout(EX_PC)
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