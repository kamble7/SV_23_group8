module ConditionChecker ();
input ;
output ;

always_comb
begin
	case ()
		: brcond = 1;
		: brcond = ()? 1:0;
		: brcond = ()? 1:0;
	default	: brcond = 0;
	endcase
end


endmodule : ConditionChecker
