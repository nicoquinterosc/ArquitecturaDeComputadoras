`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2020 21:13:44
// Design Name: 
// Module Name: DEBUG_UNIT
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

module DEBUG_UNIT(
    input clk,
    input rst,
    input on,
    input btn,
    output reg enable);

reg flag = 1'b0;

always @*
begin
    if(rst)
    begin
        enable = 1'b0;
    end
    else if (on == 1)
    begin
        if (btn == 1'b1)
        begin
            enable = 1'b1;
        end
        else
        begin
            enable = 1'b0;
        end
    end
end

always @ (posedge clk)
begin
    if (enable == 1'b1)
    begin
        flag <= 1'b1;
    end
end

always @ (negedge clk)
begin
    if(on==1)
    begin
        if (flag==1'b1)
        begin
            enable <= 1'b0;
            flag <= 1'b0;
        end
    end
end

//always @*
//begin
//    if (on == 1)
//    begin
//        if (btn == 1'b1)
//        begin
//            flag = 1'b1;
//        end
//    end
//    else
//    begin
//        enable = 1'b1;
//    end
//end

//always @ (posedge clk)
//begin
//    if (flag == 1'b1)
//    begin 
//        enable = 1'b1;
//    end
//end

//always @ (negedge clk)
//begin
//    if(on==1)
//    begin
//        enable <= 1'b0;
//        if (enable == 1'b1)
//        begin
//            flag <= 1'b0;
//        end
//    end
//end
endmodule
