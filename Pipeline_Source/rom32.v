//    A simple 32-bit by 32-word read-only memory model
//    ECE 313 Fall 2002


//  11/21/02 - modified to access up to 64 words JN

module rom32(address, data_out);
  input  [31:0] address;
  output [31:0] data_out;
  reg    [31:0] data_out;

  parameter BASE_ADDRESS = 25'd0; // address that applies to this memory

  wire [5:0] mem_offset;
  wire address_select;

  assign mem_offset = address[7:2];  // drop 2 LSBs to get word offset

  assign address_select = (address[31:8] == BASE_ADDRESS);  // address decoding

  always @(address_select or mem_offset)

  begin
    if ((address % 4) != 0) $display($time, " rom32 error: unaligned address %d", address);
    if (address_select == 1)
    begin
      case (mem_offset)
5'd0  : data_out = {32'b00011000000001000000000000001010};            //movi r2, #10
5'd1  : data_out = {32'b00000000000000000000000000000000};            //nop
5'd2  : data_out = {32'b00000000000000000000000000000000};            //nop
5'd3  : data_out = {32'b00000000000000000000000000000000};            //nop
5'd4  : data_out = {32'b00000000000000000000000000000000};            //nop
5'd5  : data_out = {32'b10010000100001000011000000000000};            //mov r3, r2
			//5'd0  : data_out = {32'b10011000100000100000000000000101};            //addi r1, r2, #5
			//5'd0  : data_out = {32'b00001000010001000011000000000000};            // add r1,r2,r3			            
			//5'd1  : data_out = {32'b00011000000010000000000000001100};            // mov r4, #12
			/*5'd0  : data_out = {32'b00011000000000100000000000001000};            //movi r1, #8
			5'd1  : data_out = {32'b00000000000000000000000000000000};            //nop
			5'd2  : data_out = {32'b00000000000000000000000000000000};            //nop
			5'd3  : data_out = {32'b00011000000010000000000000000100};            //movi r4, #4
			5'd4  : data_out = {32'b00000000000000000000000000000000};            //nop
			5'd5  : data_out = {32'b00000000000000000000000000000000};            //nop
			5'd6  : data_out = {32'b00000000000000000000000000000000};            //nop
			5'd7  : data_out = {32'b00000000000000000000000000000000};            //nop
			5'd8  : data_out = {32'b01111000010010000000000000000000};            //store r4, r1
			5'd9  : data_out = {32'b01101000010001000000000000000000};            //load r1, r2
			5'd10  : data_out = {32'b00000000000000000000000000000000};            //nop
			5'd11 : data_out = {32'b00000000000000000000000000000000};            //nop
			5'd12  : data_out = {32'b00000000000000000000000000000000};            //nop
			5'd13  : data_out = {32'b00000000000000000000000000000000};            //nop
			5'd14  : data_out =  {32'b10010000100001100000000000000000};              //mov r3, r2*/
			//5'd0  : data_out = {32'b00011000000000100000000000000101};            //movi r1, #5
			//5'd1  : data_out = {32'b00000000000000000000000000000000};            //nop
		//	5'd2  : data_out = {32'b00000000000000000000000000000000};            //nop
		//	5'd3  : data_out = {32'b00000000000000000000000000000000};            //nop
		//	5'd4  : data_out = {32'b00000000000000000000000000000000};            //nop
		

		//5'd0  : data_out = {32'b10010000100000100000000000000000};            //mov r2, r1
			
			//5'd1  : data_out = {32'b00011000000000100000000000001010};    
			 
			
//          5'd1  : data_out = {32'h00631020}; // add $2, $2, $2   r2 = 2
//          5'd2  : data_out = {32'h00621024};                         // jump to instruction 6
//          5'd3  : data_out = {32'h00431025}; // add $2, $2, $2   r2 = 4 (should be skipped)
//          5'd4  : data_out = 0;                                     // These are here just so our jump is more
//          5'd5  : data_out = {32'h00621022};                                     // visible
//          5'd6  : data_out = {32'h00631820};
//          5'd7  : data_out = {6'd0, 5'd2, 5'd2, 5'd2, 5'd0, 6'd32}; // add $2, $2, $2   r2 = 4
//          5'd8  : data_out = {6'd0, 5'd2, 5'd2, 5'd2, 5'd0, 6'd32}; // add $2, $2, $2   r2 = 8 */
          default data_out = 32'hxxxx;
      endcase

      $display($time, " reading data: rom32[%h] => %h", address, data_out);

    end
  end
endmodule



