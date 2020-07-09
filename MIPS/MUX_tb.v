`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//
// Create Date:   13:26:15 10/03/2016
// Module Name:   MUX_tb
// Project Name:  MIPS
// Description:   Testing MIPS 2-to-1 MUX implementation in verilog.
//
// Dependencies:  MUX.v
//
////////////////////////////////////////////////////////////////////////////////

module MUX_tb;
	// Declare inputs.
   reg [31:0] A, B;
	reg sel;
	
   // Declare outputs.
	wire [31:0] Y;
	
	// Instantiate the MUX module.
	MUX mux(.a(A), .b(B), .sel(sel), .y(Y));
	
	initial begin
		// Initialize inputs.
		A = 0;
		B = 0;
		sel = 0;
		
		// Provide test values.
		A = 32'hAAAAAAAA;
		B = 32'h55555555;
		sel = 1'b1;
		#10;
		A = 32'h00000000;
		#10;
		sel = 1'b1;
		#10;
		B = 32'hFFFFFFFF;
		#5;
		A = 32'hA5A5A5A5;
		#5;
		sel = 1'b0;
		B = 32'hDDDDDDDD;
		#5;
		sel = 1'bx;
		
		// Terminate.
		$finish;
	end
	
	// Whenever a change occurs to A, B or sel, display information.
	always @ (A or B or sel)
		#1 $display("At t = %0d sel %b A = %h B = %h Y = %h",
				      $time, sel, A, B, Y);
endmodule
