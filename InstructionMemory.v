module Instructionmemory(input [31:0] address, output [31:0] instruction, input startin);

  reg [7:0]memory[0:255];

  always@(posedge startin) begin

    //------------------------------------------------------------------//
    //                                                                  //
    //                     Single Cycle Instructions                    //
    //                                                                  //
    //------------------------------------------------------------------//
    
    // {memory[3], memory[2], memory[1], memory[0]} <= 32'b10001100000000010000000000000000;                // lw $1, 0($0)
    // {memory[7], memory[6], memory[5], memory[4]} <= 32'b10001100000000100000000000000100;                // lw $2, 4($0)
    // {memory[11], memory[10], memory[9], memory[8]} <= 32'b10001100000000110000000000001000;              // lw $3, 8($0) 
    // {memory[15], memory[14], memory[13], memory[12]} <= 32'b10001100000001000000000000001100;            // lw $4, 12($0)
    // {memory[19], memory[18], memory[17], memory[16]} <= 32'b10001100000001010000000000010000;            // lw $5, 16($0)
    // {memory[23], memory[22], memory[21], memory[20]} <= 32'b10001100000001100000000000010100;            // lw $6, 20($0)
    // {memory[27], memory[26], memory[25], memory[24]} <= 32'b10001100000001110000000000011000;            // lw $7, 24($0)
    // {memory[31], memory[30], memory[29], memory[28]} <= 32'b10001100000010000000000000011100;            // lw $8, 28($0)
    // {memory[35], memory[34], memory[33], memory[32]} <= 32'b10001100000010010000000000100000;            // lw $9, 32($0)
    // {memory[39], memory[38], memory[37], memory[36]} <= 32'b10001100000010100000000000100100;            // lw $10, 36($0)

    // {memory[43], memory[42], memory[41], memory[40]} <= 32'b00000000001000100000100000100000;            // add $1, $1, $2
    // {memory[47], memory[46], memory[45], memory[44]} <= 32'b00000000001000110000100000100000;            // add $1, $1, $3
    // {memory[51], memory[50], memory[49], memory[48]} <= 32'b00000000001001000000100000100000;            // add $1, $1, $4
    // {memory[55], memory[54], memory[53], memory[52]} <= 32'b00000000001001010000100000100000;            // add $1, $1, $5
    // {memory[59], memory[58], memory[57], memory[56]} <= 32'b00000000001001100000100000100000;            // add $1, $1, $6
    // {memory[63], memory[62], memory[61], memory[60]} <= 32'b00000000001001110000100000100000;            // add $1, $1, $7
    // {memory[67], memory[66], memory[65], memory[64]} <= 32'b00000000001010000000100000100000;            // add $1, $1, $8
    // {memory[71], memory[70], memory[69], memory[68]} <= 32'b00000000001010010000100000100000;            // add $1, $1, $9
    // {memory[75], memory[74], memory[73], memory[72]} <= 32'b00000000001010100000100000100000;            // add $1, $1, $10

    // {memory[79], memory[78], memory[77], memory[76]} <= 32'b10101100000000010000000000101000;            // sw $1, 40($0) 



    //------------------------------------------------------------------//
    //                                                                  //
    //                      Pipe Line Instructions                      //
    //                                                                  //
    //------------------------------------------------------------------//


    {memory[3], memory[2], memory[1], memory[0]} <= 32'b00000000000000000001000000100000;                //       add $2, $0, $0
    {memory[7], memory[6], memory[5], memory[4]} <= 32'b00000000000000000010000000100000;                //       add $4, $0, $0
    {memory[11], memory[10], memory[9], memory[8]} <= 32'b00000000000000000011000000100000;              //       add $6, $0, $0

    {memory[15], memory[14], memory[13], memory[12]} <= 32'b00010000001000100000000000000111;            // Loop: beq $1, $2, End
    {memory[19], memory[18], memory[17], memory[16]} <= 32'b00000000010000110001000000100000;            //       add $2, $2, $3
    {memory[23], memory[22], memory[21], memory[20]} <= 32'b10001100100001010000000000000000;            //       lw $5, 0($4) 
    {memory[27], memory[26], memory[25], memory[24]} <= 32'b00000000110001010011000000100000;            //       add $6, $6, $5
    {memory[31], memory[30], memory[29], memory[28]} <= 32'b00000000110000111111000000100000;            //       add $30, $6, $3
    {memory[35], memory[34], memory[33], memory[32]} <= 32'b00000000110000111111100000100000;            //       add $31, $6, $3
    
    {memory[39], memory[38], memory[37], memory[36]} <= 32'b00010000000000001111111111111001;            //       beq $0, $0, Loop
    {memory[43], memory[42], memory[41], memory[40]} <= 32'b00000000100001110010000000100000;            //       add $4, $4, $7
    {memory[47], memory[46], memory[45], memory[44]} <= 32'b10101100100001100000000000000000;            // End:  sw $6, 0($4)    

  end

  assign instruction = {memory[address+3], memory[address+2], memory[address+1], memory[address]};   
  
endmodule
