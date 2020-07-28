`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   11:28:25 10/17/2016
// Module Name:   REG
// Project Name:  MIPS 
// Description:   Registers module of the DECODE stage.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module REG(input clk, regwrite, input [4:0] rs, rt, rd, input [31:0] writedata, 
	output reg [31:0] A, B);	
	// Registers
	reg [31:0] GP_REG [31:0];
	
	// Initialize memory.
	initial begin
		GP_REG[0] <= 32'h00000000; // $zero register
		GP_REG[1] <= 32'h00000000;
		GP_REG[2] <= 32'h00000000;
		GP_REG[3] <= 32'h00000000;
		GP_REG[4] <= 32'h00000000;
	end
		
	// Get the values at the specified addresses
	always @ *
	begin
		A <= GP_REG[rs];
		B <= GP_REG[rt];
	end
		
	// Write the values at the specified addresses
	always @ (posedge clk && regwrite)
	begin
		GP_REG[rd] <= writedata;
	end
endmodule
