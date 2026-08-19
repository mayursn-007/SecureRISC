`timescale 1ns/1ps

//===========================================================
// SecureRISC
// CPU-Level Security Attack Testbench
//===========================================================

module secure_risc_security_tb;

    reg clk;
    reg reset;

    wire [31:0] pc;
    wire [31:0] instruction;
    wire [31:0] alu_result;
    wire [31:0] writeback_data;

    wire mem_read;
    wire mem_write;
    wire reg_write;
    wire branch;
    wire jump;

    wire instruction_valid;
    wire security_violation;

    //=======================================================
    // DUT
    //=======================================================

    secure_risc_core DUT (
        .clk(clk),
        .reset(reset),

        .pc(pc),
        .instruction(instruction),

        .alu_result(alu_result),
        .writeback_data(writeback_data),

        .mem_read(mem_read),
        .mem_write(mem_write),
        .reg_write(reg_write),
        .branch(branch),
        .jump(jump),

        .instruction_valid(instruction_valid),
        .security_violation(security_violation)
    );

    //=======================================================
    // Clock
    //=======================================================

    always #5 clk = ~clk;

    //=======================================================
    // Test
    //=======================================================

    initial begin

        $dumpfile("secure_risc_security.vcd");
        $dumpvars(0, secure_risc_security_tb);

        clk = 1'b0;
        reset = 1'b1;

        $display("==============================================");
        $display(" SecureRISC CPU Security Attack Test");
        $display("==============================================");

        // Allow reset to reach a clock edge
        #17;
        reset = 1'b0;

        //===================================================
        // TEST 1: Valid instruction
        // ADD x3, x1, x2
        //===================================================

        force DUT.instruction = 32'h002081B3;

        #3;

        $display("");
        $display("TEST 1: Normal instruction");
        $display("Instruction = %h", instruction);
        $display("Valid       = %b", instruction_valid);
        $display("Violation   = %b", security_violation);

        if (instruction_valid == 1'b1 &&
            security_violation == 1'b0) begin

            $display("RESULT: NORMAL INSTRUCTION ACCEPTED");
            $display("STATUS: PASS");

        end
        else begin

            $display("RESULT: UNEXPECTED SECURITY VIOLATION");
            $display("STATUS: FAIL");

        end

        //===================================================
        // TEST 2: Illegal instruction
        //===================================================

        $display("");
        $display("TEST 2: Injecting illegal instruction");

        force DUT.instruction = 32'hFFFFFFFF;

        #2;

        $display("Injected instruction = %h", instruction);
        $display("Valid                = %b", instruction_valid);
        $display("Violation            = %b", security_violation);

        if (instruction_valid == 1'b0 &&
            security_violation == 1'b1) begin

            $display("RESULT: ILLEGAL INSTRUCTION BLOCKED");
            $display("STATUS: PASS");

        end
        else begin

            $display("RESULT: ILLEGAL INSTRUCTION NOT BLOCKED");
            $display("STATUS: FAIL");

        end

        //===================================================
        // TEST 3: Second illegal instruction
        //===================================================

        $display("");
        $display("TEST 3: Injecting second illegal instruction");

        force DUT.instruction = 32'h00000000;

        #2;

        $display("Injected instruction = %h", instruction);
        $display("Valid                = %b", instruction_valid);
        $display("Violation            = %b", security_violation);

        if (instruction_valid == 1'b0 &&
            security_violation == 1'b1) begin

            $display("RESULT: ILLEGAL INSTRUCTION BLOCKED");
            $display("STATUS: PASS");

        end
        else begin

            $display("RESULT: ILLEGAL INSTRUCTION NOT BLOCKED");
            $display("STATUS: FAIL");

        end

        //===================================================
        // Finish
        //===================================================

        release DUT.instruction;

        #5;

        $display("");
        $display("==============================================");
        $display(" SecureRISC Security Test Complete");
        $display("==============================================");

        $finish;

    end

endmodule