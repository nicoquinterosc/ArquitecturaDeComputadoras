`timescale 1ns / 1ps

module bip_datapath
#(
    // Parameters.
    parameter 									NB_DATA = 16,
    parameter 									NB_OPCODE = 5,
    parameter 									NB_OPERAND = 11,
    parameter 									N_INSMEM_ADDR = 2048,
    parameter 									NB_INS = 11,
    parameter 									N_DATA_ADDR = 1024, 
    parameter 									LOG2_N_DATA_ADDR = 10,
    parameter                                   NB_SEL_A = 2, 
    parameter                                   NB_DATA_S_EXT = 10,
    parameter                                   NB_EXTENSION_SIZE = 6
)
(
    // Outputs.
    output wire     [NB_DATA-1:0]               o_data,
    // Inputs.
    input  wire 	[NB_DATA_S_EXT-1:0]		    i_data_instruction, // Signal from control unit
    input  wire     [NB_DATA-1:0]               i_data_mem, // Memory coming from data bank
    input  wire     [NB_SEL_A-1:0]              i_sel_a,
    input  wire                                 i_sel_b,
    input  wire                                 i_wr_acc,
    input  wire                                 i_op_code,
    input  wire 								i_clock,
    input  wire 								i_valid,
    input  wire 								i_reset 							
) ;	

    //==========================================================================
    // LOCAL PARAMETERS.
    //==========================================================================


    //==========================================================================
    // INTERNAL SIGNALS.
    //==========================================================================
    reg 			[NB_DATA-1:0]			    acc ; // Accumulator register

    wire            [NB_DATA-1:0]               mux_selb ;
    //reg             [NB_DATA-1:0]               mux_selb_d ;
    wire            [NB_DATA-1:0]               extended_signal ;
    wire            [NB_DATA-1:0]               alu_out ;

    //==========================================================================
    // ALGORITHM.
    //==========================================================================
    assign o_data = acc ; // Output from accumulator register

    assign mux_selb = (i_sel_b)? extended_signal : i_data_mem ; // Mux that selects either extended signal or input from data bank

    assign extended_signal = {{NB_EXTENSION_SIZE{i_data_instruction[NB_DATA_S_EXT-1]}}, i_data_instruction} ; // Replicate sign to get to NB_DATA bits

    assign alu_out = (i_op_code)? acc + mux_selb : acc - mux_selb ;

    //Accumulator mux
    always @ (posedge i_clock) 
    begin
        if (i_reset)
            acc <= {NB_DATA{1'b0}};
        else if (i_wr_acc & i_valid) 
        begin
            case (i_sel_a)
            2'b00: acc <= i_data_mem;
            2'b01: acc <= extended_signal;
            2'b10: acc <= alu_out;
            default: acc <= acc;
            endcase
        end
    end

endmodule
