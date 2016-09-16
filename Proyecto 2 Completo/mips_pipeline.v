
module mips_pipeline(clk, reset,  MEM_memout,memread_tipo_instr, memwrite_tipo_instr ,memdirection_tipo_instr,
							memaluout_tipo_instr);


//Signal declarations ALTSYNCRAM      
   input clk, reset;
	input [31:0] MEM_memout;
	
/*	wire memread_tipo_instr;
	wire memwrite_tipo_instr;
	wire[31:0] memaluout_tipo_instr;
	wire[31:0] memdirection_tipo_instr; */
	
	output memread_tipo_instr, memwrite_tipo_instr;
	output [31:0] memdirection_tipo_instr, memaluout_tipo_instr;
	
	
	
	
	//Signal declarations ALTSYNCRAM
//	wire[31:0] vga_datain;
	wire[16:0] memory_address;
	
	

	//assign ledSwitch = writeData;
	
    // ********************************************************************
    //                              Signal Declarations
    // ********************************************************************

    // IF Signal Declarations

    wire [31:0] IF_instr, IF_pc, IF_pc_stalled, IF_pc_jump, IF_pc_next, IF_pc4;
    reg Stall;
    reg [31:0] ID_instr, ID_pc4;  

	wire [31:0] ID_extend, ID_rd1, ID_rd2, data_store_mem;
	wire [4:0] ID_rs, ID_rt, ID_rd,ID_op;
	wire [16:0] ID_immed;
	wire [11:0] ID_shamt;
	wire [21:0] ID_address;
	
	// ID Signal 
	assign ID_op = ID_instr[31:27];
    assign ID_rs = ID_instr[26:22];
    assign ID_rt = ID_instr[21:17];
    assign ID_rd = ID_instr[16:12];
	assign ID_shamt = ID_instr[11:0];
    assign ID_immed = ID_instr[16:0];
	assign data_store_mem = MEM_rd2;

    wire ID_RegWrite_v, ID_MemWrite_v, ID_MemRead_v, ID_Branch_v, ID_Jump_v;
    wire ID_RegWrite, ID_Branch, ID_RegDst, ID_MemtoReg, 
         ID_MemRead, ID_MemWrite, ID_ALUSrc, ID_Jump;
		 reg [4:0] EX_op , MEM_op;
    wire [1:0] ID_ALUOp;
	wire ID_RegWrite_vec, ID_MemWrite_vec, ID_MemRead_vec;
    wire ID_RegDst_vec, ID_MemtoReg_vec,  
          ID_ALUSrc_vec;	 
    wire [1:0] ID_ALUOp_vec;
	wire tipoInstr;

    // EX Signals
    reg  [31:0] EX_pc4, EX_extend, EX_rd1, EX_rd2;
    wire [31:0]  EX_offset, EX_btgt, EX_alub, EX_ALUOut;
    reg  [4:0]  EX_rs, EX_rt, EX_rd,EX_vd_vec,EX_Vd_num, EX_Vt_num;
    wire [4:0]  EX_RegRd;
    wire [5:0] EX_funct;
	reg [11:0] EX_shamt;
	reg [16:0] EX_inmediato;
	
    reg  EX_RegWrite, EX_Branch, EX_RegDst, EX_MemtoReg,  // EX Control Signals
         EX_MemRead, EX_MemWrite, EX_ALUSrc;
		 
	reg  EX_RegWrite_vec, EX_RegDst_vec, EX_MemtoReg_vec,  // EX_VECTORIAL Control Signals
         EX_MemRead_vec, EX_MemWrite_vec;

    wire EX_Zero;
	wire [4:0] EX_EscogeRegistroEscribir; //Aqui escribe cual registro debe escribir
	wire [3:0] ID_operation,ID_operation_vec;
    reg  [1:0] EX_ALUOp;
    reg [3:0] EX_Operation, EX_Operation_vec;
	reg EX_TIPO_INSTR; 

   // MEM Signals
    wire MEM_PCSrc;
