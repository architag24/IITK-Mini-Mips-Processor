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

//module data_mem (
//  input clk, mem_read, mem_write,
//  input  [31:0] addr, write_data,
//  output reg [31:0] read_data
//);

//  reg [31:0] memory [0:1023];

//  initial begin
//    memory[0] = 32'h3FC00000; //  1.5 in IEEE-754 single
//    memory[1] = 32'h40200000; //  2.5
//    // rest are 0
//  end

//  wire [9:0] word_addr = addr[11:2];

//  always @(posedge clk)
//    if (mem_write) memory[word_addr] <= write_data;

//  always @(*)
//    read_data = mem_read ? memory[word_addr] : 32'd0;
//endmodule

//`timescale 1ns / 1ps

//module testbench;

//    reg clk = 0;
//    reg reset = 1;

//    // Clock generator
//    always #5 clk = ~clk;

//    // Instantiate the top module
//    top dut (
//        .clk(clk),
//        .reset(reset)
//    );

//    initial begin
//        $monitor("Time: %0t | PC: %h | Instruction: %h | Reg[8]: %h | Reg[9]: %h | Reg[10]: %h",
//                         $time, dut.pc_current, dut.instruction, dut.reg_file.registers[8],
//                         dut.reg_file.registers[9], dut.reg_file.registers[10], dut.reg_file.registers[12], dut.reg_file.registers[13], dut.reg_file.registers[14]);
//        $display("===== IITK-Mini-MIPS Simulation Start =====");
//        $dumpfile("cpu.vcd");
//        $dumpvars(0, dut);

//        #10 reset = 0;

//        #500 $display("===== Simulation Done =====");
//        $finish;
//    end

//endmodule