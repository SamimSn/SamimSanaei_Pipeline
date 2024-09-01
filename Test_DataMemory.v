`timescale 1ns / 1ps

module Test_DataMemory;
    
    reg clk, memwrite, memread;
    reg [31:0] addr, writedata, startin;

    wire [31:0] readdata;

    DataMemory uut (
        .clk(clk),
        .mem_write(memwrite),
        .mem_read(memread),
        .address(addr),
        .write_data(writedata),
        .read_data(readdata),
        .startin(startin)
    );

    initial begin        
        clk = 0;
        memwrite = 0;
        memread = 0;
        addr = 0;
        writedata = 0;
        startin = 0;
                
        forever #5 clk = ~clk;
    end

    initial begin        
        #10;
        memwrite = 1; addr = 32'h00000004; writedata = 32'hDEADBEEF; #10;
        memwrite = 0; memread = 1; addr = 32'h00000004; #10;
                
        memwrite = 1; addr = 32'h00000008; writedata = 32'hBEEFDEAD; #10;
        memwrite = 0; memread = 1; addr = 32'h00000008; #10;        
    end
endmodule
