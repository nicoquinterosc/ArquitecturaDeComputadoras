module bip_control
#(
    // Parameters.
    parameter 									NB_DATA = 16,
    parameter 									NB_OPCODE = 5,
    parameter 									NB_OPERAND = 11,
    parameter 									N_INSMEM_ADDR = 2048,
    parameter 									LOG2_N_INSMEM_ADDR = 11,
    parameter 									N_DATA_ADDR = 1024, 
    parameter 									LOG2_N_DATA_ADDR = 10,
    parameter 									NB_SEL_A = 2
)
(
    // Outputs.
    output reg 		[NB_SEL_A-1:0]				o_sel_a,
    output reg 									o_sel_b,
    output reg 									o_wr_acc,
    output reg 									o_op_code,
    output reg 									o_wr_ram,
    output reg 									o_rd_ram,
    output wire 	[LOG2_N_INSMEM_ADDR-1:0]    o_addr_instr,
    output wire 	[LOG2_N_DATA_ADDR-1:0]	    o_data_instr,
    // Inputs.
    input  wire 	[NB_DATA-1:0]				i_instruction,
    input  wire 								i_clock,
    input  wire 								i_valid,
    input  wire 								i_reset 							
) ;	

    //==========================================================================
    // LOCAL PARAMETERS.
    //==========================================================================

    //Operations
    localparam 		[NB_OPERAND-1:0]			HALT = 0;
    localparam 		[NB_OPERAND-1:0]			STORE_VARIABLE = 1;
    localparam 		[NB_OPERAND-1:0]			LOAD_VARIABLE = 2;
    localparam 		[NB_OPERAND-1:0]			LOAD_IMMEDIATE = 3;
    localparam 		[NB_OPERAND-1:0]			ADD_VARIABLE = 4;
    localparam 		[NB_OPERAND-1:0]			ADD_IMMEDIATE = 5;
    localparam 		[NB_OPERAND-1:0]			SUBSTRACT_VARIABLE = 6;
    localparam 		[NB_OPERAND-1:0]			SUBSTRACT_IMMEDIATE = 7;


    //==========================================================================
    // INTERNAL SIGNALS.
    //==========================================================================
    reg 			[LOG2_N_INSMEM_ADDR-1:0]			pc ; //Program Counter Register
    reg 										        wr_pc ; //Add 1 to PC

    //==========================================================================
    // ALGORITHM.
    //==========================================================================
    assign o_addr_instr = pc ;

    assign o_data_instr = i_instruction[NB_OPERAND-1:0] ; //LOG2_N_DATA_ADDR

    // PC refresh
    always @ (posedge i_clock)
    begin
    	if (i_reset) 
    	begin
    		pc <= 1'b1 ; //{N_INSMEM_ADDR{1'b0}};
    	end
    	else if (i_valid && wr_pc)
    		pc <= pc + 1'b1 ;
    end

    always @(*) begin
    	case(i_instruction[NB_DATA-1-:NB_OPCODE])
    		HALT :
    		begin
    			wr_pc = 1'b0 ;
                o_sel_a = 2'b11 ;
                o_sel_b = 1'b0 ;
                o_wr_acc = 1'b0 ;
                o_op_code = 1'b0 ;
                o_wr_ram = 1'b0 ;
                o_rd_ram = 1'b0 ;
    		end
    		STORE_VARIABLE :
    		begin
    			wr_pc = 1'b1 ;
                o_sel_a = 2'b11 ; //Ver
                o_sel_b = 1'b0 ;
                o_wr_acc = 1'b0 ;
                o_op_code = 1'b0 ;
                o_wr_ram = 1'b1 ;
                o_rd_ram = 1'b0 ;
    		end
    		LOAD_VARIABLE :
    		begin
    			wr_pc = 1'b1 ;
                o_sel_a = 2'b00 ;
                o_sel_b = 1'b0 ;
                o_wr_acc = 1'b1 ;
                o_op_code = 1'b0 ;
                o_wr_ram = 1'b0 ;
                o_rd_ram = 1'b1 ;
    		end
    		LOAD_IMMEDIATE : 
    		begin
    			wr_pc = 1'b1 ;
                o_sel_a = 2'b01 ;
                o_sel_b = 1'b0 ;
                o_wr_acc = 1'b1 ;
                o_op_code = 1'b0 ;
                o_wr_ram = 1'b0 ;
                o_rd_ram = 1'b0 ;
    		end
    		ADD_VARIABLE : 
    		begin
    			wr_pc = 1'b1 ;
                o_sel_a = 2'b10 ;
                o_sel_b = 1'b0 ;
                o_wr_acc = 1'b1 ;
                o_op_code = 1'b1 ;
                o_wr_ram = 1'b0 ;
                o_rd_ram = 1'b1 ;
    		end
    		ADD_IMMEDIATE :
    		begin
    			wr_pc = 1'b1 ;
                o_sel_a = 2'b10 ;
                o_sel_b = 1'b1 ;
                o_wr_acc = 1'b1 ;
                o_op_code = 1'b1 ;
                o_wr_ram = 1'b0 ;
                o_rd_ram = 1'b0 ;
    		end
    		SUBSTRACT_VARIABLE :
    		begin
    			wr_pc = 1'b1 ;
                o_sel_a = 2'b10 ;
                o_sel_b = 1'b0 ;
                o_wr_acc = 1'b1 ;
                o_op_code = 1'b0 ;
                o_wr_ram = 1'b0 ;
                o_rd_ram = 1'b1 ;
    		end
    		SUBSTRACT_IMMEDIATE :
    		begin
    			wr_pc = 1'b1 ;
                o_sel_a = 2'b10 ;
                o_sel_b = 1'b1 ;
                o_wr_acc = 1'b1 ;
                o_op_code = 1'b0 ;
                o_wr_ram = 1'b0 ;
                o_rd_ram = 1'b0 ;
    		end
    		default :
    		begin
    			wr_pc = 1'b0 ;
                o_sel_a = 2'b11 ;
                o_sel_b = 1'b0 ;
                o_wr_acc = 1'b0 ;
                o_op_code = 1'b0 ;
                o_wr_ram = 1'b0 ;
                o_rd_ram = 1'b0 ;
    		end
    	endcase // i_instruction[NB_DATA-1-:NB_OPERAND]
    end

endmodule
