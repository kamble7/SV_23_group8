import defines::*;
module IDstage (clk, rstn, hazard_detected_in, is_imm_out, ST_or_BNE_out, instruction, reg1, reg2, src1, 
				src2_reg_file, src2_forw, val1, val2, brTaken, EXE_CMD, MEM_R_EN, MEM_W_EN, WB_EN, branch_comm);

input logic clk, rstn, hazard_detected_in;
input logic [N-1:0] instruction, reg1, reg2;
output logic brTaken, MEM_R_EN, MEM_W_EN, WB_EN, is_imm_out, ST_or_BNE_out;
output brcmd_t branch_comm;
output execmd_t EXE_CMD;
output logic [REG_FILE_ADDR_LEN-1:0] src1, src2_reg_file, src2_forw;
output logic [N-1:0] val1, val2;

logic CU2and, Cond2and;
brcmd_t CU2Cond;
logic Is_Imm, ST_or_BNE;
logic [N-1:0] signExt2Mux;

Controller controller (.opCode(instruction[31:26]),
			.branchEn(CU2and),
			.EXE_CMD(EXE_CMD),
			.Branch_command(CU2Cond),
			.Is_Imm(Is_Imm),
			.ST_or_BNE(ST_or_BNE),
			.WB_EN(WB_EN),
			.MEM_R_EN(MEM_R_EN),
			.MEM_W_EN(MEM_W_EN),
			.hazard_detected(hazard_detected_in));

mux #(.LEN(REG_FILE_ADDR_LEN)) mux_src2 (.in1(instruction[20:16]),
			.in2(instruction[15:11]),
			.sel(ST_or_BNE),
			.out(src2_reg_file));

mux #(.LEN(N)) mux_val2 (.in1(reg2),
			.in2(signExt2Mux),
			.sel(Is_Imm),
			.out(val2));

mux #(.LEN(REG_FILE_ADDR_LEN)) mux_src2_forw (.in1(instruction[20:16]),
				.in2('0),
				.sel(Is_Imm),
				.out(src2_forw));

SignExtend signExtend (.in(instruction[15:0]),
			.out(signExt2Mux));

ConditionChecker conditionChecker (.reg1(reg1),
					.reg2(reg2),
					.cuBranchComm(CU2Cond),
					.brCond(Cond2and));

assign brTaken = CU2and && Cond2and;
assign val1 = reg1;
assign src1 = instruction[25:21];
assign is_imm_out = Is_Imm;
assign ST_or_BNE_out = ST_or_BNE;
assign branch_comm = CU2Cond;

endmodule : IDstage
