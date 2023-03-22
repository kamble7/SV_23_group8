import defines::*;
module InstructionMem (rstn, addr, instruction);

input logic rstn;
input logic [N-1:0] addr;
output logic [N-1:0] instruction;

logic [$clog2(INST_MEM_SIZE)-1:0] address;
logic [MEM_CELL_SIZE-1:0] instmem [0:INST_MEM_SIZE-1];
assign address = addr[$clog2(INST_MEM_SIZE)-1:0];
always_comb
begin

    if(!rstn)
    begin

    instmem[4] <= 8'b00000100; //-- Add 	r2,r0,r1
    instmem[5] <= 8'b00000001;
    instmem[6] <= 8'b00011000;
    instmem[7] <= 8'b00000000;


/*
    instmem[8] <= 8'b00001100; //-- sub	r3,r0,r1
    instmem[9] <= 8'b01100000;
    instmem[10] <= 8'b00001000;
    instmem[11] <= 8'b00000000;
    end
*/
end

assign instruction = {instmem[address], instmem[address+1], instmem[address+2], instmem[address+3]};

endmodule : InstructionMem
