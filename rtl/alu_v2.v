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

);

endmodule
