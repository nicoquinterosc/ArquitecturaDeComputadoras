//Listing 7.14
//Author: Pong P. Chu
//Chapter 7
//Page 201
//Copyright 2008

// Test bench based on file operation

//Source: https://timetoexplore.net/blog/initialize-memory-in-verilog

`timescale 1 ns/10 ps

module readmemh_tb();

    localparam  N_BITS = 32, 
                N_REGS = 32;

    reg [N_BITS-1:0] inst_memory [0:N_REGS-1];
    integer i, logfile;
    
    initial 
    begin
        $display("Loading instructions.");
        $readmemb("memfile.mem", inst_memory);
        
        logfile=$fopen("log.txt","a+");
        
        for(i=0; i<N_REGS; i=i+1)
        begin
            #1;
            $display("%b", inst_memory[i]);
            $fwrite(logfile, "%b,%t\n", inst_memory[i], $time);
        end
        
        $fclose(logfile);
    end
endmodule

//module eq2_file_tb;
//    // signal declaration
//    reg [1:0] test_in0, test_in1;
//    wire test_out;
//    integer log_file, console_file, out_file, logfile;
//    reg [3:0] v_mem [0:7];
//    integer i;
//    reg [7:0] inst_memory [0:15];
    
    
//    // instantiate the circuit under test
//    eq2_sop uut (.a(test_in0), .b(test_in1), .aeqb(test_out));
    
//    initial 
//    begin
//        logfile = $fopen("test.txt","w");
//        $display("VALUE OF FILE IS %d",logfile);
//        $fwrite("TEST_SUCCSESS");
//        $fclose(logfile);
//        log_file = $fopen("eqlog.txt", "wb");
//        if (!log_file)
//            $display("Cannot open log file");
//        console_file = 32'h0000_0001;
//        out_file = log_file | console_file;
        
//        // read test vector
//        $readmemb("vector.txt", v_mem);
        
//        // test generator iterating through 8 patterns
//        for(i = 0; i < 8; i = i+1)
//        begin
//            {test_in0, test_in1} =  v_mem[i];
//            #200;       // wait 200 ns per entry
//        end
        
//        // stop simulation
//        $fclose(log_file);
//        $stop;
//    end
    
//    // text_display
//    initial
//    begin
//        $fdisplay(out_file, "       time    test_in0    test_in1    test_out");
//        $fdisplay(out_file, "               (a)         (b)         (aeqb)  ");
//        $fmonitor(out_file, "%10d       %b          %b          %b", $time, test_in0, test_in1, test_out);
//    end
    
//endmodule