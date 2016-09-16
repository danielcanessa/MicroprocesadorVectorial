module muxVGA( sel, address, data, vga_data );

    input[16:0] sel;
	 input [1:0] address;
    input  [31:0] data;
    output reg [7:0] vga_data;
	 
	 always @(posedge sel)
    begin
        case (address)
          2'b00:
          begin
              vga_data =  data[7:0];
		//		 vga_data =  8'hFF;
          end
		  2'b01:
          begin
              vga_data =  data[15:8];
		//		  vga_data =  8'h00;
          end
		  
		  2'b10:
          begin
              vga_data =  data[23:16];
			//	   vga_data =  8'hFF;
          end
		  
		  2'b11:
          begin
              vga_data =  data[31:24];
			//	   vga_data =  8'h00;
          end 
          
//          default
//          begin
//              vga_data =  8'h00;
//          end
        endcase
    end

endmodule
