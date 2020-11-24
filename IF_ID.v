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
		.en(~freeze), // if freeze = 1, nothing new is stored after posedge clk
		.d(PCin & {32{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.q(PCout)
		);

	Reg32 instReg (
		.clk(clk),
		.rst(rst),
		.en(~freeze), // if freeze = 1, nothing new is stored after posedge clk
		.d(instIn & {32{~flush}}), // if flush = 1, 0 is stored in register after clk posedge, else data is stored
		.q(instOut)
		);
endmodule 