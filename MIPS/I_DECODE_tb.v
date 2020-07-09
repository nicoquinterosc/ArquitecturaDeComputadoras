`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   11:22:00 10/24/2016
// Module Name:   I_DECODE_tb
// Project Name:  MIPS
// Description:   Tests the MIPS ID (DECODE) pipeline stage.
//
// Dependencies:  I_DECODE.v
//
////////////////////////////////////////////////////////////////////////////////

module I_DECODE_tb;
	// Inputs
	reg        clk;
	reg        RegWrite;
	reg [31:0] IF_ID_Instr;
	reg [31:0] IF_ID_NPC;
	reg [4:0]  MEM_WB_Writereg;
	reg [31:0] MEM_WB_Writedata;

	// Outputs
	wire [1:0] WB;
	wire [2:0] M;
	wire [3:0] EX;
	wire [31:0] NPC;
	wire [31:0] rdata1out;
	wire [31:0] rdata2out;
	wire [31:0] IR;
	wire [4:0] instrout_2016;
	wire [4:0] instrout_1511;

	// Instantiate the I_DECODE module
	I_DECODE decode(.clk(clk), .RegWrite(RegWrite), .IF_ID_Instr(IF_ID_Instr), 
		.IF_ID_NPC(IF_ID_NPC), .MEM_WB_Writereg(MEM_WB_Writereg), 
		.MEM_WB_Writedata(MEM_WB_Writedata), .WB(WB), .M(M), .EX(EX), 
		.NPC(NPC), .rdata1out(rdata1out), .rdata2out(rdata2out), 
		.IR(IR), .instrout_2016(instrout_2016), .instrout_1511(instrout_1511));

	initial begin
		// Initialize Inputs
		clk = 1;
		RegWrite = 0;
		IF_ID_Instr = 0;
		IF_ID_NPC = 0;
		MEM_WB_Writereg = 0;
		MEM_WB_Writedata = 0;

	   // Wait 100 ns for global reset to finish
		$display("Initializing and waiting for reset...");
		#100;
        
		// Write test data to the first nine locations
		$display("Writing data...");
		RegWrite  = 1;		
		MEM_WB_Writedata = 32'h002300AA;
		
		#20;
		MEM_WB_Writereg = MEM_WB_Writereg + 1;
		MEM_WB_Writedata = 32'h10654321;
		
		#20;
		MEM_WB_Writereg = MEM_WB_Writereg + 1;
		MEM_WB_Writedata = 32'h00100022;
		
		#20;
		MEM_WB_Writereg = MEM_WB_Writereg + 1;
		MEM_WB_Writedata = 32'h8C123456;
		
		#20;
		MEM_WB_Writereg = MEM_WB_Writereg + 1;
		MEM_WB_Writedata = 32'h8F123456;
		
		#20;
		MEM_WB_Writereg = MEM_WB_Writereg + 1;
		MEM_WB_Writedata = 32'hAD654321;
		
		#20;
		MEM_WB_Writereg = MEM_WB_Writereg + 1;
		MEM_WB_Writedata = 32'h13012345;
		
		#20;
		MEM_WB_Writereg = MEM_WB_Writereg + 1;
		MEM_WB_Writedata = 32'hAC654321;
		
		#20;
		MEM_WB_Writereg = MEM_WB_Writereg + 1;
		MEM_WB_Writedata = 32'h12012345;
		
		// Read test data from the nine test locations.
		// rs will read evens and rt will read odds until the last register,
		// where both will read the ninth register together.
		#20;
		$display("Reading data...");
		RegWrite = 0;
		IF_ID_instr = 32'b00000000000000010000000000000000;
		
		#20
		IF_ID_instr = 32'b00000000010000110000000000000000;
		
		#20
		IF_ID_instr = 32'b00000000100001010000000000000000;
		
		#20
		IF_ID_instr = 32'b00000000110001110000000000000000;
		
		#20
		IF_ID_instr = 32'b00000001000010000000000000000000;
		
      #20 $finish;
	end
	
	initial begin
		$monitor("INPUTS: IF_ID_instr = %b | IF_ID_NPC = %h | RegWrite = %d | ",
				   IF_ID_instr, IF_ID_NPC, RegWrite, 
					"MEM_WB_Writereg = %d | MEM_WB_Writedata = %h | ", 
					MEM_WB_Writereg, MEM_WB_Writedata,
					"OUTPUTS: WB = %b | M = %b | EX = %b | NPC = %h | ",
					WB, M, EX, NPC,
					"rdata1out = %h | rdata2out = %h | IR = %d | ",
					rdata1out, rdata2out, IR,
					"instrout_2016 = %d | instrout_1511 = %d",
					instrout_2016, instrout_1511);
		forever begin
			#10 clk = ~clk;
		end
	end
      
endmodule

