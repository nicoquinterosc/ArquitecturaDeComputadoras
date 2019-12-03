`timescale 1ns / 1ps

module counter
    (
    output o_valid,
    input  i_clk, i_rst, i_enable
    );

    reg valid_reg = 1'b1;

    assign o_valid = valid_reg;

    always @ (posedge i_clk) 
    begin
    if(i_rst)
        begin
            valid_reg <= 1'b1;
        end
    else if(i_enable==1)
        begin
            valid_reg <= 1'b0;
        end
    end

endmodule
