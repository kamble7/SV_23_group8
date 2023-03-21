module mux (in1, in2, sel, out);
parameter LENGTH = 32;
input [LENGTH-1:0] in1, in2;
input sel;
output [LENGTH-1:0] out;

assign out = sel?in2:in1;

endmodule: mux

module mux3 (in1, in2, in3, sel, out);
parameter LENGTH = 32;
input [LENGTH-1:0] in1, in2, in3;
input [1:0] sel;
output [LENGTH-1:0] out;

assign out = (sel==2'b00)? in1 : (sel==2'b01)? in2 : in3;

endmodule : mux3
