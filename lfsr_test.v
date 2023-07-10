module lfsr_test (lfsr_out, clk50mhz, clk1hz, rst,HEX0, HEX1);

  output reg [7:0] lfsr_out;
  input clk50mhz, rst;
  output clk1hz;
  output wire [6:0] HEX0, HEX1;

  reg clk1hz =1'b0;
  integer counter_50M =0;
  
  always @(posedge clk50mhz, negedge rst)

   begin
	 if (!rst)
	 counter_50M <=0;
	 else if (counter_50M <25000000)
	 begin
	 counter_50M <= counter_50M + 1;
	 end
	 else if (counter_50M ==25000000)
	begin
		clk1hz <= !clk1hz;
		counter_50M <=0;
	 end
end

  wire feedback;
  assign feedback = ~(lfsr_out[7] ^ lfsr_out[5] ^ lfsr_out[4] ^ lfsr_out[3]);

always @(posedge clk1hz, negedge rst)
  begin
    if (!rst)
      lfsr_out = 8'b0;
    else
      lfsr_out = {lfsr_out[6:0],feedback};
  end
  
    // Creating Seven_Segment instance
    DEC_7SEG i1
    (
        .Hex_digit(lfsr_out[3:0]),
        .segment_data(HEX0[6:0])
    );
	 DEC_7SEG i2
    (
        .Hex_digit(lfsr_out[7:4]),
        .segment_data(HEX1[6:0])
    );
endmodule
