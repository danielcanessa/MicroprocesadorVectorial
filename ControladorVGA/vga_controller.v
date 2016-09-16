/* This module implements the VGA controller. It assumes a 25MHz clock is supplied as input.
 *
 * General approach:
 * Go through each line of the screen and read the colour each pixel on that line should have from
 * the Video memory. To do that for each (x,y) pixel on the screen convert (x,y) coordinate to
 * a memory_address at which the pixel colour is stored in Video memory. Once the pixel colour is
 * read from video memory its brightness is first increased before it is forwarded to the VGA DAC.
 */
module vga_controller(	vga_clock, resetn, pixel_colour, memory_address, 
		VGA_R, VGA_G, VGA_B,
		VGA_HS, VGA_VS, VGA_BLANK,
		VGA_SYNC, VGA_CLK, x_coordinate, y_coordinate, image_on);
	
	/* Screen resolution and colour depth parameters. */
	
	parameter BITS_PER_COLOUR_CHANNEL = 1;
	/* The number of bits per colour channel used to represent the colour of each pixel. A value
	 * of 1 means that Red, Green and Blue colour channels will use 1 bit each to represent the intensity
	 * of the respective colour channel. For BITS_PER_COLOUR_CHANNEL=1, the adapter can display 8 colours.
	 * In general, the adapter is able to use 2^(3*BITS_PER_COLOUR_CHANNEL) colours. The number of colours is
	 * limited by the screen resolution and the amount of on-chip memory available on the target device.
	 */	
	
	parameter MONOCHROME = "FALSE";
	/* Set this parameter to "TRUE" if you only wish to use black and white colours. Doing so will reduce
	 * the amount of memory you will use by a factor of 3. */
	
	parameter RESOLUTION = "320x240";
	/* Set this parameter to "160x120" or "320x240". It will cause the VGA adapter to draw each dot on
	 * the screen by using a block of 4x4 pixels ("160x120" resolution) or 2x2 pixels ("320x240" resolution).
	 * It effectively reduces the screen resolution to an integer fraction of 640x480. It was necessary
	 * to reduce the resolution for the Video Memory to fit within the on-chip memory limits.
	 */
	
	//--- Timing parameters.
	/* Recall that the VGA specification requires a few more rows and columns are drawn
	 * when refreshing the screen than are actually present on the screen. This is necessary to
	 * generate the vertical and the horizontal syncronization signals. If you wish to use a
	 * display mode other than 640x480 you will need to modify the parameters below as well
	 * as change the frequency of the clock driving the monitor (VGA_CLK).
	 */
	parameter C_VERT_NUM_PIXELS  = 10'd480;
	parameter C_VERT_SYNC_START  = 10'd493;
	parameter C_VERT_SYNC_END    = 10'd494; //(C_VERT_SYNC_START + 2 - 1); 
	parameter C_VERT_TOTAL_COUNT = 10'd525;

	parameter C_HORZ_NUM_PIXELS  = 10'd640;
	parameter C_HORZ_SYNC_START  = 10'd659;
	parameter C_HORZ_SYNC_END    = 10'd754; //(C_HORZ_SYNC_START + 96 - 1); 
	parameter C_HORZ_TOTAL_COUNT = 10'd800;	
		
	/*****************************************************************************/
	/* Declare inputs and outputs.                                               */
	/*****************************************************************************/
	
	input vga_clock, resetn;
//	input [((MONOCHROME == "TRUE") ? (0) : (BITS_PER_COLOUR_CHANNEL*3-1)):0] pixel_colour; La comente
//	output [((RESOLUTION == "320x240") ? (16) : (14)):0] memory_address; //Esta la comente
	input [7:0] pixel_colour;
	output [16:0] memory_address;
	output reg [9:0] VGA_R;
	output reg [9:0] VGA_G;
	output reg [9:0] VGA_B;
	output reg VGA_HS;
	output reg VGA_VS;
	output reg VGA_BLANK;
	output VGA_SYNC, VGA_CLK;
	output reg [9:0] x_coordinate;
	output reg [8:0] y_coordinate;
	output image_on;
	
	/*****************************************************************************/
	/* Local Signals.                                                            */
	/*****************************************************************************/
	
	reg VGA_HS1;
	reg VGA_VS1;
	reg VGA_BLANK1; 
	reg [9:0] xCounter, yCounter;
	wire xCounter_clear;
	wire yCounter_clear;
	wire vcc;
	wire [2:0] Colour;
	
