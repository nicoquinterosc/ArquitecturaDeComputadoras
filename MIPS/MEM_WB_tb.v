`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   14:40:00 10/31/2016
// Module Name:   MEM_WB_tb
// Project Name:  MIPS
// Description:   Testing the MIPS MEM/WB register (latch) of the MEMORY (MEM) 
//                stage.
//
// Dependencies:  MEM_WB.v
//
////////////////////////////////////////////////////////////////////////////////

module MEM_WB_tb;
	// Inputs
	reg clk;
	reg [1:0] control_wb_in;
	reg [31:0] Read_data_in;
	reg [31:0] ALU_result_in;
	reg [4:0] Write_reg_in;

	// Outputs
	wire [1:0] mem_control_wb;
	wire [31:0] Read_data;
	wire [31:0] mem_ALU_result;
	wire [4:0] mem_Write_reg;

	// Instantiate the Unit Under Test (UUT)
	MEM_WB mem_wb (
		.clk(clk), 
		.control_wb_in(control_wb_in), 
		.Read_data_in(Read_data_in), 
		.ALU_result_in(ALU_result_in), 
		.Write_reg_in(Write_reg_in), 
		.mem_control_wb(mem_control_wb), 
		.Read_data(Read_data), 
		.mem_ALU_result(mem_ALU_result), 
		.mem_Write_reg(mem_Write_reg)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		control_wb_in = 0;
		Read_data_in = 0;
		ALU_result_in = 0;
		Write_reg_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Test
		control_wb_in = 1;
		Read_data_in = 32'hFF00AAD0;
		ALU_result_in = 32'h00ADAD10;
		Write_reg_in = 3;
		
		#20;
		$finish;
	end
	
	initial begin
		$monitor("INPUTS: control_wb_in = %b\tRead_data_in = %h\tALU_result_in = %h\tWrite_reg_in = %b\t", 
			control_wb_in, Read_data_in, ALU_result_in, Write_reg_in,
			"OUTPUTS: mem_control_wb = %b\tRead_data = %h\tmem_ALU_result = %h\tmem_Write_reg = %b",
			mem_control_wb, Read_data, mem_ALU_result, mem_Write_reg);				
		forever begin
			#10 clk = ~clk;
		end
	end	
endmodule

