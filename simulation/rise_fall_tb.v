`timescale 1ns/1ns
`define CLK100M_PERIOD 10

module	rise_fall_tb;

wire	variable_rise;
reg		variable;
reg		variable_r1;
reg		variable_r2;
reg		clk;
reg		rst_n;

initial clk = 1'b1;
always #(`CLK100M_PERIOD/2) clk = ~clk;

assign variable_rise = ~variable_r2 & variable_r1;	//检测上升沿

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		variable_r1 <= 1'b1;
		variable_r2 <= 1'b1;
	end
	else begin
		variable_r1 <= variable;
		variable_r2 <= variable_r1;
	end
end

endmodule
