module EX_MEM(  
  input [31:0] alu_result_input, read_data_2_input,
  input [4:0] write_register_input,  
  input [1:0] WB_input,
  input [1:0] MEM_input,
  input startin,
  input clock,
  output reg [31:0] alu_result_output, read_data_2_output,
  output reg [4:0] write_register_output,  
  output reg [1:0] WB_output,
  output reg [1:0] MEM_output
);

  always @(posedge startin)
  begin
    MEM_output <= 0;
    WB_output <= 0;
    write_register_output <= 0;
    read_data_2_output <= 0;
    alu_result_output <= 0;
  end

  always @(posedge clock)
  begin
    alu_result_output <= alu_result_input;
    WB_output <= WB_input;
    read_data_2_output <= read_data_2_input;
    write_register_output <= write_register_input;    
    MEM_output <= MEM_input;
  end

endmodule

