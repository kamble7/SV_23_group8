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
rst = LOW;
@(negedge clk);
rst = HIGH;
forwarding_EN = 1'b0;
repeat (500) @(negedge clk);
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

@(posedge clk);
$strobe ($time,"**IM** instruction=%b",dut.IFstage.instructions.instruction);

//@(posedge clk);
$strobe ($time,"**IFStage** instruction=%b", dut.IFstage.instruction);

//@(negedge clk);
//$strobe ($time,"**IFIDpipelinereg** pcout=%b, instruction=%b", dut.IF2IDReg.pcOut, dut.IF2IDReg.instructionOut);

@(posedge clk);
$strobe ($time,"**Register** src1=%b src2=%b reg1=%b reg2=%b dest=%b",dut.regFile.src1, dut.regFile.src2, dut.regFile.reg1, dut.regFile.reg2, dut.regFile.dest);
//$strobe ($time,"**#2 IM** instruction=%b",dut.IFstage.instructions.instruction);
//$strobe ($time,"**#2 IFStage** instruction=%b", dut.IFstage.instruction);
//$strobe ($time,"**#2 IFIDpipelinereg** pcout=%b, instruction=%b", dut.IF2IDReg.pcOut, dut.IF2IDReg.instructionOut);

//@(negedge clk);
$strobe ($time,"** IDEXEpipelinereg** dest=%b, src1_out=%b, src2_out=%b, ST_value=%b, val1=%b, val2=%b, PC=%b;", dut.ID2EXEReg.dest, dut.ID2EXEReg.src1_out, dut.ID2EXEReg.src2_out, dut.ID2EXEReg.ST_value, dut.ID2EXEReg.val1, dut.ID2EXEReg.val2, dut.ID2EXEReg.PC);

@(posedge clk)
$strobe ($time,"**EXEStage** ALUResult=%b ST_Value_Out=%b", dut.EXEstage.ALUResult, dut.EXEstage.ST_value_out);
//$strobe ($time,"**EXEMEMpiplinereg** ALURes=%b, STVal=%b dest=%b",dut.EXE2MEMReg.ALURes, dut.EXE2MEMReg.STVal, dut.EXE2MEMReg.dest);

//$strobe ($time,"**#2 Register** src1=%b src2=%b reg1=%b reg2=%b dest=%b",dut.regFile.src1, dut.regFile.src2, dut.regFile.reg1, dut.regFile.reg2, dut.regFile.dest);
//$strobe ($time,"**#2 IDEXEpipelinereg** dest=%b, src1_out=%b, src2_out=%b, ST_value=%b, val1=%b, val2=%b, PC=%b", dut.ID2EXEReg.dest, dut.ID2EXEReg.src1_out, dut.ID2EXEReg.src2_out, dut.ID2EXEReg.ST_value, dut.ID2EXEReg.val1, dut.ID2EXEReg.val2, dut.ID2EXEReg.PC);
//$strobe ($time,"**#3 IM** instruction=%b",dut.IFstage.instructions.instruction);
//$strobe ($time,"**#3 IFStage** instruction=%b", dut.IFstage.instruction);
//$strobe ($time,"**#3 IFIDpipelinereg** pcout=%b, instruction=%b", dut.IF2IDReg.pcOut, dut.IF2IDReg.instructionOut);



@(posedge clk);
$strobe ($time,"**MEMstage** datamem_out=%b", dut.MEMstage.dataMem_out);
//$strobe ($time,"**MEMWBpipelinereg** ALURes=%b, =%b", dut.MEM2WB.ALURes, dut.MEM2WB.memReadVal);

//$strobe ($time,"**#2 EXEStage** ALUResult=%b ST_Value_Out=%b", dut.EXEstage.ALUResult, dut.EXEstage.ST_value_out);
//$strobe ($time,"**#2 EXEMEMpiplinereg** ALURes=%b, STVal=%b dest=%b",dut.EXE2MEMReg.ALURes, dut.EXE2MEMReg.STVal, dut.EXE2MEMReg.dest);

@(posedge clk);
//$strobe ($time,"**#2 MEMstage** datamem_out=%b", dut.MEMstage.dataMem_out);
//$strobe ($time,"**#2 MEMWBpipelinereg** ALURes=%b, =%b", dut.MEM2WB.ALURes, dut.MEM2WB.memReadVal);
@(posedge clk);
$display("\n\n\n%p",dut.regFile.regMem);
@(posedge clk);
$display("\n\n\n%p",dut.regFile.regMem);
@(posedge clk);
$display("\n\n\n%p",dut.regFile.regMem);
@(posedge clk);
$display("\n\n\n%p",dut.regFile.regMem);
@(posedge clk);
$display("\n\n\n%p",dut.regFile.regMem);
@(posedge clk);
$display("\n\n\n%p",dut.regFile.regMem);



$finish(5000);
end

endmodule : top
