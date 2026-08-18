`timescale 1ns/1ps

module immediate_generator_tb;

    reg  [31:0] instruction;
    wire [31:0] immediate;

    immediate_generator DUT (
        .instruction(instruction),
        .immediate(immediate)
    );

    initial begin

        $dumpfile("immediate_generator.vcd");
        $dumpvars(0, immediate_generator_tb);

        $display("========================================");
        $display(" SecureRISC Immediate Generator Test");
        $display("========================================");

        // ADDI x1, x2, 10
        instruction = 32'b000000001010_00010_000_00001_0010011;
        #10;
        $display("ADDI  : immediate = %h", immediate);

        // LOAD with immediate 4
        instruction = 32'b000000000100_00010_010_00001_0000011;
        #10;
        $display("LOAD  : immediate = %h", immediate);

        // STORE with immediate 4
        instruction = 32'b0000000_00100_00010_010_00100_0100011;
        #10;
        $display("STORE : immediate = %h", immediate);

        // BEQ with positive offset
        instruction = 32'b0000000_00011_00010_000_00000_1100011;
        #10;
        $display("BEQ   : immediate = %h", immediate);

        // JAL with positive offset
        instruction = 32'b00000000000100000000_00001_1101111;
        #10;
        $display("JAL   : immediate = %h", immediate);

        // ADDI with -1
        instruction = 32'b111111111111_00010_000_00001_0010011;
        #10;
        $display("ADDI -1: immediate = %h", immediate);

        // Unsupported instruction
        instruction = 32'b0;
        #10;
        $display("DEFAULT: immediate = %h", immediate);

        $display("========================================");
        $display(" Immediate Generator Verification Complete");
        $display("========================================");

        $finish;

    end

endmodule