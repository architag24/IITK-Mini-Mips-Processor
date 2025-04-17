`timescale 1ns / 1ps

module testbench;

    reg clk = 0;
    reg reset = 1;

    // Clock generator
    always #5 clk = ~clk;

    // Instantiate the top module
    top dut (
        .clk(clk),
        .reset(reset)
    );

    initial begin
        $monitor("Time: %0t | PC: %h | Instruction: %h | Reg[8]: %h | Reg[9]: %h | Reg[10]: %h", 
                         $time, dut.pc_current, dut.instruction, dut.reg_file.registers[8], 
                         dut.reg_file.registers[9], dut.reg_file.registers[10]);
        $display("===== IITK-Mini-MIPS Simulation Start =====");
        $dumpfile("cpu.vcd");
        $dumpvars(0, dut);

        #10 reset = 0;

        #100 $display("===== Simulation Done =====");
        $finish;
    end

endmodule
