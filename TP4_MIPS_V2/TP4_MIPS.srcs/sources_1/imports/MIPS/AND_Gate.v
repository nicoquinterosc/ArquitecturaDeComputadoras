`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   14:25:00 10/31/2016
// Module Name:   AND_Gate
// Project Name:  MIPS
// Description:   The MIPS MEMORY (MEM) branching AND gate module.
//
// Dependencies:  None.
//
////////////////////////////////////////////////////////////////////////////////


module AND_Gate(
    input m_ctlout,
    input zero,
    output PCSrc);
    
	assign PCSrc = zero && m_ctlout;
endmodule
