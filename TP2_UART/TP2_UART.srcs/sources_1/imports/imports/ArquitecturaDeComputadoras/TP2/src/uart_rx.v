`timescale 1ns / 1ps

module uart_rx 
#(
    // Parameters.
    parameter                                   NB_DATA         = 1 , // Parallelism = 1
    parameter                                   N_DATA          = 8 , // Nr of bits from frame
    parameter                                   LOG2_N_DATA     = 4 , // LOG2 (N_DATA+PARITY)
    parameter                                   M_STOP          = 1 , // Nr of bits from stop 
    parameter                                   LOG2_M_STOP     = 1                            
)
(
    // Outputs.
    output  reg     [N_DATA-1:0]   o_data ,
    output  reg                                 rx_done ,   // Data is ready
    // Inputs.
    input   wire    [NB_DATA-1:0]               i_data ,
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
    localparam                                  MAX_TIMER       = 15 ;
    localparam                                  NB_TIMER        = 4 ;

    localparam                                  NB_N_DATA_COUNTER = LOG2_N_DATA ;
    localparam                                  NB_M_STOP_COUNTER = LOG2_M_STOP ;                            

    //==========================================================================
    // INTERNAL SIGNALS.
    //==========================================================================
    reg                                             data_d ;
    wire                                            data_negedge ;

    reg             [NB_TIMER-1:0]                  timer ;
    wire                                            time_out ;

    wire                                            sof ;
    wire                                            max_n_data_counter ;
    wire                                            max_m_stop_counter ;
    wire                                            sampling_timeout ;

    reg             [LOG2_N_DATA-1:0]               n_data_counter ;
    reg             [LOG2_M_STOP-1:0]               m_stop_counter ;

    // FSM
    reg             [NB_STATE-1:0]                  state ;
    reg             [NB_STATE-1:0]                  next_state ;

    reg                                             fsmo_idle ;
    reg                                             fsmo_reset_timer ;
    //reg                                             fsmo_start_timer ;
    reg                                             fsmo_middle_sampling ; //Control signal for sampling at 7 clocks
    reg                                             fsmo_reset_n_data_counter ; //Control signal to reset data counter
    reg                                             fsmo_reset_m_stop_counter ; //Control signal to reset stop counter
    reg                                             fsmo_capture_data ;
    reg                                             fsmo_data_ready ;

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
        fsmo_idle                   = 1'b1 ;
        fsmo_reset_timer            = 1'b0 ;
        fsmo_middle_sampling        = 1'b0 ;
        fsmo_reset_n_data_counter   = 1'b0 ;
        fsmo_reset_m_stop_counter   = 1'b0 ;
        fsmo_capture_data           = 1'b0 ;
        fsmo_data_ready             = 1'b0 ;

        case ( state )
            ST_0_IDLE :
            begin
                casez ( {sampling_timeout, sof, max_n_data_counter, max_m_stop_counter} )
                    4'b?1?? : next_state   = ST_1_START ;
                    default : next_state   = ST_0_IDLE ;
                endcase
                fsmo_idle                   = 1'b1 ;
                fsmo_reset_timer            = sof  ;
                fsmo_middle_sampling        = 1'b0 ;
                fsmo_reset_n_data_counter   = 1'b0 ;
                fsmo_reset_m_stop_counter   = 1'b0 ;
                fsmo_capture_data           = 1'b0 ;
                fsmo_data_ready             = 1'b0 ;
            end

            ST_1_START :
            begin
                casez ( {sampling_timeout, sof, max_n_data_counter, max_m_stop_counter} )
                    4'b1??? : next_state   = ST_2_DATA ;
                    default : next_state   = ST_1_START ;
                endcase
                fsmo_idle                   = 1'b0 ;
                fsmo_reset_timer            = sampling_timeout ;
                fsmo_middle_sampling        = 1'b1 ;
                fsmo_reset_n_data_counter   = sampling_timeout ;
                fsmo_reset_m_stop_counter   = 1'b0 ;
                fsmo_capture_data           = 1'b0 ;
                fsmo_data_ready             = 1'b0 ;
            end

            ST_2_DATA :
            begin
                casez ( {sampling_timeout, sof, max_n_data_counter, max_m_stop_counter} )
                    4'b??1? : next_state   = ST_3_STOP ;
                    default : next_state   = ST_2_DATA ;
                endcase
                fsmo_idle                   = 1'b0 ;
                fsmo_reset_timer            = max_n_data_counter ;
                fsmo_middle_sampling        = 1'b0 ;
                fsmo_reset_n_data_counter   = 1'b0 ;
                fsmo_reset_m_stop_counter   = max_n_data_counter ;
                fsmo_capture_data           = 1'b1 ;
                fsmo_data_ready             = 1'b0 ;
            end

            ST_3_STOP :
            begin
                casez ( {sampling_timeout, sof, max_n_data_counter, max_m_stop_counter} )
                    4'b???1 : next_state    = ST_0_IDLE ;
                    default : next_state    = ST_3_STOP ;
                endcase
                fsmo_idle                   = 1'b0 ;
                fsmo_reset_timer            = 1'b0 ;
                fsmo_middle_sampling        = 1'b0 ;
                fsmo_reset_n_data_counter   = 1'b0 ;
                fsmo_reset_m_stop_counter   = 1'b0 ;
                fsmo_capture_data           = 1'b0 ;
                fsmo_data_ready             = max_m_stop_counter ;
            end

        endcase
    end


    //----------------------------------
    //OTHER LOGIC
    //----------------------------------

    // Negedge from data
    always @( posedge i_clock )
    begin
        if ( i_reset )
            data_d <= 1'b0 ;
        else if ( i_valid )
            data_d <= i_data ;
    end

    assign data_negedge = ~i_data & data_d ;

    assign sof = (data_negedge && fsmo_idle);

    // Shift register for the output
   always @( posedge i_clock )
     begin
        if ( i_reset )
          o_data <= {(N_DATA){1'b0}} ;
        else if ( i_valid && fsmo_capture_data && time_out)
          o_data <= {i_data, o_data[N_DATA-1:1]} ;
     end

    // Signal that there is data ready
    always @( posedge i_clock )
    begin
        if ( i_reset )
            rx_done <= 1'b0 ;
        else if ( i_valid )
            rx_done <= fsmo_data_ready ;
    end


    // Timer logic
    /*
    Timer que cuenta ticks para sincronizar los datos.
    */
    //TODO: Ver tema de racing condition entre timeout para el contador de n y m
    always @( posedge i_clock )
    begin
        if ( i_reset || i_valid && fsmo_reset_timer || i_valid && time_out )
            timer <= {NB_TIMER{1'b0}} ;
        else if ( i_valid && !time_out )
            timer <= timer + 1'b1 ;
    end

    assign time_out = &timer;

    assign sampling_timeout = (( timer >= 7 ) && fsmo_middle_sampling ) ;

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

endmodule