//	wire [31:0] MEM_memout; La comente porque va a ser una salida
    reg  MEM_RegWrite, MEM_Branch, MEM_MemtoReg,
         MEM_MemRead, MEM_MemWrite, MEM_Zero;
    reg  [31:0] MEM_btgt, MEM_ALUOut, MEM_rd2;
    reg  [5:0] MEM_RegRd;
	
	// MEM Signals Vectorial 
    wire MEM_PCSrc_vec;
	wire [31:0] MEM_memout_vec;
    reg  MEM_RegWrite_vec, MEM_Branch_vec, MEM_MemtoReg_vec,
         MEM_MemRead_vec, MEM_MemWrite_vec, MEM_Zero_vec, MEM_Tipo_INSTR;
    reg  [31:0] MEM_btgt_vec, MEM_ALUOut_vec, MEM_rd2_vec, MEM_vd_vec, MEM_RegDestinationVector;
    reg  [5:0] MEM_RegRd_vec;

    // WB Signals
    reg WB_RegWrite, WB_MemtoReg;  // WB Control Signals
    reg  [31:0] WB_memout, WB_ALUOut;
    wire [31:0] WB_wd;
    reg  [4:0] WB_RegRd;
	
	// WB Signals Vectorial Processor
    reg WB_RegWrite_vec, WB_MemtoReg_vec;  // WB Control Signals
    reg  [31:0] WB_memout_vec, WB_ALUOut_vec;
    wire [31:0] WB_wd_vec;
    reg  [4:0] WB_RegRd_vec;
	
	
    // ********************************************************************
    //                              IF Stage
    // ********************************************************************

    reg32		IF_PC(clk, reset, IF_pc_next, IF_pc); // le entra el siguiente pc, salida es IF_PC

    add32 		IF_PCADD(IF_pc, 32'd4, IF_pc4); // toma la salida 

    mux2 #(32)  IF_SMUX(Stall, IF_pc4, IF_pc, IF_pc_stalled);

    // Mux que elige entre el pc+4 o el pc del beq 
	// IF_pc_stalled si es stall es el pc, sino si tiene el pc+4
    mux2 #(32)	IF_PCMUX(MEM_PCSrc, IF_pc_stalled, MEM_btgt, IF_pc_next);

    rom32 		IMEM(IF_pc, IF_instr);

    always @(posedge clk)		    // IF/ID Pipeline Register
    begin
        if (reset)
        begin
            ID_instr <= 0;
            ID_pc4   <= 0;
        end
        else begin
            if (ID_Jump)
                ID_instr <= 0;
            else if (Stall)
                ID_instr <= ID_instr;
            else
                ID_instr <= IF_instr;
            ID_pc4   <= IF_pc4;
        end
    end

    // ********************************************************************
    //                              ID Stage
    // ********************************************************************

	wire    [3:0] RegisterVectorVd, RegisterVectorVs, RegisterVectorVt;
	wire [31:0] ID_vector_Vd, ID_vector_Vt, ID_vector_Vs;
	reg [31:0] EX_vector_Vd, EX_vector_Vt, EX_vector_Vs ;
	
    reg_file	RFILE(clk, WB_RegWrite, ID_rs, ID_rt, WB_RegRd, ID_rd1, ID_rd2, WB_wd);
	
	/**
	Aca se instancia el control de los registros vectoriales para lograr mapear su codigo de registro
	**/
	lane_vectorial_control vector_register_mappingVd(.RegisterCode(ID_rd), .RegisterVector(RegisterVectorVd));

	/**
	Aca se instancia el control de los registros vectoriales para lograr mapear el codigo del registro Vs
	**/
	lane_vectorial_control vector_register_mappingVs(.RegisterCode(ID_rs), .RegisterVector(RegisterVectorVs));

	/**
	Aca se instancia el control de los registros vectoriales para lograr mapear el codigo del registro Vt
	**/
	lane_vectorial_control vector_register_mappingVt(.RegisterCode(ID_rt), .RegisterVector(RegisterVectorVt));
	
	vector_register vector_register_bank(.clock(clk),.indexVd(WB_RegRd_vec), .indexVs(RegisterVectorVs), 
	.indexVt(RegisterVectorVt), .update_register(WB_wd_vec), .update_enable(WB_RegWrite_vec), 
	.registerSource1(ID_vector_Vs), .registerSource2(ID_vector_Vt), .registerDestination(ID_vector_Vd));

    // sign-extender
    assign ID_extend = { {15{ID_immed[16]}}, ID_immed };

	// Se determina si hay un stall o no
    always @(*)
    begin
        if (EX_MemRead
            && ((EX_rt == ID_rs) || (EX_rt == ID_rt)))
            Stall = 1'b1;
        else
            Stall = 1'b0;
    end

   control_pipeline CTL(.opcode(ID_op), .RegDst(ID_RegDst), .ALUSrc(ID_ALUSrc), .MemtoReg(ID_MemtoReg),
                       .RegWrite(ID_RegWrite_v), .MemRead(ID_MemRead_v), .MemWrite(ID_MemWrite_v),
					   .Branch(ID_Branch_v), .ALUOperation(ID_operation), .Jump(ID_Jump_v));
					   
					   
	control_pipeline_vectorial CTL_vectorial(.opcode(ID_op), .RegDst(ID_RegDst_vec),
		   .MemtoReg(ID_MemtoReg_vec), .RegWrite(ID_RegWrite_vec), .MemRead(ID_MemRead_vec),
		   .MemWrite(ID_MemWrite_vec), .ALUOperation(ID_operation_vec) , .TipoInstr(tipoInstr));

    mux2 #(1)   ID_RW_SMUX(Stall, ID_RegWrite_v, 1'b0, ID_RegWrite);
    mux2 #(1)   ID_MR_SMUX(Stall, ID_MemRead_v,  1'b0, ID_MemRead);
    mux2 #(1)   ID_MW_SMUX(Stall, ID_MemWrite_v, 1'b0, ID_MemWrite);
    mux2 #(1)   ID_BR_SMUX(Stall, ID_Branch_v,   1'b0, ID_Branch);
    mux2 #(1)   ID_JU_SMUX(Stall, ID_Jump_v,     1'b0, ID_Jump);

    always @(posedge clk)		    // ID/EX Pipeline Register
    begin
        if (reset)
        begin
            EX_RegDst   <= 0;
            EX_ALUOp    <= 0;
            EX_ALUSrc   <= 0;
            EX_Branch   <= 0;
            EX_MemRead  <= 0;
            EX_MemWrite <= 0;
            EX_RegWrite <= 0;
            EX_MemtoReg <= 0;
				EX_shamt    <= 0;
            EX_pc4      <= 0;
            EX_rd1      <= 0;
            EX_rd2      <= 0;
            EX_extend   <= 0;
            EX_rs       <= 0;
            EX_rt       <= 0;
            EX_rd       <= 0;
				EX_vector_Vd <= 0;
			EX_vector_Vt <= 0;
			EX_vector_Vs <= 0;
			EX_vd_vec <= 0;
			EX_Vd_num  <= 0;
			EX_Vt_num  <= 0;
			EX_TIPO_INSTR <= 0;
			EX_op 	<= 0;
        end
        else begin
            EX_RegDst   	<= ID_RegDst;
            EX_ALUOp    	<= ID_ALUOp;
            EX_ALUSrc   	<= ID_ALUSrc;
            EX_Branch   	<= ID_Branch;
            EX_MemRead  	<= ID_MemRead;
            EX_MemWrite 	<= ID_MemWrite;
            EX_RegWrite 	<= ID_RegWrite;
            EX_MemtoReg 	<= ID_MemtoReg;
			EX_Operation	 <= ID_operation;
			EX_Operation_vec <= ID_operation_vec;
            EX_pc4      	<= ID_pc4;
            EX_rd1      	<= ID_rd1;
            EX_rd2      	<= ID_rd2;
            EX_extend   	<= ID_extend;
			EX_inmediato	<= ID_immed;
			EX_shamt    	<= ID_shamt;
            EX_rs       	<= ID_rs;
            EX_rt       	<= ID_rt;
            EX_rd       	<= ID_rd;
			EX_vector_Vd 	<= ID_vector_Vd;
			EX_vector_Vt 	<= ID_vector_Vt;
			EX_vector_Vs 	<= ID_vector_Vs;
			
			/**Señales que salen del control_pipeline_vectorial **/
			EX_RegWrite_vec <= ID_RegWrite_vec;
			EX_RegDst_vec 	<= ID_RegDst_vec;
			EX_MemtoReg_vec <= ID_MemtoReg_vec;
			EX_MemRead_vec 	<= ID_MemRead_vec;
			EX_MemWrite_vec <= ID_MemWrite_vec;
			EX_Vd_num 	 	<= RegisterVectorVd;
			EX_Vt_num  		<= RegisterVectorVt;
			EX_TIPO_INSTR 	<= tipoInstr;
			EX_op 	<= ID_op;
        end
    end

    // ********************************************************************
    //                              EX Stage
    // ********************************************************************

    // branch offset shifter
    assign EX_offset = EX_extend << 2;
	
    add32 		EX_BRADD(EX_pc4, EX_offset, EX_btgt);

    wire [31:0] MuxA_out, MuxB_out;

    // Mux que elige entre el inmediato o registro como valor B de la ALU
	// 0 -> Registro
	// 1 -> Inmediato
    mux2 #(32) 	ALUMUX(EX_ALUSrc, EX_rd2, EX_extend, EX_alub);

    // Take the output from FMUXA instead of directly from ID/EX
    alu 		EX_ALU(EX_Operation, EX_rd1, EX_alub, EX_ALUOut, EX_Zero);
	
	wire [(8*4)-1:0] EX_LANE_OUT_VAL; //Wire que contiene el valor de salida del lane
	/**Aqui instancia los lane vectoriales  **/
	/**Aqui genera los lane paralelos **/
	genvar i;
	
	generate
	 for (i=0; i < 4; i=i+1) begin : VLANES
			lane_vectorial #(i) lane_vectorial (clk, reset, EX_Operation_vec, EX_inmediato, EX_shamt,
			EX_LANE_OUT_VAL[((8*(i+1))-1) : (8*i)],EX_vector_Vd, EX_vector_Vs, EX_vector_Vt);
	 end // block: VLANES
	endgenerate

	// Mux que elige el numero de registro a modificar en el WB 
	// 0 -> rt
	// 1 -> rd
    mux2 #(5) 	EX_RFMUX(EX_RegDst, EX_rt, EX_rd, EX_RegRd);
	
	////
	mux2 #(5) 	WB_MUX_VEC(EX_RegDst_vec, EX_Vt_num, EX_Vd_num, EX_EscogeRegistroEscribir);
	
    always @(posedge clk)		    // EX/MEM Pipeline Register
    begin
        if (reset)
        begin
            MEM_Branch   	<= 0;
            MEM_MemRead  	<= 0;
            MEM_MemWrite 	<= 0;
            MEM_RegWrite 	<= 0;
            MEM_MemtoReg 	<= 0;
            MEM_Zero     	<= 0;
            MEM_btgt     	<= 0;
            MEM_ALUOut   	<= 0;
            MEM_rd2      	<= 0;
            MEM_RegRd    	<= 0;
			
			MEM_MemRead_vec  <= 0;
            MEM_MemWrite_vec <= 0;
            MEM_RegWrite_vec <= 0;
            MEM_MemtoReg_vec <= 0;
            MEM_ALUOut_vec   <= 0;
			MEM_vd_vec 		 <= 0;
			MEM_Tipo_INSTR 	 <= 0;
			MEM_rd2_vec 	 <= 0;
			MEM_RegDestinationVector <= 0;
			MEM_op <= 0;
        end
        else begin
            MEM_Branch   <= EX_Branch;
            MEM_MemRead  <= EX_MemRead;
            MEM_MemWrite <= EX_MemWrite;
            MEM_RegWrite <= EX_RegWrite;
            MEM_MemtoReg <= EX_MemtoReg;
            MEM_Zero     <= EX_Zero;
            MEM_btgt     <= EX_btgt;
            MEM_ALUOut   <= EX_ALUOut;
            MEM_rd2      <= EX_rd2;
            MEM_RegRd    <= EX_RegRd;
			
			// MEM Signals Vectorial
			MEM_MemRead_vec  <= EX_MemRead_vec;
            MEM_MemWrite_vec <= EX_MemWrite_vec;
            MEM_RegWrite_vec <= EX_RegWrite_vec;
            MEM_MemtoReg_vec <= EX_MemtoReg_vec;
            MEM_ALUOut_vec   <= EX_LANE_OUT_VAL;
			MEM_vd_vec 		 <= EX_EscogeRegistroEscribir;
			MEM_Tipo_INSTR 	 <= EX_TIPO_INSTR;
			MEM_rd2_vec 	 <= EX_rd1;
			MEM_RegDestinationVector <= EX_vector_Vt;
			MEM_op <= EX_op;
        end
    end

    // ********************************************************************
    //                              MEM Stage
    // ********************************************************************
