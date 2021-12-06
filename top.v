//top.v
module top(
	input reset_n_in,
	
	input clk_spi_in,
	input mosi_in,
	output miso_out,
	input cs_n_in,
	
	output led_out
);
	//Declare wires for pinout
	wire mosi, miso, clk_spi, clk_sb, cs_n, reset_n, led;
	
	//Local Parameters, currently supported: 14
	localparam NUM_MEM_BLOCKS = 14;
	
	//Declare clock signals
	reg clk_en = 1'b1;
	reg clk_pu = 1'b1;
	
	//Instantiate system bus clock module
	SB_HFOSC OSCInst0 (
		.CLKHFEN(clk_en),
		.CLKHFPU(clk_pu),
		.CLKHF(clk_sb)
	) /* synthesis ROUTE_THROUGH_FABRIC = 0 */;
	defparam OSCInst0.CLKHF_DIV = "0b00";
	
	//Declare wires for spi_slave module
	wire miso_tx, mosi_rx, miso_out, miso_en;
	wire [23:0] miso_data_in, mosi_data_out;
	
	//Instantiate spi_slave module
	spi_slave spi_slave_1(
		.reset_n(reset_n),
		.clk_sb(clk_sb),
		
		.clk_spi(clk_spi),
		.mosi(mosi),
		.miso(miso),
		.cs_n(cs_n),
		
		.miso_tx(miso_tx),
		.miso_data_in(miso_data_in),
		.miso_en(miso_en),
		
		.mosi_rx(mosi_rx),
		.mosi_data_out(mosi_data_out)
	);
	
	//Declare wires for system bus translator module
	wire [8:0] addr_out;
	wire [7:0] ram_data_in, ram_data_out;
	wire [NUM_MEM_BLOCKS - 1:0] ram_sel, ram_we;
	wire [23:0] rgb_data_out;
	wire ws2812_next_led, send_leds_n;
	
	//Instantiate system bus translator module
	sb_translator sb_translator_1(
		.reset_n(reset_n),
		.clk_sb(clk_sb),
		.instr_in(mosi_data_out),
		.instr_rx(mosi_rx),
		.data_in(ram_data_out),
		
		.instr_out(miso_data_in),
		.instr_tx(miso_tx),
		.data_out(ram_data_in),
		.addr_out(addr_out),
		.ram_sel(ram_sel),
		.ram_we(ram_we),
		
		.ws2812_next_led(ws2812_next_led),
		.send_leds_n(send_leds_n),
		.rgb_data_out(rgb_data_out)
	);
	
	//Declare mux/demux signals
	wire [NUM_MEM_BLOCKS*8-1:0] demux_data_in;
	
	//Instantiate demux module
	demux_8x16 demux(
		.data_in(demux_data_in),
		.sel(ram_sel),
		.data_out(ram_data_out));
	
	//Instantiate WS2812 module
	ws2812 ws2812(
		.reset_n(reset_n),
		.rgb_data(rgb_data_out),
		
		.clk(clk_sb),  	//System bus clock 48MHz
		.send_n(send_leds_n),
		
		.new_data_req(ws2812_next_led),
		.data(led)
	);
	
	//Instantiate RAM modules
	genvar i;
	generate
	begin 
		for(i = 0; i < NUM_MEM_BLOCKS; i = i + 1)
		begin
			ram ram_i (
				.din(ram_data_in),
				.write_en(ram_we[i]), 
				.waddr(addr_out),
				.wclk(clk_sb),
				.raddr(addr_out),
				.rclk(clk_sb),
				.dout(demux_data_in[(i+1)*8-1:i*8]));
		end
	end
	endgenerate
	
	SB_IO_OD #(
		.PIN_TYPE(6'b00_0001), // configure as simple open-drain input pin
		.NEG_TRIGGER(1'b0)    
	) mosi_input (
		.PACKAGEPIN(mosi_in), // connect to input pin
		.DIN0(mosi)        // with data from this wire
	);
	
	SB_IO_OD #(
		.PIN_TYPE(6'b01_1001), // configure as simple open-drain output pin
		.NEG_TRIGGER(1'b0)
	) miso_output (
		.PACKAGEPIN(miso_out), // connect to input pin
		.DOUT0(miso),        // with data from this wire
		.OUTPUTENABLE(miso_en)
	);
	
	SB_IO_OD #(
		.PIN_TYPE(6'b00_0001), // configure as simple open-drain input pin
		.NEG_TRIGGER(1'b0)    
	) clk_spi_input (
		.PACKAGEPIN(clk_spi_in), // connect to input pin
		.DIN0(clk_spi)        // with data from this wire
	);
	
	SB_IO_OD #(
		.PIN_TYPE(6'b00_0001), // configure as simple open-drain input pin
		.NEG_TRIGGER(1'b0)    
	) cs_n_input (
		.PACKAGEPIN(cs_n_in), // connect to input pin
		.DIN0(cs_n)        // with data from this wire
	);
	
	SB_IO_OD #(
		.PIN_TYPE(6'b00_0001), // configure as simple open-drain input pin
		.NEG_TRIGGER(1'b0)    
	) reset_n_input (
		.PACKAGEPIN(reset_n_in), // connect to input pin
		.DIN0(reset_n)        // with data from this wire
	);
	
	SB_IO #(
		.PIN_TYPE(6'b01_1000), // configure as simple output pin
		.NEG_TRIGGER(1'b0)
	) led_output (
		.PACKAGE_PIN(led_out), // connect to output pin
		.D_OUT_0(led)        // with data from this wire
	);
	
endmodule