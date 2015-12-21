/****************************************************************************
 * IFIDPipeReg.v
 ****************************************************************************/

/**
 * Module: IFIDPipeReg
 * 
 * TODO: Add module documentation
 */
module IFIDPipeReg(
		input[31:0] instr_add_4,
		output reg [31:0] IFIDinstr_add_4,
		input[31:0] instr,
		output reg [31:0] IFIDinstr,
		input ifFlush, // from comparator 
		input stall,
		input clk); //from hazard unit
	
	reg [31:0] internalReg;
	reg [31:0] internalRegPlus4;
	
	//standard operation is to just move data left to right @ clk
	always @(posedge clk)
	begin 
		if (ifFlush == 1) begin
			// zero out the instruction
			IFIDinstr = 32'h0000;
			internalReg = 32'h0000;
		end
		else if (stall == 1) begin
			//repeat the same instruction over again
			IFIDinstr_add_4 = internalRegPlus4;
			IFIDinstr = internalReg;
			internalReg = internalReg; 
			internalRegPlus4 = internalRegPlus4;
		end
		else begin
			IFIDinstr_add_4 = instr_add_4;
			IFIDinstr = instr;
			internalReg = instr; 
			internalRegPlus4 = IFIDinstr_add_4;
		end
	end

endmodule


