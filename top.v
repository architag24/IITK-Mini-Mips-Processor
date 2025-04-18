`timescale 1ns / 1ps

module top (
    input clk,
    input reset
);

    // Program Counter and Instruction
    wire [31:0] pc_current;
    wire [31:0] pc_next;
    wire [31:0] instruction;

    // Instruction Fields
    wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immediate;
    wire [25:0] address;

    // Register outputs
    wire [31:0] reg_data1, reg_data2, write_data;
    wire [31:0] alu_input_b;
    wire [31:0] alu_result;
    wire zero;

    // Control Signals
    wire reg_dst, alu_src, mem_to_reg, reg_write;
    wire mem_read, mem_write, branch, jump;
    wire is_imm_unsigned;                      //added to fix ori,xori

    wire [3:0] alu_control;
    wire [4:0] write_reg;

    // ==BRANCHING==
    wire [31:0] branch_offset = imm_ext << 2;
    wire [31:0] branch_target = pc_current + 4 + branch_offset;

    reg [31:0] hi, lo;


    // === PC Logic ===
    pc pc_inst (
        .clk(clk),
        .reset(reset),
        .next_pc(pc_next),
        .curr_pc(pc_current)
    );

    //assign pc_next = pc_current + 4; // no branching yet
    //assign pc_next = (branch && zero) ? branch_target : pc_current + 4;
    wire branch_taken = branch && zero;
    assign pc_next = branch_taken ? branch_target : pc_current + 4;

    // === Instruction Memory ===
    instruction_mem imem (
        .addr(pc_current),
        .instruction(instruction)
    );

    // === Decoder ===
    decoder decode (
        .instruction(instruction),
        .opcode(opcode),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .shamt(shamt),
        .funct(funct),
        .immediate(immediate),
        .address(address)
    );

//    wire [31:0] imm_ext = (is_imm_unsigned) ? {16'b0, immediate} : {{16{immediate[15]}}, immediate};

    // === Controller ===
    controller control_unit (
        .opcode(opcode),
        .funct(funct),
        .reg_dst(reg_dst),
        .alu_src(alu_src),
        .mem_to_reg(mem_to_reg),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch),
        .jump(jump),
        .alu_control(alu_control)
    );

    // === Register File ===
    assign write_reg = (reg_dst) ? rd : rt;

    register_file reg_file (
        .clk(clk),
        .reset(reset),
        .reg_write(reg_write),
        .rs(rs),
        .rt(rt),
        .rd(write_reg),
        .write_data(write_data),
        .read_data1(reg_data1),
        .read_data2(reg_data2)
    );
    
     wire [31:0] imm_ext = {{16{immediate[15]}}, immediate};
    assign alu_input_b = (alu_src) ? imm_ext : reg_data2;

    // === ALU Operand Select ===    whether to choose immediate or reg_data2
    //assign alu_input_b = (alu_src) ? {{16{immediate[15]}}, immediate} : reg_data2;

    alu alu_inst (
        .a(reg_data1),
        .b(alu_input_b),
        .shamt(shamt),
        .alu_control(alu_control),
        .result(alu_result),
        .zero(zero)
    );

    // === Data Memory Placeholder ===
    //assign write_data = alu_result; // for now (no mem_to_reg support yet)

    // === Data Memory ===
    wire [31:0] mem_data_out;

    data_mem dmem (
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .addr(alu_result),
        .write_data(reg_data2),
        .read_data(mem_data_out)
    );

    // === Write-back mux ===
    assign write_data = (mem_to_reg) ? mem_data_out : alu_result;

    always @(posedge clk) begin
    $display("PC: %h | Instruction: %h", pc_current, instruction);
    end


    always @(posedge clk) begin
    if (!reset) begin
        $display("reg[8] (t0)  = %d", reg_file.register[8]);
        $display("reg[9] (t1)  = %d", reg_file.register[9]);
        $display("reg[10] (t2) = %d", reg_file.register[10]);
        $display("reg[11] (t3) = %d", reg_file.register[11]);
        $display("mem[0]       = %d", dmem.memory[0]);
    end
    end


endmodule
