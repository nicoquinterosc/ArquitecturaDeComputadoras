module bip_uart_interface
	#(
		parameter                                   NB_DATA = 16,
		parameter                                   NB_DATATX = 16,
		parameter                                   N_ADDR = 16, 
		parameter                                   LOG2_N_INSMEM_ADDR = 11,
		parameter                                   N_WORD_BUFFER = 30,
        parameter                                   NB_TIMER = 4
		)
	 (
		output [NB_DATA-1:0]                        o_data,
		output                                      o_tx_start,
		output                                      o_valid,

		input                                       i_tx_done,

		input [NB_DATA-1:0]                         i_acc, 
		input [NB_DATA-1:0]                         i_instruction,
		input [LOG2_N_INSMEM_ADDR-1:0]              i_nclock,

		input                                       i_clock, 
		input 										i_reset
		);

	localparam 								  		MAX_INSTR = 10;

    reg             [NB_DATA-1:0]               	acc_bank [N_ADDR-1:0] ;
    reg             [NB_DATA-1:0]               	ins_bank [N_ADDR-1:0] ;
    reg             [NB_DATA-1:0]               	ncl_bank [N_ADDR-1:0] ;
    reg             [NB_DATA-1:0]                 	data ;   

    reg 			[NB_TIMER-1:0]		timer_wr ;
    reg 			[NB_TIMER+2-1:0]		timer_rd ;
    reg 			[NB_TIMER-1:0] 		addr_rd ;
    reg                                             timeout_wr ;
    reg 											timeout_rd ;
    reg 											tx_done_d ;

    wire 			[2-1:0]							seleccion ;
    wire 											tx_done_pos ;


    //TX done posedge
    always @(posedge i_clock) begin
    	if (i_reset)
    		tx_done_d <= 1'b0;
    	else
    		tx_done_d <= i_tx_done ;
    end

    assign tx_done_pos = i_tx_done & ~tx_done_d; 


    //Timer write
    always @(posedge i_clock)begin
    	if (i_reset) begin
    		timer_wr <= {NB_TIMER{1'b0}};
    		timeout_wr <= 1'b0;
    	end
    	else if(!timeout_wr) begin
    		timer_wr <= timer_wr + 1'b1;
    		timeout_wr <= (timer_wr >= MAX_INSTR-1);
    	end
    end

    //Timer read
    always @(posedge i_clock)begin
    	if (i_reset) begin
    		timer_rd <= {NB_TIMER{1'b0}};
    		timeout_rd <= 1'b0;
    	end
    	else if (timeout_wr && !timeout_rd && tx_done_pos) begin
    		timer_rd <= timer_rd + 1'b1 ;
    		timeout_rd <= (timer_rd >= (3*MAX_INSTR)-1) ;
    	end
    end

    //Address read pointer
    always @(posedge i_clock)begin
    	if (i_reset) begin
    		addr_rd <= {NB_TIMER{1'b0}};
    	end
    	else if (tx_done_pos && ((timer_rd + 1) % 3 == 0)) begin
    		addr_rd <= addr_rd + 1'b1 ;
    	end
    end

    assign seleccion = (timer_rd == 0)? 1'b0 : (timer_rd % 3);

	assign o_valid = 1'b1;

    always @ (negedge i_clock)
    begin
        if (i_reset)
            data <= {NB_DATA{1'b0}};
        else if (!timeout_wr) begin
            acc_bank[timer_wr] <= i_acc ;
            ins_bank[timer_wr] <= i_instruction ;
            ncl_bank[timer_wr] <= i_nclock ;
        end
        else if (tx_done_pos && !timeout_rd) begin
            case (seleccion)
            	2'b00: data <= ncl_bank[addr_rd] ;
            	2'b01: data <= ins_bank[addr_rd] ;
            	2'b10: data <= acc_bank[addr_rd] ;
            	default: data <= data ;
            endcase
        end
    end

    assign o_data = data ;

    assign o_tx_start = timeout_wr && !timeout_rd ;





/*
	 wire [3*NB_DATATX-1:0]                       ext_data;
	 wire [NB_DATATX-1:0]                         tx_i_data;
	 wire                                         fifo_full;
	 wire                                         neg_tx_start;
	 reg [1:0]                                    state;
	 reg                                          valid_reg;


	assign o_tx_start = ~neg_tx_start;




	 
	 always@(posedge i_clk)begin
			valid_reg <= (state==2'b00);
			if(i_rst) begin
				state <= 2'b00;
				valid_reg <= 1'b1;
			end else begin
				if(!fifo_full)
					state <= state +1'b1;
			end
	 end

	 assign o_valid = (state==2'b00) ;//& ~valid_reg;
	 
	 assign ext_data = {
											 i_acc[NB_DATATX-1:0],
											 i_instruction[NB_DATATX-1:0],
											 i_nclock[NB_DATATX-1:0]
											 };

	 assign tx_i_data = ext_data[state*NB_DATATX-:NB_DATATX];

	 FIFO#(
				 .NB_WORD(NB_DATATX),
				 .N_WORD_BUFFER(N_WORD_BUFFER)
				 )
	 u_FIFO(
					.o_data(o_data),
					.o_fifo_empty(neg_tx_start),
					.o_fifo_full(fifo_full), //not connected
					.i_data(tx_i_data),
					.i_read(i_tx_done),
					.i_write(~fifo_full),
					.i_rst(i_rst),
					.i_clk(i_clk)
					);

*/



endmodule
