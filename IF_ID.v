module IF_ID (clk, rst, PCin, instIn, flush, freeze, PCout, instOut);
input clk;
input rst;
input [31:0] PCin;
input [31:0] instIn;
input flush;
input freeze;
output [31:0] PCout;
output [31:0] instOut;

	Reg32 pcReg (
		.clk(clk),
		.rst(rst),
		.en(1'b1),
		.d(PCin),
		.q(PCout)
		);

	Reg32 instReg (
		.clk(clk),
		.rst(rst),
		.en(1'b1),
		.d(instIn),
		.q(instOut)
		);
endmodule 