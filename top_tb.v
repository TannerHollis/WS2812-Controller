//top_tb.v
/*

	Instructions:
		1. To use this file, you must enable the SIMULATE define in the file "common_defines.v"
		2. This define disabled hardware specific IPs, not necessary for simulation. https://www.latticesemi.com/view_document?document_id=52206
			a. The internal High Frequency Oscillator, HF_OSC
			b. The standard I/O module, SB_IO
			c. The standard open-drain I/O, SB_IO_OD
		3. A fun excersize is too look at the spi_period and experiment with the clock frequency to observe 
			a practical excersize in the sampling theorem, Nyquist's theorem. Any value of spi_period that 
			is less than twice the sb_period, there will be missed clock inputs and data. Effectively breaking
			the state machine in the SPI_Slave module.
		4. This test bench sends write commands for parameter, WRITE_CMDS, and then sends a "send_leds" command 
			after. The data written is only the first 8 bits of the addr of the iteration of the WRITE_CMDS, "i".
		4. Currently this is only tested with the ModelSim included in the iCEcube2 software. (Requires Free License)
		
*/

`timescale 10 ps /1 ps  // time-unit = 1 ns, precision = 10 ps

module top_tb;

    reg clk_sb, clk_spi, cs_n, mosi, reset_n;
	wire led_out;
	
    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam SB_PERIOD = 1;
	localparam SPI_PERIOD = 10;
	localparam WRITE_CMDS = 128;
    
	reg [23:0] i;
	reg [23:0] j, k;
	
	wire [23:0] mosi_write, mosi_send_leds;
	assign mosi_write = 	{3'b100, i[12:0], i[7:0]};
	assign mosi_send_leds = {3'b111, 21'd2};
	
	initial
	begin
		reset_n = 1'b1;
		#10 reset_n = 1'b0;
		#10 reset_n = 1'b1;
		clk_sb = 0;
		clk_spi = 0;
		cs_n = 1;
		#100
		for (i = 0; i < WRITE_CMDS; i = i + 1)
		begin
			#20
			cs_n = 0;
			mosi = mosi_write[23];
			k = 0;
			#20
			for (j = 0; j < 24; j = j + 1)
			begin
				#SPI_PERIOD clk_spi = ~clk_spi;
				k = k + 1;
				mosi = mosi_write[23 - k];
				#SPI_PERIOD clk_spi = ~clk_spi;
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
			#SB_PERIOD clk_spi = ~clk_spi;
			k = k + 1;
			mosi = mosi_send_leds[23 - k];
			#SPI_PERIOD clk_spi = ~clk_spi;
		end
		#20
		cs_n = 1;
		#15000 $stop;
	end
	
	initial
		forever #sb_period clk_sb = ~clk_sb;
	
	
	top top(
		.reset_n_in(reset_n),
		.clk_sb(clk_sb),
		
		.clk_spi_in(clk_spi),
		.mosi_in(mosi),
		.miso_out(miso),
		.cs_n_in(cs_n),
		
		.led_out(led_out));
endmodule