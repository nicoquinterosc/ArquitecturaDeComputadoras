`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/21/2018 02:36:48 PM
// Design Name: 
// Module Name: alu
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
module alu
#(
    parameter NB_DATA = 8,
    parameter NB_OPCODE = 6
)
(
   input        [NB_DATA    : 0] a, //operand
   input        [NB_DATA    : 0] b, //operand
   input        [NB_OPCODE  : 0] op,
   output   reg [NB_DATA    : 0] r //the Result value
);

    always @ (*) begin
        case(op)
            8'h20  :  r = a + b;
            8'h22  :  r = a - b;  
            8'h24  :  r = a & b; 
            8'h25  :  r = a | b;
            8'h26  :  r = a ^ b;
            8'h03  :  r = a >>> b;
            8'h02  :  r = a >> b;
            8'h27  :  r = ~(a | b);
            default:  r = 8'h00;
        endcase
    end
    
endmodule