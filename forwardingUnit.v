/****************************************************************************
 * ForwardingUnit.v
 ****************************************************************************/

/**
 * Module: ForwardingUnit
 * 
 * TODO: Add module documentation
 */
module ForwardingUnit(
		input [4:0] IDEXinstrRt2016,
		input [4:0] IDEXinstrRs2521,
		input EXMEMRegWrite,
		input [4:0] EXMEMRegRd1511,
		input MEMWBRegWrite,
		input [4:0] MEMWBRegRd1511,
		output reg [1:0] fwdA,
		output reg [1:0] fwdB
		);
		
	// EX HAZARD
	//algorithm
	/*if EXMEM.RegWrite == 1
		and EXMEMRegRd1511 != 0 
		and EXMEMRegRd1511 == IDEX Rs  IFIDinstr[25:21]
		begin 
		output ForwardA 2'b10; 
		
		//these should run in parralel 
		//algorithm
		if EXMEM.RegWrite == 1
		and EXMEMRegRd1511 != 0 
		and EXMEMRegRd1511 == IDEX Rt IDEXinstr[20:16]
		
		begin
		output ForwardA 2'b10;
	 */
		
	always @(IDEXinstrRt2016 or 
		IDEXinstrRs2521 or 
		EXMEMRegWrite or 
		EXMEMRegRd1511 or 
		MEMWBRegWrite or 
		MEMWBRegRd1511)
	begin
		
			fwdA = 2'b00;
		  fwdB = 2'b00;
		  
		if ((EXMEMRegWrite == 1) && (EXMEMRegRd1511 != 0)) begin
			if (EXMEMRegRd1511 == IDEXinstrRs2521) begin 
				fwdA = 2'b10;
			end 
			if (EXMEMRegRd1511 == IDEXinstrRt2016) begin 
				fwdB = 2'b10;
			end
		 

		end
		
		//MEM HAZARD
		//agorithm should only run if first one does not, so nest it.
		if ((EXMEMRegWrite == 0) || (EXMEMRegRd1511 == 0 || EXMEMRegRd1511 != IDEXinstrRs2521)) begin 
			if ((MEMWBRegWrite == 1) && (MEMWBRegRd1511 != 0)) begin
				if (MEMWBRegRd1511 == IDEXinstrRs2521) begin 
					fwdA = 2'b01;
				end 
			end
		end
		
		if ((EXMEMRegWrite == 0) || (EXMEMRegRd1511 == 0 || EXMEMRegRd1511 != IDEXinstrRt2016)) begin 
			if ((MEMWBRegWrite == 1) && (MEMWBRegRd1511 != 0)) begin
				if (MEMWBRegRd1511 == IDEXinstrRt2016) begin 
					fwdB = 2'b01;
				end 
			end
		end
		
	end
		
	endmodule


