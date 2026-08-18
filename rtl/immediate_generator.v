//===========================================================
// SecureRISC SR32
// Immediate Generator
//===========================================================

module immediate_generator (

    input  wire [31:0] instruction,

    output reg [31:0] immediate

);

    //=======================================================
    // Immediate Generation
    //=======================================================

    always @(*) begin

        // Default
        immediate = 32'b0;

        case (instruction[6:0])

            //================================================
            // I-Type
            // ADDI / LOAD
            //================================================
            7'b0010011,
            7'b0000011: begin
                immediate = {{20{instruction[31]}},
                             instruction[31:20]};
            end

            //================================================
            // S-Type
            // STORE
            //================================================
            7'b0100011: begin
                immediate = {{20{instruction[31]}},
                             instruction[31:25],
                             instruction[11:7]};
            end

            //================================================
            // B-Type
            // BEQ
            //================================================
            7'b1100011: begin
                immediate = {{19{instruction[31]}},
                             instruction[31],
                             instruction[7],
                             instruction[30:25],
                             instruction[11:8],
                             1'b0};
            end

            //================================================
            // J-Type
            // JAL
            //================================================
            7'b1101111: begin
                immediate = {{11{instruction[31]}},
                             instruction[31],
                             instruction[19:12],
                             instruction[20],
                             instruction[30:21],
                             1'b0};
            end

            default: begin
                immediate = 32'b0;
            end

        endcase

    end

endmodule