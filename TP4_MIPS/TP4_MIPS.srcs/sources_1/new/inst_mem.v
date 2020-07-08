`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2020 23:05:43
// Design Name: 
// Module Name: inst_mem
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
           
module instruction_memory
    #(
        // Parameters.
        parameter   NB_INST = 32,
        parameter   NB_PC = 32,
        parameter   N_INSMEM_ADDR = 2048
    )
    (
        input i_clk, i_reset,
        input wire[NB_PC-1:0] i_inst_addr,
        output wire[NB_INST-1:0] o_inst
    );
    
    integer addr;
    reg [NB_INST-1:0] inst;
    reg [NB_INST-1:0] memory [0:N_INSMEM_ADDR-1];
    
    assign o_inst = inst;
    
    initial
    begin
        $readmemb("memfile.mem", memory);
    end
    
    always @(posedge i_clk) begin
        addr <= i_inst_addr;
        inst <= memory[addr/4];
    end
    
endmodule
