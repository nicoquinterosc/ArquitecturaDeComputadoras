`timescale 1ns / 1ps

module FIFO
  #(
    parameter NB_WORD = 8,
    parameter N_WORD_BUFFER = 4
    )
   (
    output [NB_WORD-1:0] o_data,
    output               o_fifo_empty, o_fifo_full,

    input [NB_WORD-1:0]  i_data,
    input                i_read, i_write,
    input                i_rst, i_clk
    );

   localparam NB_PTR = clog2(N_WORD_BUFFER);

   integer               index;

   //using +1 here in order to differentiate empty state from full state
   reg [NB_PTR+1-1:0]    rd_ptr_reg, wr_ptr_reg;
   reg [NB_WORD-1:0]     buffer[0:N_WORD_BUFFER-1];
   reg                   i_read_reg;

   wire [NB_PTR-1:0]     rd_ptr, wr_ptr;
   wire                  rd_ptr_of, wr_ptr_of;

   initial
     for (index = 0; index < N_WORD_BUFFER; index = index+1) begin
        buffer[index] = {NB_WORD{1'b0}};
     end

   assign {rd_ptr_of, rd_ptr} = rd_ptr_reg;
   assign {wr_ptr_of, wr_ptr} = wr_ptr_reg;

   assign o_data = buffer[rd_ptr];
   assign o_fifo_empty = (rd_ptr_reg == wr_ptr_reg);
   assign o_fifo_full = (rd_ptr == wr_ptr) & (rd_ptr_of != wr_ptr_of);

   always@(posedge i_clk) begin
      i_read_reg <= i_read;
      if (i_rst) begin
         rd_ptr_reg <= {NB_PTR+1{1'b0}};
      end
      else begin
         if(i_read & ~i_read_reg) begin
            rd_ptr_reg <= rd_ptr+1;
         end
      end
   end

   always@(negedge i_clk)begin
      if(i_rst)begin
         wr_ptr_reg <= {NB_PTR+1{1'b0}};
      end
      else begin
         if(i_write) begin
            buffer[wr_ptr] <= i_data;
            wr_ptr_reg <= wr_ptr+1;
         end
      end
   end

`include "clog2.vh"
endmodule
