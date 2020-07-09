`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//
// Create Date:   14:34:17 10/03/2016
// Module Name:   IF_ID_tb
// Project Name:  MIPS 
// Description:   Testing MIPS IF_ID register implementation in verilog.
//
// Dependencies:  IF_ID.v
//
////////////////////////////////////////////////////////////////////////////////

module IF_ID_tb;
	// Declare inputs.
	reg clk;
	reg [31:0] npc;
	reg [31:0] instr;

	// Declare outputs.
	wire [31:0] instrout;
	wire [31:0] npcout;

	// Instantiate the IF_ID module.
	IF_ID ifid(.clk(clk), .npc(npc), .instr(instr), .instrout(instrout), 
		.npcout(npcout));

	initial begin
		// Initialize inputs.
		clk = 0;
		npc = 0;
		instr = 0;
	
		// Test values.
		npc   = 32'h44444440;
		instr = 32'hA0A0A0A0;
		#10;
		npc   = 32'h22220022;
		instr = 32'hFFFFFFFF;
		#10;
		npc   = 32'h08080808;
		instr = 32'hBBCCBBCC;
		#10;
		npc   = 32'h78FF23A0;
		instr = 32'h88905FBC;
		
		// Terminate;
		#10 $finish;
	end
		
	// Monitor values.
	initial begin
		$monitor("Time = %0d\tclk = %0d\tnpc = %8h \t instr = %8h\t\tnpcout = %8h\tinstrout = %8h", 
			$time, clk, npc, instr, npcout, instrout);
	end
	
	// Clock.
	initial begin
		forever begin
			#10 clk = ~clk;
		end
	end     
endmodule

