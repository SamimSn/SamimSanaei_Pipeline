module Main(
  input wire clk,
  input wire startin,
  input wire [4:0] regNo,
  output wire [31:0] val
);       

    wire [31:0] PcIn;
    wire [31:0] PcOut;
    wire [31:0] PcResult;
    wire [31:0] instruction; 
    wire RegDst;
    wire AluSrc;
    wire MemToReg;
    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire Branch;
    wire [1:0] AluOp;
    wire Jump;
    wire [31:0] SignExtended;
    wire [4:0] WriteRegister;
    wire [31:0] data1;
    wire [31:0] data2;
    wire [31:0] RegWriteData;
    wire [31:0] AluIn;
    wire [3:0] AluControlOp;
    wire [31:0] AluResult;
    wire zero;
    wire [31:0] memory_read_data;
    wire [27:0] JumpAddr;
    wire [31:0] ShiftToLeft;
    wire [31:0] PcBranch;    
    wire [31:0] next_addrees;    

    PC PCInstance (
        .clk(clk),
        .startin(startin),
        .in(PcIn),
        .out(PcOut),
        .write(1'b1)
    );    

    Add AddInstance1 (
        .digit1(PcOut),
        .digit2(32'd4),
        .result(PcResult)
    ); 
        
    Instructionmemory InstructionmemoryInstance (
        .address(PcOut),
        .instruction(instruction),
        .startin(startin)
    );
                                        
    Control ControlInstance (
        .OpCode(instruction[31:26]),
        .RegDst(RegDst),
        .AluSrc(AluSrc),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .AluOp(AluOp),
        .Jump(Jump)
    );
        
    SignExtend SignExtendInstance (
        .in(instruction[15:0]),
        .result(SignExtended)
    );
        
    Mux5 Mux5Instance (
        .input1(instruction[20:16]), // rt 
        .input2(instruction[15:11]), // rd
        .op(RegDst),
        .out(WriteRegister)
    );
                
    RegisterFile RegisterFileInstance (
        .read1(instruction[25:21]),  // rs
        .read2(instruction[20:16]),  // rt
        .write_reg(WriteRegister),
        .reg_write(RegWrite),
        .write_data(RegWriteData),
        .startin(startin),
        .reg_no(regNo),
        .clk(clk),
        .data1(data1),
        .data2(data2),        
        .val(val)
    );
        
    Mux32 Mux32Instance1 ( // alu input 2
        .input1(data2), 
        .input2(SignExtended),
        .op(AluSrc),
        .out(AluIn)
    );
        
    ALUControl ALUControlInstance (
        .func(instruction[5:0]),
        .op(AluOp),
        .control(AluControlOp)
    );
            
    ALU ALUInstance (
        .in1(data1),  
        .in2(AluIn), 
        .operation(AluControlOp),
        .out(AluResult),
        .zero(zero)
    );
        
    DataMemory DataMemoryInstance (
        .address(AluResult),
        .write_data(data2),
        .mem_write(MemWrite),
        .mem_read(MemRead),
        .clk(clk),
        .startin(startin),
        .read_data(memory_read_data)
    );

    Mux32 Mux32Instance2 (  // write back
        .input1(AluResult),
        .input2(memory_read_data),
        .op(MemToReg),
        .out(RegWriteData)
    );
    
    Shift26_28 Shift26_28Instance (  // jump
        .in(instruction[25:0]),
        .out(JumpAddr)
    );
        
    Shiftleft2 Shiftleft2Instance (  // immediad shift to left
        .in(SignExtended),
        .out(ShiftToLeft)
    );
    
    Add AddInstance2 (  
        .digit1(PcResult),
        .digit2(ShiftToLeft),
        .result(PcBranch)
    );        
        
    Mux32 Mux32Instance3 ( // pc = ((pc+4) vs (pc+4 + 4*imm))
        .input1(PcResult),
        .input2(PcBranch),
        .op(Branch && zero),
        .out(next_addrees)
    );
        
    Mux32 Mux32Instance4 (  // pc vs pc_jump
        .input1(next_addrees),
        .input2({PcResult[31:28], JumpAddr}),
        .op(Jump),
        .out(PcIn)
    );       

endmodule