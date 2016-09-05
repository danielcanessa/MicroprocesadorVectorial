//-----------------------------------------------------------------------------
// Title         : ALU Behavioral Model
// Project       : ECE 313 - Computer Organization
//-----------------------------------------------------------------------------
// File          : alu.v
// Author        : John Nestor  <nestorj@lafayette.edu>
// Organization  : Lafayette College
// 
// Created       : October 2002
// Last modified : 7 January 2005
//-----------------------------------------------------------------------------
// Description :
//   Behavioral model of the ALU used in the implementations of the MIPS processor
//   subset described in Ch. 5-6 of "Computer Organization and Design, 3rd ed."
//   by David Patterson & John Hennessey, Morgan Kaufmann, 2004 (COD3e).  
//
//   It implements the function specified on p. 301 of COD3e.
//
//-----------------------------------------------------------------------------

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
	  4'b1000 : result = b;     // MOVI	      
      default : result = 32'd0;
   endcase
   if (result == 32'd0) zero = 1;
   else zero = 0;
 end
endmodule

