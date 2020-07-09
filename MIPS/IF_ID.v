`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//
// Create Date:   14:31:53 10/03/2016
// Module Name:   IF_ID
// Project Name:  MIPS 
// Description:   MIPS IF_ID register implementation in verilog.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module IF_ID(input clk, input [31:0] npc, instr, output reg [31:0] instrout, npcout);
	// Initialize.
	initial begin
		instrout <= 0;
		npcout <= 0;
	end

	// Update.
	always @ (posedge clk)
		begin
			npcout <= npc;
			instrout <= instr;
		end
endmodule
