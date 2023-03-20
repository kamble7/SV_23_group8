module ALU (val1, val2, EXE_CMD, zero, aluout);
typedef enum {ADD, SUB, AND, OR, NOR, XOR, SLA, SLL, SRA, SRL} execmd_t;

input execmd_t EXE_CMD;
input logic [31:0] val1, val2;
output logic zero;
output logic [31:0] aluout;

//typedef enum {ADD, SUB, AND, OR, NOR, XOR, SLA, SLL, SRA, SRL} execmd_t;


assign zero = (aluout=='0);
always_comb
begin
	case (EXE_CMD)
	ADD	: aluout = val1 + val2;
	SUB	: aluout = val1 - val2;
	AND	: aluout = val1 & val2;
	OR	: aluout = val1 | val2;
	XOR	: aluout = ~(val1 | val2);
	NOR	: aluout = val1 ^ val2;
	SLA	: aluout = val1 << val2;
	SLL	: aluout = val1 <<< val2;
	SRA	: aluout = val1 >> val2;
	SRL	: aluout = val1 >>> val2;
	default	: aluout = '0;
	endcase
end

endmodule : ALU
