import defines::*;
module SignExtend (in, out);
localparam SIGN = N/2; 
input logic [SIGN-1:0] in;
output logic [WORD_LEN-1:0] out;

assign out = in[SIGN-1]? {'1,in} : {'0,in} ;

endmodule : SignExtend
