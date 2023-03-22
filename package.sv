package defines;

// Wire widths
parameter N = 32;
parameter LENGTH = 32; //Used in mux
parameter REG_FILE_ADDR_LEN = 5;
parameter FORWARD_SEL_LEN = 2;
parameter OP_CODE_LEN = 6;

// Memory constants
parameter DATA_MEM_SIZE = 1024;
parameter INST_MEM_SIZE = 1024;
parameter REG_FILE_SIZE = 32;
parameter MEM_CELL_SIZE = 8;

//Testbench
parameter LOW = 1'b0;
parameter HIGH = 1'b1;
parameter CLOCK_CYCLE = 20;
parameter CLOCK_WIDTH = CLOCK_CYCLE/2;

typedef enum logic [1:0] {COND_JUMP=2'b01, COND_BEZ=2'b10, COND_BNE=2'b11} brcmd_t;


typedef enum logic [5:0] {OP_NOP = 6'b000000,
			OP_ADD = 6'b000001,
			OP_SUB = 6'b000011,
			OP_AND = 6'b000101,
			OP_OR  = 6'b000110,
			OP_NOR = 6'b000111,
			OP_XOR = 6'b001000,
			OP_SLA = 6'b001001,
			OP_SRA = 6'b001011,
			OP_SLL = 6'b001010,
			OP_SRL = 6'b001100,
			OP_ADDI= 6'b100000,
			OP_SUBI= 6'b100001,
			OP_LD  = 6'b100100,
			OP_ST  = 6'b100101,
			OP_BEZ = 6'b101000,
			OP_BNE = 6'b101001,
			OP_JMP = 6'b101010} opcode_t;
			
typedef enum logic [3:0] {EXE_ADD = 4'b0000,
			EXE_SUB = 4'b0001, 
			EXE_AND = 4'b0010, 
			EXE_OR  = 4'b0011,
			EXE_NOR = 4'b0100, 
			EXE_XOR = 4'b0101, 
			EXE_SLA = 4'b0110, 
			EXE_SLL = 4'b0111,
			EXE_SRA = 4'b1000, 
			EXE_SRL = 4'b1001, 
			EXE_NO_OPERATION = 4'b1111} execmd_t;

endpackage
