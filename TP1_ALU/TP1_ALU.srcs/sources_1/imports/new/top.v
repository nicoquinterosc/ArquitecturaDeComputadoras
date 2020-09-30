module top
#(
    parameter NB_SW = 8,
    parameter NB_LED = 16,
    parameter NB_OPCODE = 6,
    parameter NB_OPERANDO = 8
)
(
    input   clk,                // clk
    input   [NB_SW -1 : 0] sw,  // switches
    input   btnC,               // boton OPCODE
    input   btnR,               // boton OPB
    input   btnL,               // boton OPA
    input   btnU,               // boton reset
    output  [NB_LED - 1 :0] led // leds
);

    reg [NB_OPERANDO - 1 : 0] operandoA;
    reg [NB_OPERANDO - 1 : 0] operandoB;
    reg [NB_OPCODE   - 1 : 0] OPCODE;
    //reg [NB_SW       - 1 : 0] ultimoSW;
    reg reset = 0;
    
    alu alu0(
        .i_data_a(operandoA),
        .i_data_b(operandoB),
        .i_op(OPCODE),
        .o_result(led[NB_LED - 1 :8])
    );
   
//    assign led[NB_LED - 1 :8] = ultimoSW[NB_SW - 1 : 0];
    assign led[NB_SW - 1 : 0] = sw[NB_SW - 1 : 0];  //Asignar leds derecha a switches
    //D Flip Flop
    always @(posedge clk)
    begin
        if(btnL)
        begin
            operandoA <= sw[NB_SW - 1 : 0];
//            ultimoSW <= sw[NB_SW - 1 : 0] ;  
        end
        if(btnR)
        begin
            operandoB <= sw[NB_SW - 1 : 0];
//            ultimoSW <= sw[NB_SW - 1 : 0] ;  
        end
        if(btnC)
        begin
            OPCODE <= sw[NB_OPCODE -1 : 0];
//            ultimoSW <= sw[NB_SW - 1 : 0];
        end
        if(btnU)
        begin
            operandoA   <= 8'h00;
            operandoB   <= 8'h00;
            OPCODE      <= 8'h00;
        end
    end
    
endmodule