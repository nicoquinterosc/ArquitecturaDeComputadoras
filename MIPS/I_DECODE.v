`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   11:12:18 10/17/2016
// Module Name:   I_DECODE
// Project Name:  MIPS
// Description:   The MIPS ID (DECODE) pipeline stage.
//
// Dependencies:  CONTROL.v, REG.v, S_EXTEND.v, ID_EX.v
//
////////////////////////////////////////////////////////////////////////////////

module I_DECODE(
	input         clk, RegWrite,
	input  [31:0] IF_ID_Instr, IF_ID_NPC, 
	input  [4:0]  MEM_WB_Writereg,
   input  [31:0] MEM_WB_Writedata,
	output [1:0]  WB,
	output [2:0]  M,
	output [3:0]  EX,
	output [31:0] NPC,
	output [31:0] rdata1out,
	output [31:0] rdata2out,
	output [31:0] IR,
	output [4:0]  instrout_2016,
	output [4:0]  instrout_1511,
	
	// Forwarding
	// ---------------------------
	output [4:0]  instrout_2521
	// ---------------------------
	);
	
	// Wires
	wire [1:0]  CTL_WB_wire;
	wire [2:0]  CTL_M_wire;
	wire [3:0]  CTL_EX_wire;
	wire [31:0] REG_A_wire;
	wire [31:0] REG_B_wire; 
	wire [31:0] EXT_OUT_wire;
	
	// Instantiate modules		
	// CONTROL
	CONTROL ctl(.opcode(IF_ID_Instr[31:26]), .WB(CTL_WB_wire), .M(CTL_M_wire), 
		.EX(CTL_EX_wire));	
	// REG
	REG gp_reg(.clk(clk), .regwrite(RegWrite), .rs(IF_ID_Instr[25:21]), 
		.rt(IF_ID_Instr[20:16]), .rd(MEM_WB_Writereg), 
		.writedata(MEM_WB_Writedata), .A(REG_A_wire), .B(REG_B_wire));		
	// S_EXTEND	
	S_EXTEND #(.OUT_SIZE(32), .IN_SIZE(16)) s_ex(.din(IF_ID_Instr[15:0]), 
		.dout(EXT_OUT_wire));	
	// ID_EX
	ID_EX	id_ex(.clk(clk), .ctlwb_out(CTL_WB_wire), .ctlm_out(CTL_M_wire), 
		.ctlex_out(CTL_EX_wire), .npc(IF_ID_NPC), .readdat1(REG_A_wire), 
		.readdat2(REG_B_wire), .signext_out(EXT_OUT_wire), 
		.instr_2016(IF_ID_Instr[20:16]), .instr_1511(IF_ID_Instr[15:11]), 
		.instr_2521(IF_ID_Instr[25:21]),
		.wb_ctlout(WB), .m_ctlout(M),
		.ex_ctlout(EX), .npcout(NPC), .rdata1out(rdata1out), 
		.rdata2out(rdata2out), .s_extendout(IR), .instrout_2016(instrout_2016), 
		.instrout_1511(instrout_1511), .instrout_2521(instrout_2521));
endmodule
