`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//
// Create Date:   13:08:46 10/03/2016
// Module Name:   INCR
// Project Name:  MIPS
// Description:   MIPS Incrementer by 1 implementation in verilog.
//
// Dependencies:  None.
//
////////////////////////////////////////////////////////////////////////////////

module INCR(input [31:0] pcin, output [31:0] pcout);
	// Increment the input by one and assign to the output.
	assign pcout = pcin + 1;
endmodule
