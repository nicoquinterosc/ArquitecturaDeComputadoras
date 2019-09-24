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
module alu(
   input   [7:0] a, //operand
   input   [7:0] b, //operand
   input   [5:0] op,
   output  reg [7:0] r //the Result value
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