`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:08:07 08/29/2016
// Design Name:   mips_pipeline
// Module Name:   D:/Proyectos Xilins/Pipeline_Arqui/simulation.v
// Project Name:  Pipeline_Arqui
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mips_pipeline
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module simulation;

	// Inputs
	reg clk;
	reg reset;

	// Instantiate the Unit Under Test (UUT)
	mips_pipeline uut (
		.clk(clk), 
		.reset(reset)
	);
	
 
	initial begin 
		// Initialize Inputs
		clk = 0;
		reset = 0;

		// Wait 100 ns for global reset to finish
		#10;
		reset = 1;
		#10;
		reset = 0;
        
		// Add stimulus here

	end
	 always
    #5 clk = ~clk;
      
endmodule

