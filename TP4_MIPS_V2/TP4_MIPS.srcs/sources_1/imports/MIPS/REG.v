`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   11:28:25 10/17/2016
// Module Name:   REG
// Project Name:  MIPS 
// Description:   Registers module of the DECODE stage.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module REG(input clk,
           input regwrite,
           input enable,
           input [4:0] rs,
           input [4:0] rt,
           input [4:0] rd,
           input [31:0] writedata,
	       output reg [31:0] A, B);
	// Registers
	reg [31:0] GP_REG [31:0];
	
	// Initialize memory.
	initial begin
		GP_REG[0] <= 32'h00000000; // $zero register
		GP_REG[1] <= 32'h00000001;
		GP_REG[2] <= 32'h00000002;
		GP_REG[3] <= 32'h00000003;
		GP_REG[4] <= 32'h00000004;
		GP_REG[5] <= 32'h00000005;
		GP_REG[6] <= 32'h00000006;
		GP_REG[7] <= 32'h00000007;
		GP_REG[8] <= 32'h00000008;
		GP_REG[9] <= 32'h00000009;
		GP_REG[10] <= 32'h0000000a;
		GP_REG[11] <= 32'h0000000b;
		GP_REG[12] <= 32'h0000000c;
		GP_REG[13] <= 32'h0000000d;
		GP_REG[14] <= 32'h0000000e;
		GP_REG[15] <= 32'h0000000f;
		GP_REG[16] <= 32'h00000010;
		GP_REG[17] <= 32'h00000011;
		GP_REG[18] <= 32'h00000012;
		GP_REG[19] <= 32'h00000013;
		GP_REG[20] <= 32'h00000014;
		GP_REG[21] <= 32'h00000015;
		GP_REG[22] <= 32'h00000016;
		GP_REG[23] <= 32'h00000017;
		GP_REG[24] <= 32'h00000018;
		GP_REG[25] <= 32'h00000019;
		GP_REG[26] <= 32'h0000001a;
		GP_REG[27] <= 32'h0000001b;
		GP_REG[28] <= 32'h0000001c;
		GP_REG[29] <= 32'h0000001d;
		GP_REG[30] <= 32'h0000001e;
		GP_REG[31] <= 32'h0000001f;
	end
		
	// Get the values at the specified addresses
	always @ *
	begin
		A = GP_REG[rs];
		B = GP_REG[rt];
	end
	
	// Write the values at the specified addresses
	always @ (posedge clk && regwrite)
	begin
	   if (enable)
	   begin
		  GP_REG[rd] <= writedata;
       end
	end
endmodule
