module control_pipeline_vectorial(opcode, RegDst, MemtoReg, RegWrite, MemRead, MemWrite, 
ALUOperation, TipoInstr);
    input [4:0] opcode;
    output reg RegDst, MemtoReg, RegWrite, MemRead, MemWrite, TipoInstr;
    output reg [3:0] ALUOperation;
   

    //Default = stall
	parameter ADDV = 5'b00010;
	parameter XORIV = 5'b00110;
	parameter MOVV = 5'b00100;
	parameter LSLV = 5'b01001;
	parameter LSRV = 5'b01010;
    parameter SUBV = 5'b10001;
    parameter LOADV = 5'b01110;
    parameter STOREV = 5'b10000;
	parameter RORV = 5'b00111;
	parameter ROLV = 5'b01000;

    always @(opcode)
    begin
        case (opcode)
          ADDV :
          begin
              RegDst=1'b1; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; ALUOperation = 4'b0001; TipoInstr = 1'b1;
          end
		  
		  SUBV :
          begin
              RegDst=1'b1; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; ALUOperation = 4'b0100; TipoInstr = 1'b1;
          end
		  
		   XORIV :
          begin
              RegDst=1'b0; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; ALUOperation = 4'b0010; TipoInstr = 1'b1;
          end
		  
		  LOADV :
          begin
              RegDst=1'b0; MemtoReg=1'b1; RegWrite=1'b1; MemRead=1'b1;
              MemWrite=1'b0; ALUOperation = 4'b0000; TipoInstr = 1'b1;
          end
		  
		  STOREV :
          begin
              RegDst=1'b0; MemtoReg=1'b0; RegWrite=1'b0; MemRead=1'b0;
              MemWrite=1'b1; ALUOperation = 4'b0000; TipoInstr = 1'b1;
          end
		  
		  MOVV:
          begin
              RegDst=1'b1; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; ALUOperation = 4'b0011; TipoInstr = 1'b1;	
          end
		  
		   LSLV :
          begin
             RegDst=1'b1; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; ALUOperation = 4'b0101; TipoInstr = 1'b1;
          end 
		  
		  LSRV :
          begin
             RegDst=1'b1; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; ALUOperation = 4'b0110; TipoInstr = 1'b1;
          end 
		  
		  RORV :
          begin
             RegDst=1'b1; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; ALUOperation = 4'b0111; TipoInstr = 1'b1;
          end 
		  
		  ROLV :
          begin
             RegDst=1'b1; MemtoReg=1'b0; RegWrite=1'b1; MemRead=1'b0;
              MemWrite=1'b0; ALUOperation = 4'b1000; TipoInstr = 1'b1;
          end 
		  
          default
          begin
              $display("control_single unimplemented opcode %d", opcode);
              RegDst=1'b0; MemtoReg=1'b0; RegWrite=1'b0; MemRead=1'b0;
              MemWrite=1'b0; ALUOperation = 4'b0000; TipoInstr = 1'b0;
          end
        endcase
    end
endmodule