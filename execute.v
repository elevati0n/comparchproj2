/****************************************************************************
 * execute.v
 ****************************************************************************/

/**
 * Module: execute
 * 
 * TODO: Add module documentation
 */
module execute(
		input [1:0] alu_op,
		output [31:0] data_addrEXMEM,
		input [31:0] IDEXreadData1,
		input [31:0] IDEXreadData2,
		input [31:0] EXMEMreadData1,
		input [31:0] EXMEMreadData2,
		input [31:0] MEMWBreadData1,
		input [31:0] MEMWBreadData2,
		input [31:0] IDEXsignExtended,
		input [31:0] IDEXinstr,
		input alu_src,
		input [1:0] fwdA,
		input [1:0] fwdB,
		input regdest,
		output [4:0] writeReg,
		output [31:0] fwdBMux
		);
		
	
	/*
 module mux4_4_1(
		input [4:0] IDEX,
		input [4:0] EXMEM,
		input [4:0] MEMWB,
		input [1:0] s,
		output reg [4:0] aluInput);
	
 endmodule
 
 module alu_control(input[1:0] aluop, input[5:0] funct, output reg[3:0] operation );
 endmodule 
 
 module alu( output reg[31:0] aluresult, output zero,
            input[3:0] operation, input[31:0] data_a, input [31:0] data_b );
 endmodule 
 
 module mux32_2_1(
	input s,
	input [31:0] in0,
	input [31:0] in1,
	output reg [31:0] out
	);
 endmodule
 
 
 module mux4_2_1(
		input [4:0] in0,
		input [4:0] in1,
		input s,
		output reg [4:0] out);
 	
 endmodule
 
	 */
	//internal connection
	wire [3:0] operation;
		
	alu_control alu_control (
			.aluop      (alu_op),  //  external input [1:0]
			.funct      (IDEXinstr[5:0]     ), // external input[5:0]
			.operation  (operation )); // internal output [3:0]
			
	//internal connections 
	wire [31:0] readData1;
	wire [31:0] readData2;
		
	//forwarding mux A for ALU input A
	mux4_4_1 fwdmuxa (
			.IDEX      (IDEXreadData1     ), //external input [31:0]
			.EXMEM     (EXMEMreadData1    ), //external input [31:0]
			.MEMWB     (MEMWBreadData1    ), //external input [31:0]
			.s         (fwdA        ), 		//exteral input [1:0]
			.aluInput  (readData1 ));		//internal output [31:0]	
		
	
	//forwarding mux B for ALU input B
	mux4_4_1 fwdmuxb (
			.IDEX      (IDEXreadData2     ), //external input [31:0]
			.EXMEM     (EXMEMreadData2    ), //external input [31:0]
			.MEMWB     (MEMWBreadData2    ), //external input [31:0]
			.s         (fwdB        ), 		//exteral input [1:0]
			.aluInput  (fwdBMux ));			//internal output [31:0]	
		
	//choose between fwdb out and signed int
	mux32_2_1 mux32_2_1 (
			.s    (alu_src   ), 		//external input 
			.in0  (fwdBMux ), 			//external output [31:0]	
			.in1  (IDEXsignExtended ), //external output [31:0]	
			.out  (readData2 ));
		
	//main alu
	alu aluMain (
			.aluresult  (data_addrEXMEM),	 // external output [31:0]
			.zero       (      ),	 		// output null
			.operation  (operation ), 		// internal input [3:0]
			.data_a     (readData1    ),	 //  internal input [31:0]
			.data_b     (readData2    ));	// internal input [31:0]
		
	//mux to choose register destination
	//mux for write register
	mux4_2_1 mux4_2_1 (
			.in0  (IDEXinstr[20:16]), // input [5:0]
			.in1  (IDEXinstr[15:11]), // input [5:0]
			.s    (regdest), 
			.out  (writeReg)); //output [4:0]
		
		


endmodule




