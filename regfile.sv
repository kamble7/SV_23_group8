import defines::*;
module RegFile (clk, rstn, writeEn, src1, src2, dest, writeVal, reg1, reg2);

input logic clk, rstn, writeEn;
input logic [REG_FILE_ADDR_LEN-1:0] src1, src2, dest;
input logic [N-1:0] writeVal;
output logic [N-1:0] reg1, reg2;

logic [N-1:0] regMem [0:REG_FILE_SIZE-1];

always_ff @(posedge clk)
begin
regMem[0] <= '0;
    if (!rstn)
    begin
    for (int i=0; i<N; i++)
    regMem[i] <= '0;
    end
    else if (writeEn)
    regMem[dest] <= writeVal;
end    
    
assign reg1 = regMem[src1];
assign reg2 = regMem[src2];

endmodule : RegFile
