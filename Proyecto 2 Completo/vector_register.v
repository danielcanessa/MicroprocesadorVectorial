module vector_register(clock,indexVd, indexVs, indexVt, update_register, update_enable, 
registerSource1, registerSource2,registerDestination);
  input [3:0] indexVd;
  input [3:0] indexVs;
  input [3:0] indexVt;
  input clock;
  input update_enable;
  input [31:0] update_register;
  output [31:0] registerSource1;
  output [31:0] registerSource2;
  output [31:0] registerDestination;

  reg [31:0] VECREG [15:0]; // vector register file
  reg [31:0] registerVd;
  reg [31:0] registerVs;
  reg [31:0] registerVt;
 
  always @(*)
  begin
	 if (update_enable) begin	
		VECREG[indexVd] <= update_register;
		$display("Contenido Registros Vectoriales \n");
		$display("Registro Vectorial 0: %h",VECREG[0]);
		$display("Registro Vectorial 1: %h",VECREG[1]);
		$display("Registro Vectorial 2: %h",VECREG[2]);
		$display("Registro Vectorial 3: %h",VECREG[3]);
		$display("Registro Vectorial 4: %h",VECREG[4]);
		$display("Registro Vectorial 5: %h",VECREG[5]);
		$display("Registro Vectorial 6: %h",VECREG[6]);
		$display("Registro Vectorial 7: %h",VECREG[7]);
		$display("Registro Vectorial 8: %h",VECREG[8]);
		$display("Registro Vectorial 9: %h",VECREG[9]);
		$display("Registro Vectorial 10: %h",VECREG[10]);
		$display("Registro Vectorial 11: %h",VECREG[11]);
		$display("Registro Vectorial 12: %h",VECREG[12]);
		$display("Registro Vectorial 13: %h",VECREG[13]);
		$display("Registro Vectorial 14: %h",VECREG[14]);
		$display("Registro Vectorial 15: %h",VECREG[15]);
		
	 end
	 registerVs <= VECREG[indexVs];
	 registerVt <= VECREG[indexVt];
	 registerVd <= VECREG[indexVd];
  end
  
  assign registerDestination = registerVd;
  assign registerSource1 = registerVs;
  assign registerSource2 = registerVt;
  
  integer i;
  initial begin
  for (i=0; i<16; i=i+1) VECREG[i] = 0;
    //  VECREG[0] = 32'b00000000000000010000001000000011;
	 // VECREG[1] = 32'b00000100000001010000011000000111;
	// VECREG[2] = 32'b00000100000001010000011000000111;
  end
  
endmodule
