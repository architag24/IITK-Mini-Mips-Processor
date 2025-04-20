`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/19/2025 11:29:39 AM
// Design Name:
// Module Name: fp_controller
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

module fp_controller (
    input  [5:0] opcode,
    input  [4:0] fmt,
    input  [5:0] fp_funct,
    output reg    is_fp_op,      // true for any COP1 instruction
    output reg    fp_add,
    output reg    fp_write,      // write result into FP reg
    output reg    fp_mem_read,   // lwc1
    output reg    fp_mem_write   // swc1
);

    always @(*) begin
        is_fp_op     = 0;
        fp_add       = 0;
//        fp_sub       = 0;
//        fp_mul       = 0;
//        fp_div       = 0;
        fp_write     = 0;
        fp_mem_read  = 0;
        fp_mem_write = 0;

        if(opcode == 6'b010001) begin
            is_fp_op = 1;
            case (fp_funct)
                6'b000000: begin fp_add = 1; fp_write=1; end
                default : ;
            endcase
        end

//        if (opcode == 6'b010001) begin  // COP1
//            is_fp_op = 1;
//            case (fmt)
//                5'b00000: begin  // FP Arithmetic
//                    case (fp_funct)
//                        6'b000000: begin fp_add   = 1; fp_write = 1; end  // add.s
////                        6'b000001: begin fp_sub   = 1; fp_write = 1; end  // sub.s
////                        6'b000010: begin fp_mul   = 1; fp_write = 1; end  // mul.s
////                        6'b000011: begin fp_div   = 1; fp_write = 1; end  // div.s
//                        default: /* no-op */;
//                    endcase
//                end

//                5'b00100: begin  // load FP: lwc1
//                    fp_mem_read = 1;
//                    fp_write    = 1;
//                end

//                5'b00101: begin  // store FP: swc1
//                    fp_mem_write = 1;
//                end

//                default: /* other FP formats */
//                    ;
//            endcase
//        end
//        else if(opcode==6'b100011) begin // lw
//                reg_dst     = 0;
//                alu_src     = 1;
//                mem_to_reg  = 1;
//                reg_write   = 1;
//                mem_read    = 1;
//                alu_control = 4'b0010;
//         end
    end

endmodule
