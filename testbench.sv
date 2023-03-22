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
forwarding_EN = 1'b0;
repeat (50) @(negedge clk);
rst = HIGH;

$finish (1000);
end
endmodule : top
