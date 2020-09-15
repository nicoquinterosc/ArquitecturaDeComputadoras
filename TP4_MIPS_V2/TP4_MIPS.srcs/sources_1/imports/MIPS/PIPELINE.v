`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   11:10:00 10/17/2016
// Module Name:   PIPELINE
// Project Name:  MIPS 
// Description:   MIPS pipeline.
//
// Dependencies:  I_FETCH.v, I_DECODE.v, I_EXECUTE.v, MEM.v, WB.v
//
////////////////////////////////////////////////////////////////////////////////

// ssign salida = | wb_data_wire
// rst

module PIPELINE(input clk,
                input rst,
                input enable_wr,
                input btn,
                input on,
                input [31:0] addr_bus,
                input [31:0] instr_bus,
                output [15:0] LED);
	// I_FETCH output wires.
	wire [31:0] IF_ID_IR;
	wire [31:0] IF_ID_NPC;
	
	// I_DECODE output wires.
	wire [1:0]  ID_EX_WB_wire;
	wire [2:0]  ID_EX_M_wire;
	wire [3:0]  ID_EX_EX_wire;
	wire [31:0] ID_EX_NPC_wire;
	wire [31:0] ID_EX_rdata1out_wire;
	wire [31:0] ID_EX_rdata2out_wire;
	wire [31:0] ID_EX_IR_wire;
	wire [4:0]  ID_EX_instrout_2016_wire;
	wire [4:0]  ID_EX_instrout_1511_wire;
	wire        ID_EX_halt_wire;
	// Forwarding
	wire [4:0]  ID_EX_instrout_2521_wire;
	
	// I_EXECUTE output wires.
	wire [1:0]  EX_MEM_wb_ctlout_wire;
	wire [2:0]  EX_MEM_m_ctlout_wire;
	wire [31:0] EX_MEM_add_result_wire;
	wire        EX_MEM_zero_wire;
	wire [31:0] EX_MEM_alu_result_wire;
	wire [31:0] EX_MEM_rdata2out_wire;
	wire [4:0]  EX_MEM_five_bit_muxout_wire;
		
	// MEM output wires.
	wire        PCSrc_wire;
	wire [4:0]  mem_Write_reg_wire;
	wire [1:0]  mem_control_wb_wire;
	wire [31:0] Read_data_wire;
	wire [31:0] mem_ALU_result_wire;
	
	// WB output wires.
	wire [31:0] wb_data_wire;
	
	// Forwarding Unit wires.
	wire [1:0]  forward_a_sel_wire;
	wire [1:0]  forward_b_sel_wire;
	
	// Debug Unit wires
	wire enable_wire;
	
	I_FETCH FETCH(
	   .clk(clk),
	   .rst(rst),
	   .enable(enable_wire),
	   .PCSrc(PCSrc_wire), 
	   .enable_wr(enable_wr),
	   .EX_MEM_NPC(EX_MEM_add_result_wire),
	   .addr_wire(addr_bus),
	   .instr_wire(instr_bus),
	   .IF_ID_IR(IF_ID_IR),
	   .IF_ID_NPC(IF_ID_NPC));
//	I_FETCH FETCH(
//		// Inputs
//		.clk(clk),
//		.rst(rst),
//		.PCSrc(PCSrc_wire),
//		.EX_MEM_NPC(EX_MEM_add_result_wire), 
//		// Outputs
//		.IF_ID_IR(IF_ID_IR),
//		.IF_ID_NPC(IF_ID_NPC));
    
	I_DECODE DECODE(
		// Inputs
		.clk(clk),
        .rst(rst), 
        .enable(enable_wire),
		.RegWrite(mem_control_wb_wire[1]), 
		.IF_ID_Instr(IF_ID_IR), 
		.IF_ID_NPC(IF_ID_NPC), 
		.MEM_WB_Writereg(mem_Write_reg_wire), 
		.MEM_WB_Writedata(wb_data_wire), 
		// Outputs
		.WB(ID_EX_WB_wire), 
		.M(ID_EX_M_wire), 
		.EX(ID_EX_EX_wire), 
		.NPC(ID_EX_NPC_wire), 
		.rdata1out(ID_EX_rdata1out_wire), 
		.rdata2out(ID_EX_rdata2out_wire), 
		.IR(ID_EX_IR_wire), 
		.instrout_2016(ID_EX_instrout_2016_wire), 
		.instrout_1511(ID_EX_instrout_1511_wire),
		// Forwarding
		.instrout_2521(ID_EX_instrout_2521_wire));
		
	I_EXECUTE EXECUTE(
		// Inputs
		.clk(clk), 
		.rst(rst),
		.enable(enable_wire),
		.WB(ID_EX_WB_wire), 
		.M(ID_EX_M_wire), 
		.EX(ID_EX_EX_wire), 
		.NPC(ID_EX_NPC_wire), 
		.rdata1in(ID_EX_rdata1out_wire), 
		.rdata2in(ID_EX_rdata2out_wire), 
		.IR(ID_EX_IR_wire), 
		.instrout_2016(ID_EX_instrout_2016_wire), 
		.instrout_1511(ID_EX_instrout_1511_wire), 
		// Outputs
		.wb_ctlout(EX_MEM_wb_ctlout_wire), 
		.m_ctlout(EX_MEM_m_ctlout_wire), 
		.add_result(EX_MEM_add_result_wire), 
		.zero(EX_MEM_zero_wire), 
		.alu_result(EX_MEM_alu_result_wire), 
		.rdata2out(EX_MEM_rdata2out_wire),
		.five_bit_muxout(EX_MEM_five_bit_muxout_wire),
		// Forwarding
		.forward_a_sel(forward_a_sel_wire), 
		.forward_b_sel(forward_b_sel_wire), 
		.wb_data(wb_data_wire), 
		.mem_alu_result(EX_MEM_alu_result_wire)
		);
		
	MEM MEMORY(
		// Inputs
		.clk(clk),
		.rst(rst),
		.enable(enable_wire),
		.m_ctlout(EX_MEM_m_ctlout_wire[2]), 
		.zero(EX_MEM_zero_wire), 
		.MemWrite(EX_MEM_m_ctlout_wire[0]), 
		.MemRead(EX_MEM_m_ctlout_wire[1]),
		.Write_data(EX_MEM_rdata2out_wire), 
		.control_wb_in(EX_MEM_wb_ctlout_wire), 
		.ALU_result_in(EX_MEM_alu_result_wire), 
		.Write_reg_in(EX_MEM_five_bit_muxout_wire),
		// Outputs
		.PCSrc(PCSrc_wire),
		.mem_control_wb(mem_control_wb_wire), 
		.Read_data(Read_data_wire),
		.mem_ALU_result(mem_ALU_result_wire), 
		.mem_Write_reg(mem_Write_reg_wire));
	
	WB WRITEBACK(
//          Inputs
		.MemtoReg(mem_control_wb_wire[0]), 
		.ReadData(Read_data_wire), 
		.ALUResult(mem_ALU_result_wire), 
//		 Outputs	
		.WriteData(wb_data_wire));
		
	// Forwarding
	FORWARDING_UNIT FU(
		// Inputs
		.rs(ID_EX_instrout_2521_wire), 
		.rt(ID_EX_instrout_2016_wire), 
		.five_bit_mux_out(EX_MEM_five_bit_muxout_wire), 
		.ex_mem_wb(EX_MEM_wb_ctlout_wire), 
		.mem_Write_reg(mem_Write_reg_wire), 
		.mem_wb_wb(mem_control_wb_wire), 
		// Outputs
		.forward_a_sel(forward_a_sel_wire), 
		.forward_b_sel(forward_b_sel_wire));
	
	DEBUG_UNIT DU(
	   .clk(clk),
	   .rst(rst),
	   .btn(btn),
	   .on(on),
	   .enable(enable_wire));
	   
    assign LED = wb_data_wire [15:0];
//    assign fas = forward_a_sel_wire;
endmodule
