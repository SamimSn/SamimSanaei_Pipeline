module MEM_WB(  
  input [31:0] read_data_input, alu_result_input,
  input [4:0] write_register_input,
  input [1:0] WB_input,
  input startin,
  input clock,
  output reg [31:0] read_data_output, alu_result_output,
  output reg [4:0] write_register_output,
  output reg [1:0] WB_output
);

  always @(posedge startin)
  begin
    alu_result_output <= 0;
    WB_output <= 0;
    read_data_output <= 0;
    write_register_output <= 0;
  end

  always @(posedge clock)
  begin
    write_register_output <= write_register_input;
    read_data_output <= read_data_input;
    WB_output <= WB_input;
    alu_result_output <= alu_result_input;
  end

endmodule
