module tb_uart_tx();
   
   localparam NB_DATA        = 8 ;
   localparam N_DATA         = 8 ;
   localparam LOG2_N_DATA    = 4 ;
   localparam PARITY_CHECK   = 1 ;
   localparam EVEN_ODD_PARITY = 1 ;
   localparam M_STOP         = 1 ;
   localparam LOG2_M_STOP    = 1 ;

   localparam N_FRAMES       = 2 ;


   // Outputs.
   wire                                        		  data_tb_o ;
   wire                                        		  tx_done_o_tb ;   // Data is ready
   // Inputs.
   reg                  [NB_DATA-1:0]                data_tb_i ;
   reg                                               tx_start_tb_i ;
   
   reg                                          	  valid_tb_i ;   // Throughput control.
   reg                                          	  reset_tb_i ;
   reg                                          	  clock_tb_i ;
   
   reg     [5-1:0]                                   timer ;
   reg     [5-1:0]                                   timeout_counter ;
   wire                                              timeout ;
   reg     [NB_DATA-1:0]                             data [N_FRAMES-1:0];  

   initial begin
      clock_tb_i = 1'b0;
      reset_tb_i = 1'b0;
      valid_tb_i = 1'b0;
      data_tb_i = 'b0 ;
      timer = 1'b0 ;
      data[0] = 'b11101110 ;
      data[1] = 'b00100100 ;
      
      #2 reset_tb_i = 1'b1;
      #4 reset_tb_i = 1'b0;

      #5 valid_tb_i = 1'b1 ;


      #5000 $finish;

   end

   always #2 clock_tb_i = ~clock_tb_i;

   always @ (posedge clock_tb_i)
   begin
      if (reset_tb_i || timeout)
         timer <= 1'b0 ;
      else if ( valid_tb_i )
         timer <= timer + 1'b1 ;
   end

   assign timeout = ( timer == 16 ) ;

   always @ (posedge clock_tb_i)
   begin
      if ( reset_tb_i )
         timeout_counter <= 1'b0 ;
      else if ( valid_tb_i && timeout )
         timeout_counter <= timeout_counter + 1'b1 ;
   end

   always @ (posedge clock_tb_i)
   begin
      if (timeout_counter % 16 == 0) begin // Cada 16 timeouts, mandar un frame
         tx_start_tb_i <= 1'b1 ;
         data_tb_i <= data[0] ;
         timeout_counter <= 1'b0 ;
      end
      else begin
         tx_start_tb_i <= 1'b0 ;
      end
   end



   uart_tx
   #(
      .NB_DATA        	(NB_DATA    ),  
      .N_DATA         	(N_DATA     ),
      .LOG2_N_DATA    	(LOG2_N_DATA),
      .PARITY_CHECK   	(PARITY_CHECK),
      .EVEN_ODD_PARITY	(EVEN_ODD_PARITY),
      .M_STOP         	(M_STOP     ),
      .LOG2_M_STOP    	(LOG2_M_STOP)
   )
   u_uart_tx
   (
      .o_data           (data_tb_o),
      .o_tx_done        (tx_done_o_tb), 
      .i_data           (data_tb_i),
      .i_tx_start       (tx_start_tb_i),
      .i_valid          (valid_tb_i),   
      .i_reset          (reset_tb_i),
      .i_clock          (clock_tb_i)
   );

endmodule
