module Mux10(input [9:0] input1, input [9:0] input2, input op, output [9:0] out);
  assign out = op ? input2 : input1;
endmodule
