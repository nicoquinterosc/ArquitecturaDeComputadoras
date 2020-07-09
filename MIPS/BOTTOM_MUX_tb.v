`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   15:17:23 10/24/2016
// Module Name:   BOTTOM_MUX_tb
// Project Name:  MIPS
// Description:   Testing MIPS 2-to-1 5-bit MUX implementation in verilog.
//
// Dependencies:  BOTTOM_MUX.v
//
////////////////////////////////////////////////////////////////////////////////
module BOTTOM_MUX_tb;
	// Inputs
	reg [4:0] a;
	reg [4:0] b;
	reg sel;

	// Outputs
	wire [4:0] y;

	// Instantiate the module.
	BOTTOM_MUX mux(.a(a), .b(b), .sel(sel), .y(y));

	initial begin
		a = 5'b01010;
		b = 5'b10101;
		sel = 1'b1;
		#100;
		a = 5'b00000;
		#10;
		sel = 1'b1;
		#10;
		b = 5'b11111;
		#5;
		a = 5'b00101;
		#5;
		sel = 1'b0;
		b = 5'b11101;
		#5;
		sel = 1'bx;
	end
   
	always @ *
		#1 $display("t = %0d sel =%b a = %b b = %b y = %b",
			$time, sel, a, b, y);
endmodule

