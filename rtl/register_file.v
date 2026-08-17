//===========================================================
// Project : SecureRISC SR32
// Module  : Register File
// File    : register_file.v
//
// Description:
// 32 x 32-bit register file with two combinational read
// ports and one synchronous write port.
//
// Register x0 is permanently hardwired to zero.
//===========================================================

module register_file #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5
)(
    input  wire                   clk,
    input  wire                   reset,

    input  wire [ADDR_WIDTH-1:0]  read_addr_a,
    input  wire [ADDR_WIDTH-1:0]  read_addr_b,

    output wire [DATA_WIDTH-1:0]  read_data_a,
    output wire [DATA_WIDTH-1:0]  read_data_b,

    input  wire [ADDR_WIDTH-1:0]  write_addr,
    input  wire [DATA_WIDTH-1:0]  write_data,
    input  wire                   write_enable
);
//===========================================================
// Register Storage
//===========================================================

reg [DATA_WIDTH-1:0] registers [0:31];
//===========================================================
// Synchronous Write Logic
//===========================================================

//===========================================================
// Synchronous Write Logic
//===========================================================

always @(posedge clk) begin

    if (reset) begin
        registers[0] <= {DATA_WIDTH{1'b0}};
    end
    else if (write_enable && (write_addr != {ADDR_WIDTH{1'b0}})) begin
        registers[write_addr] <= write_data;
    end

    // x0 is always forced to zero
    registers[0] <= {DATA_WIDTH{1'b0}};

end


//===========================================================
// Combinational Read Logic
//===========================================================

assign read_data_a =
    (read_addr_a == {ADDR_WIDTH{1'b0}})
    ? {DATA_WIDTH{1'b0}}
    : registers[read_addr_a];

assign read_data_b =
    (read_addr_b == {ADDR_WIDTH{1'b0}})
    ? {DATA_WIDTH{1'b0}}
    : registers[read_addr_b];


endmodule