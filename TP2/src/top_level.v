`timescale 1ns / 1ps

module top_level
  #(
    parameter B_RATE = 9600,
    parameter NB_DATA = 1,
    parameter N_DATA = 8,
    parameter NB_OPERATION = 6
    )
   (
    //TODO: reemplazar por pines del contraint
    output      RsTx,
    output [1:0] JA,
    // output [1:0]        o_led,
    
    input       RsRx,
    input       i_clk,
    input       i_btnC
    );

   wire    i_data;
   wire    o_data;
   wire    i_rst;
   
   // Wires
   wire [NB_OPERATION-1:0] iface_dataop_alu;
   wire [N_DATA-1:0]       iface_dataa_alu;
   wire [N_DATA-1:0]       iface_datab_alu;
   wire [N_DATA-1:0]       iface_data_utx;
   wire                    iface_start_utx;

   wire                    brgen_valid_urx;
   wire                    brgen_valid_utx;

   wire [N_DATA-1:0]       urx_data_iface;
   wire                    urx_done_iface;

   wire                    utx_done_iface;

   wire [N_DATA-1:0]       alu_data_iface;

   assign JA[1] = RsRx;
   assign i_data = RsRx;
   assign RsTx = o_data;
   assign JA[0] = o_data;
   assign i_rst = i_btnC;

   assign brgen_valid_utx = brgen_valid_urx;

   uart_rx
     u_uart_rx(
               .o_data(urx_data_iface),
               .rx_done(urx_done_iface),
               .o_frame_valid(),
               .i_data(i_data),
               .i_valid(brgen_valid_utx),
               .i_reset(i_rst),
               .i_clock(i_clk)
               );
   
   uart_tx
     u_uart_tx(
               .o_data(o_data),
               .o_tx_done(utx_done_iface),
               .i_data(iface_data_utx),
               .i_tx_start(iface_start_utx),
               .i_valid(brgen_valid_utx),
               .i_reset(i_rst),
               .i_clock(i_clk)
               );
   
   uart_alu_interface
     u_iface(
             .o_alu_data_a(iface_dataa_alu),
             .o_alu_data_b(iface_datab_alu),
             .o_alu_data_op(iface_dataop_alu),
             .o_tx_data(iface_data_utx),
             .o_tx_start(iface_start_utx),
             .i_alu_data(alu_data_iface),
             .i_rx_data(urx_data_iface),
             .i_rx_done(urx_done_iface),
             .i_tx_done(utx_done_iface),
             .i_rst(i_rst),
             .i_clk(i_clk)
             );
   
   baudrate_generator#(.BAUD_RATE(B_RATE))
     u_br_gen(
              .o_tick(brgen_valid_urx),
              .i_clk(i_clk),
              .i_rst(i_rst)
              );
   
   alu
     u_alu(
           .o_result(alu_data_iface),
           .i_data_a(iface_dataa_alu),
           .i_data_b(iface_datab_alu),
           .i_op(iface_dataop_alu)
           );

endmodule
