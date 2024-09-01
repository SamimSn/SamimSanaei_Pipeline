module Comparator_Test;
  
  reg [31:0] input1;
  reg [31:0] input2;
  wire out;
  
  Comparator uut (
    .input1(input1),
    .input2(input2),
    .out(out)
  );

  initial begin
    
    input1 = 32'hFFFFFFFF;
    input2 = 32'hFFFFFFFF;
    #10;
    
    input1 = 32'hFFFFFFFF;
    input2 = 32'h00000000;
    #10;    
    
    input1 = 32'h00000000;
    input2 = 32'hFFFFFFFF;
    #10;    
    
    input1 = 32'hFFFFFFFF;
    input2 = 32'h00000000;
    #10;    
    
    input1 = 32'h00000000;
    input2 = 32'h00000000;
    #10;    
    
    input1 = 32'h11111111;
    input2 = 32'h11111111;
    #10;    
    
    input1 = 32'hABCDEF12;
    input2 = 32'h12345678;
    #10;    
    
    input1 = 32'hABCDEF12;
    input2 = 32'hABCDEF12;
    #10;    
        
  end
endmodule
