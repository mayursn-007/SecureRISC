`timescale 1ns/1ps

module instruction_memory_tb;

    reg  [31:0] address;
    wire [31:0] instruction;

    instruction_memory DUT (
        .address(address),
        .instruction(instruction)
    );

    initial begin

        $dumpfile("instruction_memory.vcd");
        $dumpvars(0, instruction_memory_tb);

        // Load sample instructions into memory
        DUT.memory[0] = 32'h00000033; // ADD
        DUT.memory[1] = 32'h40000033; // SUB
        DUT.memory[2] = 32'h00000013; // ADDI
        DUT.memory[3] = 32'h00002003; // LOAD
        DUT.memory[4] = 32'h00002023; // STORE

        $display("========================================");
        $display(" SecureRISC Instruction Memory Test");
        $display("========================================");

        address = 32'd0;
        #10;
        $display("Address = %d  Instruction = %h", address, instruction);

        address = 32'd4;
        #10;
        $display("Address = %d  Instruction = %h", address, instruction);

        address = 32'd8;
        #10;
        $display("Address = %d  Instruction = %h", address, instruction);

        address = 32'd12;
        #10;
        $display("Address = %d  Instruction = %h", address, instruction);

        address = 32'd16;
        #10;
        $display("Address = %d  Instruction = %h", address, instruction);

        $display("========================================");
        $display(" Instruction Memory Verification Complete");
        $display("========================================");

        $finish;

    end

endmodule