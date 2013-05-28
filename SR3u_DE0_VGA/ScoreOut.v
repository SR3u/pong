module	ScoreOut	(Score1,Score2,//Player 1 and 2 score
					    CLK,//Clock_50
						 HEX0_D,//Seven Segment Digit 0
		             HEX0_DP,//Seven Segment Digit DP 0
		             HEX1_D,//Seven Segment Digit 1
		             HEX1_DP,//Seven Segment Digit DP 1
		             HEX2_D,//Seven Segment Digit 2
		             HEX2_DP,//Seven Segment Digit DP 2
		             HEX3_D,//Seven Segment Digit 3
		             HEX3_DP,//Seven Segment Digit DP 3
						 LEDG,//	LED Green[9:0]
						 WIN1,WIN2//Wictory of player1 && player 2
						 );
input  [4:0] Score1;
input  [4:0] Score2;
input WIN1;
input WIN2;
output reg [6:0] HEX0_D; // Seven Segment Digit 0
output reg HEX0_DP;      // Seven Segment Digit DP 0
output reg [6:0] HEX1_D; // Seven Segment Digit 1
output reg HEX1_DP;      // Seven Segment Digit DP 1
output reg [6:0] HEX2_D; // Seven Segment Digit 2
output reg HEX2_DP;      // Seven Segment Digit DP 2
output reg [6:0] HEX3_D; // Seven Segment Digit 3
output reg HEX3_DP;      // Seven Segment Digit DP 3

output reg [9:0] LEDG;	//	LED Green[9:0]

integer tmp=0;

reg [6:0] DIG_0 = 7'b1000000;
reg [6:0] DIG_1 = 7'b1111001;
reg [6:0] DIG_2 = 7'b0100100;
reg [6:0] DIG_3 = 7'b0110000;
reg [6:0] DIG_4 = 7'b0011001;
reg [6:0] DIG_5 = 7'b0010010;
reg [6:0] DIG_6 = 7'b0000010;
reg [6:0] DIG_7 = 7'b1111000;
reg [6:0] DIG_8 = 7'b0000000;
reg [6:0] DIG_9 = 7'b0010000;

input CLK;
always@(posedge CLK)
begin
LEDG<=10'h000;
//Player  1 score output
tmp=Score1;
tmp=tmp/10;
case(tmp)
    0 : HEX1_D <= DIG_0;
    1 : HEX1_D <= DIG_1;
    2 : HEX1_D <= DIG_2;
	 3 : HEX1_D <= DIG_3;
	 4 : HEX1_D <= DIG_4;
	 5 : HEX1_D <= DIG_5;
	 6 : HEX1_D <= DIG_6;
	 7 : HEX1_D <= DIG_7;
	 8 : HEX1_D <= DIG_8;
	 9 : HEX1_D <= DIG_9;
	 default: HEX1_D <= 7'h7F;
endcase
tmp=Score1-tmp*10;
case(tmp)
    0 : HEX0_D <= DIG_0;
    1 : HEX0_D <= DIG_1;
    2 : HEX0_D <= DIG_2;
	 3 : HEX0_D <= DIG_3;
	 4 : HEX0_D <= DIG_4;
	 5 : HEX0_D <= DIG_5;
	 6 : HEX0_D <= DIG_6;
	 7 : HEX0_D <= DIG_7;
	 8 : HEX0_D <= DIG_8;
	 9 : HEX0_D <= DIG_9;
endcase
//Player 2 score output
tmp=Score2;
tmp=tmp/10;
case(tmp)
    0 : HEX3_D <= DIG_0;
    1 : HEX3_D <= DIG_1;
    2 : HEX3_D <= DIG_2;
	 3 : HEX3_D <= DIG_3;
	 4 : HEX3_D <= DIG_4;
	 5 : HEX3_D <= DIG_5;
	 6 : HEX3_D <= DIG_6;
	 7 : HEX3_D <= DIG_7;
	 8 : HEX3_D <= DIG_8;
	 9 : HEX3_D <= DIG_9;
endcase
tmp=Score2-tmp*10;
case(tmp)
    0 : HEX2_D <= DIG_0;
    1 : HEX2_D <= DIG_1;
    2 : HEX2_D <= DIG_2;
	 3 : HEX2_D <= DIG_3;
	 4 : HEX2_D <= DIG_4;
	 5 : HEX2_D <= DIG_5;
	 6 : HEX2_D <= DIG_6;
	 7 : HEX2_D <= DIG_7;
	 8 : HEX2_D <= DIG_8;
	 9 : HEX2_D <= DIG_9;
endcase
HEX0_DP<=1;
HEX1_DP<=1;
HEX2_DP<=0;
HEX3_DP<=1;
if(WIN1)
begin
LEDG[0]<=1;
LEDG[1]<=1;
LEDG[2]<=1;
LEDG[3]<=1;
LEDG[4]<=1;
end
if(WIN2)
begin
LEDG[5]<=1;
LEDG[6]<=1;
LEDG[7]<=1;
LEDG[8]<=1;
LEDG[9]<=1;
end
end
endmodule