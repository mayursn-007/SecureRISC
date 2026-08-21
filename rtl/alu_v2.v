//===========================================================
// Project : SecureRISC SR32
// Module  : ALU
// Version : v0.2
// Status  : Verified
// Author  : Mayur S Nagoji
//===========================================================
// Description:
// 32-bit combinational Arithmetic Logic Unit.
// Supports arithmetic, logical and shift operations.
//
// ALU Operations:
// 0000 - ADD
// 0001 - SUB
// 0010 - AND
// 0011 - OR
// 0100 - XOR
// 0101 - SLL
// 0110 - SRL
// 0111 - SLT
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
    output zero_flag,
    output negative_flag
);

    //=======================================================
    // Internal signals
    //=======================================================

    reg [DATA_WIDTH-1:0] arithmetic_result;
    reg [DATA_WIDTH-1:0] logic_result;
    reg [DATA_WIDTH-1:0] shift_result;
    reg carry_temp;

    //=======================================================
    // Status flags
    //=======================================================

    assign zero_flag     = (result == {DATA_WIDTH{1'b0}});
    assign negative_flag = result[DATA_WIDTH-1];

    //=======================================================
    // Combinational ALU Logic
    //=======================================================

    always @(*) begin

        // Default values
        result            = {DATA_WIDTH{1'b0}};
        arithmetic_result = {DATA_WIDTH{1'b0}};
        logic_result      = {DATA_WIDTH{1'b0}};
        shift_result      = {DATA_WIDTH{1'b0}};

        carry_flag        = 1'b0;
        carry_temp        = 1'b0;
        overflow_flag     = 1'b0;

        case (alu_control)

            //================================================
            // ADD
            //================================================

            4'b0000: begin

                {carry_temp, arithmetic_result} =
                    operand_a + operand_b;

                result = arithmetic_result;

                carry_flag = carry_temp;

                overflow_flag =
                    (~operand_a[DATA_WIDTH-1] &
                     ~operand_b[DATA_WIDTH-1] &
                      result[DATA_WIDTH-1]) |

                    ( operand_a[DATA_WIDTH-1] &
                      operand_b[DATA_WIDTH-1] &
                     ~result[DATA_WIDTH-1]);

            end

            //================================================
            // SUB
            //================================================

            4'b0001: begin

                {carry_temp, arithmetic_result} =
                    operand_a - operand_b;

                result = arithmetic_result;

                carry_flag = carry_temp;

                overflow_flag =
                    (~operand_a[DATA_WIDTH-1] &
                      operand_b[DATA_WIDTH-1] &
                      result[DATA_WIDTH-1]) |

                    ( operand_a[DATA_WIDTH-1] &
                     ~operand_b[DATA_WIDTH-1] &
                     ~result[DATA_WIDTH-1]);

            end

            //================================================
            // AND
            //================================================

            4'b0010: begin

                logic_result = operand_a & operand_b;

                result = logic_result;

            end

            //================================================
            // OR
            //================================================

            4'b0011: begin

                logic_result = operand_a | operand_b;

                result = logic_result;

            end

            //================================================
            // XOR
            //================================================

            4'b0100: begin

                logic_result = operand_a ^ operand_b;

                result = logic_result;

            end

            //================================================
            // Shift Left Logical
            //================================================

            4'b0101: begin

                shift_result = operand_a << operand_b[4:0];

                result = shift_result;

            end

            //================================================
            // Shift Right Logical
            //================================================

            4'b0110: begin

                shift_result = operand_a >> operand_b[4:0];

                result = shift_result;

            end

            //================================================
            // Set Less Than
            // Signed comparison
            //================================================

            4'b0111: begin

                if ($signed(operand_a) < $signed(operand_b))
                    result =
                        {{(DATA_WIDTH-1){1'b0}}, 1'b1};
                else
                    result =
                        {DATA_WIDTH{1'b0}};

            end

            //================================================
            // Unsupported ALU operation
            //================================================

            default: begin

                result        = {DATA_WIDTH{1'b0}};
                carry_flag    = 1'b0;
                overflow_flag = 1'b0;

            end

        endcase

    end

endmodule
