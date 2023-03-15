module IDEXEpipelinereg ();
input logic ;
output logic ;


always_ff (@posedge clk)
begin
    if (!rstn)
    {WB_EN, MEM_R_EN, MEM_W_EN, EXE_CMD, dest, ST_value,val1, val2, PC, brTaken_out, src1_out, src2_out} <= '0;
    else
    begin
    MEM_R_EN <= MEM_R_EN_IN;
    end
end

endmodule : IDEXEpipelinereg
