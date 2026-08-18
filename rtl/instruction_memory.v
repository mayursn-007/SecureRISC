//===========================================================
// SecureRISC SR32
// Instruction Memory
//===========================================================

module instruction_memory #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)(
    input  wire [DATA_WIDTH-1:0] address,
    output wire [DATA_WIDTH-1:0] instruction
);

    // 256 x 32-bit instruction memory
    reg [DATA_WIDTH-1:0] memory [0:(1<<ADDR_WIDTH)-1];

    // Word-aligned instruction addressing
    assign instruction = memory[address[ADDR_WIDTH+1:2]];

endmodule