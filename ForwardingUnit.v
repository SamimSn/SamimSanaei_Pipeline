module ForwardingUnit (
    input wire EX_MEM_regWrite,
    input wire MEM_WB_regWrite,
    input wire [4:0] ID_EX_rt,
    input wire [4:0] ID_EX_rs,
    input wire [4:0] EX_MEM_rd,
    input wire [4:0] MEM_WB_rd,
    output reg [1:0] ForwardA,
    output reg [1:0] ForwardB
);

always @(*) begin    
    ForwardA <= 2'b00;
    ForwardB <= 2'b00;
    
    if (EX_MEM_regWrite && (EX_MEM_rd != 5'b0) && (EX_MEM_rd == ID_EX_rs)) begin
        ForwardA <= 2'b10;
    end else if (MEM_WB_regWrite && (MEM_WB_rd != 5'b0) && (MEM_WB_rd == ID_EX_rs)) begin
        ForwardA <= 2'b01;
    end
    
    if (EX_MEM_regWrite && (EX_MEM_rd != 5'b0) && (EX_MEM_rd == ID_EX_rt)) begin
        ForwardB <= 2'b10;
    end else if (MEM_WB_regWrite && (MEM_WB_rd != 5'b0) && (MEM_WB_rd == ID_EX_rt)) begin
        ForwardB <= 2'b01;
    end
end

endmodule

//    If ((EX/MEM.RegWrite) && (EX/MEM.rd == ID/EX.rs) && (EX/MEM.rd != 0)):   [ForwardA = 10]
//    If ((MEM/WB.RegWrite) && (MEM/WB.rd == ID/EX.rs) && (MEM/WB.rd != 0)):   [ForwardA = 01]
//    If ((EX/MEM.RegWrite) && (EX/MEM.rd == ID/EX.rt) && (EX/MEM.rd != 0)):   [ForwardB = 10]
//    If ((MEM/WB.RegWrite) && (MEM/WB.rd == ID/EX.rt) && (MEM/WB.rd != 0)):   [ForwardB = 01]
// 
//    default:
//        ForwardingA = 00
//        ForwardingB = 00
