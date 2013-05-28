module	VGA_Pattern	(	//	Read Out Side
						oRed,
						oGreen,
						oBlue,
						iVGA_X,
						iVGA_Y,
						iVGA_CLK,
						//	Control Signals
						iRST_n,
						iColor_SW,
						// PONG
						ballX,ballY,
						plat1X,plat1Y,
						plat2X,plat2Y,
						plat1H,plat2H,
						Score1,Score2);
//	Read Out Side
output	reg	[9:0]	oRed;
output	reg	[9:0]	oGreen;
output	reg	[9:0]	oBlue;
//PONG 
input	[9:0]	ballX;
input	[9:0]	ballY;
input	[9:0]	plat1X;
input	[9:0]	plat1Y;
input	[9:0]	plat2X;
input	[9:0]	plat2Y;
input	[9:0]	plat1H;
input	[9:0]	plat2H;
input [4:0] Score1;
input [4:0] Score2;

input	[9:0]		iVGA_X;
input	[9:0]		iVGA_Y;
input				iVGA_CLK;
//	Control Signals
input				iRST_n;
input				iColor_SW;

always@(posedge iVGA_CLK or negedge iRST_n)
begin
	if(!iRST_n)
	begin
		oRed	<=	0;
		oGreen	<=	0;
		oBlue	<=	0;
	end
	else
	begin
		//if(iColor_SW == 1)
		//begin
			if (iVGA_Y<5)
			begin
				oRed	<=	15;
				oGreen	<=	15;	
				oBlue	<=	15;
			end
			else if (iVGA_Y>=5 && iVGA_Y<475)
			begin
			    if (iVGA_X>(ballX-5)&&iVGA_X<(ballX+5)&&iVGA_Y>(ballY-5)&&iVGA_Y<(ballY+5))
			    begin
			      oRed	 <=	0;
				  oGreen <=	15;
				  oBlue	 <=	15;
			    end 
			    else if (iVGA_Y>(plat1Y)&&iVGA_Y<(plat1Y+plat1H)&&iVGA_X>(plat1X)&&iVGA_X<(plat1X+10))
			    begin
			      oRed	 <=	15;
				  oGreen <=	15-Score2;
				  oBlue	 <=	15-Score2;
			    end
			    else if (iVGA_Y>(plat2Y)&&iVGA_Y<(plat2Y+plat2H)&&iVGA_X>(plat2X)&&iVGA_X<(plat2X+10))
			    begin
			      oRed	 <=	15;
				  oGreen <=	15-Score1;
				  oBlue	 <=	15-Score1;
			    end
				 else if(iVGA_X>=319&&iVGA_X<=321)
				 begin
				   oRed<=15;
					oGreen<=15;
					oBlue<=15;
				 end
			    else
			    begin
				     oRed	<=	0;
				     oGreen	<=	0;
				     oBlue	<=	0;
				end
			end
			else if (iVGA_Y>=475 && iVGA_Y<480)
			begin
				oRed	<=	15;
				oGreen	<=	15;
				oBlue	<=	15;
			end
			else
			begin
				oRed	<=	0;
				oGreen	<=	0;
				oBlue	<=	0;
			end
		//end
		//else
		//begin
			//oRed	<=	15;
			//oGreen	<=	15;
			//oBlue	<=	15;
		//end
	end
end

endmodule