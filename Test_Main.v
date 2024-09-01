module Test_Main;

    reg clk;
    reg startin;
    reg [4:0] regNo;

    wire [31:0] val;

    Main uut (
        .clk(clk),
        .startin(startin),
        .regNo(regNo),
        .val(val)
    );

    always #10 clk = ~clk;

    initial begin
        
        clk = 0;
        startin = 0;
        regNo = 32'd1;

        startin = 1;
        #10;
        startin = 0;       
        #10;
        regNo = 32'd1;
        
        repeat (10) @(posedge clk);
    end


endmodule
