module	NOTGATE	(INP,OUT,CLK);
input  INP;
input CLK;
output reg OUT;
always@(posedge CLK)
begin
OUT<=0;
if(INP==0)
begin
OUT<=1;
end
end
endmodule