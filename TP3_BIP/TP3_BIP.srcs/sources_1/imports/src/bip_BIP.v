module bip_BIP
#(
    // Parameters.
    parameter                                   NB_DATA = 16,
    parameter                                   NB_OPCODE = 5,
    parameter                                   NB_OPERAND = 11,
    parameter                                   N_INSMEM_ADDR = 2048,
    parameter                                   LOG2_N_INSMEM_ADDR = 11,
    parameter                                   N_DATA_ADDR = 1024, 
    parameter                                   LOG2_N_DATA_ADDR = 10,
    parameter                                   NB_SEL_A = 2, 
    parameter                                   NB_DATA_S_EXT = 10,
    parameter                                   NB_EXTENSION_SIZE = 6
)
(
    // Outputs.
    output wire     [NB_DATA-1:0]               o_acc,
    output wire     [NB_DATA-1:0]               o_instruction,
    output wire     [LOG2_N_INSMEM_ADDR-1:0]    o_pc,
    
    input  wire                                 i_clock,
    input  wire                                 i_valid,
    input  wire                                 i_reset                             
) ; 

    //==========================================================================
    // LOCAL PARAMETERS.
    //==========================================================================

    //==========================================================================
    // INTERNAL SIGNALS.
    //==========================================================================
    wire [LOG2_N_INSMEM_ADDR-1:0]         addr_instr;
    wire [LOG2_N_DATA_ADDR-1:0]           data_instr;

    wire                                  rd;
    wire                                  wr;

    wire [NB_DATA-1:0]                    data_pc_to_mem;
    wire [NB_DATA-1:0]                    instr;
    wire [NB_DATA-1:0]                    data_mem;
   reg [LOG2_N_INSMEM_ADDR-1:0]           n_clock;


    //==========================================================================
    // ALGORITHM.
    //==========================================================================


   assign o_pc = n_clock;
   assign o_instruction = instr ;
   assign o_acc = data_pc_to_mem;
   
   always@(posedge i_clock) begin
      if(i_reset)
        n_clock <= {LOG2_N_INSMEM_ADDR{1'b0}};
      else
        if(i_valid)
          n_clock <= n_clock +1'b1;
   end

    bip_cpu
    #(              
        .NB_DATA                        (NB_DATA           ),  
        .NB_OPCODE                      (NB_OPCODE         ),  
        .NB_OPERAND                     (NB_OPERAND        ),      
        .N_INSMEM_ADDR                  (N_INSMEM_ADDR     ),      
        .LOG2_N_INSMEM_ADDR             (LOG2_N_INSMEM_ADDR),              
        .N_DATA_ADDR                    (N_DATA_ADDR       ),      
        .LOG2_N_DATA_ADDR               (LOG2_N_DATA_ADDR  ),          
        .NB_SEL_A                       (NB_SEL_A          ),  
        .NB_DATA_S_EXT                  (NB_DATA_S_EXT     ),      
        .NB_EXTENSION_SIZE              (NB_EXTENSION_SIZE )          
    )
    u_bip_cpu
    (
        .o_addr_instr                   (addr_instr),  // To Program mem          
        .o_data_instr                   (data_instr),  // To Data mem         
        .o_data                         (data_pc_to_mem), // From ACC to data mem  
        .o_wr_ram                       (wr),       
        .o_rd_ram                       (rd),                                       
                                    
        .i_instruction                  (instr),           
        .i_data_mem                     (data_mem),                                    
        .i_clock                        (i_clock),       
        .i_valid                        (i_valid),       
        .i_reset                        (i_reset)                                   
    ) ; 

    bip_program_memory
    #(
        .NB_DATA                        (NB_DATA           ),          
        .N_ADDR                         (N_INSMEM_ADDR     ),      
        .LOG2_N_INSMEM_ADDR             (LOG2_N_INSMEM_ADDR)                  
    )
    u_bip_program_memory
    (
        .o_data                         (instr),
        
        .i_addr                         (addr_instr), 
        .i_clock                        (i_clock),
        .i_enable                       (i_valid),
        .i_reset                        (i_reset)
    );
    
    bip_data_memory
    #(    
        .NB_DATA                        (NB_DATA         ),
        .N_ADDR                         (N_DATA_ADDR     ),
        .LOG2_N_DATA_ADDR               (LOG2_N_DATA_ADDR)            
    )
    u_bip_data_memory
    (
       .o_data                          (data_mem),          
                        
       .i_addr                          (data_instr),         
       .i_data                          (data_pc_to_mem),         
       .i_clock                         (i_clock),         
       .i_wr                            (wr),         
       .i_rd                            (rd),         
       .i_reset                         (i_reset)                          
    );      

endmodule
