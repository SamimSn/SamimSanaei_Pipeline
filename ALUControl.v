module ALUControl(
  input [5:0] func,
  input [1:0] op, 
  output reg [3:0] control
);

always @(*) begin
    case (op)
        2'b00: control = 4'b0010; 
        2'b01: control = 4'b0110; 
        2'b10: begin 
            case (func)
                6'b100000: control = 4'b0010;
                6'b100010: control = 4'b0110;
                6'b100100: control = 4'b0000;
                6'b100101: control = 4'b0001;
                6'b101010: control = 4'b0111;
                default: control = 4'bx;
            endcase
        end
        default: control = 4'bx;
    endcase
end

endmodule