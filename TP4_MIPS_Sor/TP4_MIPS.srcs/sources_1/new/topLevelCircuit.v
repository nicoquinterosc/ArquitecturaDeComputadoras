//`include "Verilog/defines.v"

// Wire widths
`define WORD_LEN 32
`define REG_FILE_ADDR_LEN 5
`define EXE_CMD_LEN 4
`define FORW_SEL_LEN 2
`define OP_CODE_LEN 6

// Memory constants
`define DATA_MEM_SIZE 1024
`define INSTR_MEM_SIZE 1024
`define REG_FILE_SIZE 32
`define MEM_CELL_SIZE 8

// To be used inside controller.v
`define OP_NOP 6'b000000
`define OP_ADD 6'b000001
`define OP_SUB 6'b000011
`define OP_AND 6'b000101
`define OP_OR 6'b000110
`define OP_NOR 6'b000111
`define OP_XOR 6'b001000
`define OP_SLA 6'b001001
`define OP_SLL 6'b001010
`define OP_SRA 6'b001011
`define OP_SRL 6'b001100
`define OP_ADDI 6'b100000
`define OP_SUBI 6'b100001
`define OP_LD 6'b100100
`define OP_ST 6'b100101
`define OP_BEZ 6'b101000
`define OP_BNE 6'b101001
`define OP_JMP 6'b101010

// To be used in side ALU
`define EXE_ADD 4'b0000
`define EXE_SUB 4'b0010
`define EXE_AND 4'b0100
`define EXE_OR 4'b0101
`define EXE_NOR 4'b0110
`define EXE_XOR 4'b0111
`define EXE_SLA 4'b1000
`define EXE_SLL 4'b1000
`define EXE_SRA 4'b1001
`define EXE_SRL 4'b1010
`define EXE_NO_OPERATION 4'b1111 // for NOP, BEZ, BNQ, JMP

// To be used in conditionChecker
`define COND_JUMP 2'b10
`define COND_BEZ 2'b11
`define COND_BNE 2'b01
`define COND_NOTHING 2'b00

