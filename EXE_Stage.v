module EXE_Stage (clk, PCin, PCout);
input clk;
input [31:0] PCin;
output [31:0] PCout;

	assign PCout = PCin;

endmodule