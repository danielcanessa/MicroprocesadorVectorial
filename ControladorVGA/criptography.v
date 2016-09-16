/* This module converts a user specified coordinates into a memory address.
 * The output of the module depends on the resolution set by the user.
 */
module criptography(data_memory, vga_datain, memory_address, dataTransfer, writeData);

	input [31:0] data_memory;
	input dataTransfer;
	output [31:0] vga_datain; 
	output reg[16:0] memory_address;
	output reg writeData;
	reg[16:0] contador_direccion;
	
	always @(*)
	begin
		
//		if(dataTransfer == 1'b1) begin
//			writeData = 1'b1;
//		end
//		else
//		begin
//			writeData = 1'b0;
//		end
		if(dataTransfer == 1'b1) begin
			memory_address = contador_direccion;
			contador_direccion = contador_direccion + 1;
			writeData = 1'b1;
		end
		else begin
			writeData = 1'b0;
		end
//		//contador_direccion = contador_direccion + 1;
	end
	
	assign vga_datain = data_memory;
//	assign write_data = (dataTransfer && contador_direccion < 16'h41eb) ? 1'b1 : 1'b0;
	
	/* The basic formula is address = y*WIDTH + x;
	 * For 320x240 resolution we can write 320 as (256 + 64). Memory address becomes
	 * (y*256) + (y*64) + x;
	 * This simplifies multiplication a simple shift and add operation.
	 * A leading 0 bit is added to each operand to ensure that they are treated as unsigned
	 * inputs. By default the use a '+' operator will generate a signed adder.
	 * Similarly, for 160x120 resolution we write 160 as 128+32.
	 */
	
//	always @(*)
//	begin
//		vga_datain = data_memory
//	end
//	
//	
//	
//
//reg [1:0] cont;
//
//always @(*)
//	begin 
//		if(cont == 3'd0) begin
//			cont <= 3'd1;
//			VGA_value = data_mem[7:0];
//		end
//		else if (cont == 3'd1) begin
//			cont <= 3'd2;
//			VGA_value = data_mem[15:8];
//		end
//		else if (cont == 3'd2) begin
//			cont <= 3'd3;
//			VGA_value = data_mem[23:16];
//		end
//		
//		else if(cont == 3'd3) begin
//			cont <= 3'd0;
//			VGA_value = data_mem[31:24];
//		end
//	end
	
endmodule