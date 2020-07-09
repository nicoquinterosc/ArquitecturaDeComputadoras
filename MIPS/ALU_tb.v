`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   15:24:23 10/24/2016
// Module Name:   ALU_tb
// Project Name:  MIPS
// Description:   Testing MIPS ALU module in the EXECUTE stage.
//
// Dependencies:  ALU.v
//
////////////////////////////////////////////////////////////////////////////////

module ALU_tb;
	// Inputs.
	reg [31:0] A;
	reg [31:0] B;
	reg [2:0] control;

	// Outputs.
	wire zero;
	wire [31:0] result;

	// Instantiate the module.
	ALU alu(.A(A), .B(B), .control(control), .zero(zero), .result(result));

	initial begin
		// Initialize inputs.
		A = 0;
		B = 0;
		control = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		A       <= 'b1010;
		B       <= 'b0111;
		control <= 'b011;
		$display("A = %b\tB = %b", A, B);
		$monitor("ALUOp = %b\tresult = %b", control, result);
		#1
		control <= 'b100;
		#1
		control <= 'b010;
		#1
		control <= 'b111;
		#1
		control <= 'b011;
		#1
		control <= 'b110;
		#1
		control <= 'b001;
		#1
		control <= 'b000;
		#1
		$finish;
	end    
endmodule

