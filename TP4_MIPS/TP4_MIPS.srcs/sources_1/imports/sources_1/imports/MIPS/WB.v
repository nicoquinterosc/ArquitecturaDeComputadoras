`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   01:11:00 11/06/2016
// Module Name:   WB
// Project Name:  MIPS
// Description:   The MIPS WRITEBACK (WB) pipeline stage.
//
// Dependencies:  MUX.v
//
////////////////////////////////////////////////////////////////////////////////

module WB(
    input  MemtoReg, 
    input  [31:0] ReadData, 
    input  [31:0] ALUResult, 
	output [31:0] WriteData);
	
	MUX mux(.a(ReadData),
	        .b(ALUResult),
	        .sel(MemtoReg),
	        .y(WriteData));
endmodule
