`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   15:17:23 10/24/2016
// Module Name:   THREE_ONE_MUX
// Project Name:  MIPS
// Description:   MIPS 3-to-1 32-bit MUX implementation in verilog.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module THREE_ONE_MUX(
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [1:0] sel,
    output reg [31:0] y);
    
	always @ *
		case (sel)
			2'b00: y = c;
			2'b01: y = b;
			2'b10: y = a;
			default: y = 0;
		endcase
endmodule
