module bip_uart_interface
	#(
		parameter                                   NB_DATA = 16,
		parameter                                   NB_DATATX = 16,
		parameter                                   N_ADDR = 16, 
		parameter                                   LOG2_N_INSMEM_ADDR = 11,
        parameter                                   NB_TIMER = 4
		)
	 (
		output [NB_DATA-1:0]                        o_data,
		
        output [7:0]                                LED,
        
		output                                      o_tx_start,
		output                                      o_valid,

        input  [1:0]                                sw,

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
    reg 			[NB_TIMER+2-1:0]	timer_rd ;
    reg 			[NB_TIMER-1:0] 		addr_rd ;
    reg             timeout_wr ;
    reg 			timeout_rd ;
    reg 			tx_done_d ;
    
    reg  [7:0]      led;

    wire 			[2-1:0]							seleccion ;
    wire 											tx_done_pos ;


    //TX done posedge
    always @(posedge i_clock) begin
    	if (i_reset)
    		tx_done_d <= 1'b0;
    	else
    		tx_done_d <= i_tx_done ;
    end

    assign tx_done_pos = i_tx_done & ~tx_done_d; //Pseudo-clock


    //Timer write
    always @(posedge i_clock)
    begin
    	if (i_reset) begin
    		timer_wr <= {NB_TIMER{1'b0}};
    		timeout_wr <= 1'b0;
    	end
    	else if(!timeout_wr) //No termino de escribir
    	begin  
    		timer_wr <= timer_wr + 1'b1;  
    		timeout_wr <= (timer_wr >= MAX_INSTR-1); //1 en timeout si termino de escribir, 0 si no.
    	end
    end

    //Timer read
    always @(posedge i_clock)
    begin
    	if (i_reset) 
    	begin
    		timer_rd <= {NB_TIMER{1'b0}};
    		timeout_rd <= 1'b0;
    	end
    	else if (timeout_wr && !timeout_rd && tx_done_pos) //Termino de escribir, no termino de leer y esta listo para enviar
    	begin   
    		timer_rd <= timer_rd + 1'b1 ;
    		timeout_rd <= (timer_rd >= (3*MAX_INSTR)-1);   //1 en timeout si termino de leer, 0 si no.
    	end
    end

    //Address read pointer
    always @(posedge i_clock)
    begin
    	if (i_reset)
    	begin
    		addr_rd <= {NB_TIMER{1'b0}};
    	end
    	else if (tx_done_pos && ((timer_rd + 1) % 3 == 0))  //Cada vez que termina de leer, avanza en el contador de registro a leer
    	begin
    		addr_rd <= addr_rd + 1'b1 ;
    	end
    end

    assign seleccion = (timer_rd == 0)? 1'b0 : (timer_rd % 3); //Contador de 0 a 2

	assign o_valid = 1'b1;

    always @ (negedge i_clock)
    begin
        if (i_reset)
            data <= {NB_DATA{1'b0}};
        else if (!timeout_wr)  // No termino de escribir 
        begin         
            acc_bank[timer_wr] <= i_acc;
            ins_bank[timer_wr] <= i_instruction;
            ncl_bank[timer_wr] <= i_nclock;
        end
        else if (tx_done_pos && !timeout_rd) // Si se puede enviar y no termino de leer
        begin
            case (seleccion)
            	2'b00: data <= ncl_bank[addr_rd];
            	2'b01: data <= ins_bank[addr_rd];
            	2'b10: data <= acc_bank[addr_rd];
            	default: data <= data;
            endcase
        end
    end

    assign o_data = data;

    assign o_tx_start = timeout_wr && !timeout_rd; // Empieza el envio si termino de escribir pero no de leer

    always @(posedge i_clock)
    begin
        case (sw)
            2'b00: led <= i_acc;
            2'b01: led <= i_instruction;
            2'b10: led <= i_nclock;
            default: led <= 16'hffff;
        endcase
    end
    
    assign LED = led;

endmodule
