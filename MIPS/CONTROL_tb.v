`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   11:22:00 10/17/2016
// Module Name:   CONTROL_tb
// Project Name:  MIPS 
// Description:   Testing control module of the DECODE stage.
//
// Dependencies:  CONTROL.v
//
////////////////////////////////////////////////////////////////////////////////

module CONTROL_tb;
	// Inputs
	reg [5:0] opcode;

	// Outputs
	wire [1:0] WB;
	wire [2:0] M;
	wire [3:0] EX;

	// Instantiate the CONTROL module
	CONTROL ctrl(.opcode(opcode), .WB(WB), .M(M), .EX(EX));

	initial begin
		// Initialize Inputs
		opcode = 6'b000000;

		#20;
		opcode = 6'b100011;		
		#20;		
		opcode = 6'b101011;
		#20;	
		opcode = 6'b000100;
		#20;
		$finish;
	end    
	
   initial begin
		$monitor("opcode = %b\tWB = %b\tM = %b\tEX = %b", opcode, WB, M, EX);
	end 
endmodule

