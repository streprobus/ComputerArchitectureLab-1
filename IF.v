module IF (clk, rst, freeze, branchTaken, branchAddress, PCPlus, inst);
input clk;
input rst;
input freeze;
input branchTaken;
input [31:0] branchAddress;
output [31:0] PCPlus;
output [31:0] inst;
	
	wire [31:0] PCin, PCout;

	Mux2to1_32 PCinMux(
			.inp0(PCPlus),
			.inp1(branchAddress),
			.sel(branchTaken),
			.out(PCin)
			);
	
	Reg32 PC(
		.clk(clk),
		.rst(rst),
		.d(PCin),
		.en(~freeze),
		.q(PCout)
		);

	InstructionMemory InstMem(
			.addr(PCout),
			.inst(inst)
			);

	Adder32 AdderPCplus4(
			.inp0(PCout),
			.inp1(4),
			.out(PCPlus)
			);

endmodule 