`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.09.2020 03:07:16
// Design Name: 
// Module Name: HAZARD_DETECTION_UNIT
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


module HAZARD_DETECTION_UNIT(
    input IdExMemRead,
    input [4:0] IdExRegisterRt,
    input [4:0] IfIdRegisterRs,
    input [4:0] IfIdRegisterRt,
    output reg stall);
    
    always @ *
	begin
		
        if(IdExMemRead &&
        ((IdExRegisterRt == IfIdRegisterRs) ||
        (IdExRegisterRt == IfIdRegisterRt)))
        begin
            stall = 1'b1;
        end
        else
        begin
            stall = 1'b0;
        end
	end					
    
endmodule
