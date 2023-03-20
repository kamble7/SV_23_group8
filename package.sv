package defines;

typedef enum logic [5:0] {OP_NOP = 6'b000000 ,
			OP_ADD = 6'b000001,
			OP_SUB = 6'b000011,
			OP_AND = 6'b000101,
			OP_OR  = 6'b000110,
			OP_NOR = 6'b000111,
			OP_XOR = 6'b001000,
			OP_SLA = 6'b001001,
			OP_SLL = 6'b001010,
			OP_SRA = 6'b001011,
			OP_SRL = 6'b001100,
			OP_ADDI= 6'b100000,
			OP_SUBI= 6'b100001,
			OP_LD  = 6'b100100,
			OP_ST  = 6'b100101,
			OP_BEZ = 6'b101000,
			OP_BNE = 6'b101001,
			OP_JMP = 6'b101010 } opcode_t;
endpackage
