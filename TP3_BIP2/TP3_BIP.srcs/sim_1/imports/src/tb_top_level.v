module tb_top_level();

    //==========================================================================
    // LOCAL PARAMETERS.
    //==========================================================================
    localparam                                   NB_DATA = 16;
    localparam                                   NB_OPCODE = 5;
    localparam                                   NB_OPERAND = 11;
    localparam                                   N_INSMEM_ADDR = 2048;
    localparam                                   LOG2_N_INSMEM_ADDR = 11;
    localparam                                   N_DATA_ADDR = 1024;
    localparam                                   LOG2_N_DATA_ADDR = 10;
    localparam                                   NB_SEL_A = 2;
    localparam                                   NB_DATA_S_EXT = 10;
    localparam                                   NB_EXTENSION_SIZE = 6;
    //==========================================================================
    // INTERNAL SIGNALS.
    //==========================================================================
   wire out;
   
    wire                                        reset ;
    reg                                         clock = 1'b0 ;
    integer                                     timer = 0 ;

    //==========================================================================
    // CONNECTION TO DUT
    //==========================================================================
   top_level
     u_top(
           .RsTx(out),
           .i_clk(clock),
           .i_btnC(reset)
           );
    //==========================================================================
    // ALGORITHM.
    //==========================================================================
    initial
        #10000 $stop;
        
    always
    begin
        #(50) clock = ~clock ;
    end

    always @ ( posedge clock )
    begin
        timer   <= timer + 1;
    end

    assign reset = (timer == 10) ;
    


endmodule
