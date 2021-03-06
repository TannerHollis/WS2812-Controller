//ws2812.v
`include "/common_defines.v"

module ws2812 (
	input reset_n,
    input wire [23:0] rgb_data,
    
    input wire clk,  //System bus clock 48MHz
	input wire send_n,
	
	output reg new_data_req,
    output reg data
);
    parameter NUM_LEDS = 8;
    parameter CLK_MHZ = 48;
    localparam LED_BITS = $clog2(NUM_LEDS);

    /* 
	
	WS2812 datasheet: https://cdn-shop.adafruit.com/datasheets/WS2812.pdf

    clock period at 48MHz = 20.833ns:
        t0_on = 350ns
        t1_on = 700ns
		t_period = 1.25us = 1250ns
        t_reset = 65us = 65000ns
    */
	
	`ifdef WS2812
		parameter t0_on = 17; 		//ceil(350ns/20.833ns)
		parameter t1_on = 34; 		//ceil(700ns/20.833ns)
		parameter t_reset = 3120;	//ceil(65us/20.833ns)
		localparam t_period = 60;	//ceil(1.25us/20.833ns)
	`endif

    localparam COUNT_BITS = $clog2(t_reset);

    reg [COUNT_BITS-1:0] bit_counter = t_reset;
    reg [4:0] rgb_counter;

    localparam STATE_DATA  = 0;
    localparam STATE_RESET = 1;
	localparam STATE_IDLE = 2;

    reg [1:0] state = STATE_RESET;

    always @(posedge clk or negedge reset_n)
		if(~reset_n)
		begin
			state <= STATE_RESET;
			bit_counter <= t_reset;
			rgb_counter <= 5'd23;
			new_data_req <= 0;
			data <= 0;
		end
		else
		begin
			case(state)
				STATE_RESET: begin
					// register the input values
					data <= 0;

					if(bit_counter == 0) begin
						state <= STATE_IDLE;
						bit_counter <= t_period;
					end
					else
						bit_counter <= bit_counter - 1;
				end
				
				STATE_IDLE: begin
					if(~send_n)
					begin
						state <= STATE_DATA;
						new_data_req <= 1'b1;
					end
				end
				
				STATE_DATA: begin
					// output the data
					if(rgb_data[rgb_counter])
						data <= (t_period - bit_counter) < t1_on;
					else
						data <= (t_period - bit_counter) < t0_on;

					// after each bit, increment rgb counter
					if(bit_counter == 0) 
					begin
						if(rgb_counter == 0) 
						begin
							rgb_counter <= 5'd23;
							if(send_n)
							begin
								state <= STATE_RESET;
								bit_counter <= t_reset;
								new_data_req <= 1'b0;
							end
							else
							begin
								bit_counter <= t_period;
								new_data_req <= 1'b1;
							end
						end
						else
						begin
							rgb_counter <= rgb_counter - 1;
							bit_counter <= t_period;
						end
					end
					else
					begin
						bit_counter <= bit_counter - 1;
						new_data_req <= 1'b0;
					end
				end
			endcase
		end
endmodule