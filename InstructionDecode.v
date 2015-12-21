/****************************************************************************
 * InstructionDecode.v
 ****************************************************************************/

/**
 * Module: InstructionDecode
 * 
 * TODO: Add module documentation
 */
 
module InstructionDecode(
		input [31:0] IFIDinstr,
		input [31:0] IFIDinstr_add_4,
		output [31:0] aluAddresult,
		input [4:0] writeReg, 
		input [31:0] writeData,
		input regWrite,
		input clk,
		output [31:0] readData1,
		output [31:0] data_out,
		output ifflush,
		output pcSrc,
		output [31:0] signExtended,
		output jump,
		output [31:0] aluAddB
		);
		
		
		
	//this wire connects the branch calculator to the PC Mux 
	//output wire [31:0] aluAddresult;
	
	//this comes from the pipeline
	//input [31:0] IFIDinstr; 
	//input [31:0] IFIDinstr_add_4; 
			
	sign_extend sign_extend (
			.extendMe  (IFIDinstr[15:0]), //   external input [15:0] from IFID reg
			.extended  (signExtended)); // internal output [31:0]
	
	shiftleft2 shiftleft2 (
			.shiftMe  (signExtended[29:0]),  // internal input [31:0]
			.shifted  (aluAddB ));		//  internal output [31:0]
	
	//alu add b 
	//wire [31:0] aluAddresult;
	
	alu aluAdd (
			//instr mux 0
			.aluresult  (aluAddresult ), // output external to PC counter [31:0]
			.zero       (      ), //  output null
			//adder, same as jump + 4 
			.operation  (4'b0010), //  input[4:0] const
			.data_a     (IFIDinstr_add_4  ),  //  external input [31:0]
			.data_b     (aluAddB    )); // internal input [31:0]

	/*
	input wire [4:0] writeReg;  
    input wire [31:0] writeData; 
    input wire  [31:0] readData1;
    input wire regWrite;
    input wire clk;
    output wire [31:0] readData1;
    output wire [31:0] data_out; 
	 */


	reg_file reg_file (
			.readReg1   (IFIDinstr[25:21]), // external input [4:0]
			.readReg2   (IFIDinstr[20:16]), // external input [4:0]
			.writeReg   (writeReg  ),   // external input [4:0]
			.writeData  (writeData ),   // external input [31:0]
			.regWrite   (regWrite  ),   // external input
			.clk        (clk       ),   // external input
			.readData1  (readData1 ),   // external output [31:0]
			.readData2  (data_out ));  // external output [31:0]
	
	
	comparator c1( 
			.readData1 (readData1),
			.readData2 (data_out),
			.IFFlush (ifflushInternal),
			.IFIDinstr (IFIDinstr[31:26]),
			.PCSrc (pcSrcAnd),
			.jump (jump),
			.zero (zero));
	
	andGate andGate (
		.in0  (ifflushInternal ), 
		.in1  (zero ), 
		.out  (out ));
	
	andGate andGate2 (
		.in0  (pcSrcAnd ), 
		.in1  (zero ), 
		.out  (pcSrc ));
	
	orGate orGate (
		.in0  (out ), 
		.in1  (jump ), 
		.out  (ifflush ));
	
	
	/*
	 * 	combineSLPC4 combineSLPC4 (
		.aluPlus4  (instr_add_4[31:28]), //input [4:0]
		.instr  (instr[25:0] ), //input [25:0]
		.out  (jumpMux1 ));	//output [31:0]
	 */
	
	


endmodule




