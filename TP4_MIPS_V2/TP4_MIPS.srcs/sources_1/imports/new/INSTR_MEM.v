`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   14:20:02 10/03/2016
// Module Name:   INSTR_MEM
// Project Name:  MIPS 
// Description:   MIPS Instruction Memory implementation in verilog.
//
// Dependencies:  None
//
////////////////////////////////////////////////////////////////////////////////

module INSTR_MEM(input clk,
                 input rst,
                 input enable,
                 input enable_wr,
                 input [31:0] addr,
                 input [31:0] saveaddr,
                 input [31:0] instr,
                 output reg [31:0] data,
                 output reg halt);
                 
   // Declare the memory block.
	reg [31:0] MEM [127:0];
	
	// Initialize memory.
	//initial begin
		/* SET 1 - Using NOPs to mitigate data hazards. 
		MEM[0]  <= 32'b100011_00000_00001_0000_0000_0000_0001;  // LW r1 , 1(r0)
		MEM[1]  <= 32'b100011_00000_00010_0000_0000_0000_0010;  // LW r2 , 2(r0)
		MEM[2]  <= 32'b100011_00000_00011_0000_0000_0000_0011;  // LW r3 , 3(r0)
		MEM[3]  <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[4]  <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[5]  <= 32'b000000_00001_00010_00001_00000_100000;   // ADD r1, r1, r2
		MEM[6]  <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[7]  <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP:
		MEM[8]  <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP		
		MEM[9]  <= 32'b000000_00001_00011_00001_00000_100000;   // ADD r1, r1, r3		
		MEM[10] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[11] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[12] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP			
		MEM[13] <= 32'b000000_00001_00001_00001_00000_100000;   // ADD r1, r1, r1		
		MEM[14] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[15] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[16] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[17] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP		
		MEM[18] <= 32'b000000_00001_00000_00001_00000_100000;   // ADD r1, r1, r0		
		MEM[19] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[20] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[21] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[22] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		MEM[23] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
		*/
		/* SET 2 - Using ordering of instructions to mitigate data hazards. 
		MEM[0]  <= 32'b100011_00000_00001_0000_0000_0000_0001;  // LW r1, 1(r0)
		MEM[1]  <= 32'b100011_00000_00010_0000_0000_0000_0010;  // LW r2, 2(r0)
		MEM[2]  <= 32'b100011_00000_00011_0000_0000_0000_0011;  // LW r3, 3(r0)
		MEM[3]  <= 32'b100011_00000_00100_0000_0000_0000_0100;  // LW r4, 4(r0)
		MEM[4]  <= 32'b100011_00000_00101_0000_0000_0000_0101;  // LW r5, 5(r0)
		MEM[5]  <= 32'b101011_00000_00001_0000_0000_0000_0110;  // SW r1, 6(r0)
		MEM[6]  <= 32'b101011_00000_00010_0000_0000_0000_0111;  // SW r2, 7(r0)
		MEM[7]  <= 32'b101011_00000_00011_0000_0000_0000_1000;  // SW r3, 8(r0)
		MEM[8]  <= 32'b101011_00000_00100_0000_0000_0000_1001;  // SW r4, 9(r0)
		MEM[9]  <= 32'b101011_00000_00101_0000_0000_0000_1010;  // SW r5, 10(r0)
		*/
		/* SET 3 - Using forwarding to mitigate data hazards. */
//		MEM[0] <= 32'b1000_0000_0000_0000_0000_0000_0000_0000; // NOP
//		MEM[1]  <= 32'b001000_00001_00001_0000000000000001;   // ADD r1, r1, 1
//		MEM[2]  <= 32'b001000_00010_00010_0000000000000010;   // ADD r2, r2, 2
		
		//$readmemb("memfile.mem", MEM);
		
	//end

   // Assign the contents at the requested memory address to data.
    always @ *
    begin
        if (enable_wr == 0)
        begin
            data = MEM[addr];
        end
	end
	
	always @(posedge clk)
	begin
	   if (enable_wr == 1)
	   begin
	       MEM[saveaddr] <= instr;
	   end
	end
	
	always @(negedge clk)
	begin
	   if (data[31:26] == 6'b111111 ) //Check if instruction is HALT
	   begin
	       halt = 1'b1;
	   end
	   else
	   begin
	       halt = 1'b0;
	   end
	end
endmodule
