//top_tb.v

`timescale 10 ps /1 ps  // time-unit = 1 ns, precision = 10 ps

module top_tb;

    reg clk_sb, clk_spi, cs_n, mosi, reset_n;
	wire led_out;
	
    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam sb_period = 1;
	localparam spi_period = 10;
    
	reg [23:0] i;
	reg [23:0] j, k;
	
	wire [23:0] mosi_write, mosi_send_leds;
	assign mosi_write = 	{3'b100, i[12:0], i[7:0]};
	assign mosi_send_leds = {3'b111, i[12:0], i[7:0]};
	
	initial
	begin
		reset_n = 1'b1;
		#10 reset_n = 1'b0;
		#10 reset_n = 1'b1;
		clk_sb = 0;
		clk_spi = 0;
		cs_n = 1;
		#100
		for (i = 0; i < 128; i = i + 1)
		begin
			#20
			cs_n = 0;
			mosi = mosi_write[23];
			k = 0;
			#20
			for (j = 0; j < 24; j = j + 1)
			begin
				#spi_period clk_spi = ~clk_spi;
				k = k + 1;
				mosi = mosi_write[23 - k];
				#spi_period clk_spi = ~clk_spi;
			end
			#20
			cs_n = 1;
		end

		#20
		cs_n = 0;
		mosi = mosi_send_leds[23];
		k = 0;
		#20
		for (j = 1; j < 25; j = j + 1)
		begin
			#spi_period clk_spi = ~clk_spi;
			k = k + 1;
			mosi = mosi_send_leds[23 - k];
			#spi_period clk_spi = ~clk_spi;
		end
		#20
		cs_n = 1;
		#10000 $stop;
	end
	
	initial
		forever #sb_period clk_sb = ~clk_sb;
	
	
	top top(
		.reset_n(reset_n),
		.clk_sb(clk_sb),
		
		.clk_spi(clk_spi),
		.mosi(mosi),
		.miso(miso),
		.cs_n(cs_n),
		
		.led_out(led_out));
endmodule