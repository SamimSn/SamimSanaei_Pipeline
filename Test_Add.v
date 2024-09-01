`timescale 1ns / 1ps

module Test_Add;

  reg [31:0] a, b;
  wire [31:0] sum;
  
  // Instantiate the adder module
  Add uut (
    .digit1(a), 
    .digit2(b), 
    .result(sum)
  );

  initial begin
    // Initialize inputs
    a = 0;
    b = 0;

    // Apply test vectors
    #10 a = 32'h00000001; b = 32'h00000001;
    #10 a = 32'hFFFFFFFF; b = 32'h00000001;
    #10 a = 32'h7FFFFFFF; b = 32'h00000001;
    #10 a = 32'h80000000; b = 32'h80000000;
    #10 a = 32'h12345678; b = 32'h87654321;
    #10;
  end    

endmodule
