`timescale 1ns/1ps

module instruction_verifier_tb;

    reg  [31:0] instruction;

    wire instruction_valid;
    wire security_violation;

    instruction_verifier DUT (
        .instruction(instruction),
        .instruction_valid(instruction_valid),
        .security_violation(security_violation)
    );

    initial begin

        $dumpfile("instruction_verifier.vcd");
        $dumpvars(0, instruction_verifier_tb);

        $display("========================================");
        $display(" SecureRISC Instruction Verifier Test");
        $display("========================================");

        //===================================================
        // VALID INSTRUCTIONS
        //===================================================

        // ADD
        instruction = 32'h002081B3;
        #10;

        $display("ADD   : valid=%b violation=%b",
                 instruction_valid, security_violation);

        // ADDI
        instruction = 32'h00A00093;
        #10;

        $display("ADDI  : valid=%b violation=%b",
                 instruction_valid, security_violation);

        // LOAD
        instruction = 32'h01002203;
        #10;

        $display("LOAD  : valid=%b violation=%b",
                 instruction_valid, security_violation);

        // STORE
        instruction = 32'h00302823;
        #10;

        $display("STORE : valid=%b violation=%b",
                 instruction_valid, security_violation);

        // BEQ
        instruction = 32'h00310063;
        #10;

        $display("BEQ   : valid=%b violation=%b",
                 instruction_valid, security_violation);

        // JAL
        instruction = 32'h000000EF;
        #10;

        $display("JAL   : valid=%b violation=%b",
                 instruction_valid, security_violation);

        //===================================================
        // INVALID INSTRUCTIONS
        //===================================================

        instruction = 32'h00000000;
        #10;

        $display("INVALID 0 : valid=%b violation=%b",
                 instruction_valid, security_violation);

        instruction = 32'hFFFFFFFF;
        #10;

        $display("INVALID F : valid=%b violation=%b",
                 instruction_valid, security_violation);

        $display("========================================");
        $display(" Instruction Verifier Verification Complete");
        $display("========================================");

        $finish;

    end

endmodule