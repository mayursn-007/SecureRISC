//===========================================================
// SecureRISC SR32
// Data Memory
//===========================================================

module data_memory #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 8
)(
    input  wire                  clk,
    input  wire                  mem_read,
    input  wire                  mem_write,

    input  wire [DATA_WIDTH-1:0] address,
    input  wire [DATA_WIDTH-1:0] write_data,

    output wire [DATA_WIDTH-1:0] read_data
);

    // 256 x 32-bit data memory
    reg [DATA_WIDTH-1:0] memory [0:(1<<ADDR_WIDTH)-1];

    // Combinational read
    assign read_data =
        mem_read ? memory[address[ADDR_WIDTH+1:2]] : 32'b0;

    // Synchronous write
    always @(posedge clk) begin
        if (mem_write)
            memory[address[ADDR_WIDTH+1:2]] <= write_data;
    end

endmodule