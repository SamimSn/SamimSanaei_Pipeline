module Main_Pipeline(
  input wire clk,
  input wire startin,
  input wire [4:0] regNo,
  output wire [31:0] val
);       


    //------------------------------------------------------------------//
    //                                                                  //
    //                             WIRES                                //
    //                                                                  //
    //------------------------------------------------------------------//



    // IF -------------------------------------------------------------------------------------------------------------
    wire IF_PCWrite;
    // assign IF_PCWrite = 1;
    wire [31:0] IF_PcIn;
    wire [31:0] IF_PcOut;
    wire [31:0] IF_PcResult;
    wire [31:0] IF_instruction; 
    // IF_ID -------------------------------------------------------------------------------------------------------------
    wire IF_ID_Write; 
    // assign IF_ID_Write = 1;
    wire [31:0] IF_ID_instruction_output;
    wire [31:0] IF_ID_pc_plus_4_output;
    // ID -------------------------------------------------------------------------------------------------------------
    wire ID_RegDst;
    wire ID_AluSrc;
    wire ID_MemToReg;
    wire ID_RegWrite;
    wire ID_MemRead;
    wire ID_MemWrite;
    wire ID_Branch;
    wire [1:0] ID_AluOp;
    wire ID_Jump;
    wire [31:0] ID_data1;
    wire [31:0] ID_data2;
    wire ID_comparator_out;
    wire [31:0] ID_PcBranch;
    wire [31:0] ID_SignExtended;
    wire [31:0] ID_ShiftToLeft;
    wire ID_controlSelect;
    wire [9:0] ID_control_mux_input;
    assign ID_control_mux_input = {ID_Jump, ID_AluOp, ID_Branch, ID_MemWrite, ID_MemRead, ID_RegWrite, ID_MemToReg, ID_AluSrc, ID_RegDst};    
        // [0] -> ID_RegDst
        // [1] -> ID_AluSrc
        // [2] -> ID_MemToReg
        // [3] -> ID_RegWrite
        // [4] -> ID_MemRead
        // [5] -> ID_MemWrite
        // [6] -> ID_Branch
        // [8:7] -> ID_AluOp
        // [9] -> ID_Jump  
    wire [9:0] ID_control_mux_output;              
    // ID_EX -------------------------------------------------------------------------------------------------------------     
    wire [14:0] ID_EX_instruction_output;    
    wire [31:0] ID_EX_sign_extend_out; 
    wire [31:0] ID_EX_read_data_1_output; 
    wire [31:0] ID_EX_read_data_2_output;
    wire [1:0] ID_EX_WB_output;
        // [0]: memToReg 
        // [1]: regWrite        
    wire [1:0] ID_EX_MEM_output;  
        // [0]: memRead 
        // [1]: memWrite        
    wire [3:0] ID_EX_EX_output;
        // [0]: regDst 
        // [1]: ALUsrc
        // [2:3]: ALUop
    // EX -------------------------------------------------------------------------------------------------------------
    wire [1:0] EX_forwardA;
    wire [1:0] EX_forwardB;   
    wire [31:0] EX_mux1_output;
    wire [31:0] EX_mux2_output;
    wire [31:0] EX_mux3_output;
    wire [4:0] EX_mux4_output;
    wire [3:0] EX_alu_control;
    wire [31:0] EX_alu_output;
    // EX_MEM -------------------------------------------------------------------------------------------------------------
    wire [31:0] EX_MEM_alu_result_output;
    wire [31:0] EX_MEM_read_data_2_output;
    wire [4:0] EX_MEM_write_register_output;  
    wire [1:0] EX_MEM_WB_output;
    wire [1:0] EX_MEM_MEM_output;
    // MEM -------------------------------------------------------------------------------------------------------------
    wire [31:0] MEM_readData;
    // MEM_WB -------------------------------------------------------------------------------------------------------------
    wire [31:0] MEM_WB_read_data_output;
    wire [31:0] MEM_WB_alu_result_output;
    wire [4:0] MEM_WB_write_register_output;
    wire [1:0] MEM_WB_WB_output;
        // [0]: memToReg 
        // [1]: regWrite
    // WB -------------------------------------------------------------------------------------------------------------
    wire [31:0] WB_output;




    //------------------------------------------------------------------//
    //                                                                  //
    //                           Connections                            //
    //                                                                  //
    //------------------------------------------------------------------//





    /////////////////////////////////////////////////////////////////////////////////////////////////////////
    ////// IF ///////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////

    PC IF_1 (
        .clk(clk),
        .startin(startin),
        .in(IF_PcIn),
        .write(IF_PCWrite),
        .out(IF_PcOut) // output
    );    

    Add IF_2 (
        .digit1(IF_PcOut),
        .digit2(32'd4),
        .result(IF_PcResult) // output
    ); 

    Instructionmemory IF_3 (
        .address(IF_PcOut),
        .startin(startin),
        .instruction(IF_instruction) // output
    );

    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ////// IF_ID //////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////// 

    IF_ID IF_ID_1 (
        .instruction_input(IF_instruction),
        .pc_plus_4_input(IF_PcResult),
        .write(IF_ID_Write),
        .startin(startin),
        .clock(clk),
        .instruction_output(IF_ID_instruction_output), // output
        .pc_plus_4_output(IF_ID_pc_plus_4_output) // output
    );

    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////// ID //////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////            

    Control ID_1 (
        .OpCode(IF_ID_instruction_output[31:26]),
        .RegDst(ID_RegDst), // output
        .AluSrc(ID_AluSrc), // output
        .MemToReg(ID_MemToReg), // output
        .RegWrite(ID_RegWrite), // output
        .MemRead(ID_MemRead), // output
        .MemWrite(ID_MemWrite), // output
        .Branch(ID_Branch), // output
        .AluOp(ID_AluOp), // output
        .Jump(ID_Jump) // output
    );
    

    HazardDetectionUnit ID_2 (
        .ID_EX_memRead(ID_EX_MEM_output[0]),
        .ID_EX_rt(ID_EX_instruction_output[9:5]),
        .IF_ID_rs(IF_ID_instruction_output[25:21]),
        .IF_ID_rt(IF_ID_instruction_output[20:16]),
        .PCWrite(IF_PCWrite), // output
        .IF_IDWrite(IF_ID_Write), // output
        .control_select(ID_controlSelect) // output
    );

    Mux10 ID_3 (
        .input1(ID_control_mux_input),
        .input2(10'b0),
        .op(ID_controlSelect),
        .out(ID_control_mux_output) // output
    );
        
    SignExtend ID_4 (
        .in(IF_ID_instruction_output[15:0]),
        .result(ID_SignExtended) // output
    );

    Shiftleft2 ID_5 (
        .in(ID_SignExtended),
        .out(ID_ShiftToLeft) // output
    );

    RegisterFile ID_6 (
        .read1(IF_ID_instruction_output[25:21]),
        .read2(IF_ID_instruction_output[20:16]),
        .write_reg(MEM_WB_write_register_output),
        .reg_write(MEM_WB_WB_output[1]),
        .write_data(WB_output),
        .startin(startin),
        .reg_no(regNo),
        .clk(clk),
        .data1(ID_data1), // output
        .data2(ID_data2), // output
        .val(val)
    );

    Comparator ID_7 (
        .input1(ID_data1),
        .input2(ID_data2),
        .out(ID_comparator_out) // output
    );    

    Add ID_8 (  
        .digit1(IF_ID_pc_plus_4_output),
        .digit2(ID_ShiftToLeft),
        .result(ID_PcBranch) // output
    );   

    Mux32 ID_9 (
        .input1(IF_PcResult),
        .input2(ID_PcBranch),
        .op(ID_comparator_out && ID_Branch),
        .out(IF_PcIn) // output
    );


    ///////////////////////////////////////////////////////////////////////////////////////////////////////
    ////// ID_EX //////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////// 


    ID_EX ID_EX_1 (
        .instruction_input(IF_ID_instruction_output[25:11]),
        .sign_extend_in(ID_SignExtended),
        .read_data_1_input(ID_data1), 
        .read_data_2_input(ID_data2),
        .WB_input(ID_control_mux_output[3:2]),
        .MEM_input(ID_control_mux_output[5:4]),
        .EX_input({ID_control_mux_output[8:7], ID_control_mux_output[1], ID_control_mux_output[0]}),
        .startin(startin),
        .clock(clk),
        .instruction_output(ID_EX_instruction_output),
        .sign_extend_out(ID_EX_sign_extend_out), 
        .read_data_1_output(ID_EX_read_data_1_output), // output
        .read_data_2_output(ID_EX_read_data_2_output), // output
        .WB_output(ID_EX_WB_output), // output
        .MEM_output(ID_EX_MEM_output), // output
        .EX_output(ID_EX_EX_output) // output
    );



    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////// EX //////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////

    ForwardingUnit EX_1 (
        .EX_MEM_regWrite(EX_MEM_WB_output[1]),
        .MEM_WB_regWrite(MEM_WB_WB_output[1]),
        .ID_EX_rt(ID_EX_instruction_output[9:5]),
        .ID_EX_rs(ID_EX_instruction_output[14:10]),
        .EX_MEM_rd(EX_MEM_write_register_output),
        .MEM_WB_rd(MEM_WB_write_register_output),
        .ForwardA(EX_forwardA), // output
        .ForwardB(EX_forwardB) // output
    );

    Mux32_3In EX_2 (
        .input1(ID_EX_read_data_1_output),
        .input2(MEM_WB_read_data_output),
        .input3(EX_MEM_alu_result_output),
        .op(EX_forwardA),
        .out(EX_mux1_output) // output
    );

    Mux32_3In EX_3 (
        .input1(ID_EX_read_data_2_output),
        .input2(MEM_WB_read_data_output),
        .input3(EX_MEM_alu_result_output),
        .op(EX_forwardB),
        .out(EX_mux2_output) // output
    );

    Mux32 EX_4 (
        .input1(EX_mux2_output),
        .input2(ID_EX_sign_extend_out),
        .op(ID_EX_EX_output[1]),
        .out(EX_mux3_output) // output
    );


    Mux5 EX_5 (
        .input1(ID_EX_instruction_output[9:5]),
        .input2(ID_EX_instruction_output[4:0]),
        .op(ID_EX_EX_output[0]),
        .out(EX_mux4_output) // output
    );

    ALUControl EX_6 (
        .func(ID_EX_sign_extend_out[5:0]),
        .op(ID_EX_EX_output[3:2]), 
        .control(EX_alu_control) // output
    );

    ALU EX_7 (
        .in1(EX_mux1_output),
        .in2(EX_mux3_output),
        .operation(EX_alu_control),
        .out(EX_alu_output) // output
    );


    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////// EX_MEM //////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////


    
    EX_MEM EX_MEM (
        .alu_result_input(EX_alu_output),
        .read_data_2_input(EX_mux2_output),
        .write_register_input(EX_mux4_output),
        .WB_input(ID_EX_WB_output),
        .MEM_input(ID_EX_MEM_output),
        .startin(startin),
        .clock(clk),
        .alu_result_output(EX_MEM_alu_result_output), // output
        .read_data_2_output(EX_MEM_read_data_2_output), // output
        .write_register_output(EX_MEM_write_register_output), // output
        .WB_output(EX_MEM_WB_output), // output
        .MEM_output(EX_MEM_MEM_output) // output
    );


    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////// MEM /////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////


    DataMemory MEM_1 (
        .address(EX_MEM_alu_result_output),
        .write_data(EX_MEM_read_data_2_output),
        .mem_write(EX_MEM_MEM_output[1]),
        .mem_read(EX_MEM_MEM_output[0]),
        .clk(clk),
        .startin(startin),
        .read_data(MEM_readData) // output
    );



    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////// MEM_WB //////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////


    MEM_WB MEM_WB_1 (
        .read_data_input(MEM_readData), 
        .alu_result_input(EX_MEM_alu_result_output),
        .write_register_input(EX_MEM_write_register_output),
        .WB_input(EX_MEM_WB_output),
        .startin(startin),
        .clock(clk),
        .read_data_output(MEM_WB_read_data_output), // output
        .alu_result_output(MEM_WB_alu_result_output), // output
        .write_register_output(MEM_WB_write_register_output), // output
        .WB_output(MEM_WB_WB_output) // output
    );



    ////////////////////////////////////////////////////////////////////////////////////////////////////
    ////// WB //////////////////////////////////////////////////////////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////////

    Mux32 WB_1 (
        .input1(MEM_WB_alu_result_output),
        .input2(MEM_WB_read_data_output),
        .op(MEM_WB_WB_output[0]),
        .out(WB_output) // output
    );


endmodule