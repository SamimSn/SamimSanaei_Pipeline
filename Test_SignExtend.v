`timescale 1ns / 1ps

module Test_SignExtend;
    
    reg [15:0] in;
    
    wire [31:0] out;

    
    sign_extend uut (
        .in(in),
        .result(out)
    );

    initial begin
        
        in = 16'h0001;
        
        
        #100;
        

        in = 16'h0001; #50;
        in = 16'h8000; #50;
        in = 16'h7FFF; #50;
        in = 16'hFFFF; #50;
        
    end
endmodule
