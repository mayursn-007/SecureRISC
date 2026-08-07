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
