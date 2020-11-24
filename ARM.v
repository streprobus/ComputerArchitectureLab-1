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
	IF IF_stage(
		.clk(clk),
		.rst(rst),
		.freeze(freeze), 
		.branchTaken(branchTaken), 
		.branchAddress(branchAddress), 
		.PCPlus(IF_PC), 
		.inst(IF_Inst)
		);

	
	//Stage IF_ID Registers//
	IF_ID IF_ID_stage(
		.clk(clk), 
		.rst(rst), 
		.PCin(IF_PC), 
		.instIn(IF_Inst), 
		.flush(flush), 
		.freeze(freeze), 
		.PCout(IF_ID_PC), 
		.instOut(IF_ID_Inst)
		);

	//Stage ID//
	ID ID_stage(
		.clk(clk),
		.rst(rst),
		.PCin(IF_ID_PC),
		.PCout(ID_PC)
		);

	//Stage ID_EX Registers//
	ID_EX ID_EX_stage(
		.clk(clk),
		.rst(rst),
		.PCin(ID_PC),
		.PCout(ID_EX_PC)
		);

	//Stage EX//
	EX EX_stage(
		.clk(clk),
		.rst(rst),
		.PCin(ID_EX_PC),
		.PCout(EX_PC)
		);

	//Stage EX_MEM Registers//
	EX_MEM EX_MEM_stage(
		.clk(clk),
		.rst(rst),
		.PCin(EX_PC),
		.PCout(EX_MEM_PC)
		);

	//Stage MEM//
	MEM MEM_stage(
		.clk(clk),
		.rst(rst),
		.PCin(EX_MEM_PC),
		.PCout(MEM_PC)
		);

	//Stage MEM_WB Registers//
	MEM_WB MEM_WB_stage(
		.clk(clk),
		.rst(rst),
		.PCin(MEM_PC),
		.PCout(MEM_WB_PC)
		);
	
	//Stage WB//
	WB WB_stage(
		.clk(clk),
		.rst(rst),
		.PCin(MEM_WB_PC),
		.PCout(WB_PC)
		);


endmodule 