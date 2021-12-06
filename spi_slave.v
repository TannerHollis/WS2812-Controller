//spi_slave.v

module spi_slave(
	input reset_n,
	input clk_sb,
	input clk_spi,
	input mosi,
	output reg miso,
	input cs_n,
	
	input miso_tx,
	input wire [23:0] miso_data_in,
	output reg miso_en,
	
	output reg mosi_rx,
	output reg [23:0] mosi_data_out
);
//Configure SPI Clock polarity and phase
localparam CPOL = 0;
localparam CPHA = 0;

//Clock Buffer for edge trigger detection
reg [1:0] clk;
wire clk_neg;
wire clk_pos;

//Declare clocks configured with CPOL and CPHA
always @(posedge clk_sb) clk <= {clk[0], clk_spi};
assign clk_pos = ((clk == 2'b01) && ((CPOL == 0) || (CPOL == 3))) || ((clk == 2'b10) && ((CPOL == 1) || (CPOL == 2)));
assign clk_neg = ((clk == 2'b10) && ((CPOL == 0) || (CPOL == 3))) || ((clk == 2'b01) && ((CPOL == 1) || (CPOL == 2)));

//Input data buffer due to clock buffer
reg [1:0] mosi_buffer;
reg miso_en;

//Handle SPI in 24-bits format, so we need a 5 bits counter to count the bits as they come in
reg [4:0] bitcnt_rx = 5'd0;
reg [4:0] bitcnt_tx = 5'd23;

//Declare 24-bit data buffers
reg [23:0] miso_data_out;
reg [23:0] mosi_data_in;

//Declare MOSI data output
always @(posedge clk_sb or negedge reset_n) 
begin
	if(~reset_n)
	begin
		mosi_rx <= 1'b0;
		mosi_data_out <= 0;
	end
	else
	begin
		mosi_data_out <= (cs_n && (bitcnt_rx == 5'd24)) ? mosi_data_in : mosi_data_out;
		mosi_rx <= cs_n && (bitcnt_rx == 5'd24);
	end
end

//Implement SPI_RX
always @(posedge clk_sb or negedge reset_n)
begin
	if(~reset_n)
	begin
		bitcnt_rx <= 5'd0;
		mosi_data_in <= 24'd0;
		mosi_buffer <= 2'd0;
	end
	else
	begin
		if(cs_n)
		begin
			bitcnt_rx <= 5'd0;
			mosi_data_in <= 24'd0;
			mosi_buffer <= 2'd0;
		end
		else
			mosi_buffer <= {mosi_buffer[0], mosi};
		if(clk_pos)
		begin
			bitcnt_rx <= bitcnt_rx + 5'd1;

			//Implement left-shift register with buffered miso input(previous value)
			mosi_data_in <= {mosi_data_in[22:0], mosi_buffer[1]};
		end
	end
end

//Implement SPI_TX
always @(posedge clk_sb)
begin
	if(~reset_n)
	begin
		bitcnt_tx <= 5'd23;
		miso <= 1'b0; 		//miso <= 1'bz; //ICE40UL products do not have tristate capabilities
		miso_en <= 1'b0;	//Use SB_IO_OD primitive with 
	end
	else
	begin
		if(cs_n)
		begin
			if(miso_tx && (bitcnt_tx == 5'd23))
			begin
				bitcnt_tx <= 5'd0;
				miso_data_out <= miso_data_in;
			end
			
			if(bitcnt_tx == 5'd23)
			begin
				miso_en <= 1'b0;
			end
			else
			begin
				miso <= miso_data_out[5'd23];
				miso_en <= 1'b1;
			end
		end
		else if(clk_neg && (bitcnt_tx < 5'd23))
		begin
			bitcnt_tx <= bitcnt_tx + 5'd1;
			
			miso <= miso_data_out[5'd22 - bitcnt_tx];
		end
	end
end

endmodule