module adder (A,B, S);
input logic [31:0] A, B;
output logic [31:0] S;
output CO;

assign {CO,S} = A + B;

endmodule : adder
