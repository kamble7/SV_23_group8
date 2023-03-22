import defines::*;
module MEMstage (clk, rstn, MEM_R_EN, MEM_W_EN, ALU_res, ST_value, dataMem_out);
input clk, rstn, MEM_R_EN, MEM_W_EN;
input [N-1:0] ALU_res, ST_value;
output [N-1:0]  dataMem_out;

DataMem dataMem (.clk(clk),
		.rstn(rstn),
		.writeEn(MEM_W_EN),
		.readEn(MEM_R_EN),
		.address(ALU_res),
		.datain(ST_value),
		.dataout(dataMem_out));
		
endmodule : MEMstage
