`timescale 1ns / 1ps

module Test_RegisterFile;
    
    reg [4:0] Read1, Read2, WriteReg, regNo;
    reg [31:0] WriteData, startin;
    reg RegWrite, clk;
    wire [31:0] Data1, Data2, val;    
    
    Test_RegisterFile uut (
        .clk(clk),        
        .read1(Read1),
        .read2(Read2),
        .write_reg(WriteReg),
        .reg_write(RegWrite),
        .write_data(WriteData),
        .startin(startin),
        .reg_no(regNo),
        .data1(Data1),
        .data2(Data2),
        .val(val)
    );
    
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        RegWrite = 0;
        startin = 0;

        WriteReg = 5'b00001;
        WriteData = 32'hA5A5A5A5;

	WriteReg = 5'b00010;
        WriteData = 32'hA5A5A5A6;

        RegWrite = 1;
        #10;
        RegWrite = 0;

        Read1 = 5'b00001;
	Read2 = 5'b00010;
        #10;        

        regNo = 5'b00001;
        #10;   
    end
endmodule
