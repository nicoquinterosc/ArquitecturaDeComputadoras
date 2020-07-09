`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   11:35:36 10/17/2016
// Module Name:   REG_tb
// Project Name:  MIPS 
// Description:   Testing the registers module of the DECODE stage.
//
// Dependencies:  REG.v
//
////////////////////////////////////////////////////////////////////////////////

module REG_tb;
	// Inputs
	reg clk;
	reg regwrite;
	reg [4:0] rs;
	reg [4:0] rt;
	reg [4:0] rd;
	reg [31:0] writedata;

	// Outputs
	wire [31:0] A;
	wire [31:0] B;

	// Instantiate the REG module
	REG gp_regs(.clk(clk), .regwrite(regwrite), .rs(rs), .rt(rt), .rd(rd), 
		.writedata(writedata), .A(A), .B(B));

	initial begin
		// Initialize Inputs
		clk = 1;
		regwrite = 0;
		rs = 0;
		rt = 0;
		rd = 0;
		writedata = 0;

		// Wait 100 ns for global reset to finish
		$display("Initializing and waiting for reset...");
		#100;
        
		// Write test data to the first nine locations
		$display("Writing data...");
		regwrite = 1;		
		writedata = 32'h002300AA;
		
		#20;
		rd = rd + 1;
		writedata = 32'h10654321;
		
		#20;
		rd = rd + 1;
		writedata = 32'h00100022;
		
		#20;
		rd = rd + 1;
		writedata = 32'h8C123456;
		
		#20;
		rd = rd + 1;
		writedata = 32'h8F123456;
		
		#20;
		rd = rd + 1;
		writedata = 32'hAD654321;
		
		#20;
		rd = rd + 1;
		writedata = 32'h13012345;
		
		#20;
		rd = rd + 1;
		writedata = 32'hAC654321;
		
		#20;
		rd = rd + 1;
		writedata = 32'h12012345;
		
		// Read test data from the nine test locations.
		// rs will read evens and rt will read odds until the last register,
		// where both will read the ninth register together.
		#20;
		$display("Reading data...");
		regwrite = 0;
		rt = rt + 1;
		
		#20
		rs = rs + 2;
		rt = rt + 2;
		
		#20
		rs = rs + 2;
		rt = rt + 2;
		
		#20
		rs = rs + 2;
		rt = rt + 2;
		
		#20
		rs = rs + 2;
		rt = rt + 1;
		
      #20 $finish;
	end
	
	initial begin
		$monitor("rs = %b\trt = %b\tregwrite = %b\trd = %b\twritedata = %h\tA = %h\tB = %h", 
			rs, rt, regwrite, rd, writedata, A, B);
		forever begin
			#10 clk = ~clk;
		end
	end
      
endmodule

