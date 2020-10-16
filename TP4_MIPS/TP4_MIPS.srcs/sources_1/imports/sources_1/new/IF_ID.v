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
             input stall,
             input [31:0] npc,
             input [31:0] instr,
             output reg [31:0] rs,
             output reg [31:0] rt,
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
        else if (enable && !stall)
        begin
            npcout <= npc;
			instrout <= instr;
			rs <= instr[25:21];
			rt <= instr[20:16];
		end
endmodule
