`timescale 1ns / 1ps

module Test_PC;

  reg clk;
  reg reset;
  reg [31:0] pc_in;
  reg write;

  wire [31:0] pc_out;
  
  PC uut (
    .clk(clk), 
    .startin(reset), 
    .in(pc_in), 
    .out(pc_out),
    .write(write)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin    
    clk = 0;
    reset = 1;
    pc_in = 0;
    #10 reset = 0;
    #10 write = 1; pc_in = 32'h00000004;
    #10 write = 0; pc_in = 32'h00000008;
    #10 write = 1; pc_in = 32'h0000000C;
    #10 write = 1; pc_in = 32'h00000010;
    #10;
  end

endmodule
