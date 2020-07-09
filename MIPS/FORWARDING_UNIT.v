`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   10:22:00 11/21/2016
// Module Name:   FORWARDING_UNIT
// Project Name:  MIPS 
// Description:   Forwarding Unit implementation in the MIPS pipeline.
//
// Dependencies:  None.
//
////////////////////////////////////////////////////////////////////////////////

module FORWARDING_UNIT(
	// Inputs from the ID/EX latch.
	input  [4:0] rs, 
	input  [4:0] rt, 
	// Inputs from the EX/MEM latch.
	input  [4:0] five_bit_mux_out, 
	input  [1:0] ex_mem_wb, 
	input  [4:0] mem_Write_reg,
	// Input form the MEM/WB latch.
	input  [1:0] mem_wb_wb, 
	// Outputs to the EX stage.
	output reg [1:0] forward_a_sel,
	output reg [1:0] forward_b_sel);

	
	always @ * begin
		forward_a_sel <= 2'b00;
		forward_b_sel <= 2'b00;
		
		// EX Hazard
		if (ex_mem_wb[1] && 
		    (five_bit_mux_out != 0) && (five_bit_mux_out == rs)) 
			begin
				forward_a_sel <= 2'b10;
			end
		 
		if (ex_mem_wb[1] && 
		    (five_bit_mux_out != 0) && (five_bit_mux_out == rt)) 
			begin
				forward_b_sel <= 2'b10;
			end
	
		// MEM Hazard
		if (mem_wb_wb[1] && (mem_Write_reg != 0) && 
		    !(ex_mem_wb[1] && (five_bit_mux_out != 0) && (five_bit_mux_out != rs)) && 
			 (mem_Write_reg == rs)) 
			begin
				forward_a_sel <= 2'b01;
			end
		 
		if (mem_wb_wb[1] && (mem_Write_reg != 0) && 
		    !(ex_mem_wb[1] && (five_bit_mux_out != 0) && (five_bit_mux_out != rt)) && 
			 (mem_Write_reg == rt)) 
			begin
				forward_b_sel <= 2'b01;
			end
	end						  
endmodule
