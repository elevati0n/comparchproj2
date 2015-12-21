/****************************************************************************
 * pipelineProcessor.v
 ****************************************************************************/

/**
 * Module: pipelineProcessor
 * 
 * TODO: Add module documentation
 */
 
module pipelineProcessor(
	// Interface
	//testbench signals clk, reset
	input clk,
	input reset,
	//connections to Memory
	output [31:0]  inst_addr,
	input  [31:0]  instr,
	output [31:0]  data_addr,
	output  [31:0]  data_out,
	output        mem_read,
	output          mem_write,
	input  [31:0]  data_in
	);

	//IFID PIPELINE
	/*
	 * module InstructionFetch(
		input clk, 
		input reset,
		output [31:0] inst_addr,
		input [31:0] aluAddresult,
		output [31:0] instr_add_4,
		input pcSrc
		);
	 */
	
	wire [31:0] instr_add_4;
	wire [31:0] aluAddresult;
	wire [31:0] aluAddB;
	
	
	wire [31:0] IFIDinstr;
	
	wire [31:0] jumpMux1;
	
	InstructionFetch InstructionFetch (
	  .clk   (clk),
		.reset         (reset        ), //external input testbench
		.inst_addr     (inst_addr    ), //external output [31:0] 
		.aluAddresult  (aluAddresult ), //internal input [31:0]
		.instr_add_4   (instr_add_4  ), //internal output [31:0]
		.pcSrc         (pcSrc        ), //internal input 
		.hazardStall	(stall ),
		.jump         (jump),
		.jumpMux1     (jumpMux1));			//internal input
	
	
	
	wire [31:0] IFIDinstr_add_4; 
	
	//IFID pipeline 
	/* module IFIDPipeReg(
		input[31:0] instr_add_4,
		output reg [31:0] IFIDinstr_add_4,
		input[31:0] instr,
		output reg [31:0] IFIDinstr,
		input ifFlush, // from comparator 
		input stall,
		input clk); //from hazard unit
	 */
	IFIDPipeReg IFIDPipeReg (
		.instr_add_4      (instr_add_4     ), //input[31:0]
		.IFIDinstr_add_4  (IFIDinstr_add_4 ), //output[31:0]
		.instr            (instr           ), //input[31:0]
		.IFIDinstr        (IFIDinstr       ), //output[31:0]
		.ifFlush          (ifFlush         ), //input
		.stall            (stall           ), //input
		.clk              (clk             )); //input
	
	wire [1:0] aluopID;
	
	//Control Unit
	controlunit controlunit (
		.regdest   (regdestID  ), //output
		.jump      (jumpID     ), //output
		.branch    (branchID   ), //output
		.memread   (mem_readID  ), //output
		.memtoreg  (memtoregID ), //output
		.memwrite  (MemWriteHazard ), //output
		.alusrc    (alusrcID   ), //output
		.regwrite  (RegWriteHazard ), //output
		.aluop     (aluopID    ), //output [1:0]
		.opcode    (IFIDinstr[31:26]   )); //internal input [5:0]

	
	/*
	 
 
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
		output [31:0] signExtended
		);
	 */
	 
	wire [31:0] readData1ID;
	wire [31:0] readData2ID;
	wire [31:0] signExtended;
	wire [4:0] writeReg;
	wire [31:0] writeData;
	
	InstructionDecode InstructionDecode (
		.IFIDinstr        (IFIDinstr       ), //input [31:0] from IFID_instr
		.IFIDinstr_add_4  (IFIDinstr_add_4 ), //input [31:0] from IFID+4
		.aluAddresult     (aluAddresult    ), //input from instructionfetch
		.writeReg         (writeReg        ), //input wire [4:0] writeReg from MEMWB ??? check me; 
		.writeData        (writeData       ), //internal input [31:0] writeData from MEMWB; 
		.regWrite         (regWrite        ), //internal input wire regWrite;
		.clk              (clk             ), //external input clk
		.readData1        (readData1ID       ), //external [31:0] output 
		.data_out         (readData2ID        ), //external [31:0] output 
		.ifflush          (ifFlush         ), //internal output
		.pcSrc            (pcSrc           ), //internal output
		.signExtended     (signExtended    ),
		.jump 			  (jump)			,
		.aluAddB		  (jumpMux1)); //internal [31:0]  output
		
	

		wire [31:0] extendedEX;

		//internal connections 
		wire [31:0] IDEXreadData1, IDEXreadData2, IDEXinstr2, IDEXinstr;
		
		wire [1:0] alu_op;
		
	
	//IDEXPIPELINE
	IDEXPipeReg IDEXPipeReg (
		.regdestID             (regdestID            ), //input
		.jumpID                (jumpID               ), //input
		.branchID              (branchID             ), //input
		.mem_readID            (mem_readID           ), //input
		.memtoregID            (memtoregID           ), //input
		.MemWriteSafe          (MemWriteSafe         ), //input
		.alusrcID              (alusrcID             ), //input
		.RegWriteHazardSafe    (RegWriteSafe  		 ), //input
		.aluopID               (aluopID              ), //output [1:0]
		.regdest               (regdest              ), //output
		.jumpEX                (jumpEX               ), //output
		.branchEX              (branchEX             ), //output
		.mem_readEX            (mem_readEX           ), //output
		.memtoregEX            (memtoregEX           ), //output
		//hazard unit uses this
		.MemWriteSafeEX        (mem_writeEX       ), //output
		.alusrc                (alusrc               ), //output
		.RegWriteHazardSafeEX  (RegWriteEx		 ), ////output
		.aluop                 (alu_op                ), //output [1:0]
		.readData1ID           (readData1ID          ), //input [4:0]
		.readData2ID           (readData2ID          ), //input [4:0]
		.readData1EX           (IDEXreadData1          ), //output [4:0]
		.readData2EX           (IDEXreadData2          ), //output [4:0]
		.extendedID            (signExtended           ), //input [31:0]
		.extendedEX            (extendedEX           ), //output [31:0]
		.IDinstrRt2016         (IFIDinstr[20:16]        ), 
		.IDinstrRs2521         (IFIDinstr[25:21]        ), 
		.IDinstrRd2015         (IFIDinstr[20:16]        ), 
		.IDEXinstrRt2016       (IDEXinstr[20:16]      ), 
		.IDEXinstrRs2521       (IDEXinstr[25:21]      ), 
		.IDEXinstrRd2015       (IDEXinstr[20:16]      ), 
		.IFIDinstr			   (IFIDinstr			  ), //input [31:0] 
		.IDEXinstr				(IDEXinstr2			  ), //output [31:0]
		.clk                   (clk                  )); //external input 
	
		wire [31:0] EXMEMreadData1, EXMEMreadData2,
			MEMWBreadData1, MEMWBreadData2, IDEXsignExtended;	
		
		wire [31:0] data_addrEX;
	
	
		wire [1:0] fwdA, fwdB;
		wire [4:0] writeRegEX;
		wire [31:0] writeDataEX;
		wire [31:0] readData1MEM, readData2MEM;
		wire [31:0] readData1WB, readData2WB;
		
		execute execute (
			.alu_op            (alu_op           ), // input [1:0] alu_op from control signal pipeline
			.data_addrEXMEM    (data_addrEX   ), // internal output [31:0] 
			.IDEXreadData1     (IDEXreadData1    ), // internal input [31:0]
			.IDEXreadData2     (IDEXreadData2    ), // internal input [31:0]
			//fix these
			.EXMEMreadData1    (readData1MEM   ), // internal input [31:0] 
			.EXMEMreadData2    (readData2MEM   ), // internal input [31:0]
			.MEMWBreadData1    (readData1WB   ), // internal input [31:0]
			.MEMWBreadData2    (readData2WB   ), // internal input [31:0]
			//end fix
			.IDEXsignExtended  (extendedEX  ), // internal input [31:0]
			.IDEXinstr         (IDEXinstr2        ), // internal input [31:0]
			.alu_src           (alusrc          ), // fwd'd control unit
			.fwdA              (fwdA             ), // internal input [1:0]
			.fwdB              (fwdB             ), // internal input [1:0]
			.regdest           (regdest          ), // forwarded by control unit
			.writeReg          (writeRegEX       ), // output [5:0] writeReg
			.fwdBMux		   (writeDataEX		));	//output [31:0] goes to write data 
		
		
		//outputs to EXMEM
		
		//writeRegEX 5:0 
		//data_addrEX [31:0]
		//writeDataEX [31:0]
		
		//EXMEM PIPE
		//OUTPUTS TO DATA MEMORY
		
		//signals used in exmem
		// branch, memread, memwrite
		
		//signals forwared regwrite, memtoreg
		/*
		 * module EXMEMPipeReg(
		input [5:0] writeRegEX,
		input [31:0] data_addrEX,
		input [31:0] writeDataEX,
		//signals used
		input jumpEX, branchEX, mem_readEX, memwrite,
		//signals forwarded
		input RegWriteEx, memtoregEX,
		output reg [5:0] writeRegMEM,
		output reg [31:0] data_addr,
		output reg [31:0] writeData,
		//signals used
		output reg jump, branch, mem_read, mem_write,
		//signals forwarded
		output reg RegWriteMem, memtoregMEM,
		input clk);
		 */
		
		wire [4:0] writeRegMEM;

		
		
		
		EXMEMPipeReg EXMEMPipeReg (
			.writeRegEX   (writeRegEX  ), //input [5:0]
			.data_addrEX  (data_addrEX ), //input [31:0]
			.writeDataEX  (writeDataEX ), // input [31:0]
			.jumpEX       (jumpEX      ), //input
			.branchEX     (branchEX    ), //input
			.mem_readEX   (mem_readEX  ), //input
			.memwrite     (mem_writeEX    ), //input
			.RegWriteEx   (RegWriteEx  ), //input
			.memtoregEX   (memtoregEX  ),  //input
			.writeRegMEM  (writeRegMEM ), //output [5:0]
			.data_addr    (data_addr   ), // output external [31:0]
			.writeData    (data_out   ), // output external [31:0]
			.jump         (        ), //outputs
			.branch       (branch      ), 
			.mem_read     (mem_read    ), 
			.mem_write    (mem_write   ), 
			.RegWriteMem  (RegWriteMem ), //outputs
			.memtoregMEM  (memtoregMEM ), 
			.readData1EX (IDEXreadData1), //input [31:0]
			.readData2EX (IDEXreadData2), //input[31:0] 
			.readData1MEM(readData1MEM), //output [31:0]
			.readData2MEM(readData2MEM), //output [31:0]
			.clk          (clk         )); //input external
		
		
		//memory is in seperate file
		
		//MEMWB pipeline
		
	
	//MEMWBPIPE
		/*
		//input
		read_data
		data_addr
		writeRegMEM
		
		//output 
		regwrite
		memtoreg
		*/
		
	wire [31:0] read_dataIF, data_addrIF;
	
	/* module MEMWBPipeReg(
	input [31:0] read_data,
	input [31:0] data_addr,
	input [5:0] writeRegMem,
	input regWriteMem,
	input memtoregMem,
	output reg [31:0] read_dataIF,
	output reg [31:0] data_addrIF,
	output reg [4:0] writeRegMemIF,
	output reg regWrite,
	output reg memtoreg,
	input clk);
	 */
		
	MEMWBPipeReg MEMWBPipeReg (
		.read_data      (data_in     ), //external input [31:0]
		.data_addr      (data_addr     ), //internal input [31:0] 
		.writeRegMem    (writeRegMEM   ), //internal input [5:0]
		.regWriteMem    (RegWriteMem  ), //input internal [4:0]
		.memtoregMem    (memtoregMEM   ), //input 
		.read_dataIF    (read_dataIF   ), //output [31:0]
		.data_addrIF    (data_addrIF   ), //output [31:0]
		.writeRegMemIF  (writeReg ), //output [4:0]
		.regWrite       (regWrite      ),  //output 
		.memtoreg       (memtoreg      ), //output 
		.readData1MEM(readData1MEM), //input [31:0]
		.readData2MEM(readData2MEM), //input [31:0]
		.readData1WB(readData1WB),  //output [31:0]
		.readData2WB(readData2WB), //output [31:0] 
		.holdRegWrite ( holdRegWrite    ),
		.clk            (clk           )); //external input 
		
		
		
		
	mux32_2_1 mux32_2_1data (
		.s    (memtoreg   ), // input
		.in0  (data_addrIF ),  // input [31:0]
		.in1  (read_dataIF ), 	 // input [31:0]
		.out  (writeData )); // output [31:0]
	
	//Hazard Detector 
	/* module HazardDetector(
		input [4:0] IDEXinstrRt2016,
		input [4:0] IFIDinstrRs2521,
		input [4:0] IFIDinstrRt2016,
		input IDEXMemRead,
		output reg stall,
		input RegWrite,
		input MemWrite,
		output reg RegWriteSafe,
		output reg MemWriteSafe);
	*/
	
	HazardDetector HazardDetector (
		.IDEXinstrRt2016  (IDEXinstr[20:16] ),  //input [4:0] 
		.IFIDinstrRs2521  (IFIDinstr[25:21] ),   //input [4:0] 
		.IFIDinstrRt2016  (IFIDinstr[20:16] ),  //input [4:0] 
		.IDEXMemRead      (mem_readEX     ),   //input 
		.stall            (stall           ), //output 
		.RegWrite         (RegWriteHazard        ), // input
		.MemWrite         (MemWriteHazard        ),   // input
		.RegWriteSafe     (RegWriteSafe    ),   //output
		.MemWriteSafe     (MemWriteSafe    )); //output 
	
	/*
	 * module ForwardingUnit(
		input [4:0] IDEXinstrRt2016,
		input [4:0] IDEXinstrRs2521,
		input EXMEMRegWrite,
		input [4:0] EXMEMRegRd1511,
		input MEMWBRegWrite,
		input [4:0] MEMWBRegRd1511,
		output reg [1:0] fwdA,
		output reg [1:0] fwdB
		);
	 */
	
	ForwardingUnit ForwardingUnit (
		.IDEXinstrRt2016  (IDEXinstr[20:16] ), //input [4:0] 
		.IDEXinstrRs2521  (IDEXinstr[25:21] ), //input [4:0]  
		.EXMEMRegWrite    (RegWriteMem   ),  //input 
		.EXMEMRegRd1511   (writeRegMEM  ),   //input [4:0] 
		.MEMWBRegWrite    (holdRegWrite   ),    //input 
		.MEMWBRegRd1511   (writeReg  ),   //input 
		.fwdA             (fwdA            ), //output [1:0]
		.fwdB             (fwdB            )); //output [1:0]

endmodule


