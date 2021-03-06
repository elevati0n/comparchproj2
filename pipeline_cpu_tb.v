/****************************************************************************
 * cpu_tb.v
 ****************************************************************************/

/**
 * Module: cpu_tb
 * 
 * TODO: Add module documentation
 */
 
`timescale 1 ns /100 ps 


module pipeline_cpu_tb;

	reg clk, reset;
	/*
	 * The memory module has a set of 7 ports, the input ports are
	inst_addr (instruction memory read address), data_addr (data memory read/write address), mem_write
	(data memory write enable), mem_read (data memory read enable), data_in (data memory write value)
	and the output ports are instr (instruction memory read-out), data_out (data memory read-out).
	 */
	
	  
	wire [31:0] inst_addr, instr, data_addr, data_out_mem, data_out_processor;
	wire mem_read, mem_write;
	
	Memory memory(
			.inst_addr  (inst_addr ), // input   	[4*8:1]
			.instr      (instr     ), // output  	[31:0]  
			.data_addr  (data_addr ), // input   	[4*8:1] 
			.data_in    (data_out_processor   ), // input  	[31:0]
			.mem_read   (mem_read  ), // input	
			.mem_write  (mem_write ), // input
			.data_out   (data_out_mem  ));// output 	[31:0]
	
 pipelineProcessor processor (
		.clk        (clk       ), // input
		.reset      (reset     ), // input
		.inst_addr  (inst_addr ), // output [31:0]
		.instr      (instr     ), // input [31:0]
		.data_addr  (data_addr ), // output [31:0]
		.data_out    (data_out_processor), //output [31:0] 
		.mem_read   (mem_read  ), // output
		.mem_write  (mem_write ), // output
		.data_in   (data_out_mem )); // input [31:0] 
	

	initial begin
		clk = 0;
		reset = 1;
		#3 reset = 1;
		#12 reset = 0; 
	end
	
	
	
	always 
		#10 clk =~clk;
		
endmodule


