module ForwardingUnit_Test;

    reg EX_MEM_regWrite;
    reg MEM_WB_regWrite;
    reg [4:0] ID_EX_rt;
    reg [4:0] ID_EX_rs;
    reg [4:0] EX_MEM_rd;
    reg [4:0] MEM_WB_rd;

    wire [1:0] ForwardA;
    wire [1:0] ForwardB;

    ForwardingUnit uut (
        .EX_MEM_regWrite(EX_MEM_regWrite),
        .MEM_WB_regWrite(MEM_WB_regWrite),
        .ID_EX_rt(ID_EX_rt),
        .ID_EX_rs(ID_EX_rs),
        .EX_MEM_rd(EX_MEM_rd),
        .MEM_WB_rd(MEM_WB_rd),
        .ForwardA(ForwardA),
        .ForwardB(ForwardB)
    );

    initial begin
        EX_MEM_regWrite = 0;
        MEM_WB_regWrite = 0;
        ID_EX_rt = 5'b00000;
        ID_EX_rs = 5'b00000;
        EX_MEM_rd = 5'b00000;
        MEM_WB_rd = 5'b00000;

        #5;
        
        EX_MEM_regWrite = 0;
        MEM_WB_regWrite = 0;
        ID_EX_rt = 5'b00001;
        ID_EX_rs = 5'b00010;
        EX_MEM_rd = 5'b00011;
        MEM_WB_rd = 5'b00100;
        #5;

        EX_MEM_regWrite = 1;
        MEM_WB_regWrite = 0;
        ID_EX_rs = 5'b00011;
        EX_MEM_rd = 5'b00011;
        #5;

        EX_MEM_regWrite = 0;
        MEM_WB_regWrite = 1;
        MEM_WB_rd = 5'b00011;
        #5;

        EX_MEM_regWrite = 1;
        MEM_WB_regWrite = 0;
        ID_EX_rt = 5'b00011;
        EX_MEM_rd = 5'b00011;
        #5;

        EX_MEM_regWrite = 0;
        MEM_WB_regWrite = 1;
        MEM_WB_rd = 5'b00011;
        #5;

        EX_MEM_regWrite = 1;
        MEM_WB_regWrite = 0;
        ID_EX_rs = 5'b00011;
        ID_EX_rt = 5'b00011;
        EX_MEM_rd = 5'b00011;
        #5;

        EX_MEM_regWrite = 0;
        MEM_WB_regWrite = 1;
        MEM_WB_rd = 5'b00011;
        #5;

        EX_MEM_regWrite = 1;
        MEM_WB_regWrite = 1;
        EX_MEM_rd = 5'b00000;
        MEM_WB_rd = 5'b00000;
        ID_EX_rs = 5'b00011;
        ID_EX_rt = 5'b00011;
        #5;
        
        EX_MEM_regWrite = 1;
        MEM_WB_regWrite = 1;
        EX_MEM_rd = 5'b00011;
        MEM_WB_rd = 5'b00011;
        ID_EX_rs = 5'b00011;
        ID_EX_rt = 5'b00011;
        #5;
    end
endmodule
