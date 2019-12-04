module	data_process(
	input							clk,
	input							rst_n,
	input				[11:0]	dout_0,
	input				[2:0]		out_addr, 
	input							adc_ready,
	input							adc_done,
	
	output	reg				data,
	output			[18:0]	wraddress,
	output						wren
);

parameter		FULL_IMAGE	= 19'd800*480;
parameter		FULL_DATA	= 19'd800;

//wren 数据可写入RAM
assign	wren = adc_ready;

//adc_done上升沿检测
wire	adc_done_rise;
reg		adc_done_r1;
reg		adc_done_r2;

assign adc_done_rise = ~adc_done_r2 & adc_done_r1;	//检测上升沿

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		adc_done_r1 <= 1'b1;
		adc_done_r2 <= 1'b1;
	end
	else begin
		adc_done_r1 <= adc_done;
		adc_done_r2 <= adc_done_r1;
	end
end

//en_post
reg						en_post;
reg		[18:0]		addr_pre;
reg		[18:0]		addr_post;
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		en_post <= 1'b0;
	else 
		if(addr_pre == FULL_IMAGE - 1)
			en_post <= 1'b1;
		else if(addr_post == FULL_DATA - 1)
			en_post <= 1'b0;
		else
			en_post <= en_post;
end

//addr_pre 存储 前800*480 数据地址
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		addr_pre <= 19'b0;
	else if(wren & (!en_post))
		if(addr_pre == FULL_IMAGE - 1)
			addr_pre <= 19'b0;
		else
			addr_pre <= addr_pre + 1'b1;
	else
		addr_pre <= 19'b0;
end

//addr_post 存储 后800 数据地址
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		addr_post <= 19'b0;
	else if(en_post)
		if(adc_done_rise)
			if(addr_post == FULL_DATA - 1)
				addr_post <= 19'd0;
			else
				addr_post <= addr_post + 1'b1;
		else
			addr_post <= addr_post;
	else
		addr_post <= 19'd0;
end

//data	像素点数据，前800*480为0，后800为1
always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		data <= 1'b0;
	else 
		if(addr_pre == FULL_IMAGE - 1)
			data <= 1'b1;
		else if(addr_post == FULL_DATA - 1)
			data <= 1'b0;
		else
			data <= data;
end


assign	wraddress = (en_post) ? (addr_post + 19'd192000 - dout_0[11:4] * 800) : addr_pre;

endmodule
