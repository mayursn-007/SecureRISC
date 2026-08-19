//===========================================================
// SecureRISC SR32
// Instruction Verification Unit
//===========================================================

module instruction_verifier (

    input wire [31:0] instruction,

    output reg instruction_valid,
    output reg security_violation

);

    always @(*) begin

        // Safe defaults
        instruction_valid  = 1'b0;
        security_violation = 1'b1;

        case (instruction[6:0])

            // R-Type
            7'b0110011: begin
                instruction_valid  = 1'b1;
                security_violation = 1'b0;
            end

            // ADDI
            7'b0010011: begin
                instruction_valid  = 1'b1;
                security_violation = 1'b0;
            end

            // LOAD
            7'b0000011: begin
                instruction_valid  = 1'b1;
                security_violation = 1'b0;
            end

            // STORE
            7'b0100011: begin
                instruction_valid  = 1'b1;
                security_violation = 1'b0;
            end

            // BEQ
            7'b1100011: begin
                instruction_valid  = 1'b1;
                security_violation = 1'b0;
            end

            // JAL
            7'b1101111: begin
                instruction_valid  = 1'b1;
                security_violation = 1'b0;
            end

            // Everything else is blocked
            default: begin
                instruction_valid  = 1'b0;
                security_violation = 1'b1;
            end

        endcase

    end

endmodule