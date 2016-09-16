// Background image display

module background
	(
		CLOCK_50,						//	On Board 25 MHz
		CLOCK_25,
		CLOCK_10,
		switch,
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,	  						//	VGA Blue[9:0]
		led
	);
	
	
//	input [17:17]LEDR
	
	
	

	input	CLOCK_50;				//	50 MHz
	input CLOCK_25;				//25 MHz
	input CLOCK_10;
	input switch;
//	input [31:0] MEM_memout;
	//input	[0:0] KEY;				//	Button[0:0]
	//input PLOT; //Indica a la memoria que escriba va a ser KEY1
	//input [2:0] COLOUR; //Indica el color
	//input [5:0] X;
	//wire write_data;
	output	VGA_CLK;   				//	VGA Clock
	output	VGA_HS;					//	VGA H_SYNC
	output	VGA_VS;					//	VGA V_SYNC
	output	VGA_BLANK;				//	VGA BLANK
	output	VGA_SYNC;				//	VGA SYNC
	output	[9:0] VGA_R;   			//	VGA Red[9:0]
	output	[9:0] VGA_G;	 		//	VGA Green[9:0]
	output	[9:0] VGA_B;   			//	VGA Blue[9:0]
	//wire memread_tipo_instr, memwrite_tipo_instr;
