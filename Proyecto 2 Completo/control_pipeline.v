
module control_pipeline(opcode, RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, 
Branch, ALUOperation, Jump, TipoInstr);
    input [4:0] opcode;
    output RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump ,TipoInstr;
    output [3:0] ALUOperation;
    reg    RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, Jump ,TipoInstr;
    reg    [3:0] ALUOperation;

    //Default = stall
	parameter ADD = 5'b00001;
	parameter XOR = 5'b00101;
	parameter CMP = 5'b01011;
	parameter MOVI = 5'b00011;
	parameter MOV = 5'b10010;
    parameter LW =  5'b01101;
    parameter SW =  5'b01111;
    parameter BEQ = 5'b01100;
	parameter ADDI = 5'b10011;

    always @(opcode)
    begin
        case (opcode)
          ADD :
          begin
              RegDst=1'b1; ALUSrc=1'b0; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; Branch=1'b0; ALUOperation = 4'b0001; Jump=1'b0; 
          end
		  ADDI :
          begin
              RegDst=1'b0; ALUSrc=1'b1; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; Branch=1'b0; ALUOperation = 4'b0001; Jump=1'b0; 
          end
		  
		  MOVI :
          begin
              RegDst=1'b0; ALUSrc=1'b1; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; Branch=1'b0; ALUOperation = 4'b1000; Jump=1'b0; 		
          end
		  
		  MOV:
          begin
              RegDst=1'b1; ALUSrc=1'b0; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; Branch=1'b0; ALUOperation = 4'b1000; Jump=1'b0; 		
          end
		  
		  
		  BEQ :
          begin
              RegDst=1'bx; ALUSrc=1'b0; MemtoReg=1'bx; RegWrite=1'b0; MemRead=1'b0;
              MemWrite=1'b0; Branch=1'b1; ALUOperation = 4'b0011; Jump=1'b0; 
          end 
		   XOR :
          begin
              RegDst=1'b1; ALUSrc=1'b0; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; Branch=1'b0; ALUOperation = 4'b0010; Jump=1'b0; 
          end
		  
          LW :
          begin
              RegDst=1'b0; ALUSrc=1'b1; MemtoReg=1'b1; RegWrite=1'b1; MemRead=1'b1;
              MemWrite=1'b0; Branch=1'b0; ALUOperation = 4'b0001; Jump=1'b0; 
          end
          SW :
          begin
              RegDst=1'bx; ALUSrc=1'b1; MemtoReg=1'bx; RegWrite=1'b0; MemRead=1'b0;
              MemWrite=1'b1; Branch=1'b0; ALUOperation = 4'b0001; Jump=1'b0; 
          end 
          
          default
          begin
              $display("control_single unimplemented opcode %d", opcode);
              RegDst=1'b0; ALUSrc=1'b0; MemtoReg=1'b0; RegWrite=1'b0; MemRead=1'b0;
              MemWrite=1'b0; Branch=1'b0; ALUOperation = 4'b0000; Jump=1'b0; 
          end
        endcase
    end
endmodule
