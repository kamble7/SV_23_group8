import defines::*;
module EXEMEMpipelinereg (clk, rstn, WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN, PCIn, ALUResIn, STValIn, destIn, WB_EN, MEM_R_EN, MEM_W_EN, PC, ALURes, STVal, dest);

input logic clk, rstn;
input logic WB_EN_IN, MEM_R_EN_IN, MEM_W_EN_IN;
input logic [REG_FILE_ADDR_LEN-1:0] destIn;
input logic [N-1:0] PCIn, ALUResIn, STValIn;
output logic WB_EN, MEM_R_EN, MEM_W_EN;
output logic [REG_FILE_ADDR_LEN-1:0] dest;
output logic [N-1:0] PC, ALURes, STVal;

always_ff @(posedge clk)
begin
    if (!rstn)
    {WB_EN, MEM_R_EN, MEM_W_EN, PC, ALURes, STVal, dest} <= '0;
    else
    begin
    WB_EN <= WB_EN_IN;
    MEM_R_EN <= MEM_R_EN_IN;
    MEM_W_EN <= MEM_W_EN_IN;
    PC <= PCIn;
    ALURes <= ALUResIn;
    STVal <= STValIn;
    dest <= destIn;
    end
end

endmodule : EXEMEMpipelinereg
