/****************************************************************************
 * InstructionFetch.v
 ****************************************************************************/

/**
 * Module: InstructionFetch
 * 
 * TODO: Add module documentation
 */
 
/*
 
 module mux32_2_1(
	input s,
	input [31:0] in0,
	input [31:0] in1,
	output reg [31:0] out
	);
 	
 endmodule
 
 module pc_counter(
		//input clk, HazardUnitControl ;
		input clk,
		input reset,
		input [31:0] next_addr,
		output reg [31:0] current
		);
 	
 endmodule 
 
 module alu( output reg[31:0] aluresult, output zero,
            input[3:0] operation, input[31:0] data_a, input [31:0] data_b );
 	
 endmodule
 
 */

module InstructionFetch(
    input clk,
		input reset,
		output [31:0] inst_addr,
		input [31:0] aluAddresult,
		output [31:0] instr_add_4,
		input pcSrc,
		input hazardStall, //from hazard unit 
		input jump,
		input [31:0] jumpMux1
		);
	
	// Interface

	
	//this goes to the pipeline, addr+4 signal
	//output [31:0] instr_add_4; 
	
	
	//internal connections
	wire [31:0] next_addr;
	
	pc_counter pc_counter(
	    .clk (clk),
			.reset    (reset   ), 	//	external input
			.next_addr    (next_addr), 	//  internal input [31:0]
			.current  (inst_addr),	//  output external [31:0]
			.hazardStall(hazardStall));
		
		
	wire [31:0] mux2mux;
		
	mux32_2_1 mux32_2_1_b (
			.s    (pcSrc   ), //external input (was andGateOut) 
			.in0  (instr_add_4 ),  //input [31:0]
			.in1  (aluAddresult ), //external input [31:0]
			.out  (mux2mux )); //internal output [31:0]
	
	alu aluPLus4 (
			.aluresult  (instr_add_4), //external output [31:0]
			.zero       (      ), 		//
			.operation  (4'b0010 ), 	//input [3:0]
			.data_a     (inst_addr), 	//internal input [31:0]
			.data_b     (4    ));		//input [31:0]
			
			
  mux32_2_1 mux32_2_1_j (
			.s    (jump   ), //external input (was andGateOut) 
			.in0  (mux2mux ),  //input [31:0]
			.in1  (jumpMux1), //external input [31:0]
			.out  (next_addr )); //internal output [31:0]
		


endmodule



