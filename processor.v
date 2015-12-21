/****************************************************************************
 * processor.v
 ****************************************************************************/

/**
 * Module: processor
 * 
 * TODO: Add module documentation
 */
 
 
module Processor(
	clk,
	reset,
    inst_addr,
    instr,
	data_addr,
	data_out,
	mem_read,
	mem_write,
	data_in
);
	
	//will still use the same top level interfaces, just will route them to sub modules 
	// Interface
	input clk;
	input reset;
	output [31:0]  inst_addr;
	input  [31:0]  instr;
	output [31:0]  data_addr;
	output  [31:0]  data_out;
	output        mem_read;
	output          mem_write;
	input  [31:0]  data_in;
	
	
	//STEP 1 
	// Instruction Fetch 


	wire [31:0] jumpMux1, next_addr, instr_add_4;

	pc_counter pc_counter(
		.clk      (clk     ), 	//	input 
		.reset    (reset   ), 	//	input
		.next_addr     (next_addr    ), 	//  input [31:0]
		.current  (inst_addr));	//  output [31:0]
		
	
	// alu +4 to address, always adds 4 to address
	alu aluPLus4 (
		.aluresult  (instr_add_4), //output [31:0]
		.zero       (      ), 		//
		.operation  (4'b0010 ), 	//input [3:0]
		.data_a     (inst_addr), 	//input [31:0]
		.data_b     (4    ));		//input [31:0]
	
	
	
	
	
	
	
	
	
	/* combined the shift left and concating for jump
	shiftleft2 shiftleft2_instr (
		.shiftMe  (instr ), //input [31:0]
		.shifted  (jump_address )); //output [31:0]
	
	wire [31:0] alu_out;
	
	combineSLPC4 combineSLPC4 (
		.in0  (jump_result ), //input [31:0]
		.in1  (alu_out ), //input [31:0]
		.shiftMe  (instr[25:0] ), //input [25:0]
		.shifted  (jump_address )); //output [27å:0]
	*/
	wire [31:0] alu_out;
	
	combineSLPC4 combineSLPC4 (
		.aluPlus4  (instr_add_4[31:28]), //input [4:0]
		.instr  (instr[25:0] ), //input [25:0]
		.out  (jumpMux1 ));	//output [31:0]
	
	mux32_2_1 mux32_2_1 (
		.s    (jump	), // input
		.in0  (alu_out ), //input [31:0]
		.in1  (jumpMux1), //input [31:0] 
		.out  (next_addr ));//  output [31:0]
	
	wire [1:0] aluop;
	
	controlunit controlunit (
		.regdest   (regdest  ), //output
		.jump      (jump     ), //output
		.branch    (branch   ), //output
		.memread   (mem_read  ), //output
		.memtoreg  (memtoreg ), //output
		.memwrite  (mem_write ), //output
		.alusrc    (alusrc   ), //output
		.regwrite  (regWrite ), //output
		.aluop     (aluop    ), //output [1:0]
		.opcode    (instr[31:26]   )); //input [5:0]


    wire [4:0] writeReg;  
    wire [31:0] writeData; 
    wire  [31:0] readData1;


	reg_file reg_file (
		.readReg1   (instr[25:21]), // input [4:0]
		.readReg2   (instr[20:16]), // input [4:0]
		.writeReg   (writeReg  ),   // input [4:0]
		.writeData  (writeData ),   // input [31:0]
		.regWrite   (regWrite  ),   // input
		.clk        (clk       ),   // input
		.readData1  (readData1 ),   // output [31:0]
		.readData2  (data_out ));  // output [31:0]
	
	//mux for write register
	mux4_2_1 mux4_2_1 (
		.in0  (instr[20:16]), // input [5:0]
		.in1  (instr[15:11]), // input [5:0]
		.s    (regdest), 
		.out  (writeReg)); //output [5:0]
		
		wire [31:0] shiftLeftIn;
	
	sign_extend sign_extend (
		.extendMe  (instr[15:0]), //    input [15:0]
		.extended  (shiftLeftIn)); // output [31:0]
		
		wire [31:0] aluAddB;
	
	shiftleft2 shiftleft2 (
		.shiftMe  (shiftLeftIn[29:0]),  // input [31:0]
		.shifted  (aluAddB ));		//  output [31:0]

	
	  wire [31:0] aluAddresult;
	alu aluAdd (
		//instr mux 0
		.aluresult  (aluAddresult ), // output [31:0]
	
		.zero       (      ), //  output
		//adder, same as jump + 4 
		.operation  (4'b0010), //  output
		.data_a     (instr_add_4  ),  //  input [31:0]
		.data_b     (aluAddB    )); //input [31:0]
		
	mux32_2_1 mux32_2_1_b (
		.s    (andGateOut   ), //input 
		.in0  (instr_add_4 ),  //input [31:0]
		.in1  (aluAddresult ), //input [31:0]
		.out  (alu_out )); //output [31:0]
	
	wire [3:0] operation;
	
	alu_control alu_control (
		.aluop      (aluop),  //  input [1:0]
		.funct      (instr[5:0]     ), // input[5:0]
		.operation  (operation )); // output [3:0]
	
	wire [31:0] aluB;
	
	mux32_2_1 mux32_2_bottom (
		.in0  (data_out ), //  input [31:0]
		.in1  (shiftLeftIn ),  // input [31:0]
		.s    (alusrc   ),  //  input 
		.out  (aluB )); //  output [31:0] 

	
	alu aluMain (
		.aluresult  (data_addr ),	 // output [31:0]
		.zero       (zero      ),	 // output
		.operation  (operation ), 		// input [3:0]
		.data_a     (readData1    ),	 //  input [31:0]
		.data_b     (aluB    ));	// input [31:0]
	
	andGate andGate (
		.in0  (branch ), // input 
		.in1  (zero),  // input
		.out  (andGateOut)); // output
	
	mux32_2_1 mux32_2_1data (
		.s    (memtoreg   ), // input
		.in0  (data_addr ),  // input [31:0]
		.in1  (data_in ), 	 // input [31:0]
		.out  (writeData )); // output [31:0]
	
endmodule


