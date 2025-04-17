module controller (
    input [5:0] opcode,
    input [5:0] funct,
    output reg reg_dst,
    output reg alu_src,
    output reg mem_to_reg,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg jump,
    output reg [3:0] alu_control
);

    always @(*) begin
        // Default values
        reg_dst     = 0;
        alu_src     = 0;
        mem_to_reg  = 0;
        reg_write   = 0;
        mem_read    = 0;
        mem_write   = 0;
        branch      = 0;
        jump        = 0;
        alu_control = 4'b0000;

        case (opcode)
            6'b000000: begin  // R-type
                reg_dst    = 1;
                reg_write  = 1;
                alu_src    = 0;
                case (funct)
                    6'b100000: alu_control = 4'b0010; // add
                    6'b100010: alu_control = 4'b0011; // sub
                    6'b100100: alu_control = 4'b0000; // and
                    6'b100101: alu_control = 4'b0001; // or
                    6'b100110: alu_control = 4'b0100; // xor
                    6'b100111: alu_control = 4'b0101; // not
                    6'b000000: alu_control = 4'b0110; // sll
                    6'b000010: alu_control = 4'b0111; // srl
                    6'b000011: alu_control = 4'b1000; // sra
                    6'b101010: alu_control = 4'b1001; // slt
                    6'b101001: alu_control = 4'b1010; // seq
                    default:   alu_control = 4'b0000;
                endcase
            end

            6'b001000: begin // addi
                reg_dst     = 0;
                reg_write   = 1;
                alu_src     = 1;
                alu_control = 4'b0010;
            end

            6'b100011: begin // lw
                reg_dst     = 0;
                alu_src     = 1;
                mem_to_reg  = 1;
                reg_write   = 1;
                mem_read    = 1;
                alu_control = 4'b0010;
            end

            6'b101011: begin // sw
                alu_src     = 1;
                mem_write   = 1;
                alu_control = 4'b0010;
            end

            6'b000100: begin // beq
                branch      = 1;
                alu_control = 4'b0011;
            end

            6'b000010: begin // j
                jump = 1;
            end

            default: begin
                // Keep all control signals default
            end
        endcase
    end

endmodule
