module ALU (val1, val2, zero, aluout);
input logic [31:0] val1, val2;
output logic zero;
output logic [31:0] aluout;

assign zero = (aluout=='0);

always_comb
begin
	case (EXE_CMD)
		: aluout = val1 + val2;
		: aluout = val1 - val2;
		: aluout = val1 & val2;
		: aluout = val1 | val2;
		: aluout = ~(val11 | val2);
		: aluout = val1 ^ val2;
		: aluout = val1 << val2;
		: aluout = val1 <<< val2;
		: aluout = val1 >> val2;
		: aluout = val1 >>> val2;
	default	: aluout = '0;
	endcase
end

endmodule : ALU
