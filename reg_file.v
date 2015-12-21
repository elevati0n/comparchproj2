module reg_file(
input [4:0] readReg1, readReg2, writeReg,
input [31:0] writeData,
input regWrite, clk,
output reg [31:0] readData1, readData2
);

reg [31:0] regFile [31:0];

//zero out all registers
integer k;

initial begin 
  for (k = 0; k <= 31; k = k +1) 
    regFile[k] <= 0;
  end

always@(negedge clk) begin
	 readData1 <= regFile[readReg1];
	 readData2 <= regFile[readReg2];
end

always@(regWrite) begin
  if (writeReg == 0) begin 
    regFile[writeReg] = 0;
  end
	else if(regWrite)
		regFile[writeReg] = writeData;
end

endmodule
