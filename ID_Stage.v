module ID_Stage (clk, rst, PCin, PCout);
input clk;
input rst;
input [31:0] PCin;
output [31:0] PCout;

	assign PCout = PCin;

endmodule
