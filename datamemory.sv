module DataMem ();
input logic clk, rstn, readEn, writeEn;
input logic [] address, datain;
output logic [] dataout;

logic [] datamem [];

always_ff (@posedge clk)
begin
    if (!rstn)
    begin
    for (int i=0; i< ; i++)
    datamem[i] <= '0;
    end
    else if (writeEn)
    begin
    end

end

endmodule : DataMem
