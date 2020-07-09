`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   14:30:00 10/31/2016
// Module Name:   D_MEM
// Project Name:  MIPS
// Description:   The MIPS Data Memory (D_MEM) module in the MEMORY (MEM) stage.
//
// Dependencies:  None.
//
////////////////////////////////////////////////////////////////////////////////

module D_MEM(input clk, MemWrite, MemRead, input [31:0] Address, Write_data, 
	output reg [31:0] Read_data);
	
	reg [31:0] MEM [128:0];
	
	initial
		begin
			MEM[0] <= 32'b0000_0000_0000_0000_0000_0000_0000_0000; // Data 0
			MEM[1] <= 32'b0000_0000_0000_0000_0000_0000_0000_0001; // Data 1
			MEM[2] <= 32'b0000_0000_0000_0000_0000_0000_0000_0010; // Data 2
			MEM[3] <= 32'b0000_0000_0000_0000_0000_0000_0000_0011; // Data 3
			MEM[4] <= 32'b0000_0000_0000_0000_0000_0000_0000_0100; // Data 4
			MEM[5] <= 32'b0000_0000_0000_0000_0000_0000_0000_0101; // Data 5
		end
	
	// Get data from the specified address.
	always @ *//(MemRead)
		begin
			Read_data <= MEM[Address];
		end
	
	// Write data to the specified address.
	always @ (posedge clk && MemWrite)
		begin
			MEM[Address] <= Write_data;
		end
endmodule
