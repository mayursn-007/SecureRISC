//===========================================================
// SecureRISC SR32
// Hardware Memory Protection Unit (MPU)
//
// Memory Map:
//   0x0000 - 0x00FF : CODE      Read=YES  Write=NO
//   0x0100 - 0x1FFF : DATA      Read=YES  Write=YES
//   0x2000 - 0x2FFF : PROTECTED Read=NO   Write=NO
//   Everything else : BLOCKED
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
        read_allowed     = 1'b0;
        write_allowed    = 1'b0;
        memory_violation = 1'b0;

        //===================================================
        // CODE REGION
        //===================================================

        if (address >= 32'h00000000 &&
            address <= 32'h000000FF) begin

            read_allowed  = 1'b1;
            write_allowed = 1'b0;

        end

        //===================================================
        // DATA REGION
        //===================================================

        else if (address >= 32'h00000100 &&
                 address <= 32'h00001FFF) begin

            read_allowed  = 1'b1;
            write_allowed = 1'b1;

        end

        //===================================================
        // PROTECTED REGION
        //===================================================

        else if (address >= 32'h00002000 &&
                 address <= 32'h00002FFF) begin

            read_allowed  = 1'b0;
            write_allowed = 1'b0;

        end

        //===================================================
        // EVERYTHING ELSE
        //===================================================

        else begin

            read_allowed  = 1'b0;
            write_allowed = 1'b0;

        end

        //===================================================
        // VIOLATION DETECTION
        //===================================================

        if ((mem_read && !read_allowed) ||
            (mem_write && !write_allowed)) begin

            memory_violation = 1'b1;

        end

    end

endmodule
