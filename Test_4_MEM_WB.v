module MEM_WB_Test;
  
  reg [31:0] read_data_input, alu_result_input;
  reg [4:0] write_register_input;
  reg [1:0] WB_input;
  reg startin;
  reg clock;
  
  wire [31:0] read_data_output, alu_result_output;
  wire [4:0] write_register_output;
  wire [1:0] WB_output;

  MEM_WB uut (
    .read_data_input(read_data_input),
    .alu_result_input(alu_result_input),
    .write_register_input(write_register_input),
    .WB_input(WB_input),
    .startin(startin),
    .clock(clock),
    .read_data_output(read_data_output),
    .alu_result_output(alu_result_output),
    .write_register_output(write_register_output),
    .WB_output(WB_output)
  );

  initial begin
    clock = 0;
    forever #5 clock = ~clock;
  end

  initial begin    
    read_data_input = 32'b10100101101001011010010110100101;     // 0xA5A5A5A5
    alu_result_input = 32'b01011010010110100101101001011010;    // 0x5A5A5A5A
    write_register_input = 5'b11111;                            // 0x1F
    WB_input = 2'b10;
    startin = 0;
    
    #10 startin = 1;
    #10 startin = 0;

    #10 read_data_input = 32'b00010010001101000101011001111000; // 0x12345678
    alu_result_input = 32'b10000111011001010011001000010001;    // 0x87654321
    write_register_input = 5'b01111;                            // 0x0F
    WB_input = 2'b01;
    
    #10 read_data_input = 32'b11111111111111111111111111111111; // 0xFFFFFFFF
    alu_result_input = 32'b00010001000100010001000100010001;    // 0x11111111
    write_register_input = 5'b01010;                            // 0x0A
    WB_input = 2'b11;
    
    #10 startin = 1;
    #10 startin = 0;    
  end

endmodule
