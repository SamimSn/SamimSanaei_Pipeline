`timescale 1ns / 1ps

module Test_Shiftleft2;
    // Inputs
    reg [31:0] in;
    // Outputs
    wire [31:0] out;

    // Instantiate the Unit Under Test (UUT)
    shift_left2 uut (
        .in(in),
        .out(out)
    );

    initial begin
        // Initialize Inputs
        in = 32'h00000001;
        
        // Wait 100 ns for global reset to finish
        #100;
        
        // Apply test vectors
        in = 32'h00000001; #50;
        in = 32'h00000002; #50;
        in = 32'h80000000; #50;
        in = 32'hFFFFFFFF; #50;
        
    end
endmodule
