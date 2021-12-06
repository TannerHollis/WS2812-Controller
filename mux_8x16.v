// mux_8x16.v

module mux_8x16(
	output reg [127:0] data_out,
	input [15:0] sel,
	
	input [7:0] data_in
	);
	
	always @(sel)
	begin
		case(sel)
			1 : begin
				data_out[7:0] <= data_in;
			end
			2 : begin
				data_out[15:8] <= data_in;
			end
			4 : begin
				data_out[23:16] <= data_in;
			end
			8 : begin
				data_out[31:24] <= data_in;
			end
			16 : begin
				data_out[39:32] <= data_in;
			end
			32 : begin
				data_out[47:40] <= data_in;
			end
			64 : begin
				data_out[55:48] <= data_in;
			end
			128 : begin
				data_out[63:56] <= data_in;
			end
			256 : begin
				data_out[71:64] <= data_in;
			end
			512 : begin
				data_out[79:72] <= data_in;
			end
			1024 : begin
				data_out[87:80] <= data_in;
			end
			2048 : begin
				data_out[95:88] <= data_in;
			end
			4096 : begin
				data_out[103:96] <= data_in;
			end
			8192 : begin
				data_out[111:104] <= data_in;
			end
			16384 : begin
				data_out[119:112] <= data_in;
			end
			32768 : begin
				data_out[127:120] <= data_in;
			end
			default : begin
				data_out[7:0] <= data_in;
			end
		endcase
	end

endmodule