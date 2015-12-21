/****************************************************************************
 * EXMEMPipeReg.v
 ****************************************************************************/

/**
 * Module: EXMEMPipeReg
 * 
 * TODO: Add module documentation
 */
module EXMEMPipeReg(
		input [4:0] writeRegEX,
		input [31:0] data_addrEX,
		input [31:0] writeDataEX,
		//signals used
		input jumpEX, branchEX, mem_readEX, memwrite,
		//signals forwarded
		input RegWriteEx, memtoregEX,
		output reg [4:0] writeRegMEM,
		output reg [31:0] data_addr,
		output reg [31:0] writeData,
		//signals used
		output reg jump, branch, mem_read, mem_write,
		//signals forwarded
		output reg RegWriteMem, memtoregMEM,
		input [31:0] readData1EX,
		input [31:0] readData2EX,
		output reg [31:0] readData1MEM,
		output reg [31:0] readData2MEM,
		input clk);
	
	always @(posedge clk) begin
		writeRegMEM	= writeRegEX;
		data_addr = data_addrEX;
		writeData = writeDataEX;
		//signals used
		jump = jumpEX;
		branch = branchEX;
		mem_read = mem_readEX; 
		mem_write = memwrite;
		//signals forwarded
		RegWriteMem = RegWriteEx;
		memtoregMEM = memtoregEX;
		readData1MEM = readData1EX;
		readData2MEM = readData2EX;
	end

endmodule


