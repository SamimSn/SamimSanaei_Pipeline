module HazardDetectionUnit (
    input wire ID_EX_memRead,
    input wire [4:0] ID_EX_rt,
    input wire [4:0] IF_ID_rs,
    input wire [4:0] IF_ID_rt,
    output reg PCWrite,
    output reg IF_IDWrite,
    output reg control_select
);

always @(*) begin
    PCWrite <= 1;
    IF_IDWrite <= 1;
    control_select <= 0;
    
    if ((ID_EX_memRead) && (ID_EX_rt != 0) && ((ID_EX_rt == IF_ID_rs) || (ID_EX_rt == IF_ID_rt))) begin        
        PCWrite <= 0;
        IF_IDWrite <= 0;
        control_select <= 1;
    end
end

endmodule


//  If ((ID/EX.MemRead) && (ID/EX.rt != 0) && ((ID/EX.rt == IF/ID.rs) || (ID/EX.rt == IF/ID.rt))): 
// 	    [PCWrite = 0]
// 	    [IF/IDWrite = 0] 
// 	    [MemWrite = 0]
// 	    [RegWrite = 0]

