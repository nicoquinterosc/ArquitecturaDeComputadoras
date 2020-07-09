`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   11:05:10 10/17/2016
// Module Name:   S_EXTEND_tb
// Project Name:  MIPS
// Description:   Tests bench for the sign extender.
//
// Dependencies:  S_EXTEND.V
//
////////////////////////////////////////////////////////////////////////////////

module S_EXTEND_tb;
   // Local constants
	localparam IN_SIZE = 16;
	localparam OUT_SIZE = 32;
	
	// Inputs
	reg [(IN_SIZE - 1):0] din;
	// Outputs
	wire [(OUT_SIZE - 1):0] dout;

	// Instantiate the S_EXTEND module
	S_EXTEND #(.IN_SIZE(IN_SIZE), .OUT_SIZE(OUT_SIZE)) s_extend (.din(din), .dout(dout));

	initial begin
		// Initialize Inputs
		din = 16'b0000000000000000;

		// Wait 100 ns for global reset to finish
		#100;
		
		din = 16'b1000001100000100;
		#10;
		din = 16'b0011001100000100;
		#10;
		din = 16'b0111001100111101;
		#10;
		din = 16'b1111001100000100;	
	end
	
	initial begin
		$monitor("in = %b\tout = %b", din, dout);
	end      
endmodule

