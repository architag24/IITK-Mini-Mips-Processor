module data_mem (
    input clk,
    input mem_read,
    input mem_write,
    input [31:0] addr,
    input [31:0] write_data,
    output reg [31:0] read_data
);

    reg [31:0] memory [0:1023]; // 1K words = 4KB memory

    initial begin
        memory[0] = 32'b00000000000000000000000000000100; // 4
        memory[1] = 32'b00000000000000000000000000000011; // 3
        memory[2] = 32'b00000000000000000000000000000101; // 5
        memory[3] = 32'b00000000000000000000000000000001; // 1
        memory[4] = 32'b00000000000000000000000000000010; // 2
        memory[5] = 32'b00000000000000000000000000000110; // 6
        memory[6] = 32'b00000000000000000000000000000111; // 7
//        memory[31] = 32'b00000000000000000000000000000100;
    end

    wire [9:0] word_addr = addr[9:0]; // word-aligned

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

