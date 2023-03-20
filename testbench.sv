module top;
bit clk;
logic rst, forwarding_EN;

MIPS dut (clk, rst, forwarding_EN);

initial 
begin
clk=1'b0;
forever #50 clk=~clk ;
end

initial 
begin
rst = 1'b0;
forwarding_EN = 1'b0;
repeat (50) @(negedge clk);
rst = 1'b1;

$finish (1000);
end
endmodule : top
