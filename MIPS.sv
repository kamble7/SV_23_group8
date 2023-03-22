import defines::*;

module MIPS (input clock, input rstn, input forward_EN);

logic [N-1:0] PC_IF, PC_ID, PC_EXE, PC_MEM;
logic [N-1:0] inst_IF, inst_ID;
logic [N-1:0] reg1_ID, reg2_ID, ST_value_EXE, ST_value_EXE2MEM, ST_value_MEM;
logic [N-1:0] val1_ID, val1_EXE;
logic [N-1:0] val2_ID, val2_EXE;
logic [N-1:0] ALURes_EXE, ALURes_MEM, ALURes_WB;
logic [N-1:0] dataMem_out_MEM, dataMem_out_WB;
logic [N-1:0] WB_result;
logic [REG_FILE_ADDR_LEN-1:0] dest_EXE, dest_MEM, dest_WB; // dest_ID = instruction[25:21] thus nothing declared
logic [REG_FILE_ADDR_LEN-1:0] src1_ID, src2_regFile_ID, src2_forw_ID, src2_forw_EXE, src1_forw_EXE;
execmd_t EXE_CMD_ID, EXE_CMD_EXE;
logic [FORWARD_SEL_LEN-1:0] val1_sel, val2_sel, ST_val_sel;
brcmd_t branch_comm;
logic Br_Taken_ID, IF_Flush, Br_Taken_EXE;
logic MEM_R_EN_ID, MEM_R_EN_EXE, MEM_R_EN_MEM, MEM_R_EN_WB;
logic MEM_W_EN_ID, MEM_W_EN_EXE, MEM_W_EN_MEM;
logic WB_EN_ID, WB_EN_EXE, WB_EN_MEM, WB_EN_WB;
logic hazard_detected, is_imm, ST_or_BNE;

RegFile regFile(
	// INPUTS
	.clk(clock),
	.rstn(rstn),
	.src1(src1_ID),
	.src2(src2_regFile_ID),
	.dest(dest_WB),
	.writeVal(WB_result),
	.writeEn(WB_EN_WB),
	// OUTPUTS
	.reg1(reg1_ID),
	.reg2(reg2_ID)
);

HazardDetection hazard (
	// INPUTS
	.forward_EN(forward_EN),
	.is_imm(is_imm),
	.ST_or_BNE(ST_or_BNE),
	.src1_ID(src1_ID),
	.src2_ID(src2_regFile_ID),
	.dest_EXE(dest_EXE),
	.dest_MEM(dest_MEM),
	.WB_EN_EXE(WB_EN_EXE),
	.WB_EN_MEM(WB_EN_MEM),
	.MEM_R_EN_EXE(MEM_R_EN_EXE),
	// OUTPUTS
	.branch_comm(branch_comm),
	.hazarddetected(hazard_detected)
);

ForwardingUnit forwrding_EXE (
	.src1_EXE(src1_forw_EXE),
	.src2_EXE(src2_forw_EXE),
	.ST_src_EXE(dest_EXE),
	.dest_MEM(dest_MEM),
	.dest_WB(dest_WB),
	.WB_EN_MEM(WB_EN_MEM),
	.WB_EN_WB(WB_EN_WB),
	.val1_sel(val1_sel),
	.val2_sel(val2_sel),
	.ST_val_sel(ST_val_sel)
);

//###########################
//##### PIPLINE STAGES ######
//###########################
IFstage IFstage (
	// INPUTS
	.clk(clock),
	.rstn(rstn),
	.freeze(hazard_detected),
	.brTaken(Br_Taken_ID),
	.brOffset(val2_ID),
	// OUTPUTS
	.instruction(inst_IF),
	.PC(PC_IF)
);

IDstage IDstage (
	// INPUTS
	.clk(clock),
	.rstn(rstn),
	.hazard_detected_in(hazard_detected),
	.instruction(inst_ID),
	.reg1(reg1_ID),
	.reg2(reg2_ID),
	// OUTPUTS
	.src1(src1_ID),
	.src2_reg_file(src2_regFile_ID),
	.src2_forw(src2_forw_ID),
	.val1(val1_ID),
	.val2(val2_ID),
	.brTaken(Br_Taken_ID),
	.EXE_CMD(EXE_CMD_ID),
	.MEM_R_EN(MEM_R_EN_ID),
	.MEM_W_EN(MEM_W_EN_ID),
	.WB_EN(WB_EN_ID),
	.is_imm_out(is_imm),
	.ST_or_BNE_out(ST_or_BNE),
	.branch_comm(branch_comm)
);

