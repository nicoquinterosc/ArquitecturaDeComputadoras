`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   15:17:23 10/24/2016
// Module Name:   THREE_ONE_MUX
// Project Name:  MIPS
// Description:   MIPS 3-to-1 32-bit MUX implementation in verilog.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module THREE_ONE_MUX(input [31:0] a, b, c, input [1:0] sel, output reg [31:0] y);
	always @ *
		case (sel)
			00: y <= c;
			01: y <= b;
			10: y <= a;
		endcase
endmodule
