`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 04/19/2025 11:30:33 AM
// Design Name:
// Module Name: fp_alu
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

module fp_alu (
    input  [31:0] a,
    input  [31:0] b,
    input  fp_add,
    output reg [31:0] result
);

    wire [31:0] add_result;

    floating_adder fa (
        .inp1(a),
        .inp2(b),
        .out(add_result)
    );

    always @(*) begin
        if      (fp_add) result = add_result;
//        else if (fp_sub) result = 32'd0;
//        else if (fp_mul) result = 32'd0;
//        else if (fp_div) result = 32'd0;
        else             result = 32'd0;
    end

endmodule
