module data_mem (
    input clk,
    input mem_read,
    input mem_write,
    input [31:0] addr,
    input [31:0] write_data,
    output reg [31:0] read_data
);

    reg [31:0] memory [0:1023]; // 1K words = 4KB memory

    wire [9:0] word_addr = addr[11:2]; // word-aligned

    always @(posedge clk) begin
        if (mem_write) begin
            memory[word_addr] <= write_data;
        end
    end

    always @(*) begin
        if (mem_read)
            read_data = memory[word_addr];
        else
            read_data = 32'd0;
    end

endmodule
