`timescale 1ns/1ns
`define CLK100M_PERIOD 10
module	data_process_tb;

	reg							clk;
	reg							rst_n;
	reg				[11:0]	dout_0;
	reg				[2:0]		out_addr;
	reg							adc_ready;
	reg							adc_done;
	
	wire							data;
	wire				[18:0]	wraddress;
	wire							wren;


data_process	data_process(
	.clk(clk),
	.rst_n(rst_n),
	.dout_0(dout_0),
	.out_addr(out_addr), 
	.adc_ready(adc_ready),
	.adc_done(adc_done),
	
	.data(data),
	.wraddress(wraddress),
	.wren(wren)
);



initial clk = 1'b1;
always #(`CLK100M_PERIOD/2) clk = ~clk;

initial begin
	adc_done = 1'b0;
	forever begin
		#400;
		adc_done = 1'b1;
		#20;
		adc_done = 1'b0;
	end
end

task reset;
begin
	rst_n = 1'b0;
	dout_0 = 12'b0;
	out_addr = 3'b0;
	adc_ready = 1'b0;
end
endtask


initial begin
	reset();
	#201;
	rst_n = 1'b1;
	#400;
	adc_ready = 1'b1;
	dout_0 = 12'd2012;
	#2000000;
	$stop;
end

endmodule
