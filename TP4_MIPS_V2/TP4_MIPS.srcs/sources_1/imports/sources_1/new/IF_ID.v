`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//
// Create Date:   14:31:53 10/03/2016
// Module Name:   IF_ID
// Project Name:  MIPS 
// Description:   MIPS IF_ID register implementation in verilog.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module IF_ID(input clk,
             input rst,
             input enable,
             input [31:0] npc,
             input [31:0] instr,
             output reg [31:0] instrout,
             output reg [31:0] npcout);
	// Initialize.
	initial begin
		instrout <= 0;
		npcout <= 0;
	end

	// Update.
	always @ (posedge clk)
        if(rst)
            begin
                npcout <= 0;
                instrout <= 0;
			end
        else if (enable==1)
        begin
            npcout <= npc;
			instrout <= instr;
		end
endmodule
