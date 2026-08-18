`timescale 1ns/1ps

module data_memory_tb;

    reg clk;
    reg mem_read;
    reg mem_write;

    reg [31:0] address;
    reg [31:0] write_data;

    wire [31:0] read_data;

    data_memory DUT (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(address),
        .write_data(write_data),
        .read_data(read_data)
    );

    // Clock: 10 ns period
    always #5 clk = ~clk;

    initial begin

        $dumpfile("data_memory.vcd");
        $dumpvars(0, data_memory_tb);

        clk       = 1'b0;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        address   = 32'b0;
        write_data = 32'b0;

        $display("========================================");
        $display(" SecureRISC Data Memory Test");
        $display("========================================");

        //===================================================
        // TEST 1: Write 100 to address 16
        //===================================================

        #2;

        address    = 32'd16;
        write_data = 32'd100;
        mem_write  = 1'b1;

        #10;

        mem_write = 1'b0;

        $display("TEST 1: Write 100 to address 16");

        //===================================================
        // TEST 2: Read address 16
        //===================================================

        mem_read = 1'b1;

        #2;

        $display("TEST 2: Read address 16 = %d", read_data);

        //===================================================
        // TEST 3: Write 200 to address 20
        //===================================================

        mem_read   = 1'b0;
        address    = 32'd20;
        write_data = 32'd200;
        mem_write  = 1'b1;

        #10;

        mem_write = 1'b0;

        $display("TEST 3: Write 200 to address 20");

        //===================================================
        // TEST 4: Read address 20
        //===================================================

        mem_read = 1'b1;

        #2;

        $display("TEST 4: Read address 20 = %d", read_data);

        //===================================================
        // TEST 5: Read unwritten address
        //===================================================

        address = 32'd24;

        #2;

        $display("TEST 5: Read unwritten address 24 = %h",
                 read_data);

        $display("========================================");
        $display(" Data Memory Verification Complete");
        $display("========================================");

        $finish;

    end

endmodule