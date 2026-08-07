//===========================================================
// Project : SecureRISC SR32
// Module  : ALU
// Version : v0.2
// Status  : Under Development
// Author  : Mayur S Nagoji
//===========================================================
// Description:
// 32-bit combinational Arithmetic Logic Unit.
// Supports arithmetic, logical and shift operations.
//
//===========================================================
module alu_v2
#(
    parameter DATA_WIDTH = 32
)
(
    input  [DATA_WIDTH-1:0] operand_a,
    input  [DATA_WIDTH-1:0] operand_b,

    input  [3:0] alu_control,

    output reg [DATA_WIDTH-1:0] result,

    output reg carry_flag,
    output reg overflow_flag,
    assign zero_flag = (result == 0);
    assign negative_flag = result[DATA_WIDTH-1];
    //===========================================================
// Combinational Logic
//===========================================================

always @(*) begin

    // Default values
    result           = {DATA_WIDTH{1'b0}};
    arithmetic_result = {DATA_WIDTH{1'b0}};
    logic_result      = {DATA_WIDTH{1'b0}};
    shift_result      = {DATA_WIDTH{1'b0}};

    carry_flag       = 1'b0;
    carry_temp       = 1'b0;
    overflow_flag    = 1'b0;

    case (alu_control)

        4'b0000: begin
            // ADD
        end

        4'b0001: begin
            // SUB
        end

        4'b0010: begin
            // AND
        end

        4'b0011: begin
            // OR
        end

        4'b0100: begin
            // XOR
        end

        4'b0101: begin
            // Shift Left Logical
        end

        4'b0110: begin
            // Shift Right Logical
        end

        4'b0111: begin
            // Set Less Than
        end

        default: begin
            result = {DATA_WIDTH{1'b0}};
        end

    endcase

end

);

endmodule
