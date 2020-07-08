`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2020 01:36:24
// Design Name: 
// Module Name: pc
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

module program_counter
    #(
        // Parameters.
        parameter   NB_INST = 32,
        parameter   NB_PC = 32
    )
    (
        input i_clk, i_reset,
        input wire[NB_PC-1:0] i_pc,
        output wire[NB_INST-1:0] o_inst_addr
    );

    integer acc=0;
    assign o_inst_addr = acc;
    
    always @(posedge i_clk) begin
        acc = acc + 4;
    end
    
//    integer addr;
//    reg [NB_INST-1:0] inst;
//    reg [NB_INST-1:0] memory [0:N_INSMEM_ADDR-1];
    
//    assign o_inst = inst;
    
endmodule

