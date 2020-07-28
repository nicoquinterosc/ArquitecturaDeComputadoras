`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   15:03:00 10/24/2016
// Module Name:   ADDER_tb
// Project Name:  MIPS
// Description:   Testing the ADDER module in the MIPS EXECUTE stage.
//
// Dependencies:  ADDER.v
//
////////////////////////////////////////////////////////////////////////////////

module ADDER_tb;
	// Inputs.
	reg [31:0] add_in1;
	reg [31:0] add_in2;

	// Outputs.
	wire [31:0] add_out;

	// Instantiate the module.
	ADDER adder(.add_in1(add_in1), .add_in2(add_in2), .add_out(add_out));

	initial begin
		// Initialize inputs.
		add_in1 = 0;
		add_in2 = 0;

		// Wait 100 ns for global reset to finish.
		#100;
		
		$monitor("add_in1 = %h add_in2 = %h add_out = %h", add_in1, add_in2, add_out);        
		add_in1 = 32'h00110000;
		add_in2 = 32'h001100BB;
		#10;
		add_in1 = 32'h0011FF00;
		add_in2 = 32'h001100C0;
		#10;
		add_in1 = 32'h00110010;
		add_in2 = 32'h00110CCC;
	end
      
endmodule

