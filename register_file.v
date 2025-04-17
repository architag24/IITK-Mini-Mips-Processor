module register_file (
    input clk,
    input reset,
    input reg_write,
    input [4:0] rs, rt, rd,       // Source and destination register indices
    input [31:0] write_data,      // Data to write into rd
    output [31:0] read_data1,     // Output of rs
    output [31:0] read_data2      // Output of rt
);

    reg [31:0] registers [0:31];  // 32 general-purpose registers
    (* keep *) reg [31:0] register [0:31];  // Makes it visible in waveform + hierarchical references


    integer i;

    // Reset all registers to 0
    always @(posedge reset) begin
        for (i = 0; i < 32; i = i + 1)
            registers[i] <= 32'd0;
    end

    // Write on rising clock edge
    always @(posedge clk) begin
        if (reg_write && rd != 0)  // Register 0 is hardwired to zero
            registers[rd] <= write_data;
    end

    // Asynchronous read
    assign read_data1 = (rs != 0) ? registers[rs] : 32'd0;
    assign read_data2 = (rt != 0) ? registers[rt] : 32'd0;

endmodule
