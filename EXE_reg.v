module EXE_reg (clk, rst, PCin, PCout);
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