/* This module converts a user specified coordinates into a memory address.
 * The output of the module depends on the resolution set by the user.
 */
module vga_address_translator(x, y, mem_address,colour,image_on, clock25);

	parameter RESOLUTION = "320x240";
	/* Set this parameter to "160x120" or "320x240". It will cause the VGA adapter to draw each dot on
	 * the screen by using a block of 4x4 pixels ("160x120" resolution) or 2x2 pixels ("320x240" resolution).
	 * It effectively reduces the screen resolution to an integer fraction of 640x480. It was necessary
	 * to reduce the resolution for the Video Memory to fit within the on-chip memory limits.
	 */
/*
	input [((RESOLUTION == "320x240") ? (8) : (7)):0] x; 
	input [((RESOLUTION == "320x240") ? (7) : (6)):0] y;	
	output reg [((RESOLUTION == "320x240") ? (16) : (14)):0] mem_address; Esto tambien lo comente*/ 
	
	input [9:0] x; 
	input [8:0] y;	
	input clock25;
	output reg [16:0] mem_address; 
	output reg [2:0] colour;
	output reg image_on;
	
	
	reg [15:0] contador;
	
	/* The basic formula is address = y*WIDTH + x;
	 * For 320x240 resolution we can write 320 as (256 + 64). Memory address becomes
	 * (y*256) + (y*64) + x;
	 * This simplifies multiplication a simple shift and add operation.
	 * A leading 0 bit is added to each operand to ensure that they are treated as unsigned
	 * inputs. By default the use a '+' operator will generate a signed adder.
	 * Similarly, for 160x120 resolution we write 160 as 128+32.
	 */
	
	always @(posedge clock25)
	begin
		if ( (y >= 8'd200) && (y <= 9'd349)) begin
			if(x >= 6'd50 && x <= 8'd199)begin
				mem_address = (x- 6'd50) + (y - 8'd200)*8'd150;
				colour = 3'b110;
				image_on = 1'b1;
			end
			else if ( (x >= 8'b11111010) && (x <= 9'b110001111)) begin
				mem_address = ((16'h57e4 + (x- 8'hfa)) + (y - 8'b11001000)*8'b10010110);
				colour = 3'b010;
				image_on = 1'b1;
			end
			else if ((x >= 9'b111000010) && (x <= 10'b1001010111)) begin
				mem_address = ((16'hafc8 + (x- 12'h1c2)) + (y - 8'b11001000)*8'b10010110);
				colour = 3'b011;
				image_on = 1'b1;
			end
			else begin
				mem_address = 17'h107ac; //Esto se le pone para que apunte a un lugar en memoria donde lo que hay es ceros
				colour = 3'b000;
				image_on = 1'b0;
			end
		end
		else begin
			mem_address = 17'h107ac;
			colour = 3'b000;
			image_on = 1'b0;
		end
	end
endmodule