//*** Instruction Set Definition in file "instruction_set.v" ***//
//*** TOP LEVEL MODULE ***//
module top( clock, reset, data_load_mem, ID_VS, ID_VT, ID_VD,
ID_SHAMT, ID_OP, ID_IMM16, register_mov_data, data_memory_direction);


// Module IOs: Aqui se definen todas las entradas y salidas ya explicadas al inicio
input [4:0] ID_VS; //Contiene el valor del registro vectorial Vs 
input [4:0] ID_VT; //Contiene el valor del registro vectorial Vt
input [4:0] ID_VD; //Contiene el valor del registro vectorial Vd
input [11:0] ID_SHAMT; //Contiene el valor del shamt
input [4:0] ID_OP; //Contiene el valor del opcode
input [15:0] ID_IMM16; //Contiene el valor del inmediato
input [31:0] register_mov_data; //Contiene el valor del registro escalar al cual se le va a aplicar el MOV a un reg vectorial 
input clock;
input [31:0] data_memory_direction; //Contiene la direccion en donde se va a hacer el LOAD o el STORE
input reset;
input [31:0] data_load_mem; //Contiene los datos a escribir en el registro cuando se hace un load
//output data_read; //Señal de salida que le indica a la memoria de datos que debe leer, se activa cuando hago un Load
//output data_write; //Señal de salida que le indica a la memoria de datos que debe escribir
//output [31:0] resultado_inst_vectorial; //Resultado de la operacion vectorial
//output [31:0] data_store_mem; //Valor que se va a escribir en la memoria cuando se realiza un Store

wire[31:0] data_from_memory;
wire[31:0] resultado_inst_vectorial;
wire data_read;
wire data_write;
wire[31:0] data_store_mem;


/**
Se instancia el procesador vectorial
**/
procesador_vectorial procesador(.clock(clock), .reset(reset), .data_read(data_read), .data_write(data_write),
.resultado_inst_vectorial(resultado_inst_vectorial), .data_store_mem(data_store_mem), 
.data_load_mem(data_load_mem), .ID_VS(ID_VS), .ID_VT(ID_VT), .ID_VD(ID_VD),
.ID_SHAMT(ID_SHAMT), .ID_OP(ID_OP), .ID_IMM16(ID_IMM16), .register_mov_data(register_mov_data));

/**
Se instancia la memoria de datos
**/
data_memory memoria_datos(.clk(clock), .addr_a(data_memory_direction), .wdata(data_store_mem), 
									.wren(data_write), .dout_a(data_from_memory));
									

endmodule // Top Level VeMICry