module tb_uart_rx();
   
   localparam NB_DATA        = 1 ;
   localparam N_DATA         = 8 ;
   localparam LOG2_N_DATA    = 4 ;
   localparam PARITY_CHECK   = 1 ;
   localparam EVEN_ODD_PARITY = 1 ;
   localparam M_STOP         = 1 ;
   localparam LOG2_M_STOP    = 1 ;


   // Outputs.
   wire    [N_DATA+PARITY_CHECK-1:0]           		  data_tb_o ;
   wire                                        		  rx_done_tb ;   // Data is ready
   wire                                        		  o_frame_valid;   // Data is ready
   // Inputs.

   reg    [NB_DATA-1:0]                         	  data_tb_i ;
   reg                                          	  reset_tb_i ;
   reg                                          	  clock_tb_i ;
   
   reg     [4-1:0]                                    timer ;
   wire                                               timeout ;
   reg     [((N_DATA+PARITY_CHECK+M_STOP+1)*2)-1:0]   data ;  

   // Wires.

   wire                                               brgen_valid_urx;

   initial begin
      clock_tb_i = 1'b0;
      reset_tb_i = 1'b0;
      data_tb_i = 'b0 ;
      timer = 1'b0 ;
      data = 'b01100100000100111011101 ;
      //frame recibido 1) 11101110 0
      //frame recibido 2) 00001001 1 Con error de paridad
      
      #2 reset_tb_i = 1'b1;
      #4 reset_tb_i = 1'b0;

      #5000 $finish;

   end

   always #2 clock_tb_i = ~clock_tb_i;

   always @ (posedge clock_tb_i)
   begin
      if (reset_tb_i || timeout)
         timer <= 1'b0 ;
      else if (brgen_valid_urx)
         timer <= timer + 1'b1 ;
   end

   assign timeout = ( timer == 15 ) ;

   always @ (posedge clock_tb_i)
   begin
      if (timeout)
      	 data <= data>>1'b1 ;
      	 data_tb_i <= data ;
   end



   uart_rx
   #(
      .NB_DATA        	(NB_DATA    ),  
      .N_DATA         	(N_DATA     ),
      .LOG2_N_DATA    	(LOG2_N_DATA),
      .PARITY_CHECK   	(PARITY_CHECK),
      .EVEN_ODD_PARITY	(EVEN_ODD_PARITY),
      .M_STOP         	(M_STOP     ),
      .LOG2_M_STOP    	(LOG2_M_STOP)
   )
   u_uart_rx
   (
      .o_data           (data_tb_o),
      .rx_done          (rx_done_tb),   
      .i_data           (data_tb_i),
      .i_valid          (brgen_valid_urx),   
      .i_reset          (reset_tb_i),   
      .i_clock          (clock_tb_i)
   );

   baudrate_generator#(
                 .CLK_FREQ(614400 )// 4 ciclos por tick
                 )
   u_gr_generator(
                  .o_tick(brgen_valid_urx),
                  .i_clk(clock_tb_i),
                  .i_rst(reset_tb_i)
                  );
endmodule
