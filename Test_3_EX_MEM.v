module EX_MEM_Test;
  
  reg [31:0] pc_beq_input, alu_result_input, read_data_2_input;
  reg [4:0] write_register_input;
  reg alu_zero_input;
  reg [1:0] WB_input;
  reg [2:3] MEM_input;
  reg startin;
  reg clock;
  
  wire [31:0] pc_beq_output, alu_result_output, read_data_2_output;
  wire [4:0] write_register_output;
  wire alu_zero_output;
  wire [1:0] WB_output;
  wire [2:3] MEM_output;
  
  EX_MEM uut (
    .pc_beq_input(pc_beq_input),
    .alu_result_input(alu_result_input),
    .read_data_2_input(read_data_2_input),
    .write_register_input(write_register_input),
    .alu_zero_input(alu_zero_input),
    .WB_input(WB_input),
    .MEM_input(MEM_input),
    .startin(startin),
    .clock(clock),
    .pc_beq_output(pc_beq_output),
    .alu_result_output(alu_result_output),
    .read_data_2_output(read_data_2_output),
    .write_register_output(write_register_output),
    .alu_zero_output(alu_zero_output),
    .WB_output(WB_output),
    .MEM_output(MEM_output)
  );
  
  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end
  
  initial begin
    pc_beq_input = 32'b00000000000000000000000000000100;       // 0x00000004
    alu_result_input = 32'b10100101101001011010010110100101;    // 0xA5A5A5A5
    read_data_2_input = 32'b00010010001101000101011001111000;   // 0x12345678
    write_register_input = 5'b11111;                            // 0x1F
    alu_zero_input = 1'b0;
    WB_input = 2'b10;
    MEM_input = 3'b101;
    startin = 0;

    #10 startin = 1;
    #10 startin = 0;
    
    #10 pc_beq_input = 32'b00000000000000000000000000001000;    // 0x00000008
    alu_result_input = 32'b01011010010110100101101001011010;    // 0x5A5A5A5A
    read_data_2_input = 32'b10000111011001010011001000010001;   // 0x87654321
    write_register_input = 5'b01111;                            // 0x0F
    alu_zero_input = 1'b1;
    WB_input = 2'b01;
    MEM_input = 3'b011;
    
    #10 pc_beq_input = 32'b00000000000000000000000000001100;    // 0x0000000C
    alu_result_input = 32'b11111111111111111111111111111111;    // 0xFFFFFFFF
    read_data_2_input = 32'b00010001000100010001000100010001;   // 0x11111111
    write_register_input = 5'b01010;                            // 0x0A
    alu_zero_input = 1'b0;
    WB_input = 2'b11;
    MEM_input = 3'b110;
    
    #10 startin = 1;
    #10 startin = 0;
    
  end

endmodule
