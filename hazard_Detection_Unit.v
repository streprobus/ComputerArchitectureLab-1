module hazard_Detection_Unit (src1, src2, is_src1_valid, Two_src, Exe_Dest, Exe_WB_EN,
				Mem_Dest, Mem_WB_EN, hazard_Detected);
input [3:0] src1;
input [3:0] src2;
input is_src1_valid;
input Two_src;
input [3:0] Exe_Dest;
input Exe_WB_EN;
input [3:0] Mem_Dest;
input Mem_WB_EN; 
output hazard_Detected;

	assign hazard_Detected = (Exe_WB_EN && ((is_src1_valid && Exe_Dest == src1) | (Two_src == 1'b1 && Exe_Dest == src2)))? 1'b1
				:(Mem_WB_EN && ((is_src1_valid && Mem_Dest == src1) | (Two_src == 1'b1 && Mem_Dest == src2)))? 1'b1
				: 1'b0;

endmodule 