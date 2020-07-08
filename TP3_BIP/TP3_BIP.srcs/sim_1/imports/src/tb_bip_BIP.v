`timescale 1ns / 1ps

module tb_bip_BIP ();                          

    //==========================================================================
    // LOCAL PARAMETERS.
    //==========================================================================
    localparam                                   NB_DATA = 16;
    localparam                                   NB_OPCODE = 5;
    localparam                                   NB_OPERAND = 11;
    localparam                                   N_INSMEM_ADDR = 2048;
    localparam                                   NB_INS = 11;
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
    wire     [NB_INS-1:0]           pc;
    wire enable;
    wire                                        counter;
    wire                                        reset ;
    wire [NB_OPCODE-1:0] show_opcode;
    reg                                         clock = 1'b0 ;
    integer                                     timer = 0 ;
    wire                                        valid;
    wire [NB_INS-1:0] mostrar_pc;

    //==========================================================================
    // CONNECTION TO DUT
    //==========================================================================
    bip_BIP
    #(
        .NB_DATA                (NB_DATA           ),
        .NB_OPCODE              (NB_OPCODE         ),
        .NB_OPERAND             (NB_OPERAND        ),    
        .N_INSMEM_ADDR          (N_INSMEM_ADDR     ),    
        .NB_INS     (NB_INS),            
        .N_DATA_ADDR            (N_DATA_ADDR       ),    
        .LOG2_N_DATA_ADDR       (LOG2_N_DATA_ADDR  ),        
        .NB_SEL_A               (NB_SEL_A          ),
        .NB_DATA_S_EXT          (NB_DATA_S_EXT     ),    
        .NB_EXTENSION_SIZE      (NB_EXTENSION_SIZE )        
    )
    u_bip_BIP
    (
        .o_acc                  (acc),
        .o_instruction          (instructi on),        
        .o_pc                   (pc),
        .o_enable(enable),
        .i_clock                (clock),    
        .i_valid                (valid),    
        .i_reset                (reset),
        .mostrar_pc(mostrar_pc),
        .show_opcode (show_opcode)    
    );
    
     counter 
        u_counter(
                .o_valid(valid),
                .i_clk(clock),
                .i_rst(reset),
                .i_enable(enable)
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
        timer <= timer + 1;
    end

    assign reset = (timer == 1) ;

endmodule