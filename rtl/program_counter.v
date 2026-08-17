// ============================================================
// SecureRISC - Program Counter
// 32-bit PC with reset, increment, and load support
// ============================================================

module program_counter #(
    parameter DATA_WIDTH = 32
)(
    input  wire                  clk,
    input  wire                  reset,
    input  wire                  pc_write,
    input  wire [DATA_WIDTH-1:0] next_pc,

    output reg  [DATA_WIDTH-1:0] pc
);

    // Program Counter logic
    always @(posedge clk) begin
        if (reset) begin
            pc <= {DATA_WIDTH{1'b0}};
        end
        else if (pc_write) begin
            pc <= next_pc;
        end
        else begin
            pc <= pc + 32'd4;
        end
    end

endmodule