module fp_decoder (
    input  [31:0] instruction,
    output [4:0]  fmt,       // bits[25:21]
    output [5:0]  fp_funct   // bits[5:0]
);

    assign fmt      = instruction[25:21];
    assign fp_funct = instruction[5:0];

endmodule   