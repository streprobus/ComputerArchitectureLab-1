module IF (clk, rst, freeze, branchTaken, branchAddress, flush, PCPlus, inst);
input clk;
input rst;
input freeze;
input branchTaken;
input [31:0] branchAddress;
input flush;
output [31:0] PCPlus;
output [31:0] inst;
	

endmodule 