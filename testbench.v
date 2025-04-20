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
//        $monitor("Time: %0t | PC: %h | Instruction: %h | Reg[8]: %h | Reg[9]: %h | Reg[10]: %h | Reg[11]: %h | Reg[26]: %h | Reg[27]: %h",
//                         $time, dut.pc_current, dut.instruction, dut.reg_file.registers[8],
//                         dut.reg_file.registers[9], dut.reg_file.registers[10], dut.reg_file.registers[11], dut.reg_file.registers[26], dut.reg_file.registers[27]);

        // $monitor("Time: %0t | PC: %h | Instruction: %h | Reg[1]: %0d | Reg[2]: %0d | Reg[5]: %0d | Reg[7]: %0d | Reg[8]: %0d | Reg[31]: %0d",
        //          $time, dut.pc_current, dut.instruction,
        //          dut.reg_file.register[1], dut.reg_file.register[2],
        //          dut.reg_file.register[5], dut.reg_file.register[7],
        //          dut.reg_file.register[8], dut.reg_file.register[31]);

        $display("===== IITK-Mini-MIPS Simulation Start =====");
        $dumpfile("cpu.vcd");
        $dumpvars(0, dut);

        #10 reset = 0;

        #2000 $display("===== Simulation Done =====");
        $finish;
    end

endmodule