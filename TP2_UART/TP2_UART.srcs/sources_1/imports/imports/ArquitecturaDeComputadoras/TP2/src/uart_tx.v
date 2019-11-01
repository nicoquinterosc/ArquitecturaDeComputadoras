`timescale 1ns / 1ps

module uart_tx 
#(
    // Parameters.
    parameter                                   NB_DATA         = 8 , // Parallelism meaning how many bits of information are ready to be sent
    parameter                                   N_DATA          = 8 , // Nr of bits from frame
    parameter                                   LOG2_N_DATA     = 4 , // LOG2 (N_DATA+PARITY)
    parameter                                   M_STOP          = 1 , // Nr of bits from stop 
    parameter                                   LOG2_M_STOP     = 1                            
)
(
    // Outputs.
    output  reg                                 o_data ,
    output  reg                                 o_tx_done ,   // Data is sent
    // Inputs.
    input   wire    [NB_DATA-1:0]               i_data ,
    input   wire                                i_tx_start ,
    input   wire                                i_valid ,   // Throughput control.

    input   wire                                i_reset ,
    input   wire                                i_clock
) ;

    //==========================================================================
    // LOCAL PARAMETERS.
    //==========================================================================

    // FSM
    localparam                                  NB_STATE        = 2 ;
    localparam      [NB_STATE-1:0]              ST_0_IDLE       = 0 ;
    localparam      [NB_STATE-1:0]              ST_1_START      = 1 ;
    localparam      [NB_STATE-1:0]              ST_2_DATA       = 2 ;
    localparam      [NB_STATE-1:0]              ST_3_STOP       = 3 ;

    // Other
    localparam                                  MAX_TIMER       = 16 ;
    localparam                                  NB_TIMER        = 4 ;

    localparam                                  NB_N_DATA_COUNTER = LOG2_N_DATA ;
    localparam                                  NB_M_STOP_COUNTER = LOG2_M_STOP ;                            

    //==========================================================================
    // INTERNAL SIGNALS.
    //==========================================================================
    reg             [NB_DATA-1:0]                   data ;
    reg             [NB_TIMER-1:0]                  timer ;
    wire                                            time_out ;

    wire                                            max_n_data_counter ;
    wire                                            max_m_stop_counter ;

    reg             [LOG2_N_DATA-1:0]               n_data_counter ;
    reg             [LOG2_M_STOP-1:0]               m_stop_counter ;

    // FSM
    reg             [NB_STATE-1:0]                  state ;
    reg             [NB_STATE-1:0]                  next_state ;

    reg                                             fsmo_start_bit ;
    reg                                             fsmo_reset_n_data_counter ; //Control signal to reset data counter
    reg                                             fsmo_reset_m_stop_counter ; //Control signal to reset stop counter
    reg                                             fsmo_reset_timer ;
    reg                                             fsmo_transmit_data ;
    reg                                             fsmo_tx_done ;
    reg                                             fsmo_stop_bit ;

    //==========================================================================
    // ALGORITHM.
    //==========================================================================

    //----------------------------------
    //FSM
    //----------------------------------

    // State update.
    always @( posedge i_clock )
    begin
        if ( i_reset )
            state <= ST_0_IDLE ;
        else if ( i_valid )
            state <= next_state ;
    end

    // Calculate next state and FSM outputs.
    always @( * )
    begin

        next_state                  = ST_0_IDLE ;
        fsmo_start_bit              = 1'b0 ;
        fsmo_reset_timer            = 1'b0 ;
        fsmo_reset_n_data_counter   = 1'b0 ;
        fsmo_reset_m_stop_counter   = 1'b0 ;
        fsmo_transmit_data          = 1'b0 ;
        fsmo_tx_done                = 1'b0 ;
        fsmo_stop_bit               = 1'b0 ;

        case ( state )
            ST_0_IDLE :
            begin
                casez ( {time_out, i_tx_start, max_n_data_counter, max_m_stop_counter} )
                    4'b?1??: next_state = ST_1_START ;
                    default: next_state = ST_0_IDLE ;
                endcase
            fsmo_start_bit              = 1'b0 ;
            fsmo_reset_timer            = i_tx_start ;
            fsmo_reset_n_data_counter   = 1'b0 ;
            fsmo_reset_m_stop_counter   = 1'b0 ;
            fsmo_transmit_data          = 1'b0 ;
            fsmo_tx_done                = 1'b0 ;
            fsmo_stop_bit               = 1'b0 ;
            end

            ST_1_START :
            begin
                casez ( {time_out, i_tx_start, max_n_data_counter, max_m_stop_counter} )
                    4'b1???: next_state = ST_2_DATA ;
                    default: next_state = ST_1_START ;
                endcase
            fsmo_start_bit              = 1'b1 ;
            fsmo_reset_timer            = 1'b0 ;
            fsmo_reset_n_data_counter   = time_out ;
            fsmo_reset_m_stop_counter   = 1'b0 ;
            fsmo_transmit_data          = 1'b0 ;
            fsmo_tx_done                = 1'b0 ; 
            fsmo_stop_bit               = 1'b0 ;
            end

            ST_2_DATA :
            begin
                casez ( {time_out, i_tx_start, max_n_data_counter, max_m_stop_counter} )
                    4'b??1?: next_state = ST_3_STOP ;
                    default: next_state = ST_2_DATA ;
                endcase
            fsmo_start_bit              = 1'b0 ;
            fsmo_reset_timer            = 1'b0 ;
            fsmo_reset_n_data_counter   = 1'b0 ;
            fsmo_reset_m_stop_counter   = max_n_data_counter ;
            fsmo_transmit_data          = 1'b1 ;
            fsmo_tx_done                = max_n_data_counter ;
            fsmo_stop_bit               = max_n_data_counter ;
            end

            ST_3_STOP :
            begin
                casez ( {time_out, i_tx_start, max_n_data_counter, max_m_stop_counter} )
                    4'b???1: next_state = ST_0_IDLE ;
                    default: next_state = ST_3_STOP ;
                endcase
            fsmo_start_bit              = 1'b0 ;
            fsmo_reset_timer            = 1'b0 ;
            fsmo_reset_n_data_counter   = 1'b0 ;
            fsmo_reset_m_stop_counter   = 1'b0 ;
            fsmo_transmit_data          = 1'b0 ;
            fsmo_tx_done                = 1'b0 ;
            fsmo_stop_bit               = 1'b1 ;
            end

        endcase
    end


    //----------------------------------
    //OTHER LOGIC
    //----------------------------------

    // Timer logic
    /*
    Timer que cuenta ticks para sincronizar los datos.
    */
    always @( posedge i_clock )
    begin
        if ( i_reset || i_valid && fsmo_reset_timer || i_valid && time_out )
            timer <= {NB_TIMER{1'b0}} ;
        else if ( i_valid && !time_out )
            timer <= timer + 1'b1 ;
    end

    assign time_out = &timer;

    // N_DATA Counter
    /*
    Contador que cuenta la cantidad de bits de datos en el frame.
    Al llegar a max_n_data_counter, se resetea.
    */
    always @( posedge i_clock )
    begin
        if ( i_reset || i_valid && fsmo_reset_n_data_counter )
            n_data_counter <= {NB_N_DATA_COUNTER{1'b0}} ;
        else if ( i_valid && !max_n_data_counter && time_out)
            n_data_counter <= n_data_counter + 1'b1 ;
    end

    assign max_n_data_counter = ( n_data_counter >= (N_DATA) ) ;

    // M_STOP Counter
    /*
    Contador que cuenta la cantidad de bits de stop en el frame.
    Al llegar a max_m_stop_counter, se resetea.
    */
    always @( posedge i_clock )
    begin
        if ( i_reset || i_valid && fsmo_reset_m_stop_counter )
            m_stop_counter <= {NB_M_STOP_COUNTER{1'b0}} ;
        else if ( i_valid && !max_m_stop_counter && time_out)
            m_stop_counter <= m_stop_counter + 1'b1 ;
    end

    assign max_m_stop_counter = ( m_stop_counter >= M_STOP) ;    

    // Data copy into internal register

    // Frame composition + TX
   always @( posedge i_clock )
     begin
        if ( i_reset ) begin
           o_data <= 1'b1 ;
           data <= {NB_DATA{1'b0}} ;
        end
        else if ( i_valid && i_tx_start && (state==ST_0_IDLE))
          data <= i_data ;
        else if ( i_valid && fsmo_start_bit && time_out )
            o_data <= 1'b0 ;
        else if ( i_valid && fsmo_transmit_data && time_out) begin
            {data, o_data} <= {1'b0, data} ;
            end
        else if ( i_valid && fsmo_stop_bit && time_out )
            o_data <= 1'b1 ;      
    end

    // tx_done
    always @ ( posedge i_clock )
    begin
        if ( i_reset )
            o_tx_done <= 1'b0 ;
        else if ( i_valid )
            o_tx_done <= fsmo_tx_done;
    end

endmodule
