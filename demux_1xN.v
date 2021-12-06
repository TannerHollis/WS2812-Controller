// demux_1xN.v

module demux_1xN(
	parameter N = 16,
	
	input [N-1:0] data_in,
	input [WIDTH-1:0] sel,
	
	output data_out
	);
	
	localparam WIDTH = $clog2(N);
	
	assign data_out = data_in[sel];
	
endmodule