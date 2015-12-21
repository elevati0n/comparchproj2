/****************************************************************************
 * mux4_2_1.v
 ****************************************************************************/

/**
 * Module: mux4_2_1
 * 
 * TODO: Add module documentation
 */
module mux4_4_1(
		input [31:0] IDEX,
		input [31:0] EXMEM,
		input [31:0] MEMWB,
		input [1:0] s,
		output reg [31:0] aluInput);
	
	always @(s or IDEX or EXMEM or MEMWB)
	    case (s)
      2'b00 : begin // 
        aluInput = IDEX;
      end
     2'b10 : begin // 
        aluInput = EXMEM;
      end
     2'b01 : begin // 
        aluInput = MEMWB;
      end
	    endcase 
		
endmodule