`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:       Universidad Nacional de Cordoba
// Engineer:		Gerardo Collante
//                Nicolas Quinteros Castilla
//
// Create Date:   10:31:00 10/31/2016
// Module Name:   PIPELINE
// Project Name:  MIPS 
// Description:   Testing MIPS pipeline.
//
// Dependencies:  PIPELINE.v
//
////////////////////////////////////////////////////////////////////////////////

module PIPELINE_tb;
	// Inputs
	parameter n_instr = 6;
	parameter n_btns = 10;
	reg clk;
	reg rst;
	reg btn;
	reg on;
	reg enable_wr;
	reg [31:0] addr_bus;
	reg [31:0] instr_bus;
	wire [15:0] LED;
	reg [31:0] temp [n_instr-1:0];

	// Instantiate the Unit Under Test (UUT)
	//PIPELINE pipeline(.clk(clk), .rst(rst), .LED(LED));
PIPELINE pipeline(.clk(clk), 
                  .rst(rst), 
                  .btn(btn),
                  .on(on),
                  .enable_wr(enable_wr), 
                  .addr_bus(addr_bus),
                  .instr_bus(instr_bus),
                  .LED(LED));
                  
//    initial begin
//        #150 btn = 1;
//        #25 btn = 0;
//        #40 btn = 1;
//        #20 btn = 0;
//        #35 btn = 1;
//        #30 btn = 0;
//        #15 btn = 1;
//        #70 btn = 0;
//        #25 btn = 1;
//        #20 btn = 0;
//        #25 btn = 1;
//        #20 btn = 0;
//        #25 btn = 1;
//        #20 btn = 0;
//        #25 btn = 1;
//        #20 btn = 0;
//        #25 btn = 1;
//        #20 btn = 0;
//        #25 btn = 1;
//        #20 btn = 0;
//        #25 btn = 1;
//        #20 btn = 0;
//    end
    
    initial begin
        // Initialize Inputs
        clk = 0;
        rst = 1;
        btn = 0;
        on = 0;
        // Wait for initialization
        #135 rst = 0;
        #5 on = 1;
//        $monitor("Hola", pipeline.IF_ID_IR);
    //		$monitor("mux %d", pipeline.FETCH.mux.a);
//        $monitor("pc: %d", pipeline.FETCH.pc.npc);
        // Perform 24 cycles.
        //#480;
        //$finish;
    end
	
	initial begin
		// Wait for initialization
		$readmemb("memfile.mem", temp);
		enable_wr = 1'b1;
		//#100;
		
		forever begin
            #10 clk = ~clk;
		end
	end
	
    integer i  = 0;
	
//	initial
//    begin 
//        //$readmemb("input_output_files/adder_data.txt", read_data);
//        // or provide the compelete path as below
//        $readmemb("memfile.mem", temp);

//        // total number of lines in adder_data.txt = 6
//        for (i=0; i<6; i=i+1)
//        begin
//            //pipeline.addr_wire = i;
//            // 0_1_0_1 and 0101 are read in the same way, i.e.
//            //a=0, b=1, sum_expected=0, carry_expected=0 for above line;
//            addr_bus = i;
//            instr_bus = i;
//            // but use of underscore makes the values more readable.
//            //{a, b, sum_carry_expected} = read_data[i]; // use this or below
//            // {a, b, sum_carry_expected[0], sum_carry_expected[1]} = read_data[i];
//            #20;  // wait for 20 clock cycle
//        end
//    end
    
    // Cargamos los datos en memoria

    always @(posedge clk)
    begin
        if (i<n_instr)
        begin
            addr_bus = i;
            instr_bus = temp[i];
            i = i+1;
        end
        else
        begin
            enable_wr = 1'b0;
        end
    end
    
    initial
    begin 
        // total number of lines in adder_data.txt = 6
        #150 btn = 1;
        forever begin
            #24 btn = ~btn;
		end
    end

endmodule
