import defines::*;
module ALU (val1, val2, EXE_CMD, aluout);

input execmd_t EXE_CMD;
input logic [WORD_LEN-1:0] val1, val2;
output logic zero;
output logic [WORD_LEN-1:0] aluout;

always_comb
begin
case (EXE_CMD)
	EXE_ADD	: aluout = val1 + val2;
	EXE_SUB	: aluout = val1 - val2;
	EXE_AND	: aluout = val1 & val2;
	EXE_OR	: aluout = val1 | val2;
	EXE_XOR	: aluout = ~(val1 | val2);
	EXE_NOR	: aluout = val1 ^ val2;
	EXE_SLA	: aluout = val1 <<< val2;
	EXE_SLL	: aluout = val1 << val2;
	EXE_SRA	: aluout = val1 >>> val2;
	EXE_SRL	: aluout = val1 >> val2;
	default	: aluout = '0;
endcase
end

endmodule : ALU
