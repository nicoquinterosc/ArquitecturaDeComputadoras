`timescale 1ns / 1ps

module top_level
  #(
    parameter   B_RATE = 9600,
    parameter   NB_DATA = 1,
    parameter   N_DATA = 8,
    parameter   NB_OPERATION = 6,
    parameter   NB_DATABIP = 16,
    parameter   LOG2_N_INSMEM_ADDR = 11
    )
    
   (
    //TODO: reemplazar por pines del contraint
    output      RsTx,
    
    output [15:0]      LED,
    // output [1:0]        o_led,
    
    input       RsRx,
    input       i_clk,
    input       i_btnC,
    
    input [1:0] sw
    );

   wire    i_data;
   wire    o_data;
   wire    i_rst;
   
   // Wires
   wire [N_DATA-1:0]       iface_data_tx;
   wire                    iface_start_tx;
   wire                    iface_valid_bip;

   wire                    tx_done_iface;

   wire                    brgen_valid_tx;

   wire [NB_DATABIP-1:0]   bip_acc_iface;
   wire [NB_DATABIP-1:0]   bip_instruction_iface;
   wire [LOG2_N_INSMEM_ADDR-1:0] bip_nclock_iface;

   wire [N_DATA-1:0]       alu_data_iface;
   
   reg [15:0] led;

   assign i_data = RsRx;
   assign RsTx = o_data;
   assign i_rst = i_btnC;

   uart_tx
     u_uart_tx(
               .o_data(o_data),
               .o_tx_done(tx_done_iface),
               .i_data(iface_data_tx),
               .i_tx_start(iface_start_tx),
               .i_valid(brgen_valid_tx),
               .i_reset(i_rst),
               .i_clock(i_clk)
               );
   
   baudrate_generator#(.BAUD_RATE(B_RATE))
     u_br_gen(
              .o_tick(brgen_valid_tx),
              .i_clk(i_clk),
              .i_rst(i_rst)
              );

   bip_uart_interface
     u_bip_uart_interface(
              .o_data(iface_data_tx),
              .o_tx_start(iface_start_tx),
              .o_valid(iface_valid_bip),
              .i_tx_done(tx_done_iface),
              .i_clock(i_clk),
              .i_reset(i_rst),
              .i_acc(bip_acc_iface),
              .i_instruction(bip_instruction_iface),
              .i_nclock(bip_nclock_iface),
              .LED(LED),
              .sw(sw)
              );

//    always @(*)
//    begin 
//        case (sw)
//            2'b00: led <= bip_acc_iface;
//            2'b01: led <= bip_instruction_iface;
//            2'b10: led <= bip_nclock_iface;
//            default: led <= 16'hffff;
//        endcase 
//    end
    
//    assign LED = led;

    bip_BIP
        u_bip
        (
            .o_acc(bip_acc_iface),
            .o_instruction(bip_instruction_iface),
            .o_pc(bip_nclock_iface),
            .i_clock(i_clk),
            .i_valid(iface_valid_bip),
            .i_reset(i_rst)
        );
endmodule
