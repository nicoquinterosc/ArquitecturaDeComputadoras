`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//
// Create Date:   13:42:26 10/03/2016
// Module Name:   PC
// Project Name:  MIPS 
// Description:   MIPS PC implementation in verilog.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module PC(input clk, input [31:0] npc, output reg [31:0] PC);
	// Set PC initially to 0.
	initial begin
		PC <= 0;
	end

	// Update PC with the new PC value.
	always @ (posedge clk)
	begin
		PC <= npc;
	end
endmodule