EXEstage EXEstage (
	// INPUTS
	.clk(clock),
	.EXE_CMD(EXE_CMD_EXE),
	.val1_sel(val1_sel),
	.val2_sel(val2_sel),
	.ST_val_sel(ST_val_sel),
	.val1(val1_EXE),
	.val2(val2_EXE),
	.ALU_res_MEM(ALURes_MEM),
	.result_WB(WB_result),
	.ST_value_in(ST_value_EXE),
	// OUTPUTS
	.ALUResult(ALURes_EXE),
	.ST_value_out(ST_value_EXE2MEM)
);

MEMstage MEMstage (
	// INPUTS
	.clk(clock),
	.rstn(rstn),
	.MEM_R_EN(MEM_R_EN_MEM),
	.MEM_W_EN(MEM_W_EN_MEM),
	.ALU_res(ALURes_MEM),
	.ST_value(ST_value_MEM),
	// OUTPUTS
	.dataMem_out(dataMem_out_MEM)
);

WBstage WBstage (
	// INPUTS
	.MEM_R_EN(MEM_R_EN_WB),
	.memData(dataMem_out_WB),
	.aluRes(ALURes_WB),
	// OUTPUTS
	.WB_res(WB_result)
);

//############################
//#### PIPLINE REGISTERS #####
//############################
IFIDpipelinereg IF2IDReg (
	// INPUTS
	.clk(clock),
	.rstn(rstn),
	.flush(IF_Flush),
	.freeze(hazard_detected),
	.pcIn(PC_IF),
	.instructionIn(inst_IF),
	// OUTPUTS
	.pcOut(PC_ID),
	.instructionOut(inst_ID)
);

IDEXEpipelinereg ID2EXEReg (
	.clk(clock),
	.rstn(rstn),
	// INPUTS
	.destIn(inst_ID[15:11]),
	.src1_in(src1_ID),
	.src2_in(src2_forw_ID),
	.reg2In(reg2_ID),
	.val1In(val1_ID),
	.val2In(val2_ID),
	.PCIn(PC_ID),
	.EXE_CMD_IN(EXE_CMD_ID),
	.MEM_R_EN_IN(MEM_R_EN_ID),
	.MEM_W_EN_IN(MEM_W_EN_ID),
	.WB_EN_IN(WB_EN_ID),
	.brTaken_in(Br_Taken_ID),
	// OUTPUTS
	.src1_out(src1_forw_EXE),
	.src2_out(src2_forw_EXE),
	.dest(dest_EXE),
	.ST_value(ST_value_EXE),
	.val1(val1_EXE),
	.val2(val2_EXE),
	.PC(PC_EXE),
	.EXE_CMD(EXE_CMD_EXE),
	.MEM_R_EN(MEM_R_EN_EXE),
	.MEM_W_EN(MEM_W_EN_EXE),
	.WB_EN(WB_EN_EXE),
	.brTaken_out(Br_Taken_EXE)
);

EXEMEMpipelinereg EXE2MEMReg (
	.clk(clock),
	.rstn(rstn),
	// INPUTS
	.WB_EN_IN(WB_EN_EXE),
	.MEM_R_EN_IN(MEM_R_EN_EXE),
	.MEM_W_EN_IN(MEM_W_EN_EXE),
	.PCIn(PC_EXE),
	.ALUResIn(ALURes_EXE),
	.STValIn(ST_value_EXE2MEM),
	.destIn(dest_EXE),
	// OUTPUTS
	.WB_EN(WB_EN_MEM),
	.MEM_R_EN(MEM_R_EN_MEM),
	.MEM_W_EN(MEM_W_EN_MEM),
	.PC(PC_MEM),
	.ALURes(ALURes_MEM),
	.STVal(ST_value_MEM),
	.dest(dest_MEM)
);

MEMWBpipelinereg MEM2WB(
	.clk(clock),
	.rstn(rstn),
	// INPUTS
	.WB_EN_IN(WB_EN_MEM),
	.MEM_R_EN_IN(MEM_R_EN_MEM),
	.ALUResIn(ALURes_MEM),
	.memReadValIn(dataMem_out_MEM),
	.destIn(dest_MEM),
	// OUTPUTS
	.WB_EN(WB_EN_WB),
	.MEM_R_EN(MEM_R_EN_WB),
	.ALURes(ALURes_WB),
	.memReadVal(dataMem_out_WB),
	.dest(dest_WB)
);

assign IF_Flush = Br_Taken_ID;
endmodule
