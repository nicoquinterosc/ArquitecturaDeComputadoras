`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   14:25:00 10/31/2016
// Module Name:   AND_Gate_tb
// Project Name:  MIPS
// Description:   Testing the MIPS MEMORY (MEM) branching AND gate module.
//
// Dependencies:  AND_Gate_tb.v
//
////////////////////////////////////////////////////////////////////////////////

module AND_Gate_tb;
	// Inputs
	reg m_ctlout;
	reg zero;

	// Outputs
	wire PCSrc;

	// Instantiate the Unit Under Test (UUT)
	AND_Gate gate (.m_ctlout(m_ctlout), .zero(zero), .PCSrc(PCSrc));

	initial begin
		// Initialize Inputs
		m_ctlout = 0;
		zero = 0;

		// Wait 100 ns for global reset to finish
		#100;
      m_ctlout = 1;
		#10;
		zero = 1;
		#10;
		m_ctlout = 1;		
	end
	
	// Monitor values.
	always @ *
		#1 $display("m_ctlout = %b\tzero = %b\tPCSrc = %b", m_ctlout, zero, PCSrc);
      
endmodule

