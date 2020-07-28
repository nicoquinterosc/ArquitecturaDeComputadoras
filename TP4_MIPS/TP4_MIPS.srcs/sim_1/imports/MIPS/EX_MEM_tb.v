`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   15:58:00 10/31/2016
// Module Name:   I_EXECUTE_tb
// Project Name:  MIPS
// Description:   Testing the MIPS EX_MEM register implementation.
//
// Dependencies:  I_EXECUTE.v
//
////////////////////////////////////////////////////////////////////////////////

module EX_MEM_tb;
	// Inputs.
	reg clk;
	reg [1:0] ctlwb_out;
	reg [2:0] ctlm_out;
	reg [31:0] adder_out;
	reg aluzero;
	reg [31:0] aluout;
	reg [31:0] readdat2;
	reg [4:0] muxout;

	// Outputs.
	wire [1:0] wb_ctlout;
	wire [2:0] m_ctlout;
	wire [31:0] add_result;
	wire zero;
	wire [31:0] alu_result;
	wire [31:0] rdata2out;
	wire [4:0] five_bit_muxout;

	// Instantiate the module.
	EX_MEM ex_mem(.clk(clk), .ctlwb_out(ctlwb_out), .ctlm_out(ctlm_out), 
		.adder_out(adder_out), .aluzero(aluzero), .aluout(aluout), 
		.readdat2(readdat2), .muxout(muxout), .wb_ctlout(wb_ctlout), 
		.m_ctlout(m_ctlout), .add_result(add_result), .zero(zero), 
		.alu_result(alu_result), .rdata2out(rdata2out), 
		.five_bit_muxout(five_bit_muxout));

	initial begin
		// Initialize inputs.
		clk = 0;
		ctlwb_out = 0;
		ctlm_out = 0;
		adder_out = 0;
		aluzero = 0;
		aluout = 0;
		readdat2 = 0;
		muxout = 0;

		// Wait 100 ns for global reset to finish.
		#100;
		
		$monitor("ctlwb_out = %b, ctlm_out = %b, adder_out = %b, ",
				    ctlwb_out, ctlm_out, adder_out,
					"aluzero = %b, aluout = %b, readdat2 = %b, muxout = %b", 
					 aluzero, aluout, readdat2, muxout);
        
		ctlwb_out = 2'b01;
		ctlm_out = 3'b101;
		adder_out = 32'h00FF1133;
		aluzero = 0;
		aluout = 32'h00FFFFFF;
		readdat2 = 32'h005100C3;
		muxout = 4'b0101;
		#20;
		ctlwb_out = 2'b10;
		ctlm_out = 3'b001;
		adder_out = 32'h00FF1100;
		aluzero = 0;
		aluout = 32'h00FFFF23;
		readdat2 = 32'h00F3DD10;
		muxout = 4'b0011;
		#20;
		$finish;
	end
	
	always @ * 
		begin
			#10 clk = ~clk;
		end    
endmodule

