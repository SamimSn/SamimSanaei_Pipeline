module Mux32_3In(input [31:0] input1, input [31:0] input2, input [31:0] input3, input [1:0] op, output [31:0] out);
    assign out = (op == 2'b00) ? input1 : 
                 (op == 2'b01) ? input2 : 
                 (op == 2'b10) ? input3 : input1;
endmodule
