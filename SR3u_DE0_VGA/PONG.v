module	PONG	(	//	Ball coordinates
						ballX,
						ballY,
						//Clock
						CLK,
						//	Plateforms coordinates
						plat1X,
						plat1Y,
						plat2X,
						plat2Y,
						// Plateforms height
					   plat1H,
					   plat2H,
						// Plateforms controls
						plat1U,plat1D,//plat 1 up/down
						plat2U,plat2D,//plat 2 up/down
						Score_1,Score_2,//Player 1 and 2 score
					    RESET,PAUSE,EnableAI1,EnableAI2,WIN1,WIN2);
output	reg	[9:0]	ballX;
output	reg	[9:0]	ballY;
output	reg	[9:0]	plat1X;
output	reg	[9:0]	plat1Y;
output	reg	[9:0]	plat2X;
output	reg	[9:0]	plat2Y;
output	reg	[9:0]	plat1H;
output	reg	[9:0]	plat2H;
output   reg   [4:0] Score_1;
output   reg   [4:0] Score_2;
output reg WIN1;
output reg WIN2;

input plat1U;
input plat1D;
input plat2U;
input plat2D;
input	CLK;
input RESET;
input PAUSE;
input EnableAI1;
input EnableAI2;

//Constants
integer CLKs = 312500;//625000;//Game speed
integer AIReact = 260;//X coordinate of maximum ai's reaction
integer platY0 = 220;//Y coordinates of the platforms 1 & 2 at the begining
//Variables
integer speedX=1;
integer speedY=1;
integer ball_X=320;
integer ball_Y=240;
integer plat1_Y=0;
integer plat2_Y=0;
integer plat1_H=40;
integer plat2_H=40;
integer plat1_X=620;
integer plat2_X=10;


integer Score1=0;
integer Score2=0;

reg WIN_1=0;
reg WIN_2=0;
reg [26:0] clocks=0;
reg firstclk=1;

always@(posedge CLK)
begin

if(firstclk)
begin
firstclk=0;
plat1_Y=platY0;
plat2_Y=platY0;
end


if(PAUSE==0)
begin
if(clocks>CLKs)
begin
if((WIN_1<1)&&(WIN_2<1))
begin
clocks=0;
//ball collisions and movements
if((ball_X>plat1_X-5)&&(ball_X<plat1_X))
begin
if((ball_Y+5>=plat1_Y)&&(ball_Y-5<=plat1_Y+plat1_H))
begin
speedX=speedX*(-1);
end
end
if((ball_X-5<plat2_X+15)&&(ball_X+5>plat2_X))
begin
if((ball_Y+5>=plat2_Y)&&(ball_Y-5<=plat2_Y+plat2_H))
begin
speedX=speedX*(-1);
end
end
ball_X=ball_X+speedX;
if(ball_Y<10||ball_Y>470)
begin
speedY=speedY*(-1);
end 
ball_Y=ball_Y+speedY;
if(ball_X<=-5)//Player 1 score increment
begin
speedY=1;
Score1=Score1+1;
ball_X=plat1_X-11;
ball_Y=plat1_Y+plat1_H/2;
end
if(ball_X>=645)//Player 2 score increment
begin
speedY=-1;
Score2=Score2+1;
ball_X=plat2_X+11;
ball_Y=plat2_Y+plat2_H/2;
end
if(Score1>=15||Score2>=15)//Endgame Reset
begin
if(Score1>=15)
begin
  WIN_1=1;
end
if(Score2>=15)
begin
  WIN_2=1;
end
ball_X=320;
ball_Y=240;
end
//Plat1 controls
if((plat1D)&&(plat1_Y>1))
begin
plat1_Y=plat1_Y-1;
end
if((plat1U)&&((plat1_Y+plat1_H)<479))
begin
plat1_Y=plat1_Y+1;
end
//Plat1 AI
if((EnableAI1==1)&&(ball_X>640-AIReact)&&(speedX>0))
begin
if(ball_Y-5<plat1_Y+5)
begin
plat1_Y = plat1_Y-1;
end
if(ball_Y+5>plat1_Y+plat1_H-5)
begin
plat1_Y = plat1_Y+1;
end
end
//Plat2 AI
if((EnableAI2==0)&&(ball_X<AIReact)&&(speedX<0))
begin
if(ball_Y-5<plat2_Y+5)
begin
plat2_Y = plat2_Y-1;
end
if(ball_Y+5>plat2_Y+plat2_H-5)
begin
plat2_Y = plat2_Y+1;
end
end
end
end
////////
clocks<=clocks+1;//Clocks counter increment
if(RESET==0)//User reset
begin
WIN_1=0;
WIN_2=0;
ball_X=320;
ball_Y=240;
Score1=0;
Score2=0;
plat1_Y=platY0;
plat2_Y=platY0;
end;
//Pin output
   ballX <= ball_X;
   ballY <= ball_Y;	
	
	plat1Y <= plat1_Y;
	plat2Y <= plat2_Y;
	
	// // //
	plat1X <= plat1_X;
	plat2X <= plat2_X;
	plat1H <= plat1_H;
	plat2H <=plat2_H;
	
	Score_1<=Score1;
	Score_2<=Score2;
	WIN1<=WIN_1;
	WIN2<=WIN_2;
end
end
endmodule