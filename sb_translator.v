module sb_translator(
	input reset_n,
	input clk_sb,
	input [23:0] instr_in,
	input instr_rx,
	input [7:0] data_in,
	
	output reg [23:0] instr_out,
	output reg instr_tx,
	output reg [7:0] data_out,
	output reg [8:0] addr_out,
	output reg [15:0] ram_sel,
	output reg [15:0] ram_we,
	
	input ws2812_next_led,
	output reg send_leds_n,
	output reg [23:0] rgb_data_out
);

//Define state machine states
localparam STATE_IDLE = 0;
localparam STATE_READ = 1;
localparam STATE_WRITE = 2;
localparam STATE_SET_SETTING = 3;
localparam STATE_GET_SETTING = 4;
localparam STATE_CLEAR_RAM = 5;
localparam STATE_FILL_RAM = 6;
localparam STATE_SEND_LEDS = 7;

//Define settings parameters
reg [15:0] num_leds;

reg [17:0] cnt;

reg [2:0] state;
reg [23:0] instr_tmp;

//Send LED registers
reg [23:0] rgb_data_tmp;
reg [1:0] cnt_ram_read;
reg [16:0] cnt_leds;

//Define WS2812 controller states
localparam STATE_SEND_LEDS_PREPARE_DATA = 0;
localparam STATE_SEND_LEDS_WAIT = 1;
reg state_leds;

always @(posedge clk_sb or negedge reset_n)
begin
	if(~reset_n)
	begin
		state <= STATE_IDLE;
		cnt <= 0;
		instr_tx <= 0;
		instr_tmp <= 0;
		rgb_data_out <= 0;
		rgb_data_tmp <= 0;
		cnt_ram_read <= 0;
		cnt_leds <= 0;
		num_leds <= 0;
		ram_sel <= 0;
		ram_we <= 0;
		send_leds_n <= 0;
		data_out <= 0;
		addr_out <= 0;
		instr_out <= 0;
		state_leds <= STATE_SEND_LEDS_PREPARE_DATA;
	end
	else
	begin
		case(state)
			STATE_IDLE : begin
				instr_tx <= 1'b0;
				send_leds_n <= 1'b1; //Invert for active low
				cnt <= 0;
				if(instr_rx)
				begin
					instr_tmp <= instr_in;
					case(instr_in[23:21])
						3'b100 : begin
							state <= STATE_WRITE;
							ram_we <= 1 << instr_in[20:17];
							ram_sel <= 1 << instr_in[20:17];
							data_out <= instr_in[7:0];
							addr_out <= instr_in[16:8];
						end
						3'b000 : begin
							state <= STATE_READ;
							ram_we <= 0;
							ram_sel <= 1 << instr_in[20:17];
							addr_out <= instr_in[16:8];
						end
						3'b001 : begin
							state <= STATE_SET_SETTING;
							ram_we <= 0;
						end
						3'b010 : begin
							state <= STATE_GET_SETTING;
							ram_we <= 0;
						end
						3'b011 : begin
							state <= STATE_CLEAR_RAM;
							addr_out <= 0;
							data_out <= 0;
							ram_sel <= 1;
							ram_we <= 1;
						end
						3'b101 : begin
							state <= STATE_FILL_RAM;
							addr_out <= 0;
							data_out <= instr_in[7:0];
							ram_sel <= 1;
							ram_we <= 1;
						end
						3'b111 : begin
							state <= STATE_SEND_LEDS;
							state_leds <= STATE_SEND_LEDS_PREPARE_DATA;
							addr_out <= 0;
							ram_we <= 0;
							ram_sel <= 1;
							cnt_leds <= 0;
							cnt_ram_read <= 0;
							num_leds <= instr_in[15:0];
						end
						default : begin
							state <= STATE_IDLE;
						end
					endcase
				end
			end
			STATE_READ : begin
				instr_tx <= 1'b1;
				state <= STATE_IDLE;
				instr_out <= {instr_tmp[23:17], addr_out, data_in};
			end
			STATE_WRITE : begin
				state <= STATE_IDLE;
				ram_we <= 0;
			end
			STATE_SET_SETTING : begin
				state <= STATE_IDLE;
			end
			STATE_GET_SETTING : begin
				state <= STATE_IDLE;
			end
			STATE_FILL_RAM : begin
				if(cnt < num_leds + num_leds + num_leds)
				begin
					cnt <= cnt + 1;
					addr_out <= cnt[8:0];
					data_out <= instr_tmp[7:0];
					ram_we <= 16'b1 << cnt[12:9];
				end
				else
					state <= STATE_IDLE;
			end
			STATE_CLEAR_RAM : begin
				instr_tmp[7:0] <= 0;
				state <= STATE_FILL_RAM;
			end
			STATE_SEND_LEDS : begin
				case(state_leds)
					STATE_SEND_LEDS_PREPARE_DATA : begin
						cnt_ram_read <= cnt_ram_read + 1;
						addr_out <= cnt_leds[8:0] + 1;
						ram_sel <= 16'd1 << (cnt_leds[12:9] + 1);
						case(cnt_ram_read)
							0 : begin
								rgb_data_tmp[15:8] <= data_in;
								cnt_leds <= cnt_leds + 1;
							end
							1 : begin
								rgb_data_tmp[7:0] <= data_in;
								cnt_leds <= cnt_leds + 1;
							end
							2 : begin
								rgb_data_tmp[23:16] <= data_in;
								cnt_leds <= cnt_leds + 1;
								state_leds <= STATE_SEND_LEDS_WAIT;
								send_leds_n <= 0;
							end
							3 : begin
								//Do nothing
							end
							default : begin
								//Do nothing
							end
						endcase
					end
					STATE_SEND_LEDS_WAIT : begin
						if(cnt_leds == num_leds + num_leds + num_leds + 3)
							state <= STATE_IDLE;
						if(ws2812_next_led)
						begin
							rgb_data_out <= rgb_data_tmp;
							state_leds <= STATE_SEND_LEDS_PREPARE_DATA;
							cnt_ram_read <= 0;
						end
					end
					default : begin
						state <= STATE_IDLE;
					end
				endcase
			end
			default : begin
				state <= STATE_IDLE;
			end
		endcase
	end
end

endmodule