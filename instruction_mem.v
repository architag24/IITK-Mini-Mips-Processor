module instruction_mem (
    input [31:0] addr,
    output [31:0] instruction
);
    reg [31:0] memory [0:255]; // 1 KB instr mem

    initial begin
        memory[0] = 32'b00100000000010000000000000000101; // addi $8, $0, 5
        memory[1] = 32'b00100000000010010000000000001010; // addi $9, $0, 10
        memory[2] = 32'b00000001000010010101000000100000; // add  $10,$8,$9
        memory[3] = 32'b10101100000010100000000000000000; // sw   $10, 0($0)
        memory[4] = 32'b10001100000010110000000000000000; // lw   $11, 0($0)
    end

    assign instruction = memory[addr[31:2]]; // word-aligned
endmodule
