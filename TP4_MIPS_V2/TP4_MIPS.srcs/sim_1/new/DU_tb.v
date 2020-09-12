`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2020 21:43:07
// Design Name: 
// Module Name: DU_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//
// Create Date:   13:58:06 10/03/2016
// Module Name:   I_FETCH_tb
// Project Name:  MIPS 
// Description:   Testing MIPS FETCH stage implementation in verilog.
//
// Dependencies:  I_FETCH.v
//
////////////////////////////////////////////////////////////////////////////////

module DU_tb;
	// Delclare inputs.
	reg clk;
	reg btn;
	reg on;

	// Declare outputs.
	wire enable;

    DEBUG_UNIT du(.clk(clk),
                  .on(on),
                  .btn(btn),
                  .enable(enable));

	initial begin
		// Initialize inputs.
		clk = 0;
        btn = 0;
        on = 1;
        #35 btn = 1; //35
        #45 btn = 0; //80
        #20 btn = 1; //100
		// Terminate.
		#220 $finish;
	end
	
	// Clock.
	initial begin	
		forever begin
			#10 clk = ~clk;
		end
	end

	// Increment the cycle counter and display data at the end of each cycle.
	always @ (posedge clk)
	begin
//		$display("Cycle Number = %0d\tIF_ID_IR = %h\tIF_ID_NPC = %0d", 
//			clk_cycle, IF_ID_IR, IF_ID_NPC);
	end
endmodule