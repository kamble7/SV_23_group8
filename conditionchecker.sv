module ConditionChecker (reg1, reg2, cuBranchComm, brCond);
typedef enum {COND_JUMP, COND_BEZ, COND_BNE} brcmd_t;

input logic [31:0] reg1, reg2;
input brcmd_t cuBranchComm;
output logic brCond;

always_comb
begin
	case (cuBranchComm)
	COND_JUMP	: brCond = 1;
	COND_BEZ	: brCond = (reg1=='0)? 1:0;
	COND_BNE	: brCond = (reg1 != reg2)? 1:0;
	default	: brCond = 0;
	endcase
end


endmodule : ConditionChecker
