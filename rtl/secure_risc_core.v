//===========================================================
// SecureRISC SR32
// Integrated RISC-V Style CPU Core
//
// Security Features:
// 1. Instruction Verification
// 2. Hardware Memory Protection
//===========================================================

module secure_risc_core #(
    parameter DATA_WIDTH = 32
)(
    input wire clk,
    input wire reset,

    //=======================================================
    // CPU outputs
    //=======================================================

    output wire [31:0] pc,
    output wire [31:0] instruction,

    output wire [31:0] alu_result,
    output wire [31:0] writeback_data,

    //=======================================================
    // Control outputs
    //=======================================================

    output wire mem_read,
    output wire mem_write,
    output wire reg_write,
    output wire branch,
    output wire jump,

    //=======================================================
    // Security outputs
    //=======================================================

    output wire instruction_valid,
    output wire security_violation,
    output wire memory_violation
);

    //=======================================================
    // Internal signals
    //=======================================================

    wire [31:0] next_pc;
    wire        pc_write;

    // Decoder
    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;

    wire [2:0] funct3;
    wire [6:0] funct7;

    wire [3:0] alu_control;
    wire       alu_src;

    // Register file
    wire [31:0] register_data_a;
    wire [31:0] register_data_b;

    // Immediate
    wire [31:0] immediate;

    // ALU
    wire [31:0] alu_operand_b;
    wire        alu_zero;

    // Data memory
    wire [31:0] data_memory_read;

    //=======================================================
    // Memory protection signals
    //=======================================================

    wire read_allowed;
    wire write_allowed;

    wire protected_mem_read;
    wire protected_mem_write;

    //=======================================================
    // 1. Program Counter
    //=======================================================

    program_counter PC (
        .clk(clk),
        .reset(reset),
        .pc_write(pc_write),
        .next_pc(next_pc),
        .pc(pc)
    );

    //=======================================================
    // 2. Instruction Memory
    //=======================================================

    instruction_memory IMEM (
        .address(pc),
        .instruction(instruction)
    );

    //=======================================================
    // 3. Instruction Verification
    //=======================================================

    instruction_verifier VERIFIER (
        .instruction(instruction),
        .instruction_valid(instruction_valid),
        .security_violation(security_violation)
    );

    //=======================================================
    // 4. Instruction Decoder
    //
    // Valid instruction:
    //     Original instruction goes to decoder.
    //
    // Invalid instruction:
    //     Replace with safe ADDI/NOP-like instruction.
    //=======================================================

    instruction_decoder DECODER (
        .instruction(
            instruction_valid ?
            instruction :
            32'h00000013
        ),

        .rs1(rs1),
        .rs2(rs2),
        .rd(rd),

        .funct3(funct3),
        .funct7(funct7),

        .reg_write(reg_write),
        .alu_src(alu_src),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump),

        .alu_control(alu_control)
    );

    //=======================================================
    // 5. Register File
    //=======================================================

    register_file REGFILE (
        .clk(clk),
        .reset(reset),

        .read_addr_a(rs1),
        .read_addr_b(rs2),

        .read_data_a(register_data_a),
        .read_data_b(register_data_b),

        .write_addr(rd),
        .write_data(writeback_data),
        .write_enable(reg_write)
    );

    //=======================================================
    // 6. Immediate Generator
    //=======================================================

    immediate_generator IMM_GEN (
        .instruction(
            instruction_valid ?
            instruction :
            32'h00000013
        ),

        .immediate(immediate)
    );

    //=======================================================
    // 7. ALU Operand Selection
    //=======================================================

    assign alu_operand_b =
        alu_src ?
        immediate :
        register_data_b;

    //=======================================================
    // 8. ALU
    //=======================================================

    alu_v2 ALU (
        .operand_a(register_data_a),
        .operand_b(alu_operand_b),
        .alu_control(alu_control),

        .result(alu_result),

        .carry_flag(),
        .overflow_flag(),
        .zero_flag(alu_zero),
        .negative_flag()
    );

    //=======================================================
    // 9. Hardware Memory Protection Unit
    //=======================================================

    memory_protection_unit MPU (
        .address(alu_result),

        .mem_read(mem_read),
        .mem_write(mem_write),

        .read_allowed(read_allowed),
        .write_allowed(write_allowed),

        .memory_violation(memory_violation)
    );

    //=======================================================
    // 10. Protected Memory Control
    //
    // Memory access is allowed ONLY when the MPU permits it.
    //=======================================================

    assign protected_mem_read =
        mem_read && read_allowed;

    assign protected_mem_write =
        mem_write && write_allowed;

    //=======================================================
    // 11. Data Memory
    //=======================================================

    data_memory DMEM (
        .clk(clk),

        .mem_read(protected_mem_read),
        .mem_write(protected_mem_write),

        .address(alu_result),
        .write_data(register_data_b),

        .read_data(data_memory_read)
    );

    //=======================================================
    // 12. Writeback MUX
    //
    // LOAD -> Data memory
    // JAL  -> PC + 4
    // ALU  -> ALU result
    //=======================================================

    assign writeback_data =
        protected_mem_read ?
        data_memory_read :

        jump ?
        (pc + 32'd4) :

        alu_result;

    //=======================================================
    // 13. Next PC Logic
    //=======================================================

    assign next_pc =
        pc + immediate;

    //=======================================================
    // 14. PC Write Control
    //=======================================================

    assign pc_write =
        jump ||
        (branch && alu_zero);

endmodule
