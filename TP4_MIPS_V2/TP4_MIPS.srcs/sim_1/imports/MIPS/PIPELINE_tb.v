`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   10:31:00 10/31/2016
// Module Name:   PIPELINE
// Project Name:  MIPS 
// Description:   Testing MIPS pipeline.
//
// Dependencies:  PIPELINE.v
//
////////////////////////////////////////////////////////////////////////////////

module PIPELINE_tb;
	// Inputs
	reg clk;
	reg rst;
	wire [31:0] wd;
	wire [31:0] fas;

	// Instantiate the Unit Under Test (UUT)
	PIPELINE pipeline(.clk(clk), .rst(rst), .wd(wd), .fas(fas));

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;		
		// Wait for initialization
		#100;
		$monitor("Hola", pipeline.IF_ID_IR);
//		$monitor("mux %d", pipeline.FETCH.mux.a);
		$monitor("pc: %d", pipeline.FETCH.pc.npc);
		// Perform 24 cycles.
		//#480;
		//$finish;
	end
	
	initial begin
		// Wait for initialization
		#100;
//		rst = 1'b1;
		forever begin
            #10 clk = ~clk;
			if($time==150)
            begin 
			     rst = 1'b1;
			end
		end
	end 
endmodule
