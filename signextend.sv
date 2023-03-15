module SignExtend (in, out);
input logic [15:0] in;
output logic [31:0] out;

assign out = in[15]? {'1,in} : {'0,in} ;

endmodule : SignExtend
