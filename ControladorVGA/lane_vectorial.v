//*** Vector Processor Lane Definition ***//
module lane_vectorial (clock, reset, op, imm16, shamt, data_out,
vector_Vd, vector_Vs, vector_Vt);

// Parameters
parameter index = 0;
parameter width = 8;

// Module IOs
input clock;
input reset;
input [3:0] op;
input [11:0] shamt;
input [15:0] imm16;
input [31:0] vector_Vd;
input [31:0] vector_Vt;
input [31:0] vector_Vs;
output [7:0] data_out;

//Guarda el resultado de la operacion
reg [7:0] result;
reg [7:0] res;

//assign imm8 = imm16[7:0];

//En esta parte realiza las operaciones a los elementos del vector
always @(op)
  begin
   
    case (op) 
      4'b0001 : result = vector_Vs[((width*(index+1))-1): (width*index)] + 
						vector_Vt[((width*(index+1))-1): (width*index)]; // ADD.v
						
	  4'b0010 : result = vector_Vs[((width*(index+1))-1): (width*index)] ^ //XOR vector inmediato
						imm16[7:0]; 
	  4'b0011 : result = vector_Vt[((width*(index+1))-1): (width*index)];     // MOV.V
	  
	  4'b0100 : result = vector_Vs[((width*(index+1))-1): (width*index)] - 
						vector_Vt[((width*(index+1))-1): (width*index)]; // SUB.v
	
	  4'b0101 : result = vector_Vs[((width*(index+1))-1): (width*index)] << shamt ;     // LSL.V	
	  
	  4'b0110 : result = vector_Vs[((width*(index+1))-1): (width*index)] >> shamt ;     // LSR.V
	  
	  4'b0111 : 
	   begin
		res = vector_Vs[((width*(index+1))-1): (width*index)];     // ROR.V
			case (shamt)
				12'd1 : result = {res[0],res[7:1]};
				12'd2 : result = {res[2-1:0],res[7:2]};
				12'd3 : result = {res[3-1:0],res[7:3]};
				12'd4 : result = {res[4-1:0],res[7:4]};
				12'd5 : result = {res[5-1:0],res[7:5]};
				12'd6 : result = {res[6-1:0],res[7:6]};
				12'd7 : result = {res[7-1:0],res[7]};
				default: result = res;
			endcase
		end
		
		4'b1000 : 
	   begin
		res = vector_Vs[((width*(index+1))-1): (width*index)];     // ROL.V
			case (shamt)
				12'd7 : result = {res[0],res[7:1]};
				12'd6 : result = {res[2-1:0],res[7:2]};
				12'd5 : result = {res[3-1:0],res[7:3]};
				12'd4 : result = {res[4-1:0],res[7:4]};
				12'd3 : result = {res[5-1:0],res[7:5]};
				12'd2 : result = {res[6-1:0],res[7:6]};
				12'd1 : result = {res[7-1:0],res[7]};
				default: result = res;
			endcase
		end

      default : result = 8'd0;
   endcase
 end



//Aqui agrega señales para escribir en memoria y ademas retorna la salida//
assign data_out = result; //Hay que agregar esto
						

endmodule // Vector_Lane Module