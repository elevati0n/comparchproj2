/****************************************************************************
 * comparator.v
 ****************************************************************************/

/**
 * Module: comparator
 * 
 * TODO: Add module documentation
 */

module comparator( 
		input [31:0] readData1,
		input [31:0] readData2,
		output reg IFFlush,
		input [5:0] IFIDinstr,
		output reg PCSrc,
		output reg jump,
		output zero
		);
			
	alu alu (
			.aluresult  (  ), 
			.zero       (zero      ), 
			.operation  (4'b0110 ), 
			.data_a     (readData1    ), 
			.data_b     (readData2    ));
	
	
	always @ (IFIDinstr or readData1 or readData2) begin
    case (IFIDinstr)
      6'b000010: begin 
        //jump instruction detected, have to stall
		IFFlush = 1;
		PCSrc = 0;
		jump = 1;
      end
      6'b000100: begin // OR
      	if (zero == 1) begin
      		IFFlush = 1;
			PCSrc = 1; 
			jump = 0;	
      	end
      end
      default: begin
        IFFlush = 0;
		PCSrc = 0; 
		jump = 0;
      end
    endcase
  end
			
	

endmodule




