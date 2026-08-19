`timescale 1ns/1ps

//===========================================================
// SecureRISC CPU Integration Test
// Updated for Hardware Memory Protection
//===========================================================

module secure_risc_core_tb;

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

        $dumpfile("secure_risc_core.vcd");
        $dumpvars(0, secure_risc_core_tb);

        clk   = 1'b0;
        reset = 1'b1;

        $display("==============================================");
        $display(" SecureRISC CPU Integration Test");
        $display("==============================================");

        // Hold reset through a clock edge
        #17;
        reset = 1'b0;

        // Allow CPU to execute
        #55;

        $display("");
        $display("x1 = %d", DUT.REGFILE.registers[1]);
        $display("x2 = %d", DUT.REGFILE.registers[2]);
        $display("x3 = %d", DUT.REGFILE.registers[3]);
        $display("x4 = %d", DUT.REGFILE.registers[4]);

        $display("");
        $display("Security status:");
        $display("Instruction valid   = %b", instruction_valid);
        $display("Security violation  = %b", security_violation);
        $display("Memory violation    = %b", memory_violation);

        //===================================================
        // Check arithmetic
        //===================================================

        if (DUT.REGFILE.registers[1] == 32'd10 &&
            DUT.REGFILE.registers[2] == 32'd20 &&
            DUT.REGFILE.registers[3] == 32'd30) begin

            $display("");
            $display("CPU ARITHMETIC TEST PASSED");

        end
        else begin

            $display("");
            $display("CPU ARITHMETIC TEST FAILED");

        end

        //===================================================
        // Final status
        //===================================================

        if (DUT.REGFILE.registers[1] == 32'd10 &&
            DUT.REGFILE.registers[2] == 32'd20 &&
            DUT.REGFILE.registers[3] == 32'd30 &&
            security_violation == 1'b0) begin

            $display("");
            $display("==============================================");
            $display(" CPU INTEGRATION TEST PASSED");
            $display("==============================================");

        end
        else begin

            $display("");
            $display("==============================================");
            $display(" CPU INTEGRATION TEST FAILED");
            $display("==============================================");

        end

        $finish;

    end

endmodule
