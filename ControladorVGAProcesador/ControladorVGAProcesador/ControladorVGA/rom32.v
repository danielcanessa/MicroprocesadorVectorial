
module rom32(address, data_out);
  input  [31:0] address;
  output [31:0] data_out;
  reg    [31:0] data_out;

  parameter BASE_ADDRESS = 25'd0; // address that applies to this memory

  wire [6:0] mem_offset;
  wire address_select;

  assign mem_offset = address[7:2];  // drop 2 LSBs to get word offset

  assign address_select = (address[31:8] == BASE_ADDRESS);  // address decoding

  always @(address_select or mem_offset)

  begin
    if ((address % 4) != 0) $display($time, " rom32 error: unaligned address %d", address);
    if (address_select == 1)
    begin
      case (mem_offset)		
			6'd0  : data_out = {32'b00011000000000100000000000001010};            //movi r1, #10
			6'd1  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd2  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd3  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd4  : data_out = {32'b10010000010000100101000000000000};            //mov r5, r1
			6'd5  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd6  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd7  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd8  : data_out = {32'b00001000010010100110000000000000};            //add r6, r1, r5
			6'd9  : data_out = {32'b01111000010000000000000000000000};            //store r1, r0
			6'd10  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd11  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd12  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd13  : data_out = {32'b01101000000001000000000000000000};            //load r2, r0
			6'd14  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd15  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd16  : data_out = {32'b01110000001000000000000000000000};            //load.v v0, r0 
			6'd17  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd18  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd19  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd20  : data_out = {32'b10000000101000000000000000000000};            //store.v v0, r2
			6'd21  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd22  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd23  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd24  : data_out = {32'b00010100001000010101000000000000};            //add.v v5, v0, v0
			6'd25  : data_out = {32'b00100100001000010111000000000000};            //mov.v v7, v0
			6'd26  : data_out = {32'b10011001010010000000000000011110};            //addi r4, r5, #30
			6'd27  : data_out = {32'b00101001010011000011000000000000};            //xor r3, r5, r6
			6'd28  : data_out = {32'b00110100001001000000000000010100};            //xor.v v2, v0, #20
			6'd29  : data_out = {32'b10001101011011111110000000000000};            //sub.v v14, v5, v7
			6'd30  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd31  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd32  : data_out = {32'b01001100100000010110000000000010};            //lsl.v v6, v2, #2
			6'd33  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd34  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd35  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd36  : data_out = {32'b01010101100000011001000000000010};            //lsr.v v9, v6, #2
			6'd37  : data_out = {32'b00111100100000011010000000000011};            //ror.v v10, v2, #3
			6'd38  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd39  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd40  : data_out = {32'b00000000000000000000000000000000};            //nop
			6'd41  : data_out = {32'b01000110100000011011000000000011};            //rol.v v11, v10, #3
			
          default data_out = 32'h0000;
      endcase

      $display($time, " reading data: rom32[%h] => %h", address, data_out);

    end
  end
endmodule



