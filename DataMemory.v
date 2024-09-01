module DataMemory(
  input [31:0] address,
  input [31:0] write_data,
  input mem_write,
  input mem_read,
  input clk,
  input startin,
  output reg [31:0] read_data
);
  reg [7:0]memory[0:255];

  integer i;
  always@(posedge startin)
  begin
    for (i = 0; i < 37 ; i = i + 4) begin
      {memory[i], memory[i+1], memory[i+2], memory[i+3]} <= 32'd5;
    end

    // memory[0] = 8'b00000000; memory[1] = 8'b00000000; memory[2] = 8'b00000000; memory[3] = 8'b00000000;     
    // memory[4] = 8'b00000000; memory[5] = 8'b00000000; memory[6] = 8'b00000000; memory[7] = 8'b00001010;     
    // memory[8] = 8'b00000000; memory[9] = 8'b00000000; memory[10] = 8'b00000000; memory[11] = 8'b00001010;   
    // memory[12] = 8'b00000000; memory[13] = 8'b00000000; memory[14] = 8'b00000000; memory[15] = 8'b00001010; 
    // memory[16] = 8'b00000000; memory[17] = 8'b00000000; memory[18] = 8'b00000000; memory[19] = 8'b00001010; 
    // memory[20] = 8'b00000000; memory[21] = 8'b00000000; memory[22] = 8'b00000000; memory[23] = 8'b00001010; 
    // memory[24] = 8'b00000000; memory[25] = 8'b00000000; memory[26] = 8'b00000000; memory[27] = 8'b00001010; 
    // memory[28] = 8'b00000000; memory[29] = 8'b00000000; memory[30] = 8'b00000000; memory[31] = 8'b00001010; 
    // memory[32] = 8'b00000000; memory[33] = 8'b00000000; memory[34] = 8'b00000000; memory[35] = 8'b00001010; 
    // memory[36] = 8'b00000000; memory[37] = 8'b00000000; memory[38] = 8'b00000000; memory[39] = 8'b00001010; 
    // memory[40] = 8'b00000000; memory[41] = 8'b00000000; memory[42] = 8'b00000000; memory[43] = 8'b00001011;

    // memory[44] = 8'b00000000; memory[45] = 8'b00000000; memory[46] = 8'b00000000; memory[47] = 8'b00001011;
    // memory[48] = 8'b00000000; memory[49] = 8'b00000000; memory[50] = 8'b00000000; memory[51] = 8'b00001011;
    // memory[52] = 8'b00000000; memory[53] = 8'b00000000; memory[54] = 8'b00000000; memory[55] = 8'b00001011;
    // memory[56] = 8'b00000000; memory[57] = 8'b00000000; memory[58] = 8'b00000000; memory[59] = 8'b00001011;
    // memory[60] = 8'b00000000; memory[61] = 8'b00000000; memory[62] = 8'b00000000; memory[63] = 8'b00001011;
    // memory[64] = 8'b00000000; memory[65] = 8'b00000000; memory[66] = 8'b00000000; memory[67] = 8'b00001011;
    // memory[68] = 8'b00000000; memory[69] = 8'b00000000; memory[70] = 8'b00000000; memory[71] = 8'b00001011;
    // memory[72] = 8'b00000000; memory[73] = 8'b00000000; memory[74] = 8'b00000000; memory[75] = 8'b00001011;
    // memory[76] = 8'b00000000; memory[77] = 8'b00000000; memory[78] = 8'b00000000; memory[79] = 8'b00001011;
    // memory[80] = 8'b00000000; memory[81] = 8'b00000000; memory[82] = 8'b00000000; memory[83] = 8'b00001011;
    // memory[84] = 8'b00000000; memory[85] = 8'b00000000; memory[86] = 8'b00000000; memory[87] = 8'b00001011;
    // memory[88] = 8'b00000000; memory[89] = 8'b00000000; memory[90] = 8'b00000000; memory[91] = 8'b00001011;
    // memory[92] = 8'b00000000; memory[93] = 8'b00000000; memory[94] = 8'b00000000; memory[95] = 8'b00001011;
    // memory[96] = 8'b00000000; memory[97] = 8'b00000000; memory[98] = 8'b00000000; memory[99] = 8'b00001011;
    // memory[100] = 8'b00000000; memory[101] = 8'b00000000; memory[102] = 8'b00000000; memory[103] = 8'b00001011;
    // memory[104] = 8'b00000000; memory[105] = 8'b00000000; memory[106] = 8'b00000000; memory[107] = 8'b00001011;
    // memory[108] = 8'b00000000; memory[109] = 8'b00000000; memory[110] = 8'b00000000; memory[111] = 8'b00001011;
    // memory[112] = 8'b00000000; memory[113] = 8'b00000000; memory[114] = 8'b00000000; memory[115] = 8'b00001011;
    // memory[116] = 8'b00000000; memory[117] = 8'b00000000; memory[118] = 8'b00000000; memory[119] = 8'b00001011;
    // memory[120] = 8'b00000000; memory[121] = 8'b00000000; memory[42] = 8'b00000000; memory[43] = 8'b00001011;
    // memory[124] = 8'b00000000; memory[125] = 8'b00000000; memory[126] = 8'b00000000; memory[127] = 8'b00001011;
    // memory[128] = 8'b00000000; memory[129] = 8'b00000000; memory[130] = 8'b00000000; memory[131] = 8'b00001011;
    // memory[132] = 8'b00000000; memory[133] = 8'b00000000; memory[134] = 8'b00000000; memory[135] = 8'b00001011;
    // memory[136] = 8'b00000000; memory[137] = 8'b00000000; memory[138] = 8'b00000000; memory[139] = 8'b00001011;
    // memory[140] = 8'b00000000; memory[141] = 8'b00000000; memory[142] = 8'b00000000; memory[143] = 8'b00001011;
    // memory[144] = 8'b00000000; memory[145] = 8'b00000000; memory[146] = 8'b00000000; memory[147] = 8'b00001011;
    // memory[148] = 8'b00000000; memory[149] = 8'b00000000; memory[150] = 8'b00000000; memory[151] = 8'b00001011;
    // memory[152] = 8'b00000000; memory[153] = 8'b00000000; memory[154] = 8'b00000000; memory[155] = 8'b00001011;
    // memory[156] = 8'b00000000; memory[157] = 8'b00000000; memory[158] = 8'b00000000; memory[159] = 8'b00001011;
    

  end

  always @(posedge clk)
  begin
    if (mem_write == 1)
    begin
      {memory[address], memory[address+1], memory[address+2], memory[address+3]} <= write_data;
    end 
  end

  always @(*)
  begin
    if(mem_read)
    begin
      read_data <= {memory[address], memory[address+1], memory[address+2], memory[address+3]};
    end
  end

endmodule