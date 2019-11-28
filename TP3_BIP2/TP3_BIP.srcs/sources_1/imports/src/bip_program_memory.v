module bip_program_memory
#(
    // Parameters.
    parameter 									NB_DATA = 16,
    parameter 									N_ADDR = 2048,
    parameter 									LOG2_N_INSMEM_ADDR = 11
)
(
    // Outputs.
    output wire     [NB_DATA-1:0]               o_data,
    // Inputs.
    input  wire 	[LOG2_N_INSMEM_ADDR-1:0]    i_addr, // Signal from control unit
    input  wire 								i_clock,
    input  wire 								i_enable,
    input  wire 								i_reset 							
) ;	

    //==========================================================================
    // LOCAL PARAMETERS.
    //==========================================================================


    //==========================================================================
    // INTERNAL SIGNALS.
    //==========================================================================
    reg             [NB_DATA-1:0]               mem_bank [N_ADDR-1:0] ;
    reg             [NB_DATA-1:0]               data ;                            

    //==========================================================================
    // ALGORITHM.
    //==========================================================================
    //  | 15 Opcode 11 | 10 Operand 0 | Instruction format
    initial begin
    mem_bank[0] = 16'b00010_000_0000_0001 ; //Load variable 0x01 => ACC=0x01
    mem_bank[1] = 16'b00101_000_0000_0010 ; //Add immediate +0x2 => ACC=0x03
    mem_bank[2] = 16'b00001_000_0000_0111 ; //Store in 0x7 => ACC=0x03
    mem_bank[3] = 16'b00011_000_0000_1000 ; //Load immediate 0x08 => ACC=0x08
    mem_bank[4] = 16'b00110_000_0000_0010 ; //Substract variable in 0x02 => ACC=0x06  
    mem_bank[5] = 16'b00100_000_0000_0010 ; //Add variable in 0x02 => ACC=0x08
    mem_bank[6] = 16'b00001_000_0000_0100 ; //Store in 0xB => ACC=0x08
    mem_bank[7] = 16'b00011_000_0000_0011 ; //Load immediate 0x03 => ACC=0x03
    mem_bank[8] = 16'b00111_000_0000_0011 ; //Substract immediate 0x03 => ACC=0x00
    mem_bank[9] = 16'b00000_000_0000_0000 ; // Halt
    end

    assign o_data = data ;

    always @ (posedge i_clock)
    begin
        if (i_reset)
            data <= mem_bank[0];
        else if (i_enable)
            data <= mem_bank[i_addr];
    end

endmodule