`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   10:22:00 11/21/2016
// Module Name:   FORWARDING_UNIT
// Project Name:  MIPS 
// Description:   Forwarding Unit implementation in the MIPS pipeline.
//
// Dependencies:  None.
//
////////////////////////////////////////////////////////////////////////////////

module FORWARDING_UNIT(
	// Inputs from the ID/EX.
	input  [4:0] IdExRegisterRs,
	input  [4:0] IdExRegisterRt, 
	// Inputs from the EX/MEM.
	input  [4:0] ExMemRegisterRd, 
	input  [1:0] ExMemRegWrite, 
	input  [4:0] MemWbRegRd,
	// Input form the MEM/WB.
	input  [1:0] MemWbRegWrite, 
	// Outputs to the EX stage.
	output reg [1:0] forward_a_sel,
	output reg [1:0] forward_b_sel);
	
	reg [4:0] temp1;
	reg [5:0] temp2;
    reg [5:0] temp3;
	
	always @ *
	begin
		forward_a_sel = 2'b00;
		forward_b_sel = 2'b00;
		
		// EX Hazard
		if (ExMemRegWrite[1] && 
		    (ExMemRegisterRd != 0) && (ExMemRegisterRd == IdExRegisterRs)) 
			begin
				forward_a_sel = 2'b10;
			end
		 
		if (ExMemRegWrite[1] && 
		    (ExMemRegisterRd != 0) && (ExMemRegisterRd == IdExRegisterRt)) 
			begin
				forward_b_sel = 2'b10;
			end
	
		// MEM Hazard
		if (MemWbRegWrite[1] && (MemWbRegRd != 0) && 
		    !(ExMemRegWrite[1] && (ExMemRegisterRd != 0) && (ExMemRegisterRd != IdExRegisterRs)) && 
			 (MemWbRegRd == IdExRegisterRs)) 
			begin
				forward_a_sel = 2'b01;
			end
			
		temp1 = MemWbRegWrite[1] && (MemWbRegRd != 0);
		temp2 = !(ExMemRegWrite[1] && (ExMemRegisterRd != 0) && 
		    (ExMemRegisterRd != IdExRegisterRt));
		temp3 = (MemWbRegRd == IdExRegisterRt);
		 
		if (MemWbRegWrite[1] && (MemWbRegRd != 0) && 
		    !(ExMemRegWrite[1] && (ExMemRegisterRd != 0) && 
		    (ExMemRegisterRd != IdExRegisterRt)) && 
			 (MemWbRegRd == IdExRegisterRt)) 
			begin
				forward_b_sel = 2'b01;
			end

	end						  
endmodule
