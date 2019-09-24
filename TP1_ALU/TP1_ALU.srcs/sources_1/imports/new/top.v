module top
#(
    parameter   NB_SWITCH = 8,
    parameter   NB_OPCODE = 6,
    parameter   NB_LED = 16,
    parameter   NB_DATA = 8
)

(
    input    clk, reset,
    input    [NB_SWITCH - 1 : 0] sw,   //operands a,b,s
    input    btnC, // middle button
    input    btnR,
    input    btnL,
    output   [NB_LED - 1 : 0] led   //results c,v
);

    reg [NB_SWITCH -1 : 0] memLed;
    reg [NB_DATA - 1 : 0] operandoA;
    reg [NB_DATA - 1 : 0] operandoB;
    reg [NB_OPCODE - 1 : 0] OPCODE;
    
    alu alu0(
        .a(operandoA),
        .b(operandoB),
        .op(OPCODE),
        .r(led[NB_LED - 1 : 8])
    );
    
    always @(reset)
        begin
            operandoA <= 8'h00;
            operandoB <= 8'h00;
            OPCODE <= 6'b000000;   
        end
    
    //D Flip Flop
    always @(posedge clk)
        begin
            if(btnL)
            begin
                operandoA <= sw[NB_SWITCH - 1 : 0];         
            end
            if(btnR)
            begin
                operandoB <= sw[NB_SWITCH - 1 : 0];
            end
            if(btnC)
            begin
                OPCODE <= sw[NB_OPCODE - 1 : 0];
            end
        end
    
    always@(sw)
        begin
            memLed <= sw[NB_SWITCH - 1 : 0];
        end
    
    assign led[NB_SWITCH - 1 : 0] = memLed[NB_SWITCH - 1 : 0];
    
endmodule