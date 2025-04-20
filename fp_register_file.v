`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/19/2025 11:24:16 AM
// Design Name:
// Module Name: fp_register_file
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

// 32 single-precision FP registers ($f0-$f31)

module fp_register_file (
    input         clk,
    input         reset,
    input         fp_write,       // write enable
    input  [4:0]  frs, frt, frd,   // source and dest FP reg indices
    input  [31:0] fp_write_data,  // data to write into frd
    output [31:0] fp_read_data1,  // data from frs
    output [31:0] fp_read_data2   // data from frt
);

    reg [31:0] f_registers [0:31];

    integer i;

//    always @(posedge reset) begin
//        for (i = 0; i < 32; i = i + 1)
//            f_registers[i] <= 32'd0;
//    end

    initial begin
        f_registers[0] = 32'h40000000;
        f_registers[1] = 32'h40800000;
    end

    always @(posedge clk) begin
        if (fp_write && frd != 0)
            f_registers[frd] <= fp_write_data;
    end

//    assign fp_read_data1 = (frs != 0) ? f_registers[frs] : 32'd0;
    assign fp_read_data1 = f_registers[frs];
    assign fp_read_data2 = (frt != 0) ? f_registers[frt] : 32'd0;

endmodule