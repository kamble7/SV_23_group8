module register ();
input ;
output ;

always_ff (@posedge clk)
begin
if (!rstn)
Qout <= '0;
else if (Enable)
Qout <= Din
end

endmodule : register
