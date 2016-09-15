//*** Instruction Set Definition in file "instruction_set.v" ***//
//*** TOP LEVEL MODULE ***//
module procesador_vectorial( clock, reset, data_read, data_write,
resultado_inst_vectorial, data_store_mem, data_load_mem, ID_VS, ID_VT, ID_VD,
ID_SHAMT, ID_OP, ID_IMM16, register_mov_data);


// Parameters
parameter pWIDTH = 8; //pWIDTH se cambia a 8 debido a que cada elemento del vector guarda 8 bits
parameter numero_registros_vectoriales = 16; //Es el numero de registros vectoriales
parameter numero_elementos_registro = 4; //es el numero de elementos en cada registro vectorial
parameter numero_lanes = 4; //es el numero de lanes vectoriales
parameter vp_over_vr_width = 1; //es el resultado de la division vp/vr el cual indica el numero de ejecuciones en total
parameter vp_over_vr_minus1 = (numero_elementos_registro/numero_lanes)-1; //

//Estos son las entradas y salidas de los lane vectoriales(ALUS VECTORIALES)
wire [(pWIDTH*numero_lanes)-1:0] LANE_OUT_VAL; //Wire que contiene el valor de salida del lane
wire [(pWIDTH*numero_lanes)-1:0] data_store_val; //Wire que contiene el valor del STORE.V

// Data Memory Control Signals Señales de control para la memoria de datos
wor mem_write_wire; //wire que indica a la memoria si debe escribir
wor mem_read_wire; //wire que indica a la memoria si debe leer


// Module IOs: Aqui se definen todas las entradas y salidas ya explicadas al inicio
input [4:0] ID_VS; //Contiene el valor del registro vectorial Vs 
input [4:0] ID_VT; //Contiene el valor del registro vectorial Vt
input [4:0] ID_VD; //Contiene el valor del registro vectorial Vd
input [11:0] ID_SHAMT; //Contiene el valor del shamt
input [4:0] ID_OP; //Contiene el valor del opcode
input [15:0] ID_IMM16; //Contiene el valor del inmediato
input [31:0] register_mov_data; //Contiene el valor del registro escalar al cual se le va a aplicar el MOV a un reg vectorial 
input clock;
input reset;
input [(pWIDTH*numero_lanes)-1:0] data_load_mem; //Contiene los datos a escribir en el registro cuando se hace un load
output data_read; //Señal de salida que le indica a la memoria de datos que debe leer, se activa cuando hago un Load
output data_write; //Señal de salida que le indica a la memoria de datos que debe escribir
output [(pWIDTH*numero_lanes)-1:0] resultado_inst_vectorial; //Resultado de la operacion vectorial
output [31:0] data_store_mem; //Valor que se va a escribir en la memoria cuando se realiza un Store


	
assign data_read = mem_read_wire; //señal que le indica a la memoria que debe leer datos de la memoria
assign data_write = mem_write_wire; //señal que le indica a la memoria que se debe escribir el dato
assign resultado_inst_vectorial = LANE_OUT_VAL; //guarda el resultado vectorial calculado por la instruccion

// asigna los datos a escribir en memoria cuando se hace un store
assign data_store_mem = data_store_val; 
assign update_enable = (mem_read_wire) ? 1'b0 : 1'b1 ; //Actualiza el archivo de registros vectoriales



endmodule