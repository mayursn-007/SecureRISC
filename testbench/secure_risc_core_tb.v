`timescale 1ns/1ps

//===========================================================
// SecureRISC SR32
// CPU Core Integration Testbench
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
        .jump(jump)
    );

    //=======================================================
    // Clock
    //=======================================================

    always #5 clk = ~clk;

    //=======================================================
    // Test Program
    //
    // 0: ADDI x1, x0, 10
    // 4: ADDI x2, x0, 20
    // 8: ADD  x3, x1, x2
    // 12: SW   x3, 16(x0)
    // 16: LW   x4, 16(x0)
    //=======================================================

    initial begin

        $dumpfile("secure_risc_core.vcd");
        $dumpvars(0, secure_risc_core_tb);

        clk   = 1'b0;
        reset = 1'b1;

        //===================================================
        // Load program into Instruction Memory
        //===================================================

        DUT.IMEM.memory[0] = 32'h00A00093;
        DUT.IMEM.memory[1] = 32'h01400113;
        DUT.IMEM.memory[2] = 32'h002081B3;
        DUT.IMEM.memory[3] = 32'h00302823;
        DUT.IMEM.memory[4] = 32'h01002203;

        //===================================================
        // Reset
        //===================================================

        #12;
        reset = 1'b0;

        //===================================================
        // Run processor
        //===================================================

        #60;

        $display("");
        $display("========================================");
        $display(" SecureRISC CPU Integration Test");
        $display("========================================");

        $display("x1 = %d", DUT.REGFILE.registers[1]);
        $display("x2 = %d", DUT.REGFILE.registers[2]);
        $display("x3 = %d", DUT.REGFILE.registers[3]);
        $display("x4 = %d", DUT.REGFILE.registers[4]);

        $display("========================================");

        if (DUT.REGFILE.registers[1] == 10 &&
            DUT.REGFILE.registers[2] == 20 &&
            DUT.REGFILE.registers[3] == 30 &&
            DUT.REGFILE.registers[4] == 30) begin

            $display("CPU INTEGRATION TEST PASSED");

        end
        else begin

            $display("CPU INTEGRATION TEST FAILED");

        end

        $display("========================================");

        $finish;

    end

endmodule