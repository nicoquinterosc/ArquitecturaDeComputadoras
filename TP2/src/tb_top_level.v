`timescale 1ns / 1ps

module tb_top_level();

   localparam B_RATE         = 960000;
   localparam NB_DATA        = 1 ;
   localparam N_DATA         = 8 ;
   localparam LOG2_N_DATA    = 4 ;
   localparam PARITY_CHECK   = 0 ;
   localparam EVEN_ODD_PARITY = 1 ;
   localparam M_STOP         = 1 ;
   localparam LOG2_M_STOP    = 1 ;

   localparam REG_A = 8'b0000_0011;
   localparam REG_B = 8'b0000_1100;
   localparam OP = 6'b100000; // SUMA
   localparam REG_A1 = 8'b0000_1000;
   localparam REG_B1 = 8'b0000_0010;
   localparam OP1 = 6'b000010; // SUMA
   localparam START = 1'b0;
   localparam STOP = 1'b1;

   // Outputs.
   wire [NB_DATA-1:0]                               i_data;
   wire                                             o_data;
   
   // Inputs.
   reg                                          	  i_clk;
   reg                                          	  i_rst;

   reg [((N_DATA+PARITY_CHECK+M_STOP+1)*6):0]       data ;
   reg [$clog2(15)-1:0]                             tmr;

   assign i_data = data[0];

   initial begin
      tmr <= 'b0;
      i_clk = 1'b0;
      i_rst = 1'b0;
      data = {
              STOP,2'b00,OP1,START,STOP,REG_B1,START,STOP,REG_A1,START,
              STOP,2'b00,OP,START,STOP,REG_B,START,STOP,REG_A,START,1'b1
              };

      #100 i_rst = 1'b1;
      #200 i_rst = 1'b0;

      #100000 $finish;

   end

   always #5 i_clk = ~i_clk;

   always @ (posedge i_clk)
     begin
        if (u_tl.brgen_valid_urx)
          if (tmr < 15)
            tmr <= tmr+1;
          else begin
      	     data <= data>>1'b1 ;
             tmr <= 'b0;
          end
     end

   top_level#(.B_RATE(B_RATE))
     u_tl(
          .RsTx(o_data),
          .RsRx(i_data),
          .i_clk(i_clk),
          .i_btnC(i_rst)
          );

endmodule
