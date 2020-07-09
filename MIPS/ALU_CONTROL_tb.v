`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   15:17:23 10/24/2016
// Module Name:   ALU_CONTROL_tb
// Project Name:  MIPS
// Description:   Testing MIPS ALU_CONTROL module in the EXECUTE stage.
//
// Dependencies:  ALU_CONTROL.v
//
////////////////////////////////////////////////////////////////////////////////

module ALU_CONTROL_tb;
	// Inputs
	reg [5:0] funct;
	reg [1:0] alu_op;

	// Outputs
	wire [2:0] select;

	// Instantiate the module.
	ALU_CONTROL alu_control(.funct(funct), .alu_op(alu_op), .select(select));

	initial begin
		// Initialize Inputs
		funct = 0;
		alu_op = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		alu_op = 2'b00;
		funct = 6'b100000;
		$monitor("ALUop = %b\tfunct = %b\tselect = %b", alu_op, funct, select);
	
		#1
		alu_op = 2'b01;
		funct = 6'b100000;
		#1
		alu_op = 2'b10;
		funct = 6'b100000;
		#1
		funct = 6'b100010;
		#1
		funct = 6'b100100;
		#1
		funct = 6'b100101;
		#1
		funct = 6'b101010;
		#1
		$finish;
	end    
endmodule

