module Control(
  input [5:0] OpCode,
  output RegDst,
  output AluSrc,
  output MemToReg,
  output RegWrite,
  output MemRead,
  output MemWrite,
  output Branch,
  output [1:0] AluOp,
  output Jump
);

  wire rFormat; 
  wire lw;
  wire sw;
  wire beq;
  wire addi;            

  assign rFormat = (OpCode == 6'b000000);  // wire
  assign sw = (OpCode == 6'b101011);       // wire
  assign lw = (OpCode == 6'b100011);       // wire
  assign addi = (OpCode == 6'b001000);     // wire
  assign beq = (OpCode == 6'b000100);      // wire
 
  assign AluOp = {rFormat, beq};                    // output
  assign AluSrc = (lw || sw || addi)? 1: 0;         // output    
  assign RegWrite = (rFormat || lw || addi)? 1: 0;  // output
  assign RegDst = rFormat;                          // output  
  assign MemToReg = lw;                             // output    
  assign MemRead = lw;                              // output
  assign MemWrite = sw;                             // output
  assign Branch = beq;                              // output
  assign Jump = (OpCode == 6'b000010);              // output

endmodule