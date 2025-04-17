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
        memory[5] = 32'b00110001000011000000000000001111; // andi $12, $8, 0x000F  => $12 = $8 & 0xF
        memory[6] = 32'b00110101000111010000000011110000; // ori  $13, $9, 0x00F0  => $13 = $9 | 0xF0
        memory[7] = 32'b00111001000111100000000011111111; // xori $14, $9, 0x00FF  => $14 = $9 ^ 0xFF

    end

    assign instruction = memory[addr[31:2]]; // word-aligned
endmodule
