`timescale 1ns / 1ps

module bip_data_memory
#(
    // Parameters.
    parameter 									NB_DATA = 16,
    parameter 									N_ADDR = 1024, 
    parameter 									LOG2_N_DATA_ADDR = 10
)
(
    // Outputs.
    output wire     [NB_DATA-1:0]               o_data,
    // Inputs.
    input  wire 	[LOG2_N_DATA_ADDR-1:0]		i_addr, // Address to read/write from
    input  wire     [NB_DATA-1:0]		        i_data,
    input  wire                                 i_clock,
    input  wire                                 i_wr, //Write enable
    input  wire                                 i_rd, //Read enable
    input  wire                                 i_reset 				
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
    initial begin
    mem_bank[0] = 16'h0000 ;
    mem_bank[1] = 16'h0001 ;
    mem_bank[2] = 16'h0002 ;
    mem_bank[3] = 16'h0003 ;
    mem_bank[4] = 16'h0004 ;
    mem_bank[5] = 16'h0005 ;
    mem_bank[6] = 16'h0006 ;
    mem_bank[7] = 16'h0007 ;
    mem_bank[8] = 16'h0008 ;
    mem_bank[9] = 16'h0009 ;
    end

    assign o_data = data ;

    always @ (negedge i_clock)
    begin
        if (i_reset)
            data <= {NB_DATA{1'b0}};
        else if (i_wr)
            mem_bank[i_addr] <= i_data ; //Write
        else if (i_rd)
            data <= mem_bank[i_addr]; //Read
    end

endmodule