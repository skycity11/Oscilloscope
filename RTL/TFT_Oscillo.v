module TFT_Oscillo(
	input							clk_50m,
	input							rst_n,
	
	input							adc_dout,	//通过adc转换获得的结果
	output						adc_din,		//写入控制寄存器的数据
	output						adc_cs_n,	//adc片选信号
	output						adc_sclk,	//adc时钟信号
	
	output		[15:0]	tft_rgb,
	output					tft_hsync,
	output					tft_vsync,
	output					tft_clk,
	output					tft_de,
	output					tft_pwm,
	output					tft_blank_n
);
	
	wire						clk_adc;
	wire						clk_vga;
	wire						clk_100m;
	
	wire			[2:0]		out_addr;	//结果输出通道地址
	wire			[11:0]	out_0;		//通道0
	wire			[11:0]	out_1;		//通道1
	wire			[11:0]	out_2;		//通道2
	wire			[11:0]	out_3;		//通道3
	wire			[11:0]	out_4;		//通道4
	wire			[11:0]	out_5;		//通道5
	wire			[11:0]	out_6;		//通道6
	wire			[11:0]	out_7;		//通道7
	wire						adc_ready;
	wire						adc_done;
	
	wire						data;
	wire			[18:0]	wraddress;
	wire			[18:0]	rdaddress;
	wire						wren;
	wire						rden;
	wire						q;
	
	wire						tft_req;
	wire			[10:0]	hcount;
	wire			[10:0]	vcount;
	wire			[15:0]	display_data;
pll pll_inst (
	.refclk   (clk_50m),  
	.rst      (~rst_n),   
	.outclk_0 (clk_adc), 
	.outclk_1 (clk_vga), 
	.outclk_2 (clk_100m),
	.locked   ()    
);

ad7928 ad7928(
	.clk(clk_adc),
	.rst_n(rst_n),
	
	.dout(adc_dout),			
	.din(adc_din),			
	.cs_n(adc_cs_n),
	.sclk(adc_sclk),
	
	.adc_ready(adc_ready),
	.adc_done(adc_done),
	.out_addr(out_addr),	
	.out_0(out_0),		
	.out_1(out_1),		
	.out_2(out_2),		
	.out_3(out_3),		
	.out_4(out_4),		
	.out_5(out_5),		
	.out_6(out_6),		
	.out_7(out_7)			
);

data_process data_process(
	.clk(clk_100m),
	.rst_n(rst_n),
	.dout_0(out_0),
	.out_addr(out_addr),
	.adc_ready(adc_ready),
	.adc_done(adc_done),
	
	.data(data),
	.wraddress(wraddress),
	.wren(wren)
);

ram ram_inst (
	.data(data),
	.rdaddress(rdaddress),
	.rdclock(clk_vga),
	.rden(rden),
	.wraddress(wraddress),
	.wrclock(clk_100m),
	.wren(wren),
	.q(q)
);

TFT_image TFT_image(
	.clk_vga(clk_vga),
	.rst_n(rst_n),
	
	.tft_req(tft_req),
	.data_in(q),
	.hcount(hcount),
	.vcount(vcount),
	
	.addr(rdaddress),
	.rden(rden),
	.display_data(display_data)										
);

TFT_driver TFT_driver(
	.clk_vga(clk_vga),
	.rst_n(rst_n),
	
	.data_in(display_data),
	.hcount(hcount),				
	.vcount(vcount),				
	.tft_req(tft_req),			
	
	.tft_rgb(tft_rgb),
	.tft_hs(tft_hsync),
	.tft_vs(tft_vsync),
	.tft_clk(tft_clk),
	.tft_de(tft_de),
	.tft_pwm(tft_pwm),
	.tft_blank_n(tft_blank_n)
);

endmodule
