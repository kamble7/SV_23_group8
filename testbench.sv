import defines::*;
module top;
bit clk;
logic rst, forwarding_EN;

MIPS dut (clk, rst, forwarding_EN);

initial 
begin
clk=LOW;
forever #(CLOCK_WIDTH) clk=~clk ;
end

initial 
begin
rst = HIGH;
forwarding_EN = 1'b0;
repeat (50) @(negedge clk);
rst = LOW;
end

initial
begin
/*
#5;
$display ("**IM** instruction=%b",dut.IFstage.instructions.instruction);

#5;
$display ("**Register** reg1=%b reg2=%b dest=%b",dut.regFile.reg1, dut.regFile.reg2, dut.regFile.dest);

#5;
$display ("**IFStage** instruction=%b", dut.IFstage.instruction);

#5;
$display ("**EXEStage** ALUResult=%b ST_Value_Out=%b", dut.EXEstage.ALUResult, dut.EXEstage.ST_value_out);

#5;
$display ("**MEMstage** datamem_out=%b", dut.MEMstage.dataMem_out);

#5;
$display ("**EXEMEMpiplinereg** ALURes=%b, STVal=%b dest=%b",dut.EXE2MEMReg.ALURes, dut.EXE2MEMReg.STVal, dut.EXE2MEMReg.dest);
#5;
*/

@(negedge clk);
$monitor ($time,"**IM** instruction=%b",dut.IFstage.instructions.instruction);

@(negedge clk);
$monitor ($time,"**IFStage** instruction=%b", dut.IFstage.instruction);

//@(negedge clk);
$monitor ($time,"**IFIDpipelinereg** pcout=%b, instruction=%b", dut.IF2IDReg.pcOut, dut.IF2IDReg.instructionOut);

@(negedge clk);
$monitor ($time,"**Register** reg1=%b reg2=%b dest=%b",dut.regFile.reg1, dut.regFile.reg2, dut.regFile.dest);

//@(negedge clk);
$monitor ($time,"** IDEXEpipelinereg** pcout=%b, instruction=%b, dest=%b, src1_out=%b, src2_out=%b, ST_value=%b, val1=%b, val2=%b, PC=%b;", dut.ID2EXEReg.pcOut, dut.ID2EXEReg.instruction, dut.ID2EXEReg.dest, dut.ID2EXEReg.src1_out, dut.ID2EXEReg.src2_out, dut.ID2EXEReg.ST_value, dut.ID2EXEReg.val1, dut.ID2EXEReg.val2, dut.ID2EXEReg.PC);

@(negedge clk)
$monitor ($time,"**EXEStage** ALUResult=%b ST_Value_Out=%b", dut.EXEstage.ALUResult, dut.EXEstage.ST_value_out);
$monitor ($time,"**EXEMEMpiplinereg** ALURes=%b, STVal=%b dest=%b",dut.EXE2MEMReg.ALURes, dut.EXE2MEMReg.STVal, dut.EXE2MEMReg.dest);

@(negedge clk);
$monitor ($time,"**MEMstage** datamem_out=%b", dut.MEMstage.dataMem_out);
$monitor ($time,"**MEMWBpipelinereg** ALURes=%b, =%b", dut.MEM2WB.ALURes, dut.MEM2WB.memReadVal);
@(negedge clk);


$finish(5000);
end


endmodule : top