//	wire [31:0] memdirection_tipo_instr, memaluout_tipo_instr;
	output wire led;
	
	
	wire [31:0] vga_datain;
	wire resetn, gnd;
	assign resetn = 1'b1;
	assign gnd = 1'b0;
	
	// Create the color, x, y and writeEn wires that are inputs to the controller.

	wire [2:0] color;
	wire [7:0] x;  //Esto representa la coordenada x
	wire [6:0] y; //Esto representa la coordenada y
	wire image_on;
	wire text_on;
	wire [9:0] x_coordinate;
	wire [8:0] y_coordinate;
	
	reg [16:0] write_direction;
	reg [16:0] direction_counter;

	 //Valor inicial de la coordenada x
	assign y = 2'b01; //Valor inicial de la coordenada y
	assign color = 3'b110; //Color del pixel a pintarse
	
	wire[31:0] colourVGA;
	wire [16:0] vga_read_address;
	
	wire vcc;
	
	assign vcc = 1'b1;
	
	
	//Signal micro declarations
	wire memread_tipo_instr, memwrite_tipo_instr;
	wire [31:0] memdirection_tipo_instr, memaluout_tipo_instr;
	wire [31:0]MEM_memout;
	
	//Instancia el procesador
	mips_pipeline procesador(
					.clk(CLOCK_25), .reset(1'b0), .memread_tipo_instr(memread_tipo_instr), 
					.memwrite_tipo_instr(memwrite_tipo_instr), 
					.memdirection_tipo_instr(memdirection_tipo_instr), 
					.memaluout_tipo_instr(memaluout_tipo_instr), .MEM_memout(MEM_memout));
					
	assign led = memread_tipo_instr;				
	/* Create video memory. */
//	altsyncram	VideoMemory (
//				.wren_a (memwrite_tipo_instr), //Esto aqui lo comente para que no escriba en la memoria de momento
//				.wren_b (gnd),
//				.clock0 (CLOCK_50), // write clock
//				.clock1 (CLOCK_25), // read clock
//				.clocken0 (vcc), // write enable clock
//				.clocken1 (vcc), // read enable clock				
//				.address_a (memdirection_tipo_instr), //aQUI VA LA DIRECCION DE WRITE DEL PROCESADOR
//				.address_b (vga_read_address[16:2]), //Este es el puerto que usa VGA
//				.data_a (memaluout_tipo_instr), // data in del procesador
//				.q_a(MEM_memout), //PUERTO CPU
//				.q_b (colourVGA)	// data out
//				);
//	defparam
//		VideoMemory.WIDTH_A = 32,//((MONOCHROME == "FALSE") ? (BITS_PER_COLOUR_CHANNEL*3) : 1), //Ancho del dato
//		VideoMemory.WIDTH_B = 32, //Ancho del dato 
//		VideoMemory.INTENDED_DEVICE_FAMILY = "Cyclone IV GX",
//		VideoMemory.OPERATION_MODE = "DUAL_PORT", 
//		VideoMemory.WIDTHAD_A = 17, //Este es el ancho de la direccion de lectura
//		VideoMemory.NUMWORDS_A = 76800, //Es el numero de palabras de la memoria
//		VideoMemory.WIDTHAD_B = 17, //Este es ancho de la direccion de escritura
//		VideoMemory.NUMWORDS_B = 76800, //Este es el numero de palabras de memoria
//		VideoMemory.OUTDATA_REG_A = "CLOCK1", 
//		VideoMemory.ADDRESS_REG_A = "CLOCK1",
//		VideoMemory.OUTDATA_REG_B = "CLOCK1", 
//		VideoMemory.ADDRESS_REG_B = "CLOCK1",
//		VideoMemory.CLOCK_ENABLE_INPUT_A = "NORMAL",
//		VideoMemory.CLOCK_ENABLE_INPUT_B = "NORMAL",
//		VideoMemory.CLOCK_ENABLE_OUTPUT_A = "NORMAL",
//		VideoMemory.CLOCK_ENABLE_OUTPUT_B = "NORMAL",
//		VideoMemory.POWER_UP_UNINITIALIZED = "FALSE",
//		VideoMemory.INIT_FILE = "prueba2.mif";

altsyncram	altsyncram_component (
				.address_a (memdirection_tipo_instr),
				.address_b (vga_read_address[16:2]),
				.clock0 (CLOCK_50),
				.clock1 (CLOCK_25),
				.data_a (memaluout_tipo_instr),
				.wren_a (memwrite_tipo_instr),
				.wren_b (gnd),
				.q_a (MEM_memout), //dato que escribe el procesador
				.q_b (colourVGA), //data vga que lee
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
				.byteena_a (1'b1),
				.byteena_b (1'b1),
				.clocken0 (1'b1), 
				.clocken1 (1'b1),
				.clocken2 (1'b1),
				.clocken3 (1'b1),
				.eccstatus (),
				.rden_a (memread_tipo_instr), //aqui se le pone memread_tipo_instr para que sirva el LOAD
				.rden_b (1'b1));
	defparam
		altsyncram_component.address_reg_b = "CLOCK1",
		altsyncram_component.clock_enable_input_a = "BYPASS",
		altsyncram_component.clock_enable_input_b = "BYPASS",
		altsyncram_component.clock_enable_output_a = "BYPASS",
		altsyncram_component.clock_enable_output_b = "BYPASS",
		altsyncram_component.indata_reg_b = "CLOCK1",
		altsyncram_component.init_file = "../prueba3.mif",
		altsyncram_component.init_file_layout = "PORT_A",
		altsyncram_component.intended_device_family = "Cyclone IV GX",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.numwords_a = 32768,
		altsyncram_component.numwords_b = 32768,
		altsyncram_component.operation_mode = "BIDIR_DUAL_PORT",
		altsyncram_component.outdata_aclr_a = "NONE",
		altsyncram_component.outdata_aclr_b = "NONE",
		altsyncram_component.outdata_reg_a = "CLOCK0",
		altsyncram_component.outdata_reg_b = "CLOCK1",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.read_during_write_mode_port_a = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.read_during_write_mode_port_b = "NEW_DATA_NO_NBE_READ",
		altsyncram_component.widthad_a = 15,
		altsyncram_component.widthad_b = 15,
		altsyncram_component.width_a = 32,
		altsyncram_component.width_b = 32,
		altsyncram_component.width_byteena_a = 1,
		altsyncram_component.width_byteena_b = 1,
		altsyncram_component.wrcontrol_wraddress_reg_b = "CLOCK1";
	
	// Create an Instance of a VGA controller - "There can be only one!"
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.clock25(CLOCK_25),
			.clock10(CLOCK_10),
			.colourVGA(colourVGA),
			.x(X),
			.y(y),
			.plot(write_data), //Le indica a la memoria que escriba el pixel
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK),
			.VGA_SYNC(VGA_SYNC),
			.VGA_CLK(VGA_CLK),
			.x_coordinate(x_coordinate),
			.y_coordinate(y_coordinate),
			.image_on(image_on),
			.write_coordinate(write_direction),
			.vga_read_address(vga_read_address),
			.read_address(vga_read_address));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 3;
		defparam VGA.BACKGROUND_IMAGE = "prueba3.mif";
		
//		
//	reg[50:0] count;
//	reg clk2;
//	
//	//Esto de aqui se encarga de realizar el divisor de frecuencia
//  always @(posedge CLOCK_50)
//  begin
//   if(count == 51'd1_000_000)
//    begin
//     count<= 0;
//     clk2 <= ~clk2;
//    end
//   else
//    begin
//     count <= count + 1;
//    end
//  end	
//		
//	always @(posedge CLOCK_50 && write_data==1'b1 )
//	begin
//		if(write_direction < 16'hafc8) begin
//			write_direction <= write_direction + 1;
//		end
//	end
//	
//	initial begin
//		write_direction <= 16'h57e4;
//	end
		  
		
endmodule