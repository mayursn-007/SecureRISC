`timescale 1ns/1ps

//===========================================================
// SecureRISC
// CPU-Level Memory Protection Attack Test
//===========================================================

module memory_attack_tb;

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
    wire memory_violation;

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
        .security_violation(security_violation),
        .memory_violation(memory_violation)
    );

    //=======================================================
    // Clock
    //=======================================================

    always #5 clk = ~clk;

    //=======================================================
    // Test
    //=======================================================

    initial begin

        $dumpfile("memory_attack.vcd");
        $dumpvars(0, memory_attack_tb);

        clk   = 1'b0;
        reset = 1'b1;

        $display("==============================================");
        $display(" SecureRISC CPU Memory Attack Test");
        $display("==============================================");

        //===================================================
        // Program
        //
        // x1 = 123
        // Attempt:
        //     SW x1, 0x2000(x0)
        //
        // 0x2000 is PROTECTED.
        //===================================================

        DUT.IMEM.memory[0] = 32'h07B00093;

        // ADDI x1, x0, 123

        DUT.IMEM.memory[1] = 32'h00102023;

        // This instruction is only a placeholder.
        // We will force the ALU address to 0x2000
        // for the security test.

        DUT.IMEM.memory[2] = 32'h00000013;

        // NOP

        //===================================================
        // Reset
        //===================================================

        #17;
        reset = 1'b0;

        //===================================================
        // Wait for CPU to start
        //===================================================

        #13;

        //===================================================
        // Attack: force ALU result to protected address
        //===================================================

        $display("");
        $display("ATTACK: Unauthorized memory WRITE");
        $display("----------------------------------------------");

        force DUT.alu_result = 32'h00002000;

        // Force the CPU's memory write request.
        // This simulates an attempted unauthorized STORE.

        force DUT.mem_write = 1'b1;
        force DUT.mem_read  = 1'b0;

        #2;

        $display("Target address       = %h", DUT.alu_result);
        $display("CPU memory write     = %b", DUT.mem_write);
        $display("MPU write allowed    = %b", DUT.write_allowed);
        $display("Memory violation     = %b", memory_violation);
        $display("Protected mem write  = %b", DUT.protected_mem_write);

        //===================================================
        // Verify attack was blocked
        //===================================================

        if (DUT.write_allowed == 1'b0 &&
            memory_violation == 1'b1 &&
            DUT.protected_mem_write == 1'b0) begin

            $display("");
            $display("RESULT: UNAUTHORIZED WRITE BLOCKED");
            $display("STATUS: PASS");

        end
        else begin

            $display("");
            $display("RESULT: UNAUTHORIZED WRITE WAS NOT BLOCKED");
            $display("STATUS: FAIL");

        end

        //===================================================
        // Release forced signals
        //===================================================

        release DUT.alu_result;
        release DUT.mem_write;
        release DUT.mem_read;

        #10;

        $display("");
        $display("==============================================");
        $display(" Memory Attack Test Complete");
        $display("==============================================");

        $finish;

    end

endmodule