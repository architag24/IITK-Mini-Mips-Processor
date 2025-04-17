module alu (
    input [31:0] a, b,
    input [4:0] shamt,              // shift amount for shift ops
    input [3:0] alu_control,        // control signal selects operation
    output reg [31:0] result,
    output zero
);

    wire signed [31:0] a_signed = a;
    wire signed [31:0] b_signed = b;

    always @(*) begin
        case (alu_control)
            4'b0000: result = a & b;                    // and
            4'b0001: result = a | b;                    // or
            4'b0010: result = a + b;                    // add
            4'b0011: result = a - b;                    // sub
            4'b0100: result = a ^ b;                    // xor
            4'b0101: result = ~a;                       // not
            4'b0110: result = a << shamt;               // sll
            4'b0111: result = a >> shamt;               // srl
            4'b1000: result = a_signed >>> shamt;       // sra
            4'b1001: result = (a_signed < b_signed) ? 32'd1 : 32'd0; // slt
            4'b1010: result = (a == b) ? 32'd1 : 32'd0;  // seq
            default: result = 32'd0;
        endcase
    end

    assign zero = (result == 0);

endmodule