module top_level
    #(
    parameter                                   NB_DATABIP = 16,
    parameter                                   NB_INS = 11,
    parameter                                   NB_OPCODE = 5
    )
    (
    input       CLOCK_50,
    input       rst,
    input       forward_EN,
    input       i_clk,
    input       i_btnC,
    input       i_btnL,
    input       i_btnR,
    input       i_btnU,    
    output [15:0] LED
    );
    
    wire [`WORD_LEN-1:0] PC_IF, PC_ID, PC_EXE, PC_MEM;
	wire [`WORD_LEN-1:0] inst_IF, inst_ID;
	wire [`WORD_LEN-1:0] reg1_ID, reg2_ID, ST_value_EXE, ST_value_EXE2MEM, ST_value_MEM;
	wire [`WORD_LEN-1:0] val1_ID, val1_EXE;
	wire [`WORD_LEN-1:0] val2_ID, val2_EXE;
	wire [`WORD_LEN-1:0] ALURes_EXE, ALURes_MEM, ALURes_WB;
	wire [`WORD_LEN-1:0] dataMem_out_MEM, dataMem_out_WB;
	wire [`WORD_LEN-1:0] WB_result;
	wire [`REG_FILE_ADDR_LEN-1:0] dest_EXE, dest_MEM, dest_WB; // dest_ID = instruction[25:21] thus nothing declared
	wire [`REG_FILE_ADDR_LEN-1:0] src1_ID, src2_regFile_ID, src2_forw_ID, src2_forw_EXE, src1_forw_EXE;
	wire [`EXE_CMD_LEN-1:0] EXE_CMD_ID, EXE_CMD_EXE;
	wire [`FORW_SEL_LEN-1:0] val1_sel, val2_sel, ST_val_sel;
	wire [1:0] branch_comm;
	wire Br_Taken_ID, IF_Flush, Br_Taken_EXE;
	wire MEM_R_EN_ID, MEM_R_EN_EXE, MEM_R_EN_MEM, MEM_R_EN_WB;
	wire MEM_W_EN_ID, MEM_W_EN_EXE, MEM_W_EN_MEM;
	wire WB_EN_ID, WB_EN_EXE, WB_EN_MEM, WB_EN_WB;
	wire hazard_detected, is_imm, ST_or_BNE;
	wire clock = CLOCK_50;

	regFile regFile(
		// INPUTS
		.clk(clock),
		.rst(rst),
		.src1(src1_ID),
		.src2(src2_regFile_ID),
		.dest(dest_WB),
		.writeVal(WB_result),
		.writeEn(WB_EN_WB),
		// OUTPUTS
		.reg1(reg1_ID),
		.reg2(reg2_ID)
	);

	hazard_detection hazard (
		// INPUTS
		.forward_EN(forward_EN),
		.is_imm(is_imm),
		.ST_or_BNE(ST_or_BNE),
		.src1_ID(src1_ID),
		.src2_ID(src2_regFile_ID),
		.dest_EXE(dest_EXE),
		.dest_MEM(dest_MEM),
		.WB_EN_EXE(WB_EN_EXE),
		.WB_EN_MEM(WB_EN_MEM),
		.MEM_R_EN_EXE(MEM_R_EN_EXE),
		// OUTPUTS
		.branch_comm(branch_comm),
		.hazard_detected(hazard_detected)
	);

	forwarding_EXE forwrding_EXE (
		.src1_EXE(src1_forw_EXE),
		.src2_EXE(src2_forw_EXE),
		.ST_src_EXE(dest_EXE),
		.dest_MEM(dest_MEM),
		.dest_WB(dest_WB),
		.WB_EN_MEM(WB_EN_MEM),
		.WB_EN_WB(WB_EN_WB),
		.val1_sel(val1_sel),
		.val2_sel(val2_sel),
		.ST_val_sel(ST_val_sel)
	);

	//###########################
	//##### PIPELINE STAGES #####
	//###########################
	IFStage IFStage (
		// INPUTS
		.clk(clock),
		.rst(rst),
		.freeze(hazard_detected),
		.brTaken(Br_Taken_ID),
		.brOffset(val2_ID),
		// OUTPUTS
		.instruction(inst_IF),
		.PC(PC_IF)
	);

	IDStage IDStage (
		// INPUTS
		.clk(clock),
		.rst(rst),
		.hazard_detected_in(hazard_detected),
		.instruction(inst_ID),
		.reg1(reg1_ID),
		.reg2(reg2_ID),
		// OUTPUTS
		.src1(src1_ID),
		.src2_reg_file(src2_regFile_ID),
		.src2_forw(src2_forw_ID),
		.val1(val1_ID),
		.val2(val2_ID),
		.brTaken(Br_Taken_ID),
		.EXE_CMD(EXE_CMD_ID),
		.MEM_R_EN(MEM_R_EN_ID),
		.MEM_W_EN(MEM_W_EN_ID),
		.WB_EN(WB_EN_ID),
		.is_imm_out(is_imm),
		.ST_or_BNE_out(ST_or_BNE),
		.branch_comm(branch_comm)
	);

	EXEStage EXEStage (
		// INPUTS
		.clk(clock),
		.EXE_CMD(EXE_CMD_EXE),
		.val1_sel(val1_sel),
		.val2_sel(val2_sel),
		.ST_val_sel(ST_val_sel),
		.val1(val1_EXE),
		.val2(val2_EXE),
		.ALU_res_MEM(ALURes_MEM),
		.result_WB(WB_result),
		.ST_value_in(ST_value_EXE),
		// OUTPUTS
		.ALUResult(ALURes_EXE),
		.ST_value_out(ST_value_EXE2MEM)
	);

	MEMStage MEMStage (
		// INPUTS
		.clk(clock),
		.rst(rst),
		.MEM_R_EN(MEM_R_EN_MEM),
		.MEM_W_EN(MEM_W_EN_MEM),
		.ALU_res(ALURes_MEM),
		.ST_value(ST_value_MEM),
		// OUTPUTS
		.dataMem_out(dataMem_out_MEM)
	);

	WBStage WBStage (
		// INPUTS
		.MEM_R_EN(MEM_R_EN_WB),
		.memData(dataMem_out_WB),
		.aluRes(ALURes_WB),
		// OUTPUTS
		.WB_res(WB_result)
	);

	//############################
	//#### PIPLINE REGISTERS #####
	//############################
	IF2ID IF2IDReg (
		// INPUTS
		.clk(clock),
		.rst(rst),
		.flush(IF_Flush),
		.freeze(hazard_detected),
		.PCIn(PC_IF),
		.instructionIn(inst_IF),
		// OUTPUTS
		.PC(PC_ID),
		.instruction(inst_ID)
	);

	ID2EXE ID2EXEReg (
		.clk(clock),
		.rst(rst),
		// INPUTS
		.destIn(inst_ID[25:21]),
		.src1_in(src1_ID),
		.src2_in(src2_forw_ID),
		.reg2In(reg2_ID),
		.val1In(val1_ID),
		.val2In(val2_ID),
		.PCIn(PC_ID),
		.EXE_CMD_IN(EXE_CMD_ID),
		.MEM_R_EN_IN(MEM_R_EN_ID),
		.MEM_W_EN_IN(MEM_W_EN_ID),
		.WB_EN_IN(WB_EN_ID),
		.brTaken_in(Br_Taken_ID),
		// OUTPUTS
		.src1_out(src1_forw_EXE),
		.src2_out(src2_forw_EXE),
		.dest(dest_EXE),
		.ST_value(ST_value_EXE),
		.val1(val1_EXE),
		.val2(val2_EXE),
		.PC(PC_EXE),
		.EXE_CMD(EXE_CMD_EXE),
		.MEM_R_EN(MEM_R_EN_EXE),
		.MEM_W_EN(MEM_W_EN_EXE),
		.WB_EN(WB_EN_EXE),
		.brTaken_out(Br_Taken_EXE)
	);

	EXE2MEM EXE2MEMReg (
		.clk(clock),
		.rst(rst),
		// INPUTS
		.WB_EN_IN(WB_EN_EXE),
		.MEM_R_EN_IN(MEM_R_EN_EXE),
		.MEM_W_EN_IN(MEM_W_EN_EXE),
		.PCIn(PC_EXE),
		.ALUResIn(ALURes_EXE),
		.STValIn(ST_value_EXE2MEM),
		.destIn(dest_EXE),
		// OUTPUTS
		.WB_EN(WB_EN_MEM),
		.MEM_R_EN(MEM_R_EN_MEM),
		.MEM_W_EN(MEM_W_EN_MEM),
		.PC(PC_MEM),
		.ALURes(ALURes_MEM),
		.STVal(ST_value_MEM),
		.dest(dest_MEM)
	);

	MEM2WB MEM2WB(
		.clk(clock),
		.rst(rst),
		// INPUTS
		.WB_EN_IN(WB_EN_MEM),
		.MEM_R_EN_IN(MEM_R_EN_MEM),
		.ALUResIn(ALURes_MEM),
		.memReadValIn(dataMem_out_MEM),
		.destIn(dest_MEM),
		// OUTPUTS
		.WB_EN(WB_EN_WB),
		.MEM_R_EN(MEM_R_EN_WB),
		.ALURes(ALURes_WB),
		.memReadVal(dataMem_out_WB),
		.dest(dest_WB)
	);

	assign IF_Flush = Br_Taken_ID;
	
endmodule
