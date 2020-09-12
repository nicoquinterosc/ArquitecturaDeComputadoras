//Listing 8.5
//-- * notes to run on logi
//-- * using led-sseg display to show the led values
//-- * using onboard leds to show the buffer full/empty
//-- * using minicom running on the rpi to act as the uart interface to the fpga
//--		--you must have minicom installed and make a connection with 8n1 baud:19200.
//-- 		see: http://www.hobbytronics.co.uk/raspberry-pi-serial-port to install and run minicom
//-- 		1) run: sudo apt-get install minicom
//--		2) run: minicom -b 19200 -o -D /dev/ttyAMA0

module uart_test;
	reg clk;
	reg reset;
	reg rx;
	wire tx;
	reg [7:0] temp;
	wire [7:0] w_data;
	wire [7:0] r_data;

   // signal declaration
    wire tx_full, rx_empty, btn_tick;

   // body
   // instantiate uart
   uart uart_unit
      (.clk(clk), .reset(reset), .rd_uart(btn_tick),
       .wr_uart(btn_tick), .rx(rx), .w_data(w_data),
       .tx_full(tx_full), .rx_empty(rx_empty),
       .r_data(r_data), .tx(tx));
   // incremented data loops back
   // LED display
	
	initial begin
		// Wait for initialization
		reset = 1'b1;
		clk = 1'b0;
		rx = 1'b1;
		#10;
		rx = 1'b0;
		#10;
		//w_data = 8'hbb;
		reset = 1'b0;
		forever begin
            #1 clk = ~clk;
		end
	end 

endmodule