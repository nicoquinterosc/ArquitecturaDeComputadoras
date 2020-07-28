`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   14:20:00 10/31/2016
// Module Name:   MEM
// Project Name:  MIPS
// Description:   The MIPS MEMORY (MEM) pipeline stage.
//
// Dependencies:  D_MEM.v, MEM_WB, AND_Gate.v
//
////////////////////////////////////////////////////////////////////////////////

module MEM(
	input         clk, 
	input         m_ctlout,
	input         zero,
	input         MemWrite, 
	input         MemRead, 
	input  [31:0] Write_data,
	input  [1:0]  control_wb_in,
	input  [31:0] ALU_result_in,
	input  [4:0]  Write_reg_in,
	output        PCSrc,
	output [1:0]  mem_control_wb,
	output [31:0] Read_data,
	output [31:0] mem_ALU_result,
	output [4:0]  mem_Write_reg);
	
	// Wires.
	wire [31:0] Read_data_wire;
	
	// Instantiate modules.
	D_MEM d_mem(.clk(clk), .MemWrite(MemWrite), .MemRead(MemRead), 
		.Address(ALU_result_in), .Write_data(Write_data), .Read_data(Read_data_wire));
		
	MEM_WB mem_wb(.clk(clk), .control_wb_in(control_wb_in), .Read_data_in(Read_data_wire), 
		.ALU_result_in(ALU_result_in), .Write_reg_in(Write_reg_in), 
		.mem_control_wb(mem_control_wb), .Read_data(Read_data), 
		.mem_ALU_result(mem_ALU_result), .mem_Write_reg(mem_Write_reg));
		
	AND_Gate and_gate(.m_ctlout(m_ctlout), .zero(zero), .PCSrc(PCSrc));

endmodule
