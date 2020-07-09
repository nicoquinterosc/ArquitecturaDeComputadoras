`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   14:58:00 10/24/2016
// Module Name:   I_EXECUTE
// Project Name:  MIPS
// Description:   The MIPS EXECUTE (EX) pipeline stage.
//
// Dependencies:  ADDER.v, ALU_MUX.v, ALU.v, BOTTOM_MUX.v, EX_MEM.v
//
////////////////////////////////////////////////////////////////////////////////

module I_EXECUTE(
	input         clk, 
   input  [1:0]  WB,
	input  [2:0]  M,
	input  [3:0]  EX,
	input  [31:0] NPC,
	input  [31:0] rdata1in,
	input  [31:0] rdata2in,
	input  [31:0] IR,
	input  [4:0]  instrout_2016,
	input  [4:0]  instrout_1511,	
	
	// Forwarding
	// ---------------------------
	input  [1:0]  forward_a_sel,
	input  [1:0]  forward_b_sel,
	input  [31:0] wb_data,
	input  [31:0] mem_alu_result,
	// ---------------------------
	
	output [1:0]  wb_ctlout,
	output [2:0]  m_ctlout,
	output [31:0] add_result,
	output        zero,
	output [31:0] alu_result,
	output [31:0] rdata2out,
	output [4:0]  five_bit_muxout);
	
	// Wires.				  
	wire [31:0] add_out_wire;
	wire [31:0] alu_mux_out_wire;
	wire [2:0]  alu_control_out_wire;
	wire        alu_zero_wire;
	wire [31:0] alu_result_wire;
	wire [4:0]  bottom_mux_out_wire;
	wire [31:0] forward_mux_b_out_wire;
	wire [31:0] forward_mux_a_out_wire;
		
	// Instantiate modules.
	ADDER adder(
		.add_in1(NPC), 
		.add_in2(IR), 
		.add_out(add_out_wire));	
	
	ALU_MUX alu_mux(
		.a(IR), 
		.b(forward_mux_b_out_wire), 
		.sel(EX[0]), 
		.y(alu_mux_out_wire));
	
	ALU alu(
		.A(forward_mux_a_out_wire), 
		.B(alu_mux_out_wire), 
		.control(alu_control_out_wire), 
		.zero(alu_zero_wire), 
		.result(alu_result_wire));	
		
	ALU_CONTROL alu_control(
		.funct(IR[5:0]), 
		.alu_op(EX[2:1]), 
		.select(alu_control_out_wire));	
		
	BOTTOM_MUX bottom_mux(
		.a(instrout_1511), 
		.b(instrout_2016), 
		.sel(EX[3]), 
		.y(bottom_mux_out_wire));			
		
	EX_MEM ex_mem(
		.clk(clk), 
		.ctlwb_out(WB), 
		.ctlm_out(M), 
		.adder_out(add_out_wire), 
		.aluzero(alu_zero_wire), 
		.aluout(alu_result_wire), 
		.readdat2(forward_mux_b_out_wire), 
		.muxout(bottom_mux_out_wire), 
		.wb_ctlout(wb_ctlout), 
		.m_ctlout(m_ctlout), 
		.add_result(add_result), 
		.zero(zero), 
		.alu_result(alu_result), 
		.rdata2out(rdata2out), 
		.five_bit_muxout(five_bit_muxout));
	
	THREE_ONE_MUX FORWARD_MUX_A(
		.a(mem_alu_result), 
		.b(wb_data), 
		.c(rdata1in), 
		.sel(forward_a_sel), 
		.y(forward_mux_a_out_wire));
	
	THREE_ONE_MUX FORWARD_MUX_B(
		.a(mem_alu_result), 
		.b(wb_data), 
		.c(rdata2in), 
		.sel(forward_b_sel), 
		.y(forward_mux_b_out_wire));
endmodule