//	wire memread_tipo_instr;
//	wire memwrite_tipo_instr;
//	wire[31:0] memaluout_tipo_instr;
//	wire[31:0] memdirection_tipo_instr;

	wire[31:0] mux_out;
	
	mux2 #(1)	MEM_READ_TIPO_INSTR(MEM_Tipo_INSTR, MEM_MemRead, MEM_MemRead_vec, memread_tipo_instr);
	mux2 #(1)	MEM_WRITE_TIPO_INSTR(MEM_Tipo_INSTR, MEM_MemWrite, MEM_MemWrite_vec, memwrite_tipo_instr);
	mux2 #(32)	MEM_ALUOUT_TIPO_INSTR(MEM_Tipo_INSTR, MEM_ALUOut, MEM_RegDestinationVector, memaluout_tipo_instr);
	mux2 #(32)	MEM_RD2_INSTR(MEM_Tipo_INSTR, mux_out, MEM_rd2_vec, memdirection_tipo_instr);
	mux2 #(32)	MEM_RD2(MEM_op[1],  memaluout_tipo_instr, MEM_rd2, mux_out);
	
 /*   mem32 		MEM_DMEM(clk, memread_tipo_instr, memwrite_tipo_instr,memdirection_tipo_instr,
	memaluout_tipo_instr, MEM_memout); */ 
	
    and  		MEM_BR_AND(MEM_PCSrc, MEM_Branch, MEM_Zero);

    always @(posedge clk)		// MEM/WB Pipeline Register
    begin
        if (reset)
        begin
            WB_RegWrite 	<= 0;
            WB_MemtoReg 	<= 0;
            WB_ALUOut   	<= 0;
            WB_memout   	<= 0;
            WB_RegRd    	<= 0;	
				WB_RegWrite_vec <= 0;
            WB_MemtoReg_vec <= 0;
            WB_ALUOut_vec   <= 0;
            WB_memout_vec   <= 0;
            WB_RegRd_vec    <= 0;	
        end
        else begin
            WB_RegWrite 	<= MEM_RegWrite;
            WB_MemtoReg 	<= MEM_MemtoReg;
            WB_ALUOut   	<= MEM_ALUOut;
            WB_memout   	<= MEM_memout;
            WB_RegRd    	<= MEM_RegRd;	
			WB_RegWrite_vec <= MEM_RegWrite_vec;
            WB_MemtoReg_vec <= MEM_MemtoReg_vec;
            WB_ALUOut_vec   <= MEM_ALUOut_vec;
			WB_RegRd_vec    <= MEM_vd_vec;
        end
    end

    // ********************************************************************
    //                              WB Stage
    // ********************************************************************

    mux2 #(32)	WB_WRMUX(WB_MemtoReg, WB_ALUOut, WB_memout, WB_wd);
	
	mux2 #(32)	WB_WRMUXVEC(WB_MemtoReg_vec, WB_ALUOut_vec, WB_memout, WB_wd_vec);

endmodule