//	reg [((RESOLUTION == "320x240") ? (8) : (7)):0] x; la comente
//	reg [((RESOLUTION == "320x240") ? (7) : (6)):0] y;	la comente
	reg [9:0] x; 
	reg [8:0] y;	
	/* Inputs to the converter. */
	
	
	
	/*****************************************************************************/
	/* Controller implementation.                                                */
	/*****************************************************************************/

	assign vcc =1'b1;
	
	/* A counter to scan through a horizontal line. */
	always @(posedge vga_clock or negedge resetn)
	begin
		if (!resetn)
			xCounter <= 10'd0;
		else if (xCounter_clear)
			xCounter <= 10'd0;
		else
		begin
			xCounter <= xCounter + 1'b1;
		end
	end
	assign xCounter_clear = (xCounter == (C_HORZ_TOTAL_COUNT-1));

	/* A counter to scan vertically, indicating the row currently being drawn. */
	always @(posedge vga_clock or negedge resetn)
	begin
		if (!resetn)
			yCounter <= 10'd0;
		else if (xCounter_clear && yCounter_clear)
			yCounter <= 10'd0;
		else if (xCounter_clear)		//Increment when x counter resets
			yCounter <= yCounter + 1'b1;
	end
	assign yCounter_clear = (yCounter == (C_VERT_TOTAL_COUNT-1)); 
	
	/* Convert the xCounter/yCounter location from screen pixels (640x480) to our
	 * local dots (320x240 or 160x120). Here we effectively divide x/y coordinate by 2 or 4,
	 * depending on the resolution. */
	always @(*)
	begin
			x = xCounter;
			y = yCounter;
			x_coordinate = x;
			y_coordinate = y;
	end  //Esto lo comente
	
	/* Change the (x,y) coordinate into a memory address. */
	vga_address_translator controller_translator(
					.x(x), .y(y), .mem_address(memory_address) , .colour(Colour) , 
					.image_on(image_on), .clock25(vga_clock) );
		defparam controller_translator.RESOLUTION = RESOLUTION;


	/* Generate the vertical and horizontal synchronization pulses. */
	always @(posedge vga_clock)
	begin
		//- Sync Generator (ACTIVE LOW)
		VGA_HS1 <= ~((xCounter >= C_HORZ_SYNC_START) && (xCounter <= C_HORZ_SYNC_END));
		VGA_VS1 <= ~((yCounter >= C_VERT_SYNC_START) && (yCounter <= C_VERT_SYNC_END));
		
		//- Current X and Y is valid pixel range
		VGA_BLANK1 <= ((xCounter < C_HORZ_NUM_PIXELS) && (yCounter < C_VERT_NUM_PIXELS));	
	
		//- Add 1 cycle delay
		VGA_HS <= VGA_HS1;
		VGA_VS <= VGA_VS1;
		VGA_BLANK <= VGA_BLANK1;	
	end
	
	/* VGA sync should be 1 at all times. */
	assign VGA_SYNC = vcc;
	
	/* Generate the VGA clock signal. */
	assign VGA_CLK = vga_clock;
	
	/* Brighten the colour output. */
	// The colour input is first processed to brighten the image a little. Setting the top
	// bits to correspond to the R,G,B colour makes the image a bit dull. To brighten the image,
	// each bit of the colour is replicated through the 10 DAC colour input bits. For example,
	// when BITS_PER_COLOUR_CHANNEL is 2 and the red component is set to 2'b10, then the
	// VGA_R input to the DAC will be set to 10'b1010101010.
	
	integer index;
	integer sub_index;
	
	always @(pixel_colour)
	begin		
		VGA_R <= 'b0;
		VGA_G <= 'b0;
		VGA_B <= 'b0;
		
	//	VGA_R[8] <= pixel_colour[7];
		VGA_R[7] <= pixel_colour[7];
		VGA_R[6] <= pixel_colour[6];
		VGA_R[5] <= pixel_colour[5];
		VGA_R[4] <= pixel_colour[4];
		VGA_R[3] <= pixel_colour[3];
		VGA_R[2] <= pixel_colour[2];
		VGA_R[1] <= pixel_colour[1];
		VGA_R[0] <= pixel_colour[0];
		
	//	VGA_G[8] <= pixel_colour[4];
		VGA_G[7] <= pixel_colour[7];
		VGA_G[6] <= pixel_colour[6];
		VGA_G[5] <= pixel_colour[5];
		VGA_G[4] <= pixel_colour[4];
		VGA_G[3] <= pixel_colour[3];
		VGA_G[2] <= pixel_colour[2];
		VGA_G[1] <= pixel_colour[1];
		VGA_G[0] <= pixel_colour[0];
		
		
		//VGA_B[8] <= pixel_colour[1];
		VGA_B[7] <= pixel_colour[7];
		VGA_B[6] <= pixel_colour[6];
		VGA_B[5] <= pixel_colour[5];
		VGA_B[4] <= pixel_colour[4];
		VGA_B[3] <= pixel_colour[3];
		VGA_B[2] <= pixel_colour[2];
		VGA_B[1] <= pixel_colour[1];
		VGA_B[0] <= pixel_colour[0];
		
	end

endmodule