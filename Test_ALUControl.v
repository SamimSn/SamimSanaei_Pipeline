module Test_ALUControl;

  reg [3:0] func;
  reg [1:0] op;

  wire [3:0] control;

  ALUControl uut (
    .func(func), 
    .op(op), 
    .control(control)
  );

  initial begin    

    // Test case 1
    func = 4'b0000;
    op = 2'b00;
    #10;

    // Test case 2
    func = 4'b0010;
    op = 2'b10;
    #10;

    // Test case 3
    func = 4'b0110;
    op = 2'b01;
    #10;

    // Test case 4
    func = 4'b1100;
    op = 2'b11;
    #10;

    // Test case 5
    func = 4'b1001;
    op = 2'b10;
    #10;

    // Test case 6
    func = 4'b1111;
    op = 2'b11;
    #10;

  end

endmodule

