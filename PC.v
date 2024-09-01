module PC(output reg [31:0] out, input [31:0] in, input clk, input startin, input write);

 always @(posedge startin) begin	
	out <= 32'b0;		
 end

 always @(posedge clk) begin
	if (write == 1'b1) begin
	    out <= in;
 	end
 end 	

endmodule
