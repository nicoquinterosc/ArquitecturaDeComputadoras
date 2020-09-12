`timescale 1ns / 1ps

module baudrate_generator
  #(
    parameter CLK_FREQ = 100E6,
    parameter BAUD_RATE = 9600
    )
   (
    output o_tick,
    input  i_clk, i_rst
    );

   localparam TICK_RATE = CLK_FREQ/(16*BAUD_RATE);
   localparam COUNT_NBITS = clog2(TICK_RATE);

   reg [COUNT_NBITS-1:0] counter;

   assign o_tick = ~(|counter);

   always @ (posedge i_clk) begin
      if(i_rst || o_tick)
        counter <= TICK_RATE-1;
      else
        counter <= counter - 1;
   end

`include "clog2.vh"

endmodule
