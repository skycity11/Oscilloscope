module TFT_driver(
	input						clk_vga,
	input						rst_n,
	
	input			[15:0]	data_in,
	output		[10:0]	hcount,				//x坐标
	output		[10:0]	vcount,				//y坐标
	output					tft_req,				//数据请求信号
	
	output		[15:0]	tft_rgb,
	output					tft_hs,
	output					tft_vs,
	output					tft_clk,
	output					tft_de,
	output					tft_pwm,
	output					tft_blank_n
);
//800*480时序参数
parameter	H_SYNC  = 11'd128,
				H_BACK  = 11'd88,
				H_DISP  = 11'd800,
				H_FRONT = 11'd40,
				H_TOTAL = 11'd1056,
				V_SYNC  = 11'd2,
				V_BACK  = 11'd33,
				V_DISP  = 11'd480,
				V_FRONT = 11'd10,
				V_TOTAL = 11'd525;

//显示区域参数
parameter	X_START 	= 11'd0,
				X_ZOOM 	= 11'd800,
				Y_START 	= 11'd0,
				Y_ZOOM	= 11'd480;


//hcount_r
reg		[10:0]		hcount_r;
always @(posedge clk_vga or negedge rst_n) begin
	if(!rst_n)
		hcount_r = 11'd0;
	else
		if(hcount_r == H_TOTAL)
			hcount_r <= 11'd0;
		else
			hcount_r <= hcount_r + 1'b1;
end

//vcount_r
reg		[10:0]		vcount_r;
always @(posedge clk_vga or negedge rst_n) begin
	if(!rst_n)
		vcount_r = 11'd0;
	else if(hcount_r == H_TOTAL)
		if(vcount_r == V_TOTAL)
			vcount_r <= 11'd0;
		else
			vcount_r <= vcount_r + 1'b1;
	else
		vcount_r <= vcount_r;
end



//req
assign tft_req = ((hcount_r >= (H_SYNC + H_BACK + X_START)) && (hcount_r < (H_SYNC + H_BACK  + X_START + X_ZOOM)))
				  && ((vcount_r >= (V_SYNC + V_BACK + Y_START)) && (vcount_r < (V_SYNC + V_BACK  + Y_START + Y_ZOOM)));


							  
//hcount & vcount
assign hcount = tft_req ? (hcount_r - H_SYNC - H_BACK ):11'd0;  
assign vcount = tft_req ? (vcount_r - V_SYNC - V_BACK ):11'd0;



//de
assign tft_de= ((hcount_r >= (H_SYNC + H_BACK - 1'b1)) && (hcount_r < (H_SYNC + H_BACK + H_DISP - 1'b1)))
				&& ((vcount_r >= (V_SYNC + V_BACK - 1'b1)) && (vcount_r < (V_SYNC + V_BACK + V_DISP - 1'b1))) ? 1'b1:1'b0;

//rgb
assign tft_rgb = (tft_req) ? data_in : 16'd0;

//HS & VS
assign tft_hs = (hcount_r <= (H_SYNC - 1'b1)) ? 1'b0 : 1'b1;
assign tft_vs = (vcount_r <= (V_SYNC - 1'b1)) ? 1'b0 : 1'b1;

//Other Pins
assign tft_clk 	= clk_vga;
assign tft_pwm 	= rst_n;
assign tft_blank_n= tft_de;
endmodule
