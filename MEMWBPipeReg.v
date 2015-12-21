/****************************************************************************
 * MEMWBPipeReg.v
 ****************************************************************************/

/**
 * Module: MEMWBPipeReg
 * 
 * TODO: Add module documentation
 */
module MEMWBPipeReg(
	input [31:0] read_data,
	input [31:0] data_addr,
	input [4:0] writeRegMem,
	input regWriteMem,
	input memtoregMem,
	output reg [31:0] read_dataIF,
	output reg [31:0] data_addrIF,
	output reg [4:0] writeRegMemIF,
	output reg regWrite,
	output reg memtoreg,
	input [31:0]  readData1MEM, //input [31:0]
	input  [31:0] readData2MEM, //input [31:0]
	output reg [31:0] readData1WB,  //output [31:0]
	output reg [31:0] readData2WB, //output [31:0] 
	output reg holdRegWrite,
	input clk);
	

	
	always @(posedge clk) begin
		data_addrIF = data_addr;
		memtoreg = memtoregMem;
		readData1WB =  readData1MEM; 
		readData2WB = readData2MEM; 
		//regWrite = regWriteMem;
		writeRegMemIF = writeRegMem;
		holdRegWrite = regWriteMem;
		read_dataIF = read_data;
		regWrite = 0;
		
	  
	end
	
	always @(negedge clk) begin
	  regWrite = holdRegWrite;

	 end
	
endmodule


