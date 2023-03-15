module mux (I0,I1,S,O);
input [] I0, I1;
input S;
output [] O;

assign O = S?I1:I0;

endmodule: mux
