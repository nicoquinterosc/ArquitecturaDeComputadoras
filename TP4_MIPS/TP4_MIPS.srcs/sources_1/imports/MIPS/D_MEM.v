`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   14:30:00 10/31/2016
// Module Name:   D_MEM
// Project Name:  MIPS
// Description:   The MIPS Data Memory (D_MEM) module in the MEMORY (MEM) stage.
//
// Dependencies:  None.
//
////////////////////////////////////////////////////////////////////////////////

module D_MEM(
    input clk,
    input rst,
    input enable,
    input MemWrite,
    input MemRead,
    input [31:0] Address,
    input [31:0] Write_data,
    output reg [31:0] Read_data);
	
	reg [31:0] MEM [127:0];
	
	initial
		begin
			MEM[0] <= 32'b0000_0000_0000_0000_0000_0000_0000_0000; // Data 0
			MEM[1] <= 32'b0000_0000_0000_0000_0000_0000_0000_0001; // Data 1
			MEM[2] <= 32'b0000_0000_0000_0000_0000_0000_0000_0010; // Data 2
			MEM[3] <= 32'b0000_0000_0000_0000_0000_0000_0000_0011; // Data 3
			MEM[4] <= 32'b0000_0000_0000_0000_0000_0000_0000_0100; // Data 4
			MEM[5] <= 32'b0000_0000_0000_0000_0000_0000_0000_0101; // Data 5
			MEM[6] <= 32'b0000_0000_0000_0000_0000_0000_0000_0110; // Data 6
			MEM[7] <= 32'b0000_0000_0000_0000_0000_0000_0000_0111; // Data 7
			MEM[8] <= 32'b0000_0000_0000_0000_0000_0000_0000_1000; // Data 8
			MEM[9] <= 32'b0000_0000_0000_0000_0000_0000_0000_1001; // Data 9
			MEM[10] <= 32'b0000_0000_0000_0000_0000_0000_0000_1010; // Data 10
		end
	
	// Get data from the specified address.
//	always @ *//(MemRead)
	always @ (posedge clk && MemRead)
        begin
            if (enable)
            begin
                Read_data = MEM[Address];
            end
		end
	
	// Write data to the specified address.
    always @ (posedge clk && MemWrite)
        begin
            if (enable)
            begin
                MEM[Address] <= Write_data;
			end
		end
endmodule
