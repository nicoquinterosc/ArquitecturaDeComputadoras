`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   14:30:00 10/31/2016
// Module Name:   D_MEM_tb
// Project Name:  MIPS
// Description:   Testing the MIPS Data Memory (D_MEM) module in the MEMORY 
//                (MEM) stage.
//
// Dependencies:  D_MEM.v
//
////////////////////////////////////////////////////////////////////////////////

module D_MEM_tb;
	// Inputs
	reg clk;
	reg MemWrite;
	reg MemRead;
	reg [31:0] Address;
	reg [31:0] Write_data;

	// Outputs
	wire [31:0] Read_data;

	// Instantiate the Unit Under Test (UUT)
	D_MEM mem (
		.clk(clk), 
		.MemWrite(MemWrite), 
		.MemRead(MemRead), 
		.Address(Address), 
		.Write_data(Write_data), 
		.Read_data(Read_data)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		MemWrite = 0;
		MemRead = 0;
		Address = 0;
		Write_data = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// Test
		MemWrite = 1;
		Write_data = 32'h002300AA;
		
		#20;
		MemWrite = 1;
		Address = Address + 1;
		Write_data = 32'h10654321;

		#20;
		MemWrite = 1;
		Address = Address + 1;
		Write_data = 32'h001000220;
		
		#20;
		MemWrite = 1;
		Address = Address + 1;
		Write_data = 32'h8C123456;
		
		#20;
		MemWrite = 1;
		Address = Address + 1;
		Write_data = 32'h8F123456;
		
		#20;
		MemWrite = 1;
		Address = Address + 1;
		Write_data = 32'hAD654321;
		
		#20;
		MemWrite = 1;
		Address = Address + 1;
		Write_data = 32'h13012345;
		
		#20;
		MemWrite = 1;
		Address = Address + 1;
		Write_data = 32'hAC654321;
		
		#20;
		MemWrite = 1;
		Address = Address + 1;
		Write_data = 32'h12012345;
		
		#20;
		MemWrite = 0;
		MemRead = 1;
		Address = 0;
		
		#20;
		Address = Address + 1;
		
		#20;
		Address = Address + 1;
		
		#20;
		Address = Address + 1;
		
		#20;
		Address = Address + 1;
		
		#20;
		Address = Address + 1;
		
		#20;
		Address = Address + 1;
		
		#20;
		Address = Address + 1;
		
		#20;
		Address = Address + 1;
		
		#20;
		$finish;
	end
	
	initial begin
		$monitor("INPUT: MemWrite = %b\tMemRead = %b\tAddress = %h\tWrite_data = %h", 
			MemWrite, MemRead, Address, Write_data,
			"\tOUTPUT: Read_data = %h",
			Read_data);
		forever begin
			#10 clk = ~clk;
		end
	end
      
endmodule

