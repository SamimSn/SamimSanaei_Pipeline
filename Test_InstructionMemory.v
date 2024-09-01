`timescale 1ns / 1ps

module Test_InstructionMemory;

  reg [31:0] address, startin;
  wire [31:0] instruction;
  
  // Instantiate the instruction memory module
  instruction_memory uut (
    .address(address), 
    .instruction(instruction),
    .startin(startin)
  );

  initial begin
    // Initialize inputs
    address = 0;
    startin = 0;

    // Apply test vectors
    #10 address = 32'h00000004;
    #10 address = 32'h00000008;
    #10 address = 32'h0000000C;
    #10 address = 32'h00000010;
    #10;
  end  

endmodule
