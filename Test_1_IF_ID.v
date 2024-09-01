module IF_ID_Test;
  
  reg [31:0] instruction_input;
  reg [31:0] pc_plus_4_input;
  reg write;  
  reg startin;
  reg clock;
  
  wire [31:0] instruction_output;
  wire [31:0] pc_plus_4_output;
  
  IF_ID uut (
    .instruction_input(instruction_input),
    .pc_plus_4_input(pc_plus_4_input),
    .write(write),    
    .startin(startin),
    .clock(clock),
    .instruction_output(instruction_output),
    .pc_plus_4_output(pc_plus_4_output)
  );

  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end
  
  initial begin    
    instruction_input = 32'b10100101101001011010010110100101; // 0xA5A5A5A5
    pc_plus_4_input = 32'b00000000000000000000000000000100;  // 0x00000004
    write = 0;
    startin = 0;
        
    #10 startin = 1; #10 startin = 0;
    
    #10 write = 0;
    #10 instruction_input = 32'b01011010010110100101101001011010; // 0x5A5A5A5A
    pc_plus_4_input = 32'b00000000000000000000000000001000;  // 0x00000008
        
    #10 write = 1;
    #10 instruction_input = 32'b10101010101010101010101010101010; // 0xAAAAAAAA
    pc_plus_4_input = 32'b00000000000000000000000000001100;  // 0x0000000C
        
    #10 write = 0;
        
    #10 write = 1;
        
    #10 write = 0;
    #10 instruction_input = 32'b10111011101110111011101110111011; // 0xBBBBBBBB
    pc_plus_4_input = 32'b00000000000000000000000000010000;  // 0x00000010
    
    #10 startin = 1;
    #10 startin = 0;    
  end
endmodule
