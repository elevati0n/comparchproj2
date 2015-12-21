/****************************************************************************
 * IDEXPipeReg.v
 ****************************************************************************/

/**
 * Module: IDEXPipeReg
 * 
 * TODO: Add module documentation
 */
module IDEXPipeReg( input regdestID,
	input jumpID,
	input branchID,
	input mem_readID,
	input memtoregID,
	input MemWriteSafe,
	input alusrcID,
	input RegWriteHazardSafe,
	input [1:0] aluopID,
	//used in EX stage
	output reg regdest,
	//not used in EX stage
	output reg jumpEX,
	output reg branchEX,
	output reg mem_readEX,
	output reg memtoregEX,
	output reg MemWriteSafeEX,
	//used in EX stage
	output reg alusrc,
	//not used in EX stage
	output reg RegWriteHazardSafeEX,
	//used in EX stage
	output reg [1:0] aluop,
	//end of control signals
	
	input  [31:0] readData1ID,       
	input  [31:0] readData2ID, //external [31:0] output 

	//fix these to give them proper names
	// outputs to memory model
	output reg [31:0] readData1EX,
	output reg  [31:0] readData2EX,
	
	//input signextended extended instruction
	input [31:0] extendedID,
	output reg [31:0] extendedEX,
	
	//the two inputs to the forwarding unit
	input [4:0] IDinstrRt2016,
	input [4:0] IDinstrRs2521,
	input [4:0] IDinstrRd2015,
	
	//output to forwarding unit
	output reg [4:0] IDEXinstrRt2016,
	//input to the hazard dectector AND forwarding unit
	output reg [4:0] IDEXinstrRs2521,
	
	//thru exec to EXMEM reg
	output reg [4:0] IDEXinstrRd2015,
	input [31:0] IFIDinstr, 
	output reg [31:0] IDEXinstr,
	input clk);
	
	
	always @(posedge clk)
		begin 
		//control signals
		regdest	= regdestID;
		jumpEX	= jumpID;
		branchEX	= branchID;
		mem_readEX	= mem_readID;
		memtoregEX	= memtoregID;
		MemWriteSafeEX	= MemWriteSafe;
		alusrc	= alusrcID;
		RegWriteHazardSafeEX	= RegWriteHazardSafe;
		aluop	= aluopID;
		//end control signals 
		//move data
		readData1EX = readData1ID;      
		readData2EX = readData2ID; //external [31:0] output 
		extendedEX =  extendedID;
		IDEXinstrRt2016			= IDinstrRt2016;
		IDEXinstrRs2521			= IDinstrRs2521;
		IDEXinstrRd2015			= IDinstrRd2015;
		IDEXinstr = IFIDinstr;
		
		
	end

	
		
endmodule



