`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//
// Create Date:   14:28:09 10/03/2016
// Module Name:   INSTR_MEM_tb
// Project Name:  MIPS 
// Description:   Testing MIPS Instruction Memory implementation in verilog.
//
// Dependencies:  INSTR_MEM.v
//
////////////////////////////////////////////////////////////////////////////////

module INSTR_MEM_tb;
	// Declare inputs.
	reg [31:0] addr;
	
	// Declare outputs.
	wire [31:0] data;

	// Instantiate the EX_MEM module.
   INSTR_MEM mem (.addr(addr), .data(data));

	initial begin
		// Initialize inputs.
		addr = 0;
			
		// Increment address ten times to obtain the initialized memory block.
		repeat(10) begin
			#10;
			$display ("Address=%8h\tData=%0h", addr, data);
			addr = addr + 1;
		end
		
		// Terminate.
		$finish;
	end   
endmodule
