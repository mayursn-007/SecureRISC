//===========================================================
// SecureRISC SR32
// Instruction Memory
//
// Program:
//   x1 = 10
//   x2 = 20
//   x3 = x1 + x2
//   MEM[0x0100] = x3
//   x4 = MEM[0x0100]
//
// Data address 0x0100 is inside the MPU DATA region.
//===========================================================

module instruction_memory (
    input  wire [31:0] address,
    output reg  [31:0] instruction
);

    reg [31:0] memory [0:255];

    integer i;

    initial begin

        // Clear memory
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 32'h00000013;

        //===================================================
        // Program
        //===================================================

        // 0x00: ADDI x1, x0, 10
        memory[0] = 32'h00A00093;

        // 0x04: ADDI x2, x0, 20
        memory[1] = 32'h01400113;

        // 0x08: ADD x3, x1, x2
        memory[2] = 32'h002081B3;

        // 0x0C: SW x3, 0x100(x0)
        memory[3] = 32'h10302023;

        // 0x10: LW x4, 0x100(x0)
        memory[4] = 32'h10002203;

        // 0x14: ADDI x0, x0, 0
        memory[5] = 32'h00000013;

    end

    //=======================================================
    // Word-aligned instruction access
    //=======================================================

    always @(*) begin

        instruction = memory[address[9:2]];

    end

endmodule
