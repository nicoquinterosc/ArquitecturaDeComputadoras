`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       California State University San Bernardino
// Engineer:		Bogdan Kravtsov
//                Tyler Clayton
//
// Create Date:   14:20:00 10/31/2016
// Module Name:   MEM_tb
// Project Name:  MIPS
// Description:   Testing the MIPS MEMORY (MEM) pipeline stage.
//
// Dependencies:  MEM.v
//
////////////////////////////////////////////////////////////////////////////////

module MEM_tb;
	// Inputs
	reg clk;
	reg m_ctlout;
	reg zero;
	reg MemWrite;
	reg MemRead;
	reg [31:0] Write_data;
	reg [1:0] control_wb_in;
	reg [31:0] ALU_result_in;
	reg [4:0] Write_reg_in;

	// Outputs
	wire PCSrc;
	wire [1:0] mem_control_wb;
	wire [31:0] Read_data;
	wire [31:0] mem_ALU_result;
	wire [4:0] mem_Write_reg;

	// Instantiate the Unit Under Test (UUT)
	MEM mem (
		.clk(clk), 
		.m_ctlout(m_ctlout), 
		.zero(zero), 
		.MemWrite(MemWrite), 
		.MemRead(MemRead), 
		.Write_data(Write_data), 
		.control_wb_in(control_wb_in), 
		.ALU_result_in(ALU_result_in), 
		.Write_reg_in(Write_reg_in), 
		.PCSrc(PCSrc), 
		.mem_control_wb(mem_control_wb), 
		.Read_data(Read_data), 
		.mem_ALU_result(mem_ALU_result), 
		.mem_Write_reg(mem_Write_reg)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		m_ctlout = 0;
		zero = 0;
		MemWrite = 0;
		MemRead = 0;
		Write_data = 0;
		control_wb_in = 0;
		ALU_result_in = 0;
		Write_reg_in = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		m_ctlout = 1;
		zero = 0;
		MemWrite = 1;
		MemRead = 0;
		Write_data = 32'h002300AA;
		control_wb_in = 0;
		ALU_result_in = 32'h00230000;
		Write_reg_in = Write_reg_in + 1;
		
		#20;
		m_ctlout = 1;
		zero = 0;
		MemWrite = 1;
		MemRead = 0;
		Write_data = 32'h10654321;
		control_wb_in = 0;
		ALU_result_in = 32'hA42ADFB0;;
		Write_reg_in = Write_reg_in + 1;
		
		#20;
		m_ctlout = 1;
		zero = 0;
		MemWrite = 1;
		MemRead = 0;
		Write_data = 32'h00100022;
		control_wb_in = 0;
		ALU_result_in = 32'h00100000;
		Write_reg_in = Write_reg_in + 1;
		
		#20;
		m_ctlout = 1;
		zero = 0;
		MemWrite = 1;
		MemRead = 0;
		Write_data = 32'h8C123456;
		control_wb_in = 0;
		ALU_result_in = 32'hA42ADFB0;
		Write_reg_in = Write_reg_in + 1;
		
		#20;
		m_ctlout = 1;
		zero = 0;
		MemWrite = 1;
		MemRead = 0;
		Write_data = 32'h8F123456;
		control_wb_in = 0;
		ALU_result_in = 32'hA42ADFB0;
		Write_reg_in = Write_reg_in + 1;
			
		#20;
		m_ctlout = 1;
		zero = 0;
		MemWrite = 1;
		MemRead = 0;
		Write_data = 32'hAD654321;
		control_wb_in = 0;
		ALU_result_in = 32'hA42ADFB0;
		Write_reg_in = Write_reg_in + 1;
		
		#20;
		m_ctlout = 1;
		zero = 0;
		MemWrite = 1;
		MemRead = 0;
		Write_data = 32'h13012345;
		control_wb_in = 0;
		ALU_result_in = 32'hA42ADFB0;
		Write_reg_in = Write_reg_in + 1;
		
		#20;
		m_ctlout = 1;
		zero = 0;
		MemWrite = 1;
		MemRead = 0;
		Write_data = 32'hAC654321;
		control_wb_in = 0;
		ALU_result_in = 32'hA42ADFB0;
		Write_reg_in = Write_reg_in + 1;
		
		#20;
		m_ctlout = 1;
		zero = 0;
		MemWrite = 1;
		MemRead = 0;
		Write_data = 32'h12012345;
		control_wb_in = 0;
		ALU_result_in = 32'hA42ADFB0;
		Write_reg_in = Write_reg_in + 1;
		
		#20;
		$finish;
	end
	
	initial begin
		$monitor("INPUTS: m_ctlout = %b\tzero = %b\tMemWrite = %b\tMemRead = %b\t",
			clk, m_ctlout, zero, MemWrite, MemRead,
	      "Write_data = %d\tcontrol_wb_in = %b\ALU_result_in = %d\tWrite_reg_in = %d\t",
			Write_data, control_wb_in, ALU_result_in, Write_reg_in,
			"OUTPUTS: PCSrc = %d\tmem_control_wb = %b\tRead_data = %d\tmem_ALU_result = %d\t",
			PCSrc, mem_control_wb, Read_data, mem_ALU_result,
			"mem_Write_reg = %d",
		   mem_Write_reg);
			
		forever begin
			#10 clk = ~clk;
		end
	end
      
endmodule

