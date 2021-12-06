// demux_8x16.v

module demux_8x16(
	input [127:0] data_in,
	input [15:0] sel,
	
	output reg [7:0] data_out
	);
	
	always @(sel or data_in)
	begin
		case(sel)
			1 : begin
				data_out <= data_in[7:0];
			end
			2 : begin
				data_out <= data_in[15:8];
			end
			4 : begin
				data_out <= data_in[23:16];
			end
			8 : begin
				data_out <= data_in[31:24];
			end
			16 : begin
				data_out <= data_in[39:32];
			end
			32 : begin
				data_out <= data_in[47:40];
			end
			64 : begin
				data_out <= data_in[55:48];
			end
			128 : begin
				data_out <= data_in[63:56];
			end
			256 : begin
				data_out <= data_in[71:64];
			end
			512 : begin
				data_out <= data_in[79:72];
			end
			1024 : begin
				data_out <= data_in[87:80];
			end
			2048 : begin
				data_out <= data_in[95:88];
			end
			4096 : begin
				data_out <= data_in[103:96];
			end
			8192 : begin
				data_out <= data_in[111:104];
			end
			16384 : begin
				data_out <= data_in[119:112];
			end
			32768 : begin
				data_out <= data_in[127:120];
			end
			default : begin
				data_out <= data_in[7:0];
			end
		endcase
	end

endmodule