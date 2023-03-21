module DataMem (clk, rstn, readEn, writeEn, address, datain, dataout);
input logic clk, rstn, readEn, writeEn;
input logic [31:0] address, datain;
output logic [31:0] dataout;

logic [7:0] datamem [0:1023];
logic [31:0] base_addr;

always_ff @(posedge clk)
begin
    if (!rstn)
    begin
    for (int i=0; i<1024 ; i++)
    datamem[i] <= '0;
    end
    else if (writeEn)
    begin
    {datamem[base_addr], datamem[base_addr+1], datamem[base_addr+2], datamem[base_addr+3]} <= datain;
    end
end

assign base_addr = ((address & '1) >> 2) <<2;
assign dataout = {datamem[base_addr], datamem[base_addr+1], datamem[base_addr+2], datamem[base_addr+3]}; 

endmodule : DataMem
