import defines::*;
module ConditionChecker (reg1, reg2, cuBranchComm, brCond);

input logic [WORD_LEN-1:0] reg1, reg2;
input brcmd_t cuBranchComm;
output logic brCond;

always_comb
begin
	unique case (cuBranchComm)
	COND_JUMP	: brCond = 1;
	COND_BEZ	: brCond = (reg1=='0)? 1:0;
	COND_BNE	: brCond = (reg1 != reg2)? 1:0;
	default	: brCond = 0;
	endcase
end


endmodule : ConditionChecker
