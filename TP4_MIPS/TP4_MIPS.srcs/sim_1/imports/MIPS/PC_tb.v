`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//
// Create Date:   13:46:10 10/03/2016
// Module Name:   PC_tb
// Project Name:  MIPS
// Description:   Testing MIPS PC implementation in verilog.
//
// Dependencies:  PC.v
//
////////////////////////////////////////////////////////////////////////////////

module PC_tb;
	// Declare inputs.
	reg [31:0] npc;
	reg clk;

	// Declare outputs.
	wire [31:0] pcout;

	// Instantiate the PC module.
	PC pc (.clk(clk), .npc(npc), .PC(pcout));

	initial begin
		// Initialize inputs.
		npc = 0;
		clk = 0;
       
		// Test values.
		#20;
		npc = npc + 1;
		#20;
		npc = npc + 1;
		#20;
		npc = npc + 1;
		#20;
		npc = npc + 1;
		#20;
		npc = npc + 1;
		
		// Terminate.
		#40 $finish;
	end
						
	// Display values.
	always @ (posedge clk)
	begin
		$display("At t = %0d\tnpc = %h\t\tpc = %h", $time, npc, pcout);
	end
						
	// Clock.
	initial begin	
		forever begin
			#10 clk = ~clk;
		end
	end     
endmodule
