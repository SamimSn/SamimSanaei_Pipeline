module Mux32_3In_Test;

  reg [31:0] input1, input2, input3;
  reg [1:0] op;
  wire [31:0] out;
  
  Mux32_3In uut (
    .input1(input1),
    .input2(input2),
    .input3(input3),
    .op(op),
    .out(out)
  );

  initial begin    
    input1 = 32'hAAAAAAAA;
    input2 = 32'hBBBBBBBB;
    input3 = 32'hCCCCCCCC;
    op = 2'b00;
    #10;    
    
    op = 2'b01;
    #10;
    
    op = 2'b10;
    #10;
    
    op = 2'b11;
    #10;    
  end
endmodule
