//===========================================================
// SecureRISC SR32
// ALU Version 2 Testbench
//
// Author : Mayur S Nagoji
// Project: SecureRISC
//===========================================================

`timescale 1ns/1ps

module alu_tb_v2;
  //-----------------------------------------------------------
// Test Signals
//-----------------------------------------------------------

reg [31:0] operand_a;
reg [31:0] operand_b;
reg [3:0] alu_control;

wire [31:0] result;
wire zero_flag;
wire carry_flag;
wire overflow_flag;
wire negative_flag;
  //-----------------------------------------------------------
// Device Under Test (DUT)
//-----------------------------------------------------------

alu_v2 DUT (

    .operand_a(operand_a),
    .operand_b(operand_b),
    .alu_control(alu_control),

    .result(result),
    .zero_flag(zero_flag),
    .carry_flag(carry_flag),
    .overflow_flag(overflow_flag),
    .negative_flag(negative_flag)

);
 // Waveform generation
    initial begin
        $dumpfile("alu.vcd");
        $dumpvars(0, alu_tb_v2);
    end

    // Test sequence
    initial begin

        $display("========================================");
        $display("       SecureRISC ALU Verification");
        $display("========================================");

        // ADD
        operand_a = 32'd10;
        operand_b = 32'd20;
        alu_control = 4'b0000;
        #10;
        $display("ADD : %0d + %0d = %0d", operand_a, operand_b, result);

        // SUB
        operand_a = 32'd30;
        operand_b = 32'd10;
        alu_control = 4'b0001;
        #10;
        $display("SUB : %0d - %0d = %0d", operand_a, operand_b, result);

        // AND
        operand_a = 32'hFFFF0000;
        operand_b = 32'h0F0F0F0F;
        alu_control = 4'b0010;
        #10;
        $display("AND : %h & %h = %h", operand_a, operand_b, result);

        // OR
        operand_a = 32'hFFFF0000;
        operand_b = 32'h0F0F0F0F;
        alu_control = 4'b0011;
        #10;
        $display("OR  : %h | %h = %h", operand_a, operand_b, result);

        // XOR
        operand_a = 32'hFFFF0000;
        operand_b = 32'h0F0F0F0F;
        alu_control = 4'b0100;
        #10;
        $display("XOR : %h ^ %h = %h", operand_a, operand_b, result);

        // Shift Left Logical
        operand_a = 32'd5;
        operand_b = 32'd2;
        alu_control = 4'b0101;
        #10;
        $display("SLL : %0d << %0d = %0d", operand_a, operand_b[4:0], result);

        // Shift Right Logical
        operand_a = 32'd20;
        operand_b = 32'd2;
        alu_control = 4'b0110;
        #10;
        $display("SRL : %0d >> %0d = %0d", operand_a, operand_b[4:0], result);

        // Set Less Than
        operand_a = 32'd10;
        operand_b = 32'd20;
        alu_control = 4'b0111;
        #10;
        $display("SLT : %0d < %0d = %0d", operand_a, operand_b, result);

        $display("========================================");
        $display("       ALU Verification Complete");
        $display("========================================");

        #10;
        $finish;

    end

endmodule
