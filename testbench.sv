
class mips_instruction_generator;
    bit [31:0] instruction;
    int chk;
    bit [4:0] regs[] = '{0};
    
    // List of supported instruction types
    typedef enum {NOP, ADD, SUB, AND, OR, NOR, XOR, ADDI, SUBI, SLA, SRA, SLL, SRL, LW, SW, BEZ, BNE, JMP} inst_t;
    rand inst_t instruction_type;
    //rand bit [4:0] rd;
    rand bit [4:0] rs;
    rand bit [4:0] rt;

    constraint first {
        if (chk==0)
        instruction_type inside {ADDI,SUBI};
	rt inside {regs};
	rs inside {regs};
   }

    // Randomize the instruction type
    function void randomize_instruction_type();
	void'(randomize());
    endfunction
    
    // Generate a random immediate value
    function int signed generate_immediate();
        return $urandom_range(-32768, 32767) & 16'hffff;
    endfunction
    
    // Generate a random register number
    function int generate_register();
        return $urandom_range(1, 31);
    endfunction
    
    // Generate a random 16-bit memory offset
    function int generate_offset();
        return $urandom_range(-32, 32) & 16'h0001;
    endfunction
    
    // Generate a random 5-bit shift amount
    function int generate_shift();
        return $urandom_range(0, 31) & 5'b11111;
    endfunction
    
    // Generate a random MIPS instruction
    task generate_instruction();
    // Generate random values for rs, rt, rd, and immediate
	bit [4:0] rd ;
	bit [4:0] shift = generate_shift();
        bit signed [15:0] immediate = generate_immediate();
        bit signed [15:0] offset = generate_offset();
	
	if (instruction_type != NOP || BEZ || BNE || SW)
	rd = generate_register();
	chk=chk+1;

        case (instruction_type)
            NOP: instruction = {32'd0};
            ADD: instruction = {6'b000001, rd, rs, rt, 11'b00000000000};
            SUB: instruction = {6'b000011, rd, rs, rt, 11'b00000000000};
            AND: instruction = {6'b000101, rd, rs, rt, 11'b00000000000};
            OR : instruction = {6'b000110, rd, rs, rt, 11'b00000000000};
            NOR: instruction = {6'b000111, rd, rs, rt, 11'b00000000000};
            XOR: instruction = {6'b001000, rd, rs, rt, 11'b00000000000};
            ADDI:instruction = {6'b100000, rd, rt,  immediate};
            SUBI:instruction = {6'b100001, rd, rt, immediate};
            SLA: instruction = {6'b001001, 5'b00000, rt, rd, shift, 6'b000000};
            SRA: instruction = {6'b001011, 5'b00000, rt, rd, shift, 6'b000000};
            SLL: instruction = {6'b001010, 5'b00000, rt, rd, shift, 6'b000000};
            SRL: instruction = {6'b001100, 5'b00000, rt, rd, shift, 6'b000000};
            BEZ: instruction = {6'b101000, rs, rt, 16'd0};
            BNE: instruction = {6'b101001, rs, rt, 16'd0};
            JMP: instruction = {6'b101010, 26'd0};
            LW:  instruction = {6'b100100, rd, rt, offset};
            SW:  instruction = {6'b100101, rs, rt, offset};
	    default: $error("Unsupported instruction type ");
        endcase
//	$display("regs=%p",regs);
//	$display("rd=%d,rs=%d,rt=%d",rd,rs,rt);
	regs = {regs,rd,rt};
    endtask
endclass


module top;
bit clk;
logic rst, forwarding_EN;

logic [7:0] instmem_tb [0:1023];


MIPS dut (clk, rst, forwarding_EN);

initial 
begin
clk=1'b0;
forever #5 clk=~clk ;
end

initial 
begin
mips_instruction_generator inst_gen;
inst_gen = new();
    for (int i = 0, int j=0; i < 30; i++,j=j+4) 
    begin
    inst_gen.randomize_instruction_type();
    inst_gen.generate_instruction();
    {instmem_tb[j],instmem_tb[j+1],instmem_tb[j+2],instmem_tb[j+3]} = inst_gen.instruction;
    $display("Generated instruction: %b, %p", inst_gen.instruction,inst_gen.instruction_type);
    end 
    dut.IFstage.instructions.instmem = instmem_tb;
  
end

initial
begin
rst = 1'b0;
forwarding_EN = 1'b1;
repeat (50) @(negedge clk);
rst = 1'b1;
repeat (50) (@(posedge clk) $display("%p",dut.regFile.regMem);

$finish (1000);
end
endmodule : top
