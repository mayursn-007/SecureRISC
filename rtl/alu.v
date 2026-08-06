// SecureRISC
// Arithmetic Logic Unit (ALU)
// Author : Mayur S Nagoji

module alu(

    input  [31:0] A,
    input  [31:0] B,
    input  [3:0] ALU_Control,

    output reg [31:0] Result,
    output Zero

);

always @(*) begin

    case(ALU_Control)

        4'b0000: Result = A + B;

        4'b0001: Result = A - B;

        4'b0010: Result = A & B;

        4'b0011: Result = A | B;

        4'b0100: Result = A ^ B;

        4'b0101: Result = A << B[4:0];

        4'b0110: Result = A >> B[4:0];

        4'b0111: Result = (A < B) ? 32'd1 : 32'd0;

        default: Result = 32'd0;

    endcase

end

assign Zero = (Result == 32'd0);

endmodule
