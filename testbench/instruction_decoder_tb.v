`timescale 1ns/1ps

module instruction_decoder_tb;

    reg [31:0] instruction;

    wire [4:0] rs1;
    wire [4:0] rs2;
    wire [4:0] rd;

    wire [2:0] funct3;
    wire [6:0] funct7;

    wire reg_write;
    wire alu_src;
    wire mem_read;
    wire mem_write;
    wire branch;
    wire jump;

    wire [3:0] alu_control;

    //===========================================================
    // DUT
    //===========================================================

    instruction_decoder DUT (
        .instruction(instruction),

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

    //===========================================================
    // Verification
    //===========================================================

    initial begin

        $dumpfile("instruction_decoder.vcd");
        $dumpvars(0, instruction_decoder_tb);

        $display("========================================");
        $display(" SecureRISC Instruction Decoder Test");
        $display("========================================");

        // ADD x1, x2, x3
        instruction = 32'b0000000_00011_00010_000_00001_0110011;
        #10;

        $display("ADD: rs1=%d rs2=%d rd=%d ALU=%b reg_write=%b",
                 rs1, rs2, rd, alu_control, reg_write);

        // SUB x1, x2, x3
        instruction = 32'b0100000_00011_00010_000_00001_0110011;
        #10;

        $display("SUB: rs1=%d rs2=%d rd=%d ALU=%b reg_write=%b",
                 rs1, rs2, rd, alu_control, reg_write);

        // AND x5, x6, x7
        instruction = 32'b0000000_00111_00110_111_00101_0110011;
        #10;

        $display("AND: rs1=%d rs2=%d rd=%d ALU=%b",
                 rs1, rs2, rd, alu_control);

        // ADDI x1, x2, immediate
        instruction = 32'b000000001010_00010_000_00001_0010011;
        #10;

        $display("ADDI: rs1=%d rd=%d ALU=%b alu_src=%b",
                 rs1, rd, alu_control, alu_src);

        // LOAD
        instruction = 32'b000000000100_00010_010_00001_0000011;
        #10;

        $display("LOAD: rs1=%d rd=%d mem_read=%b",
                 rs1, rd, mem_read);

        // STORE
        instruction = 32'b000000000100_00010_010_00001_0100011;
        #10;

        $display("STORE: rs1=%d rs2=%d mem_write=%b",
                 rs1, rs2, mem_write);

        // BEQ
        instruction = 32'b0000000_00011_00010_000_00000_1100011;
        #10;

        $display("BEQ: rs1=%d rs2=%d branch=%b",
                 rs1, rs2, branch);

        // JAL
        instruction = 32'b00000000000100000000_00001_1101111;
        #10;

        $display("JAL: rd=%d jump=%b",
                 rd, jump);

        $display("========================================");
        $display(" Decoder Verification Complete");
        $display("========================================");

        $finish;

    end

endmodule