////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:47:04 09/21/2015
// Design Name:   mainTicTacToe
// Module Name:   C:/Users/Felipe/Desktop/Tec/ProyectosXilinx/ProyectoCorto1/mainTicTacToe_test.v
// Project Name:  ProyectoCorto1
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mainTicTacToe
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module procesador_vectorial_test;


	// Inputs
	reg clock;
	reg reset;
	reg [4:0] ID_VS;
	reg [4:0] ID_VT;
	reg [4:0] ID_VD;
	reg [11:0] ID_SHAMT;
	reg [4:0] ID_OP;
	reg [15:0] ID_IMM16;
	reg [31:0] register_mov_data;
	reg [31:0] data_memory_direction;
	reg [31:0] data_load_mem;

	// Outputs


	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clock(clock), 
		.reset(reset), 
		.ID_VS(ID_VS), 
		.ID_VT(ID_VT), 
		.ID_VD(ID_VD), 
		.ID_SHAMT(ID_SHAMT), 
		.ID_OP(ID_OP), 
		.ID_IMM16(ID_IMM16), 
		.register_mov_data(register_mov_data), 
		.data_memory_direction(data_memory_direction),  
		.data_load_mem(data_load_mem)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		reset = 0;
//		ID_VS = 5'b10000;
//		ID_VT = 5'b10001;
//		ID_VD = 5'b10000;
//		ID_SHAMT = 12'b0;
//		ID_OP = 5'b00100;
//		ID_IMM16 = 16'b0;
//		register_mov_data = 32'b011;
//		data_memory_direction = 32'b0;
//		data_load_mem = 32'b0;

		// Wait 100 ns for global reset to finish
		#10;
		
		// Initialize Inputs Aqui hago un MOV de 011 en el registro vectorial 0
		ID_VS = 5'b10000;
		ID_VT = 5'b10001;
		ID_VD = 5'b10000;
		ID_SHAMT = 12'b0;
		ID_OP = 5'b00100;
		ID_IMM16 = 16'b0;
		register_mov_data = 32'b00000000000000010000001000000011;
		data_memory_direction = 32'b0;
		data_load_mem = 32'b0;

		// Wait 100 ns for global reset to finish
		#10;
		
		#10;
		
		// Initialize Inputs Aqui hago un MOV de 110 en el registro vectorial 1
		ID_VS = 5'b10000;
		ID_VT = 5'b10001;
		ID_VD = 5'b10001;
		ID_SHAMT = 12'b0;
		ID_OP = 5'b00100;
		ID_IMM16 = 16'b0;
		register_mov_data = 32'b00000100000001010000011000000111;
		data_memory_direction = 32'b0;
		data_load_mem = 32'b0;

		// Wait 100 ns for global reset to finish
		#10;
		
		#10;
		
		//Aqui voy a hacer un MOV de 101 en el registro vectorial 2
		ID_VS = 5'b10000;
		ID_VT = 5'b10001;
		ID_VD = 5'b10010;
		ID_SHAMT = 12'b0;
		ID_OP = 5'b00100;
		ID_IMM16 = 16'b0;
		register_mov_data = 32'b101;
		data_memory_direction = 32'b0;
		data_load_mem = 32'b0;

		// Wait 100 ns for global reset to finish
		#10;
		
		// Initialize Inputs
		//Aqui voy a hacer un ADD de V0 Y V1 y lo voy a guardar en el registro vectorial 4
		ID_VS = 5'b10000;
		ID_VT = 5'b10001;
		ID_VD = 5'b10100;
		ID_SHAMT = 12'b0;
		ID_OP = 5'b00010;
		ID_IMM16 = 16'b0;
		register_mov_data = 32'b101;
		data_memory_direction = 32'b0;
		data_load_mem = 32'b0;

		// Wait 100 ns for global reset to finish
		#10;
		
		//Aqui voy a hacer un MOV de 101 en el registro vectorial 5
		ID_VS = 5'b10000;
		ID_VT = 5'b10001;
		ID_VD = 5'b10101;
		ID_SHAMT = 12'b0;
		ID_OP = 5'b00100;
		ID_IMM16 = 16'b0;
		register_mov_data = 32'b111;
		data_memory_direction = 32'b0;
		data_load_mem = 32'b0;

		// Wait 100 ns for global reset to finish
		#10;

		// Wait 100 ns for global reset to finish
		#10;
        
		// Add stimulus here

	end
	
	always 
		 #10 clock = ~clock;
      
endmodule
