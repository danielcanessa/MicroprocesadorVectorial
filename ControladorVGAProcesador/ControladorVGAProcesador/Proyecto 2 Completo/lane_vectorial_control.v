//-----------------------------------------------------------------------------

module lane_vectorial_control(RegisterCode, RegisterVector);
    input [4:0] RegisterCode;
    output [3:0] RegisterVector; //Contiene el numero de registro vectorial al que accede
    reg    [3:0] RegisterVector; //Guarda el registro vectorial


    always @(RegisterCode)
    begin 
        case (RegisterCode) 
            5'b10000 : RegisterVector = 4'b0000; //Registro #16 = Registro Vectorial 0
            5'b10001 : RegisterVector = 4'b0001; //Registro #17 = Registro Vectorial 1
				5'b10010 : RegisterVector = 4'b0010; //Registro #18 = Registro Vectorial 2
				5'b10011 : RegisterVector = 4'b0011; //Registro #19 = Registro Vectorial 3
				5'b10100 : RegisterVector = 4'b0100; //Registro #20 = Registro Vectorial 4
				5'b10101 : RegisterVector = 4'b0101; //Registro #21 = Registro Vectorial 5
				5'b10110 : RegisterVector = 4'b0110; //Registro #22 = Registro Vectorial 6
				5'b10111 : RegisterVector = 4'b0111; //Registro #23 = Registro Vectorial 7
				5'b11000 : RegisterVector = 4'b1000; //Registro #24 = Registro Vectorial 8
				5'b11001 : RegisterVector = 4'b1001; //Registro #25 = Registro Vectorial 9
				5'b11010 : RegisterVector = 4'b1010; //Registro #26 = Registro Vectorial 10
				5'b11011 : RegisterVector = 4'b1011; //Registro #27 = Registro Vectorial 11
				5'b11100 : RegisterVector = 4'b1100; //Registro #28 = Registro Vectorial 12
				5'b11101 : RegisterVector = 4'b1101; //Registro #29 = Registro Vectorial 13
				5'b11110 : RegisterVector = 4'b1110; //Registro #30 = Registro Vectorial 14
				5'b11111 : RegisterVector = 4'b1111; //Registro #31 = Registro Vectorial 15
          
            default RegisterVector = 4'bxxxx;
        endcase
    end
endmodule