
module alu(ctl, a, b, result, zero);
  input [3:0] ctl;
  input [31:0] a, b;
  output [31:0] result;
  output zero;

  reg [31:0] result;
  reg zero;

  always @(a or b or ctl)
  begin
    case (ctl)
      4'b0001 : result = a + b; // ADD
	  4'b0010 : result = a ^ b; // XOR
	  4'b0011 : result = a - b; // SUB - BEQ
	  4'b1000 : result = b;     // MOV	      
      default : result = 32'd0;
   endcase
   if (result == 32'd0) zero = 1;
   else zero = 0;
 end
endmodule

