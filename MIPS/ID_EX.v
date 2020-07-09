`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   11:46:02 10/17/2016
// Module Name:   ID_EX
// Project Name:  MIPS 
// Description:   ID/EX module for the DECODE stage.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module ID_EX(
	input clk, 
	input [1:0]       ctlwb_out, 
	input [2:0]       ctlm_out, 
	input [3:0]       ctlex_out, 
	input [31:0]      npc, readdat1, readdat2, signext_out, 
	input [4:0]       instr_2016, instr_1511, 
	output reg [1:0]  wb_ctlout,
	output reg [2:0]  m_ctlout,
	output reg [3:0]  ex_ctlout,
	output reg [31:0] npcout, rdata1out, rdata2out, s_extendout,
	output reg [4:0]  instrout_2016, instrout_1511,
	
	// Forwarding
	// ---------------------------
	input      [4:0]  instr_2521,
	output reg [4:0]  instrout_2521
	// ---------------------------
	);
	
	// Inititalize
	initial
		begin
			wb_ctlout     <= 0;
			m_ctlout      <= 0;
			ex_ctlout     <= 0;
			npcout        <= 0;
			rdata1out     <= 0;
			rdata2out     <= 0;
			s_extendout   <= 0;
			instrout_2016 <= 0;
			instrout_1511 <= 0;
			// Forwarding
			instrout_2521 <= 0;
		end
		
	// Update
	always @ (posedge clk)
		begin
			wb_ctlout     <= ctlwb_out;
			m_ctlout      <= ctlm_out;
			ex_ctlout     <= ctlex_out;
			npcout        <= npc;
			rdata1out     <= readdat1;
			rdata2out     <= readdat2;
			s_extendout   <= signext_out;
			instrout_2016 <= instr_2016;
			instrout_1511 <= instr_1511;
			// Forwarding
			instrout_2521 <= instr_2521;
		end
endmodule
