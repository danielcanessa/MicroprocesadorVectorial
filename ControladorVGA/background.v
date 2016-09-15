// Background image display

module background
	(
		CLOCK_50,						//	On Board 25 MHz
		CLOCK_25,
	//	KEY,							//	Push Button[0:0]
	//	PLOT, //boton que indica a la memoria que escriba el pixel
	//	COLOUR, //Me lo dan los switches
	//	X, //Coordenada X
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,	  						//	VGA Blue[9:0]
		VGA_DATAIN,
		write_data,
		led
	);

	input	CLOCK_50;				//	50 MHz
	input CLOCK_25;				//25 MHz
	//input	[0:0] KEY;				//	Button[0:0]
	//input PLOT; //Indica a la memoria que escriba va a ser KEY1
	//input [2:0] COLOUR; //Indica el color
	//input [5:0] X;
	input [31:0] VGA_DATAIN;
	input write_data;
	output	VGA_CLK;   				//	VGA Clock
	output	VGA_HS;					//	VGA H_SYNC
	output	VGA_VS;					//	VGA V_SYNC
	output	VGA_BLANK;				//	VGA BLANK
	output	VGA_SYNC;				//	VGA SYNC
	output	[9:0] VGA_R;   			//	VGA Red[9:0]
	output	[9:0] VGA_G;	 		//	VGA Green[9:0]
	output	[9:0] VGA_B;   			//	VGA Blue[9:0]
	output wire led;
	
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

	assign led = write_data; //Valor inicial de la coordenada x
	assign y = 2'b01; //Valor inicial de la coordenada y
	assign color = 3'b110; //Color del pixel a pintarse
	
	// Create an Instance of a VGA controller - "There can be only one!"
	// Define the number of colours as well as the initial background
	// image file (.MIF) for the controller.
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.clock25(CLOCK_25),
			.colour(32'hffffffff),
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
			.write_coordinate(write_direction));
		defparam VGA.RESOLUTION = "160x120";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 3;
		defparam VGA.BACKGROUND_IMAGE = "prueba.mif";
		
		
	reg[50:0] count;
	reg clk2;
	
	//Esto de aqui se encarga de realizar el divisor de frecuencia
  always @(posedge CLOCK_50)
  begin
   if(count == 51'd1_000_000)
    begin
     count<= 0;
     clk2 <= ~clk2;
    end
   else
    begin
     count <= count + 1;
    end
  end	
		
	always @(posedge CLOCK_50 && write_data==1'b1 )
	begin
		if(write_direction < 16'hafc8) begin
			write_direction <= write_direction + 1;
		end
	end
	
	initial begin
		write_direction <= 16'h57e4;
	end
		  
		
endmodule