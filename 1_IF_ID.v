module IF_ID(
  input [31:0] instruction_input,
  input [31:0] pc_plus_4_input,
  input write,
  input startin,
  input clock,
  output reg [31:0] instruction_output,
  output reg [31:0] pc_plus_4_output
);

  always @(posedge startin)
  begin    
    instruction_output <= 0;
  end
  
  always @(posedge clock)
  begin
    if (write == 1'b1) begin      
      pc_plus_4_output <= pc_plus_4_input;
      instruction_output <= instruction_input;
    end
  end

endmodule

