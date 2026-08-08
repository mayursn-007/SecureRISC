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
output zero_flag,
output negative_flag
);
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
    {carry_temp, arithmetic_result} = operand_a + operand_b;

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

        4'b0001: begin
            // SUB
{carry_temp, arithmetic_result} = operand_a - operand_b;

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

        4'b0010: begin
            // AND//

    logic_result = operand_a & operand_b;

    result = logic_result;
        end

        4'b0011: begin
            // OR
        

logic_result = operand_a | operand_b;

result = logic_result;
        end

        4'b0100: begin
            // XOR

logic_result = operand_a ^ operand_b;

result = logic_result;
        end

        4'b0101: begin
            // Shift Left Logical
            shift_result = operand_a << operand_b[4:0];
result = shift_result;
        end

        4'b0110: begin
            // Shift Right Logical
            shift_result = operand_a >> operand_b[4:0];
result = shift_result;
        end
4'b0111: begin
    // Set Less Than (signed comparison)

    if ($signed(operand_a) < $signed(operand_b))
        result = {{(DATA_WIDTH-1){1'b0}}, 1'b1};
    else
        result = {DATA_WIDTH{1'b0}};
end
    

        default: begin
            result = {DATA_WIDTH{1'b0}};
        end

    endcase

end

endmodule
