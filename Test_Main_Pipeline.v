module Test_Main_Pipeline;

    reg clk;
    reg startin;
    reg [4:0] regNo;

    wire [31:0] val;

    Main_Pipeline uut (
        .clk(clk),
        .startin(startin),
        .regNo(regNo),
        .val(val)
    );

    always #100 clk = ~clk;

    initial begin
        
        clk = 0;
        startin = 0;
        regNo = 32'd6;

        startin = 1;
        #100;
        startin = 0;       
        #100;
        regNo = 32'd6;
        
        repeat (10) @(posedge clk);
    end


endmodule
