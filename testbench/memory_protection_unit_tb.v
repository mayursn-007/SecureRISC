`timescale 1ns/1ps

//===========================================================
// SecureRISC
// Memory Protection Unit Verification
//===========================================================

module memory_protection_unit_tb;

    reg  [31:0] address;
    reg         mem_read;
    reg         mem_write;

    wire read_allowed;
    wire write_allowed;
    wire memory_violation;

    //=======================================================
    // DUT
    //=======================================================

    memory_protection_unit DUT (
        .address(address),
        .mem_read(mem_read),
        .mem_write(mem_write),

        .read_allowed(read_allowed),
        .write_allowed(write_allowed),
        .memory_violation(memory_violation)
    );

    //=======================================================
    // Test
    //=======================================================

    initial begin

        $dumpfile("memory_protection_unit.vcd");
        $dumpvars(0, memory_protection_unit_tb);

        $display("==============================================");
        $display(" SecureRISC Memory Protection Unit Test");
        $display("==============================================");

        //===================================================
        // TEST 1: Code region READ
        //===================================================

        address   = 32'h00000010;
        mem_read  = 1'b1;
        mem_write = 1'b0;

        #10;

        $display("");
        $display("TEST 1: Code region READ");
        $display("Address          = %h", address);
        $display("Read allowed     = %b", read_allowed);
        $display("Write allowed    = %b", write_allowed);
        $display("Violation        = %b", memory_violation);

        if (read_allowed == 1'b1 &&
            memory_violation == 1'b0)
            $display("STATUS: PASS");
        else
            $display("STATUS: FAIL");


        //===================================================
        // TEST 2: Code region WRITE
        //===================================================

        address   = 32'h00000020;
        mem_read  = 1'b0;
        mem_write = 1'b1;

        #10;

        $display("");
        $display("TEST 2: Code region WRITE");
        $display("Address          = %h", address);
        $display("Read allowed     = %b", read_allowed);
        $display("Write allowed    = %b", write_allowed);
        $display("Violation        = %b", memory_violation);

        if (write_allowed == 1'b0 &&
            memory_violation == 1'b1)
            $display("STATUS: PASS");
        else
            $display("STATUS: FAIL");


        //===================================================
        // TEST 3: Data region READ
        //===================================================

        address   = 32'h00001000;
        mem_read  = 1'b1;
        mem_write = 1'b0;

        #10;

        $display("");
        $display("TEST 3: Data region READ");
        $display("Address          = %h", address);
        $display("Read allowed     = %b", read_allowed);
        $display("Write allowed    = %b", write_allowed);
        $display("Violation        = %b", memory_violation);

        if (read_allowed == 1'b1 &&
            memory_violation == 1'b0)
            $display("STATUS: PASS");
        else
            $display("STATUS: FAIL");


        //===================================================
        // TEST 4: Data region WRITE
        //===================================================

        address   = 32'h00001000;
        mem_read  = 1'b0;
        mem_write = 1'b1;

        #10;

        $display("");
        $display("TEST 4: Data region WRITE");
        $display("Address          = %h", address);
        $display("Read allowed     = %b", read_allowed);
        $display("Write allowed    = %b", write_allowed);
        $display("Violation        = %b", memory_violation);

        if (write_allowed == 1'b1 &&
            memory_violation == 1'b0)
            $display("STATUS: PASS");
        else
            $display("STATUS: FAIL");


        //===================================================
        // TEST 5: Protected region READ
        //===================================================

        address   = 32'h00002000;
        mem_read  = 1'b1;
        mem_write = 1'b0;

        #10;

        $display("");
        $display("TEST 5: Protected region READ");
        $display("Address          = %h", address);
        $display("Read allowed     = %b", read_allowed);
        $display("Write allowed    = %b", write_allowed);
        $display("Violation        = %b", memory_violation);

        if (read_allowed == 1'b0 &&
            memory_violation == 1'b1)
            $display("STATUS: PASS");
        else
            $display("STATUS: FAIL");


        //===================================================
        // TEST 6: Protected region WRITE
        //===================================================

        address   = 32'h00002000;
        mem_read  = 1'b0;
        mem_write = 1'b1;

        #10;

        $display("");
        $display("TEST 6: Protected region WRITE");
        $display("Address          = %h", address);
        $display("Read allowed     = %b", read_allowed);
        $display("Write allowed    = %b", write_allowed);
        $display("Violation        = %b", memory_violation);

        if (write_allowed == 1'b0 &&
            memory_violation == 1'b1)
            $display("STATUS: PASS");
        else
            $display("STATUS: FAIL");


        //===================================================
        // TEST 7: Invalid address READ
        //===================================================

        address   = 32'h00004000;
        mem_read  = 1'b1;
        mem_write = 1'b0;

        #10;

        $display("");
        $display("TEST 7: Invalid address READ");
        $display("Address          = %h", address);
        $display("Read allowed     = %b", read_allowed);
        $display("Write allowed    = %b", write_allowed);
        $display("Violation        = %b", memory_violation);

        if (read_allowed == 1'b0 &&
            memory_violation == 1'b1)
            $display("STATUS: PASS");
        else
            $display("STATUS: FAIL");


        $display("");
        $display("==============================================");
        $display(" Memory Protection Verification Complete");
        $display("==============================================");

        $finish;

    end

endmodule