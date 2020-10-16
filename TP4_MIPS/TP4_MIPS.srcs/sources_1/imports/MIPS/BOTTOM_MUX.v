`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   15:17:23 10/24/2016
// Module Name:   BOTTOM_MUX
// Project Name:  MIPS
// Description:   MIPS 2-to-1 5-bit MUX implementation in verilog.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module BOTTOM_MUX(
    input [4:0] a,
    input [4:0] b,
    input sel,
    output [4:0] y);
	// If y = 1, select a; otherwise, select b.
	assign y = sel ? a : b;
endmodule
