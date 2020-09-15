`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:	Gerardo Collante
//
// Create Date:   13:24:33 10/03/2016
// Module Name:   MUX
// Project Name:  MIPS
// Description:   MIPS 2-to-1 32-bit MUX implementation in verilog.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module MUX(input [31:0] a,
           input [31:0] b, 
           input sel, 
           output [31:0] y);
	// If y = 1, select a; otherwise, select b.
	assign y = sel ? a : b;
endmodule