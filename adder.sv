module adder (A,B, S);
input [31:0] A, B;
output [31:0] S;

assign S = A+B;

endmodule : adder
