module MEM_WB (clk, rst, PCin, PCout);
input clk;
input rst;
input [31:0] PCin;
output [31:0] PCout;

	Reg32 pcReg (
		.clk(clk),
		.rst(rst),
		.en(1'b1),
		.d(PCin),
		.q(PCout)
		);

endmodule 
