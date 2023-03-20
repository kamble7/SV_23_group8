module MEMstage (clk, rstn, MEM_R_EN, MEM_W_EN, ALU_res, ST_value, dataMem_out);
input clk, rstn, MEM_R_EN, MEM_W_EN;
input [31:0] ALU_res, ST_value;
output [31:0]  dataMem_out;

DataMem dataMem (.clk(clk),
		.rstn(rstn),
		.writeEn(MEM_W_EN),
		.readEn(MEM_R_EN),
		.address(ALU_res),
		.datain(ST_value),
		.dataout(dataMem_out));
		
endmodule : MEMstage
