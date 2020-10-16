`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   11:21:00 10/17/2016
// Module Name:   CONTROL
// Project Name:  MIPS 
// Description:   Control module of the DECODE stage.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

    module CONTROL(input [5:0] opcode,
                   output reg [1:0] WB,
                   output reg [2:0] M,
                   output reg [3:0] EX);
	
	always @ *
	begin
		case (opcode)
			6'b000000:  // R-format
				begin
					WB = 2'b10;
					M  = 3'b000;
					EX = 4'b1100;
				end					
			6'b100011:  // I-Format: Load Word
				begin
					WB = 2'b11;
					M  = 3'b010;
					EX = 4'b0001;
				end					
			6'b101011: // I-Format: Store Word
				begin
					WB = 2'b00;
					M  = 3'b001;
					EX = 4'b0001;
				end					
			6'b000100:  // J-Format: Branch on Equal
				begin
					WB = 2'b00;
					M  = 3'b100;
					EX = 4'b0010;
				end			
            6'b100000:	// NOP 
				begin
					WB = 2'b00;
					M  = 3'b000;
					EX = 4'b0000;
				end
            6'b111111:	// HALT 
				begin
					WB = 2'b00;
					M  = 3'b000;
					EX = 4'b0000;
				end
			default:
			 begin
			    WB = 2'b00;
				M  = 3'b000;
				EX = 4'b0000;
			 end
		endcase
	end
endmodule
