import defines::*;
module SignExtend (in, out);

input logic [(N/2)-1:0] in;
output logic [N-1:0] out;

assign out = in[N/2]? {'1,in} : {'0,in} ;

endmodule : SignExtend
