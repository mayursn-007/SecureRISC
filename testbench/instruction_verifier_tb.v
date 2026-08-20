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

    integer pass_count;
    integer fail_count;

    task test_instruction;
        input [31:0] test_instruction;
        input        expected_valid;
        input        expected_violation;
        input [80*8:1] test_name;

        begin
            instruction = test_instruction;
            #10;

            if (instruction_valid == expected_valid &&
                security_violation == expected_violation) begin

                $display("PASS: %s | instruction=%h | valid=%b | violation=%b",
                         test_name,
                         instruction,
                         instruction_valid,
                         security_violation);

                pass_count = pass_count + 1;

            end
            else begin

                $display("FAIL: %s | instruction=%h | valid=%b | violation=%b",
                         test_name,
                         instruction,
                         instruction_valid,
                         security_violation);

                fail_count = fail_count + 1;

            end
        end
    endtask

    initial begin

        $dumpfile("instruction_verifier.vcd");
        $dumpvars(0, instruction_verifier_tb);

        pass_count = 0;
        fail_count = 0;

        $display("");
        $display("==============================================");
        $display(" SecureRISC Enhanced Instruction Verification");
        $display("==============================================");

        //===================================================
        // Valid R-type instructions
        //===================================================

        test_instruction(
            32'h002081B3,
            1'b1,
            1'b0,
            "ADD"
        );

        // SUB
        test_instruction(
            32'h402081B3,
            1'b1,
            1'b0,
            "SUB"
        );

        // AND
        test_instruction(
            32'h0020F1B3,
            1'b1,
            1'b0,
            "AND"
        );

        // OR
        test_instruction(
            32'h0020E1B3,
            1'b1,
            1'b0,
            "OR"
        );

        // XOR
        test_instruction(
            32'h0020C1B3,
            1'b1,
            1'b0,
            "XOR"
        );

        // SLL
        test_instruction(
            32'h002091B3,
            1'b1,
            1'b0,
            "SLL"
        );

        // SRL
        test_instruction(
            32'h0020D1B3,
            1'b1,
            1'b0,
            "SRL"
        );

        // SLT
        test_instruction(
            32'h0020A1B3,
            1'b1,
            1'b0,
            "SLT"
        );

        //===================================================
        // Invalid R-type combinations
        //===================================================

        // Invalid funct3
        test_instruction(
            32'h0020B1B3,
            1'b0,
            1'b1,
            "INVALID R-TYPE FUNCT3"
        );

        // Invalid funct7
        test_instruction(
            32'h202081B3,
            1'b0,
            1'b1,
            "INVALID R-TYPE FUNCT7"
        );

        //===================================================
        // ADDI
        //===================================================

        test_instruction(
            32'h00A00093,
            1'b1,
            1'b0,
            "ADDI"
        );

        // Invalid ADDI funct3
        test_instruction(
            32'h00A01093,
            1'b0,
            1'b1,
            "INVALID ADDI"
        );

        //===================================================
        // LOAD
        //===================================================

        test_instruction(
            32'h10002203,
            1'b1,
            1'b0,
            "LW"
        );

        // Invalid LOAD funct3
        test_instruction(
            32'h10001203,
            1'b0,
            1'b1,
            "INVALID LOAD"
        );

        //===================================================
        // STORE
        //===================================================

        test_instruction(
            32'h10302023,
            1'b1,
            1'b0,
            "SW"
        );

        // Invalid STORE funct3
        test_instruction(
            32'h10301023,
            1'b0,
            1'b1,
            "INVALID STORE"
        );

        //===================================================
        // BEQ
        //===================================================

        test_instruction(
            32'h00310063,
            1'b1,
            1'b0,
            "BEQ"
        );

        // Invalid branch funct3
        test_instruction(
            32'h00311063,
            1'b0,
            1'b1,
            "INVALID BRANCH"
        );

        //===================================================
        // JAL
        //===================================================

        test_instruction(
            32'h000000EF,
            1'b1,
            1'b0,
            "JAL"
        );

        //===================================================
        // Completely invalid instructions
        //===================================================

        test_instruction(
            32'h00000000,
            1'b0,
            1'b1,
            "INVALID ZERO"
        );

        test_instruction(
            32'hFFFFFFFF,
            1'b0,
            1'b1,
            "INVALID FFFFFFFF"
        );

        //===================================================
        // Final result
        //===================================================

        $display("");
        $display("==============================================");
        $display(" VERIFICATION SUMMARY");
        $display("==============================================");

        $display("Tests passed = %0d", pass_count);
        $display("Tests failed = %0d", fail_count);

        if (fail_count == 0) begin
            $display("");
            $display("ENHANCED INSTRUCTION VERIFIER PASSED");
            $display("ALL TESTS PASSED");
        end
        else begin
            $display("");
            $display("ENHANCED INSTRUCTION VERIFIER FAILED");
        end

        $display("==============================================");

        $finish;

    end

endmodule
