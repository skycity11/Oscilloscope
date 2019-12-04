`timescale 1ns/1ns
`define CLK20M_PERIOD 50
`define CLK33M_PERIOD 30

module	ram_tb;
	reg		[0:0]  	data;
	reg		[18:0]  	rdaddress;
	reg	  				rdclock;
	reg	  				rden;
	reg		[18:0]  	wraddress;
	reg	  				wrclock;
	reg	  				wren;
	wire		[0:0]  	q;


ram ram_inst (
	.data(data),
	.rdaddress(rdaddress),
	.rdclock(rdclock),
	.rden(rden),
	.wraddress(wraddress),
	.wrclock(wrclock),
	.wren(wren),
	.q(q)
);

initial wrclock = 1'b1;
always #(`CLK20M_PERIOD/2) wrclock = ~wrclock;

initial rdclock = 1'b1;
always #(`CLK33M_PERIOD/2) rdclock = ~rdclock;


initial begin
	reset_ram();
	#201;
	write_1();
	write_2();
	$stop;
end

initial begin
	#500;
	read();
	read();
	#2000;
end

task reset_ram;
	begin
		data = 1'b0;
		wraddress = 19'b0;
		rdaddress = 19'b0;
		wren = 1'b0;
		rden = 1'b0;
	end
endtask

task write_1;
	begin
	wren = 1'b1;
	wraddress = 19'b0;
	repeat (1000) @(posedge wrclock) begin
		wraddress = wraddress + 1'b1;
		data = ~data;
	end
	wren = 1'b0;
	end
endtask

task write_2;
	begin
	wren = 1'b1;
	wraddress = 19'b0;
	repeat (1000) @(posedge wrclock) begin
		wraddress = wraddress + 1'b1;
		data = 1'b1;
	end
	wren = 1'b0;
	end
endtask

task read;
	begin
	rden = 1'b1;
	rdaddress = 19'b0;
	repeat (1000) @(posedge rdclock)
		rdaddress = rdaddress + 1'b1;
	rden = 1'b0;
	end
endtask


endmodule

