import defines::*;
module adder (in1,in2, out);

input [N-1:0] in1, in2;
output [N-1:0] out;

assign out = in1+in2;

endmodule : adder
