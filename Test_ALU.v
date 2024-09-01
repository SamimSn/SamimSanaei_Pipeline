`timescale 1ns / 1ps

module Test_ALU;

  reg [31:0] a, b;
  reg [3:0] alu_control;
  wire [31:0] result;
  wire zero;
  
  // Instantiate the ALU module
  ALU uut (
    .in1(a), 
    .in2(b), 
    .operation(alu_control), 
    .out(result), 
    .zero(zero)
  );

  initial begin
    // Initialize inputs
    a = 0;
    b = 0;
    alu_control = 4'b0000; // Assuming 0000 is ADD operation

    // Apply test vectors
    #10 a = 32'h00000001; b = 32'h00000001; alu_control = 4'b0000; // ADD
    #10 alu_control = 4'b0001; // SUB
    #10 alu_control = 4'b0010; // AND
    #10 alu_control = 4'b0011; // OR
    #10 alu_control = 4'b0100; // XOR
    #10 alu_control = 4'b0101; // SLT
    #10;
  end  

endmodule
