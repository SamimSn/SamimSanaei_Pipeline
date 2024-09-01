module ID_EX(
  input [14:0] instruction_input,
  input [31:0] sign_extend_in, read_data_1_input, read_data_2_input,
  input [1:0] WB_input,
  input [1:0] MEM_input,
  input [3:0] EX_input,
  input startin,
  input clock,
  output reg [14:0] instruction_output,
  output reg [31:0] sign_extend_out, read_data_1_output, read_data_2_output,
  output reg [1:0] WB_output,
  output reg [1:0] MEM_output,
  output reg [3:0] EX_output
);

  always @(posedge startin)
  begin
    read_data_2_output <= 0;
    MEM_output <= 0;
    read_data_1_output <= 0;
    EX_output <= 0;
    sign_extend_out <= 0;
    WB_output <= 0;
  end

  always @(posedge clock)
  begin
    read_data_2_output <= read_data_2_input;
    read_data_1_output <= read_data_1_input;
    instruction_output <= instruction_input;
    WB_output <= WB_input;
    sign_extend_out <= sign_extend_in;
    MEM_output <= MEM_input;
    EX_output <= EX_input;
  end

endmodule
