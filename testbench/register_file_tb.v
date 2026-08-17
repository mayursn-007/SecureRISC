`timescale 1ns/1ps

module register_file_tb;

    reg clk;
    reg reset;

    reg [4:0] read_addr_a;
    reg [4:0] read_addr_b;

    wire [31:0] read_data_a;
    wire [31:0] read_data_b;

    reg [4:0] write_addr;
    reg [31:0] write_data;
    reg write_enable;

    //===========================================================
    // DUT
    //===========================================================

    register_file DUT (
        .clk(clk),
        .reset(reset),
        .read_addr_a(read_addr_a),
        .read_addr_b(read_addr_b),
        .read_data_a(read_data_a),
        .read_data_b(read_data_b),
        .write_addr(write_addr),
        .write_data(write_data),
        .write_enable(write_enable)
    );

    //===========================================================
    // Clock
    //===========================================================

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    //===========================================================
    // Test Sequence
    //===========================================================

    initial begin

        $dumpfile("register_file.vcd");
        $dumpvars(0, register_file_tb);

        $display("========================================");
        $display(" SecureRISC Register File Verification");
        $display("========================================");

        reset = 1;
        write_enable = 0;
        write_addr = 0;
        write_data = 0;
        read_addr_a = 0;
        read_addr_b = 0;

        #10;

        reset = 0;

        // Test 1: Write x5 = 100
        write_enable = 1;
        write_addr = 5;
        write_data = 100;

        #10;

        write_enable = 0;
        read_addr_a = 5;

        #1;

        $display("TEST 1: x5 = %d", read_data_a);

        // Test 2: Write x10 = 200
        write_enable = 1;
        write_addr = 10;
        write_data = 200;

        #10;

        write_enable = 0;
        read_addr_b = 10;

        #1;

        $display("TEST 2: x10 = %d", read_data_b);

        // Test 3: Read two registers simultaneously
        read_addr_a = 5;
        read_addr_b = 10;

        #1;

        $display("TEST 3: Read x5 = %d, x10 = %d",
                 read_data_a, read_data_b);

        // Test 4: Attempt to write x0
        write_enable = 1;
        write_addr = 0;
        write_data = 999;

        #10;

        write_enable = 0;
        read_addr_a = 0;

        #1;

        $display("TEST 4: x0 = %d (must remain 0)",
                 read_data_a);

        $display("========================================");
        $display(" Register File Verification Complete");
        $display("========================================");

        $finish;
    end

endmodule