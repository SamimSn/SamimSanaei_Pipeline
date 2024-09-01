`timescale 1ns / 1ps

module Test_Mux5;
    
    reg [4:0] in0, in1;
    reg sel;
    
    wire [4:0] out;
    
    Mux5 uut (
        .input1(in0),
        .input2(in1),
        .op(sel),
        .out(out)
    );

    initial begin

        in0 = 5'b00001;
        in1 = 5'b00010;
        sel = 0;
                
        #100;
                
        sel = 0; #50;
        sel = 1; #50;
                
        in0 = 5'b11111;
        in1 = 5'b00000;
        sel = 0; #50;
        sel = 1; #50;
        
    end
endmodule
