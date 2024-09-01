module Test_Control;

  reg [5:0] opCode;

  wire regDst;
  wire aluSrc;
  wire memToReg;
  wire regWrite;
  wire memRead;
  wire memWrite;
  wire branch;
  wire [1:0] aluOp;
  wire jump;

  Control uut (
    .opCode(opCode), 
    .regDst(regDst), 
    .aluSrc(aluSrc), 
    .memToReg(memToReg), 
    .regWrite(regWrite), 
    .memRead(memRead), 
    .memWrite(memWrite), 
    .branch(branch), 
    .aluOp(aluOp), 
    .jump(jump)
  );

  initial begin    

    // Test R-Format (opCode = 000000)
    opCode = 6'b000000;
    #10;

    // Test LW (opCode = 100011)
    opCode = 6'b100011;
    #10;

    // Test SW (opCode = 101011)
    opCode = 6'b101011;
    #10;

    // Test ADDI (opCode = 001000)
    opCode = 6'b001000;
    #10;

    // Test BEQ (opCode = 000100)
    opCode = 6'b000100;
    #10;

    // Test JUMP (opCode = 000010)
    opCode = 6'b000010;
    #10;

    // Test default case (an invalid opCode)
    opCode = 6'b111111;
    #10;

  end

endmodule
