//===========================================================
// SecureRISC SR32
// Hardware Memory Protection Unit (MPU)
//===========================================================

module memory_protection_unit (

    input wire [31:0] address,
    input wire        mem_read,
    input wire        mem_write,

    output reg        read_allowed,
    output reg        write_allowed,
    output reg        memory_violation

);

    always @(*) begin

        // Safe defaults
        read_allowed    = 1'b0;
        write_allowed   = 1'b0;
        memory_violation = 1'b0;

        //===================================================
        // CODE REGION
        // 0x0000 - 0x0FFF
        // Read allowed, Write forbidden
        //===================================================

        if (address >= 32'h00000000 &&
            address <= 32'h00000FFF) begin

            read_allowed  = 1'b1;
            write_allowed = 1'b0;

        end

        //===================================================
        // DATA REGION
        // 0x1000 - 0x1FFF
        // Read and Write allowed
        //===================================================

        else if (address >= 32'h00001000 &&
                 address <= 32'h00001FFF) begin

            read_allowed  = 1'b1;
            write_allowed = 1'b1;

        end

        //===================================================
        // PROTECTED REGION
        // 0x2000 - 0x2FFF
        // No access allowed
        //===================================================

        else if (address >= 32'h00002000 &&
                 address <= 32'h00002FFF) begin

            read_allowed  = 1'b0;
            write_allowed = 1'b0;

        end

        //===================================================
        // All other addresses
        // No access allowed
        //===================================================

        else begin

            read_allowed  = 1'b0;
            write_allowed = 1'b0;

        end

        //===================================================
        // SECURITY VIOLATION DETECTION
        //===================================================

        if ((mem_read && !read_allowed) ||
            (mem_write && !write_allowed)) begin

            memory_violation = 1'b1;

        end

    end

endmodule