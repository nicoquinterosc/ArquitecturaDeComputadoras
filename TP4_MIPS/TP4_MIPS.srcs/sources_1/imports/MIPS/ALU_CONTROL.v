`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   15:17:23 10/24/2016
// Module Name:   ALU_CONTROL
// Project Name:  MIPS
// Description:   MIPS ALU_CONTROL module in the EXECUTE stage.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module ALU_CONTROL(input [5:0] funct, input [1:0] alu_op, output reg [2:0] select);
	always @ * 
	begin
		case (alu_op) 
			2'b00: 
				begin
					select <= 3'b010;            // LW / SW
				end
			2'b01: 
				begin
					select <= 3'b110;            // BRE
				end
			2'b10: 
				begin
					case (funct) 
						6'b100000: 
							begin
								select <= 3'b010;   // R add
							end
						6'b100010: 
							begin
								select <= 3'b110;   // R sub
							end
						6'b100100: 
							begin
								select <= 3'b000;   // R and
							end
						6'b100101: 
							begin
								select <= 3'b001;   // R or
							end
						6'b101010: 
							begin
								select <= 3'b111;   // R slt
							end
					endcase
				end
			2'b11:
				begin
					select <= 3'b011;            // Invalid input
				end
		endcase
	end
endmodule
