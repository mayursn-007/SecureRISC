`timescale 1ns/1ps

module program_counter_tb;

    reg clk;
    reg reset;
    reg pc_write;
    reg [31:0] next_pc;

    wire [31:0] pc;

    // Instantiate Program Counter
    program_counter DUT (
        .clk(clk),
        .reset(reset),
        .pc_write(pc_write),
        .next_pc(next_pc),
        .pc(pc)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    initial begin

        // Waveform dump
        $dumpfile("program_counter.vcd");
        $dumpvars(0, program_counter_tb);

        $display("========================================");
        $display(" SecureRISC Program Counter Verification");
        $display("========================================");

        // Initial values
        clk = 0;
        reset = 1;
        pc_write = 0;
        next_pc = 32'd0;

        // Test 1: Reset
        #10;
        $display("TEST 1: Reset      PC = %d", pc);

        // Test 2: Normal increment
        reset = 0;

        #10;
        $display("TEST 2: Increment  PC = %d", pc);

        #10;
        $display("TEST 3: Increment  PC = %d", pc);

        #10;
        $display("TEST 4: Increment  PC = %d", pc);

        // Test 5: Load new PC
        next_pc = 32'd100;
        pc_write = 1;

        #10;
        $display("TEST 5: Load PC    PC = %d", pc);

        // Test 6: Continue increment
        pc_write = 0;

        #10;
        $display("TEST 6: Increment  PC = %d", pc);

        #10;
        $display("TEST 7: Increment  PC = %d", pc);

        $display("========================================");
        $display(" Program Counter Verification Complete");
        $display("========================================");

        $finish;
    end

endmodule