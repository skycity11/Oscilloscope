module TFT_image(
	input						clk_vga,
	input						rst_n,
	
	input						tft_req,
	input						data_in,
	input			[10:0]	hcount,
	input			[10:0]	vcount,
	
	output		[18:0]	addr,
	output					rden,
	output 	  	[15:0]	display_data										
);

localparam	BLACK 	= 16'h0000,		//黑色
				BLUE 		= 16'h001f,		//蓝色
				RED 		= 16'hf800,		//红色
				PURPPLE 	= 16'hf81f,		//紫色
				GREEN		= 16'h07e0,		//绿色
				CYAN 		= 16'h07ff,		//青色
				YELLOW 	= 16'hffe0,		//黄色
				WHITE 	= 16'hffff;		//白色


//addr
assign	addr = hcount + vcount * 800;
assign	rden = tft_req;	

//display_data

assign	display_data = (data_in) ? WHITE : BLACK;


endmodule
