module ALU(input [31:0] in1, input [31:0] in2, input [3:0] operation, output reg [31:0] out);
  always @(*)
  begin
    if(operation == 'b0000)
    begin
      out <= in1 & in2;
    end
    else if(operation == 'b0001)
    begin
      out <= in1 | in2;
    end
    else if(operation == 'b0010)
    begin
      out <= in1 + in2;
    end
    else if(operation == 'b0110)
    begin
      out <= in1 - in2;
    end
    else if(operation == 'b0111)
    begin
      out <= in1 < in2;
    end
    else if(operation == 'b1100)
    begin
      out <= ~(in1 | in2);
    end
  end

endmodule

// module ALU(input [31:0] in1, input [31:0] in2, input [3:0] operation, output reg [31:0] out, output zero);
//   always @(*)
//   begin
//     if(operation == 'b0000)
//     begin
//       out <= in1 & in2;
//     end
//     else if(operation == 'b0001)
//     begin
//       out <= in1 | in2;
//     end
//     else if(operation == 'b0010)
//     begin
//       out <= in1 + in2;
//     end
//     else if(operation == 'b0110)
//     begin
//       out <= in1 - in2;
//     end
//     else if(operation == 'b0111)
//     begin
//       out <= in1 < in2;
//     end
//     else if(operation == 'b1100)
//     begin
//       out <= ~(in1 | in2);
//     end
//   end

//   assign zero = out == 0 ? 1: 0;
// endmodule