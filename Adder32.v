module Adder32 (inp0, inp1, out, co);
input [31:0] inp0;
input [31:0] inp1;
output [31:0] out;
output co;

	assign {co, out} = inp0 + inp1;

endmodule
