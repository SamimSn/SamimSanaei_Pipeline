module ID_EX_Test;
  
  reg [14:0] instruction_input;
  reg [31:0] pc_plus_4_input, sign_extend_in, read_data_1_input, read_data_2_input;
  reg [1:0] WB_input;
  reg [2:3] MEM_input;
  reg [3:4] EX_input;
  reg startin;
  reg clock;
  
  wire [14:0] instruction_output;
  wire [31:0] pc_plus_4_output, sign_extend_out, read_data_1_output, read_data_2_output;
  wire [1:0] WB_output;
  wire [2:3] MEM_output;
  wire [3:4] EX_output;
  
  ID_EX uut (
    .instruction_input(instruction_input),
    .pc_plus_4_input(pc_plus_4_input),
    .sign_extend_in(sign_extend_in),
    .read_data_1_input(read_data_1_input),
    .read_data_2_input(read_data_2_input),
    .WB_input(WB_input),
    .MEM_input(MEM_input),
    .EX_input(EX_input),
    .startin(startin),
    .clock(clock),
    .instruction_output(instruction_output),
    .pc_plus_4_output(pc_plus_4_output),
    .sign_extend_out(sign_extend_out),
    .read_data_1_output(read_data_1_output),
    .read_data_2_output(read_data_2_output),
    .WB_output(WB_output),
    .MEM_output(MEM_output),
    .EX_output(EX_output)
  );
  
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  initial begin    
    instruction_input = 15'b000110100011111; // 0x1A3F
    pc_plus_4_input = 32'b00000000000000000000000000000100; // 0x00000004
    sign_extend_in = 32'b00000000000000000000000000001000; // 0x00000008
    read_data_1_input = 32'b00010010001101000101011001111000; // 0x12345678
    read_data_2_input = 32'b10000111011001010011001000010001; // 0x87654321
    WB_input = 2'b10;
    MEM_input = 3'b101;
    EX_input = 4'b1100;
    startin = 0;
    
    #10 startin = 1;
    #10 startin = 0;
    
    #10 instruction_input = 15'b0010101101001100; // 0x2B4C
    pc_plus_4_input = 32'b00000000000000000000000000010000; // 0x00000010
    sign_extend_in = 32'b00000000000000000000000000100000; // 0x00000020
    read_data_1_input = 32'b10011010101111001101111011110000; // 0x9ABCDEF0
    read_data_2_input = 32'b00001111111011011100101110101001; // 0x0FEDCBA9
    WB_input = 2'b01;
    MEM_input = 3'b011;
    EX_input = 4'b0011;
    
    #10 instruction_input = 15'b0011110001011101; // 0x3C5D
    pc_plus_4_input = 32'b00000000000000000000000000011000; // 0x00000018
    sign_extend_in = 32'b00000000000000000000000000110000; // 0x00000030
    read_data_1_input = 32'b00010001000100010001000100010001; // 0x11111111
    read_data_2_input = 32'b00100010001000100010001000100010; // 0x22222222
    WB_input = 2'b11;
    MEM_input = 3'b110;
    EX_input = 4'b1001;
    
    #10 startin = 1;
    #10 startin = 0;    
  end

endmodule
