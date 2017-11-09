module top (
	input  clk,
	output LED1,
	output LED2,
	output LED3,
	output LED4,
	output LED5,
);

	localparam BITS = 3;
	localparam DELAY = 22;

	reg [BITS:0] datactr = 0;
	reg [DELAY:0] timectr = 0;

	reg done = 0;
	wire logic_box_out;
	
	logic_box #(
		.BITS (BITS)
	) b0 (
		.reg_in(datactr),
		.result(logic_box_out)
	);
	rememberer r0 (logic_box_out, LED4);
	always @(posedge clk) begin
		timectr <= timectr + 1;
		if (timectr == 0)
		begin
			datactr <= datactr + 1;
			if (datactr == ((1<<(BITS))-1))
				done <= 1;
		end
	end
  
	assign LED1 = datactr[0];
	assign LED2 = datactr[1];
	assign LED3 = datactr[2];
	assign LED5 = done;
endmodule

module logic_box #(
	parameter BITS = 8
) (
	input [BITS:0] reg_in, 
	output wire result
);
	assign result = reg_in[0] & reg_in[1] & reg_in[2];
endmodule

module rememberer(a, b);
	input a;
	output b;

	wire a, b;
	reg set_at = 0;
	always @(a) begin
		set_at <= set_at | a;
	end
	assign b = set_at;
endmodule