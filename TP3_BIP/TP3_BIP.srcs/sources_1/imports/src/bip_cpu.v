`timescale 1ns / 1ps

module bip_cpu
#(
    // Parameters.
    parameter                                   NB_DATA = 16,
    parameter                                   NB_OPCODE = 5,
    parameter                                   NB_OPERAND = 11,
    parameter                                   N_INSMEM_ADDR = 2048,
    parameter                                   NB_INS = 11,
    parameter                                   N_DATA_ADDR = 1024, 
    parameter                                   LOG2_N_DATA_ADDR = 10,
    parameter                                   NB_SEL_A = 2, 
    parameter                                   NB_DATA_S_EXT = 10,
    parameter                                   NB_EXTENSION_SIZE = 6
)
(
    // Outputs.
    output wire     [NB_INS-1:0]    o_addr_instr,
    output wire     [NB_DATA_S_EXT-1:0]         o_data_instr,
    output wire     [NB_DATA-1:0]               o_data,
    output wire                                 o_wr_ram,
    output wire                                 o_rd_ram,
    output wire                                 o_enable,
    output wire     [NB_OPCODE-1:0]                          show_opcode,

    // Inputs.
    input  wire     [NB_DATA-1:0]               i_instruction, 
    input  wire     [NB_DATA-1:0]               i_data_mem,

    input  wire                                 i_clock,
    input  wire                                 i_valid,
    input  wire                                 i_reset,
    
    output wire     [NB_INS-1:0]                mostrar_pc                             
) ; 

    //==========================================================================
    // LOCAL PARAMETERS.
    //==========================================================================

    //==========================================================================
    // INTERNAL SIGNALS.
    //==========================================================================
    wire [NB_INS-1:0]                     addr_instr;
    wire [NB_DATA_S_EXT-1:0]              data_instr;
    wire                                  rd;
    wire                                  wr;
    wire [NB_DATA-1:0]                    data ;


    wire [NB_SEL_A-1:0]                   sel_a;
    wire                                  sel_b;
    wire                                  wr_acc;
    wire                                  op_code;


    //==========================================================================
    // ALGORITHM.
    //==========================================================================

    assign o_addr_instr = addr_instr ;
    assign o_data_instr = data_instr ;
    assign o_rd_ram = rd ;
    assign o_wr_ram = wr ;
    assign o_data = data ;

    bip_control
    #(
        .NB_DATA                (NB_DATA           ),   
        .NB_OPCODE              (NB_OPCODE         ),   
        .NB_OPERAND             (NB_OPERAND        ),       
        .N_INSMEM_ADDR          (N_INSMEM_ADDR     ),          
        .NB_INS     (NB_INS),               
        .N_DATA_ADDR            (N_DATA_ADDR       ),       
        .LOG2_N_DATA_ADDR       (LOG2_N_DATA_ADDR  ),           
        .NB_SEL_A               (NB_SEL_A          )
    )
    u_bip_control
    (
        .o_sel_a                (sel_a),
        .o_sel_b                (sel_b),
        .o_wr_acc               (wr_acc),
        .o_op_code              (op_code),
        .o_wr_ram               (wr),
        .o_rd_ram               (rd),
        .o_addr_instr           (addr_instr),
        .o_data_instr           (data_instr),
        .o_enable               (o_enable),
        .show_opcode            (show_opcode),
        .mostrar_pc             (mostrar_pc),

        .i_instruction          (i_instruction),
        .i_clock                (i_clock),
//        .i_valid                (i_valid),
        .i_reset                (i_reset) 
    );

    bip_datapath
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
    u_bip_datapath
    (
        .o_data                 (data),

        .i_data_instruction     (data_instr),            
        .i_data_mem             (i_data_mem),    
        .i_sel_a                (sel_a),    
        .i_sel_b                (sel_b),    
        .i_wr_acc               (wr_acc),    
        .i_op_code              (op_code),    
        .i_clock                (i_clock),    
        .i_valid                (i_valid),    
        .i_reset                (i_reset)                
    );

endmodule