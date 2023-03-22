import defines::*;
module HazardDetection (forward_EN, is_imm, ST_or_BNE, src1_ID, src2_ID, dest_EXE, WB_EN_EXE, dest_MEM, WB_EN_MEM, MEM_R_EN_EXE, branch_comm, hazarddetected);

input logic [REG_FILE_ADDR_LEN-1:0] src1_ID, src2_ID;
input logic [REG_FILE_ADDR_LEN-1:0] dest_EXE, dest_MEM;
input brcmd_t branch_comm;
input logic forward_EN, WB_EN_EXE, WB_EN_MEM, is_imm, ST_or_BNE, MEM_R_EN_EXE;
output logic hazarddetected;

logic src2_is_valid, exe_has_hazard, mem_has_hazard, hazard, instr_is_branch;

assign src2_is_valid = (~is_imm) || ST_or_BNE;
assign exe_has_hazard = WB_EN_EXE && ((src1_ID==dest_EXE) || (src2_is_valid && (src2_ID==dest_EXE)));
assign mem_has_hazard = WB_EN_MEM && ((src1_ID==dest_MEM) || (src2_is_valid && (src2_ID==dest_MEM)));

assign hazard = (exe_has_hazard || mem_has_hazard);
assign instr_is_branch = ((branch_comm==COND_BEZ)||(branch_comm==COND_BNE));

assign hazarddetected = ~forward_EN? hazard : (instr_is_branch && hazard) || (MEM_R_EN_EXE && mem_has_hazard);

endmodule : HazardDetection
