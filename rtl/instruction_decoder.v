//===========================================================
// SecureRISC SR32
// Instruction Decoder
//===========================================================

module instruction_decoder (

    input  wire [31:0] instruction,

    // Register fields
    output wire [4:0] rs1,
    output wire [4:0] rs2,
    output wire [4:0] rd,

    // Function fields
    output wire [2:0] funct3,
    output wire [6:0] funct7,

    // Control signals
    output reg        reg_write,
    output reg        alu_src,
    output reg        mem_read,
    output reg        mem_write,
    output reg        branch,
    output reg        jump,

    // ALU operation
    output reg [3:0]  alu_control
);
//===========================================================
// Instruction Field Extraction
//===========================================================

assign rs1    = instruction[19:15];
assign rs2    = instruction[24:20];
assign rd     = instruction[11:7];

assign funct3 = instruction[14:12];
assign funct7 = instruction[31:25];

//===========================================================
// Default Control Signals
//===========================================================

always @(*) begin

    // Safe defaults
    reg_write   = 1'b0;
    alu_src     = 1'b0;
    mem_read    = 1'b0;
    mem_write   = 1'b0;
    branch      = 1'b0;
    jump        = 1'b0;
    alu_control = 4'b0000;

    // Decode opcode
    case (instruction[6:0])

        // R-type
        7'b0110011: begin
            reg_write = 1'b1;
            alu_src = 1'b0;

            case (funct3)

                // ADD / SUB
                3'b000: begin
                    if (funct7 == 7'b0100000)
                        alu_control = 4'b0001; // SUB
                    else
                        alu_control = 4'b0000; // ADD
                end

                // AND
                3'b111:
                    alu_control = 4'b0010;

                // OR
                3'b110:
                    alu_control = 4'b0011;

                // XOR
                3'b100:
                    alu_control = 4'b0100;

                // SLL
                3'b001:
                    alu_control = 4'b0101;

                // SRL
                3'b101:
                    alu_control = 4'b0110;

                // SLT
                3'b010:
                    alu_control = 4'b0111;

                default:
                    alu_control = 4'b0000;

            endcase
        end

        // ADDI
        7'b0010011: begin
            reg_write = 1'b1;
            alu_src = 1'b1;
            alu_control = 4'b0000;
        end

        // LOAD
        7'b0000011: begin
            reg_write = 1'b1;
            alu_src = 1'b1;
            mem_read = 1'b1;
            alu_control = 4'b0000;
        end

        // STORE
        7'b0100011: begin
            alu_src = 1'b1;
            mem_write = 1'b1;
            alu_control = 4'b0000;
        end

        // BEQ
        7'b1100011: begin
            branch = 1'b1;
            alu_control = 4'b0001; // SUB for comparison
        end

        // JAL
        7'b1101111: begin
            reg_write = 1'b1;
            jump = 1'b1;
        end

        default: begin
            // Keep safe defaults
        end

    endcase

end

endmodule