/****************************************************************************
 * orGate.v
 ****************************************************************************/

/**
 * Module: orGate
 * 
 * TODO: Add module documentation
 */
module orGate(input in0, input in1, output reg out);
	
	always @(in0 or in1) begin
		if ((in0 == 1 ) || (in1 == 1))
			out = 1; 
		else 
			out = 0;
	end

endmodule

