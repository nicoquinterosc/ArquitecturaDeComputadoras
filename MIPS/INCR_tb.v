`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//
// Create Date:   13:10:02 10/03/2016
// Module Name:   INCR_tb
// Project Name:  MIPS 
// Description:   Testing MIPS Incrementer by 1 implementation in verilog.
//
// Dependencies:  INCR.v
//
////////////////////////////////////////////////////////////////////////////////

module INCR_tb();
   // Declare inputs.
	reg [31:0] A;
	
	// Declare outputs.
	wire [31:0] IncrOut;
	
	// Instantiate the INCR module.
	INCR incr(.pcin(A), .pcout(IncrOut));
	
	initial begin
		// Initialize inputs.
		A = 0;
		
	   // Send values to be incremented.
		#10
		A = 3;
		#10
		A = 15;
		#10
		A = 64;
		
		// Terminiate.
		#5 $finish;
	end
	
	// Whenever A changes, display information.
	always @ (A)
		#1 $display("Time = %0d\tA=%0d\tIncrout=%0d", $time, A, IncrOut);
endmodule
