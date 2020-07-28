`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   15:24:23 10/24/2016
// Module Name:   ALU
// Project Name:  MIPS
// Description:   MIPS ALU module in the EXECUTE stage.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module ALU(input [31:0] A, B, input [2:0] control, output reg zero, 
	output reg [31:0] result);
	
	always @ *
	begin
		case (control)
			3'b010:
				result <= A + B;
			3'b110:
				result <= A - B;
			3'b000:
				result <= A & B;
			3'b001:
				result <= A | B;
			3'b111:
				result <= (A < B) ? 1 : 0;	
			3'b011:
				result <= 32'bxxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx_xxxx;
		endcase
		zero <= result ? 0 : 1;
	end
endmodule
