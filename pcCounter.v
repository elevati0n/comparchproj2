/****************************************************************************
 * pcCounter.v
 ****************************************************************************/

/**
 * Module: pcCounter
 * 
 * TODO: Add module documentation
 */
module pc_counter(
		input clk,
		input reset,
		input [31:0] next_addr,
		output reg [31:0] current,
		input hazardStall);
	
	reg [31:0] internalReg;
	/*
	always @(posedge clk) begin
		begin
				current = internalReg; 		
				internalReg = current;
			end
		end
		
	 always @(negedge clk) begin
	   begin 
				internalReg = next_addr;	       
	   end
  end
	 */    
			
			
		always @(next_addr or reset or hazardStall or clk) begin	
		if (hazardStall == 1)
			begin 
				internalReg = current;
			end
		else if (reset == 1) 
			begin
				internalReg = 32'h00003000;
			  
			end 
		else if (clk == 1) begin
		    current = internalReg;
		  end
		else if (clk == 0) begin
		    internalReg = next_addr;
		end
		end
		
endmodule


