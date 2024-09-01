`timescale 1ns / 1ps

module Test_Mux32;
    // Inputs
    reg [31:0] in0, in1;
    reg sel;
    // Outputs
    wire [31:0] out;

    // Instantiate the Unit Under Test (UUT)
    Mux32 uut (
        .input1(in0),
        .input2(in1),
        .op(sel),
        .out(out)
    );

    initial begin
        // Initialize Inputs
        in0 = 32'hA5A5A5A5;
        in1 = 32'h5A5A5A5A;
        sel = 0;
        
        // Wait 100 ns for global reset to finish
        #100;
        
        // Apply test vectors
        sel = 0; #50;
        sel = 1; #50;
        
        // Add more test cases as needed
        in0 = 32'hFFFFFFFF;
        in1 = 32'h00000000;
        sel = 0; #50;
        sel = 1; #50;
        
    end
endmodule
