`timescale 1ns / 1ps

module Test_Shift26_28;
    
    reg [25:0] in;
    
    wire [27:0] out;
    
    Shift26_28 uut (
        .in(in),
        .out(out)
    );

    initial begin
        
        in = 26'h000001;
        
        #100;
        
        in = 26'h000001; #50;
        in = 26'h000002; #50;
        in = 26'h3FFFFFF; #50;
        in = 26'h1FFFFFF; #50;
        
    end
endmodule
