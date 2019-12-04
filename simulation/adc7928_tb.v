`timescale 1ns/1ns
`define CLK10M_PERIOD 100

module	adc7928_tb;

	reg							clk;
	reg							rst_n;
	
	reg							dout;			//通过adc转换获得的结果
	wire							din;			//写入控制寄存器的数据
	
	wire				[2:0]		out_addr;	//结果输出通道地址
	wire				[11:0]	out_0;		//通道0
	wire				[11:0]	out_1;		//通道1
	wire				[11:0]	out_2;		//通道2
	wire				[11:0]	out_3;		//通道3
	wire				[11:0]	out_4;		//通道4
	wire				[11:0]	out_5;		//通道5
	wire				[11:0]	out_6;		//通道6
	wire				[11:0]	out_7;		//通道7
	
	
	

ad7928 ad7928(
	.clk(clk),
	.rst_n(rst_n),

	.dout(dout),			//通过adc转换获得的结果
	.din(din),				//写入控制寄存器的数据

	.out_addr(out_addr),	//结果输出通道地址
	.out_0(out_0),			//通道0
	.out_1(out_1),			//通道1
	.out_2(out_2),			//通道2
	.out_3(out_3),			//通道3
	.out_4(out_4),			//通道4
	.out_5(out_5),			//通道5
	.out_6(out_6),			//通道6
	.out_7(out_7)			//通道7
);



initial clk = 1'b1;
always #(`CLK10M_PERIOD/2) clk = ~clk;

initial begin
	rst_n = 0;
	#201;
	dout = 1;
	rst_n = 1;
	#20000;
	$stop;
end

endmodule


