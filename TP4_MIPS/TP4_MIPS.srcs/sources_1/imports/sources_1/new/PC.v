`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//
// Create Date:   13:42:26 10/03/2016
// Module Name:   PC
// Project Name:  MIPS 
// Description:   MIPS PC implementation in verilog.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module PC(input clk,
          input rst, 
          input enable,
          input halt,
          input stall,
          input [31:0] npc, 
          output reg [31:0] PC);

	// Update PC with the new PC value.
	always @ (posedge clk)
	if(rst)
	begin
	   PC <= {32{1'b0}};
    end
    else
	begin
	if (enable && !stall && !halt)
	   begin
	       PC <= npc;
	   end
	end
endmodule
