//===========================================================
// SecureRISC SR32
// Enhanced Instruction Verification Unit
//
// Security principle:
// Validate opcode + function fields before execution.
//
// Supported instructions:
//   R-Type : ADD, SUB, AND, OR, XOR, SLL, SRL, SLT
//   I-Type : ADDI
//   LOAD   : LW
//   STORE  : SW
//   BRANCH : BEQ
//   JUMP   : JAL
//===========================================================

module instruction_verifier (

    input wire [31:0] instruction,

    output reg instruction_valid,
    output reg security_violation

);

    //=======================================================
    // Instruction fields
    //=======================================================

    wire [6:0] opcode;
    wire [2:0] funct3;
    wire [6:0] funct7;

    assign opcode = instruction[6:0];
    assign funct3 = instruction[14:12];
    assign funct7 = instruction[31:25];

    //=======================================================
    // Verification logic
    //=======================================================

    always @(*) begin

        // Safe defaults
        instruction_valid  = 1'b0;
        security_violation = 1'b1;

        case (opcode)

            //================================================
            // R-TYPE
            //
            // ADD  funct7=0000000 funct3=000
            // SUB  funct7=0100000 funct3=000
            // AND  funct7=0000000 funct3=111
            // OR   funct7=0000000 funct3=110
            // XOR  funct7=0000000 funct3=100
            // SLL  funct7=0000000 funct3=001
            // SRL  funct7=0000000 funct3=101
            // SLT  funct7=0000000 funct3=010
            //================================================

            7'b0110011: begin

                case (funct3)

                    // ADD / SUB
                    3'b000: begin

                        if (funct7 == 7'b0000000 ||
                            funct7 == 7'b0100000) begin

                            instruction_valid  = 1'b1;
                            security_violation = 1'b0;

                        end

                    end

                    // SLL
                    3'b001: begin

                        if (funct7 == 7'b0000000) begin

                            instruction_valid  = 1'b1;
                            security_violation = 1'b0;

                        end

                    end

                    // SLT
                    3'b010: begin

                        if (funct7 == 7'b0000000) begin

                            instruction_valid  = 1'b1;
                            security_violation = 1'b0;

                        end

                    end

                    // XOR
                    3'b100: begin

                        if (funct7 == 7'b0000000) begin

                            instruction_valid  = 1'b1;
                            security_violation = 1'b0;

                        end

                    end

                    // SRL
                    3'b101: begin

                        if (funct7 == 7'b0000000) begin

                            instruction_valid  = 1'b1;
                            security_violation = 1'b0;

                        end

                    end

                    // OR
                    3'b110: begin

                        if (funct7 == 7'b0000000) begin

                            instruction_valid  = 1'b1;
                            security_violation = 1'b0;

                        end

                    end

                    // AND
                    3'b111: begin

                        if (funct7 == 7'b0000000) begin

                            instruction_valid  = 1'b1;
                            security_violation = 1'b0;

                        end

                    end

                    default: begin
                        instruction_valid  = 1'b0;
                        security_violation = 1'b1;
                    end

                endcase

            end

            //================================================
            // ADDI
            //================================================

            7'b0010011: begin

                if (funct3 == 3'b000) begin

                    instruction_valid  = 1'b1;
                    security_violation = 1'b0;

                end

            end

            //================================================
            // LOAD
            // LW only
            //================================================

            7'b0000011: begin

                if (funct3 == 3'b010) begin

                    instruction_valid  = 1'b1;
                    security_violation = 1'b0;

                end

            end

            //================================================
            // STORE
            // SW only
            //================================================

            7'b0100011: begin

                if (funct3 == 3'b010) begin

                    instruction_valid  = 1'b1;
                    security_violation = 1'b0;

                end

            end

            //================================================
            // BRANCH
            // BEQ only
            //================================================

            7'b1100011: begin

                if (funct3 == 3'b000) begin

                    instruction_valid  = 1'b1;
                    security_violation = 1'b0;

                end

            end

            //================================================
            // JAL
            //================================================

            7'b1101111: begin

                instruction_valid  = 1'b1;
                security_violation = 1'b0;

            end

            //================================================
            // Everything else is BLOCKED
            //================================================

            default: begin

                instruction_valid  = 1'b0;
                security_violation = 1'b1;

            end

        endcase

    end

endmodule
