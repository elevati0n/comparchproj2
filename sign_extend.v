/****************************************************************************
 * sign_extend.v
 ****************************************************************************/

/**
 * Module: sign_extend
 * 
 * TODO: Add module documentation
 */
module sign_extend(
	input [15:0] extendMe,
	output reg [31:0] extended);
	
	always @(extendMe) 
		//check sign bit 16th bit
		begin if 
				(extendMe[15] == 0) 
			extended =  {16'b0000000000000000, extendMe};
	
		else if (extendMe[15] == 1)  
			extended =  {16'b1111111111111111, extendMe};
		end
		
		
endmodule


