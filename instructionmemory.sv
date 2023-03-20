module InstructionMem (rstn, addr, instruction);
input logic rstn;
input logic [31:0] addr;
output logic [31:0] instruction;

logic [9:0] address;
logic [7:0] instmem [0:1024];
assign address = addr[9:0];
always_comb
begin
    if(!rstn)
    begin
    instmem[0] <= 8'b10000000; //-- Addi	r1,r0,10
    instmem[1] <= 8'b00100000;
    instmem[2] <= 8'b00000000;
    instmem[3] <= 8'b00001010;

    instmem[4] <= 8'b00000100; //-- Add 	r2,r0,r1
    instmem[5] <= 8'b01000000;
    instmem[6] <= 8'b00001000;
    instmem[7] <= 8'b00000000;

    instmem[8] <= 8'b00001100; //-- sub	r3,r0,r1
    instmem[9] <= 8'b01100000;
    instmem[10] <= 8'b00001000;
    instmem[11] <= 8'b00000000;
    end
end

assign instruction = {instmem[address], instmem[address+1], instmem[address+2], instmem[address+3]};

endmodule : InstructionMem
