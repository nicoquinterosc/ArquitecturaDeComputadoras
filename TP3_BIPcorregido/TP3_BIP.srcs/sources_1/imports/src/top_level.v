`timescale 1ns / 1ps

module top_level
  #(
    parameter                                   NB_DATABIP = 16,
    parameter                                   NB_INS = 11,
    parameter                                   NB_OPCODE = 5
    )
   (
    input       i_clk,
    input       i_btnC,
    input       i_btnL,
    input       i_btnR,
    input       i_btnU,    
    output [15:0] LED
    );

    wire        i_rst;
    wire     valid;
    wire    show_acc;
    wire    show_pc;
    wire    show_op;
    wire    enable;
    reg [15:0] led;
    reg [NB_OPCODE-1:0] opcode;
    wire   [NB_OPCODE-1:0] show_opcode;
    
   wire [NB_DATABIP-1:0]   acc;
   wire [NB_DATABIP-1:0]   ins;
   wire [NB_INS-1:0] pc;
   wire [NB_INS-1:0] mostrar_pc;

   assign i_rst = i_btnC;
   assign show_acc = i_btnL;
   assign show_pc = i_btnR;
   assign show_op = i_btnU;

    always @(posedge i_clk)
    begin
        if(show_acc)
        begin
            led <= acc;
        end
        if(show_pc)
        begin 
            led <= mostrar_pc;
        end
        if(show_op)
        begin
            led[NB_OPCODE-1:0] <= opcode;
        end
    end
    
    always @(posedge i_clk)
    begin
        if(enable==1)
        opcode <= show_opcode;
    end
    
    assign LED = led;
    
   counter 
        u_counter(
            .o_valid(valid),
            .i_clk(i_clk),
            .i_rst(i_rst),
            .i_enable(enable)
   );

   bip_BIP
        u_bip(
            .o_acc(acc),
            .o_instruction(ins),
            .o_pc(pc),
            .o_enable(enable),
            .i_clock(i_clk),
            .i_valid(valid),
            .i_reset(i_rst),
            .show_opcode(show_opcode),
            .mostrar_pc(mostrar_pc)
            );
endmodule
