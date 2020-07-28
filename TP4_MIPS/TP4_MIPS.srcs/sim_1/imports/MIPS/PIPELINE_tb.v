`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   10:31:00 10/31/2016
// Module Name:   PIPELINE
// Project Name:  MIPS 
// Description:   Testing MIPS pipeline.
//
// Dependencies:  PIPELINE.v
//
////////////////////////////////////////////////////////////////////////////////

module PIPELINE_tb;
	// Inputs
	reg clk;


	// Instantiate the Unit Under Test (UUT)
	PIPELINE pipeline(.clk(clk));

	initial begin
		// Initialize Inputs
		clk = 0;		
		// Wait for initialization
		#100;
		// Perform 24 cycles.
		//#480;
		//$finish;
	end
	
	initial begin
		// Wait for initialization
		#100;
		forever begin
			#10 clk = ~clk;
		end
	end 
endmodule
