module RegFile (clk, rstn, writeEn, src1, src2, dest, writeVal, reg1, reg2);
input logic clk, rstn, writeEn;
input logic [4:0] src1, src2, dest;
input logic [31:0] writeVal;
output logic [31:0] reg1, reg2;

logic [31:0] regMem [0:31];

always_ff @(posedge clk)
begin
regMem[0] <= '0;
    if (!rstn)
    begin
    for (int i=0; i<32; i++)
    regMem[i] <= '0;
    end
    else if (writeEn)
    regMem[dest] <= writeVal;
end    
    
assign reg1 = regMem[src1];
assign reg2 = regMem[src2];

endmodule : RegFile
