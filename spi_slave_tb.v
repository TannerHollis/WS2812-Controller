// spi_slave_tb.v

`timescale 10 ps /1 ps  // time-unit = 1 ns, precision = 10 ps

module spi_slave_tb;

    reg clk_sb, clk_spi, cs_n, miso_tx, mosi;
	
	wire miso, miso_rx;
	
	//Verify data
	wire miso_verify;
	wire mosi_verify;
	
    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam sb_period = 1;
	localparam spi_period = 10;
    
	integer i, k;
	reg [4:0] j = 23;
	
	reg [23:0] miso_data_in = 24'b10000000_00000000_10101010;
	reg [23:0] mosi_data_in = 24'b10000000_00000000_01010101;
	reg [23:0] miso_data_out;
	wire [23:0] mosi_data_out;
	
	assign miso_verify = miso_data_in == miso_data_out;
	assign mosi_verify = mosi_data_in == mosi_data_out;
	
	initial
	begin
		clk_sb = 0;
		clk_spi = 0;
		cs_n = 1;
		miso_tx = 1;
		#2000 miso_tx = 0;
		#17
		for (k = 0; k < 4096; k = k + 1)
		begin
			#20
			mosi_data_in = k;
			mosi = mosi_data_in[23];
			cs_n = 0;
			#20
			for (i = 0; i < 24; i = i + 1)
			begin
				#spi_period clk_spi = ~clk_spi;
				#spi_period clk_spi = ~clk_spi;
			end
			#20
			#spi_period
			cs_n = 1;
		end
		$stop;
	end
	
	initial
		forever #sb_period clk_sb = ~clk_sb;
	
	always @(negedge clk_spi)
	begin
		mosi <= mosi_data_in[j];
		miso_data_out <= {miso_data_out[22:0], miso};
		if(j == 0)
			j <= 23;
		else
			j <= j - 1;
	end
	
	spi_slave spi1(
		.clk_sb(clk_sb),
		
		.clk_spi(clk_spi),
		.mosi(mosi),
		.miso(miso),
		.cs_n(cs_n),
		
		.miso_tx(miso_tx),
		.miso_data_in(miso_data_in),
		
		.mosi_rx(mosi_rx),
		.mosi_data_out(mosi_data_out)
	);
endmodule