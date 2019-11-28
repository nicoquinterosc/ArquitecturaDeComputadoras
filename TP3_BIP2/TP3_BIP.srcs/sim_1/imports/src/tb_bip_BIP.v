module tb_bip_BIP ();                          

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
    wire     [NB_DATA-1:0]                      acc;
    wire     [NB_DATA-1:0]                      instruction;
    wire     [LOG2_N_INSMEM_ADDR-1:0]           pc;

    wire                                        reset ;
    reg                                         clock = 1'b0 ;
    integer                                     timer = 0 ;

    //==========================================================================
    // CONNECTION TO DUT
    //==========================================================================
    bip_BIP
    #(
        .NB_DATA                (NB_DATA           ),
        .NB_OPCODE              (NB_OPCODE         ),
        .NB_OPERAND             (NB_OPERAND        ),    
        .N_INSMEM_ADDR          (N_INSMEM_ADDR     ),    
        .LOG2_N_INSMEM_ADDR     (LOG2_N_INSMEM_ADDR),            
        .N_DATA_ADDR            (N_DATA_ADDR       ),    
        .LOG2_N_DATA_ADDR       (LOG2_N_DATA_ADDR  ),        
        .NB_SEL_A               (NB_SEL_A          ),
        .NB_DATA_S_EXT          (NB_DATA_S_EXT     ),    
        .NB_EXTENSION_SIZE      (NB_EXTENSION_SIZE )        
    )
    u_bip_BIP
    (
        .o_acc                  (acc),
        .o_instruction          (instruction),        
        .o_pc                   (pc),
        .i_clock                (clock),    
        .i_valid                (1'b1),    
        .i_reset                (reset)        
    );

    //==========================================================================
    // ALGORITHM.
    //==========================================================================

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