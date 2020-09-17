`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       	Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//
// Create Date:   13:47:21 10/03/2016
// Module Name:   I_FETCH
// Project Name:  MIPS 
// Description:   MIPS FETCH stage implementation in verilog.
//
// Dependencies:  MUX.v, PC.v, INSTR_MEM.v, INCR.v, IF_ID.v
//
////////////////////////////////////////////////////////////////////////////////

module I_FETCH(
    input clk,
    input enable,
    input enable_wr,
    input PCSrc,
    input rst,
    input stall,
    input wire [31:0] EX_MEM_NPC, 
    input wire [31:0] addr_wire, 
    input wire [31:0] instr_wire,
    output wire [31:0] IF_ID_IR, 
    output wire [31:0] IF_ID_NPC,
    output wire [31:0] IF_ID_rs,
    output wire [31:0] IF_ID_rt
    );
   
	// Declare signal wires.
	wire [31:0] data_wire;
	wire [31:0] mux_npc_wire;
	wire [31:0] npc_wire;
    wire [31:0] pc_wire;
	wire halt_wire;
	
	// Instantiate modules.
	MUX mux(
	   .a(EX_MEM_NPC),
	   .b(npc_wire),
	   .sel(PCSrc),
	   .y(mux_npc_wire));
	
	PC pc(
	   .clk(clk),
	   .halt(halt_wire),
	   .rst(rst),
	   .enable(enable),
	   .stall(stall),
	   .npc(mux_npc_wire),
	   .PC(pc_wire));
	
	INSTR_MEM mem(
	   .addr(pc_wire),
	   .saveaddr(addr_wire),
	   .enable(enable),
	   .instr(instr_wire),
	   .clk(clk),
	   .rst(rst),
	   .enable_wr(enable_wr),
	   .halt(halt_wire),
	   .data(data_wire));
	
	INCR incr(
	   .pcin(pc_wire), 
	   .pcout(npc_wire));
	
	IF_ID if_id(
	   .clk(clk),
	   .rst(rst),
	   .stall(stall),
	   .enable(enable),
	   .npc(npc_wire),
	   .instr(data_wire),
	   .instrout(IF_ID_IR),
	   .npcout(IF_ID_NPC),
	   .rs(IF_ID_rs),
	   .rt(IF_ID_rt));
endmodule
