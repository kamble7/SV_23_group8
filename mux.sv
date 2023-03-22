import defines::*;

module mux (in1, in2, sel, out);
parameter LEN = LENGTH;
input logic [LEN-1:0] in1, in2;
input logic sel;
output logic [LEN-1:0] out;

assign out = sel?in2:in1;

endmodule: mux

//3 Input Mux
module mux3 (in1, in2, in3, sel, out);
parameter LEN = LENGTH;
input logic [LEN-1:0] in1, in2, in3;
input logic [1:0] sel;
output logic [LEN-1:0] out;

assign out = (sel==2'b00)? in1 : (sel==2'b01)? in2 : in3;

endmodule : mux3
