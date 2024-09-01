module RegisterFile(
  input [4:0] read1,
  input [4:0] read2,
  input [4:0] write_reg,
  input reg_write,
  input [31:0] write_data,
  input startin,
  input [4:0] reg_no,
  input clk,
  output [31:0] data1,
  output [31:0] data2,
  output [31:0] val
);
  reg [31:0]registers[0:31];

  integer i;
  always@(posedge startin)
  begin
    for (i = 0; i < 32 ; i = i + 1) begin
      registers[i] <= i;
    end
    // Pipe Line mannual assigning-------------------------------------------------------------------------
    registers[1] <= 32'b00000000000000000000000000001010;
    registers[3] <= 32'b00000000000000000000000000000001;
    registers[7] <= 32'b00000000000000000000000000000100;
    //-----------------------------------------------------------------------------------------------------
  end
  
  

  always @(posedge clk)
  begin
    if (reg_write == 1)
    begin
      registers[write_reg] <= write_data;
    end
  end

  assign data1 = registers[read1];
  assign data2 = registers[read2];

  assign val = registers[reg_no];

endmodule


//------------------------------------------------------------------//
//                                                                  //
//                      $t{i} --> i'th register                     //
//                      $s0 --> 30'th register                      //
//                      $s1 --> 31'th register                      //
//                                                                  //
//------------------------------------------------------------------//