`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   14:25:00 10/31/2016
// Module Name:   AND_Gate
// Project Name:  MIPS
// Description:   The MIPS MEMORY (MEM) branching AND gate module.
//
// Dependencies:  None.
//
////////////////////////////////////////////////////////////////////////////////


module AND_Gate(input m_ctlout, zero, output PCSrc);
	assign PCSrc = zero && m_ctlout;
endmodule
