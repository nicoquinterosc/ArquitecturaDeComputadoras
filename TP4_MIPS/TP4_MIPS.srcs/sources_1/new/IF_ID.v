`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.07.2020 02:26:06
// Design Name: 
// Module Name: IF_ID
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
module IF_ID
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
endmodule