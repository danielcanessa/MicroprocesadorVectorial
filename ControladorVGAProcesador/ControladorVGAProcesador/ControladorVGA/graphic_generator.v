module graphic_generator(
	 input wire video_on,
	 input wire clk,
	 input wire cerrar, //esta entrada indica que ponga el cursor de las opciones en el inicio 
	 input wire btn_left, //contiene los botones con los cuales se desplaza entre las opciones
	 input wire nuevo,
	 input wire btn_right,
    input wire [9:0] pix_x, pix_y,
	 input wire pinta_pantalla_principal, //esta entrada indica el momento en que hay que pintar la pantalla
	 output wire graph_on, //esta salida le indica al mux que se está pintando este modulo
    output reg [7:0] graph_rgb
   );

   //Se declaran el valor horizontal de la pantalla y el valor vertical de la pantalla 640x480
   // x, y coordinates (0,0) to (639,479)
   localparam MAX_X = 640;
   localparam MAX_Y = 480;
	
	//Se definen los botones con los debounces
	wire move_x_left_tick,move_x_right_tick;
	
	//Registro para mantener almacenadas las coordenadas
   reg [9:0] barra_cursor_reg = 10'b0000010000;
	wire [9:0] barra_cursor_next;
	
	//Registro que indica cuanto se debe mover el cursor
   reg [2:0] posicion_cursor_reg = 3'b000;
	wire [2:0] posicion_cursor_next; //indica la nueva posicion del cursor en el eje x
	
	// En esta parte se instancian los botones que mueven con un debounce en cada uno
   debounce deb_unit0
      (.clk(clk), .reset(reset), .sw(btn_left),
       .db_level(), .db_tick(move_x_left_tick));
   debounce deb_unit1
      (.clk(clk), .reset(reset), .sw(btn_right),
       .db_level(), .db_tick(move_x_right_tick));
		 
	//Esta parte se encarga de realizar que la barra utilizada como cursor se mueva
   always @(posedge clk)
		begin
			if(cerrar)
			begin
			barra_cursor_reg <= 10'b0000010000;
			posicion_cursor_reg <= 3'b000;
			end
			else if(nuevo)
			begin
			barra_cursor_reg <= 10'b0000010000;
			posicion_cursor_reg <= 3'b000;
			end
			else
			begin
			barra_cursor_reg <= barra_cursor_next;
			posicion_cursor_reg <= posicion_cursor_next;
			end
		end
	
	
	
	//--------------------------------------------
   //BARRA HORIZONTAL UTILIZADA COMO CURSOR
   //--------------------------------------------
	
   //BARRA_CURSOR: Bordes izquierdo y derecho
   localparam BARRA_CURSOR_X_SIZE = 56;
  
   //BARRA_CURSOR: Bordes superior y inferior 
   localparam BARRA_CURSOR_Y_SIZE = 17;
   localparam BARRA_CURSOR_Y_TOP = 65; 
   localparam BARRA_CURSOR_Y_BOTTOM = BARRA_CURSOR_Y_TOP+BARRA_CURSOR_Y_SIZE-1;
	
	//--------------------------------------------
   //BARRA HORIZONTAL SUPERIOR 1
   //--------------------------------------------
	
   //BARRA_SUPERIOR: Bordes izquierdo y derecho
   localparam BARRA_SUPERIOR_X_LEFT = 0;
   localparam BARRA_SUPERIOR_X_RIGHT = 640;
   //BARRA_SUPERIOR: Bordes superior y inferior 
   localparam BARRA_SUPERIOR_Y_SIZE = 8;
   localparam BARRA_SUPERIOR_Y_TOP = 0; 
   localparam BARRA_SUPERIOR_Y_BOTTOM = BARRA_SUPERIOR_Y_TOP+BARRA_SUPERIOR_Y_SIZE-1;
	
	//--------------------------------------------
   //BARRA HORIZONTAL 2
   //--------------------------------------------
	
   //BARRA_SUPERIOR: Bordes izquierdo y derecho
   localparam BARRA_HORIZONTAL2_X_LEFT = 0;
   localparam BARRA_HORIZONTAL2_X_RIGHT = 640;
   //BARRA_SUPERIOR: Bordes superior y inferior 
   localparam BARRA_HORIZONTAL2_Y_SIZE = 8;
   localparam BARRA_HORIZONTAL2_Y_TOP = 90; 
   localparam BARRA_HORIZONTAL2_Y_BOTTOM = BARRA_HORIZONTAL2_Y_TOP+BARRA_HORIZONTAL2_Y_SIZE-1;
		
	//--------------------------------------------
   //BARRA HORIZONTAL INFERIOR
   //--------------------------------------------
	
   //BARRA_INFERIOR: Bordes izquierdo y derecho
   localparam BARRA_INFERIOR_X_LEFT = 0;
   localparam BARRA_INFERIOR_X_RIGHT = 640;
   //BARRA_INFERIOR: Bordes superior y inferior 
   localparam BARRA_INFERIOR_Y_SIZE = 8;
   localparam BARRA_INFERIOR_Y_TOP = 472; 
   localparam BARRA_INFERIOR_Y_BOTTOM = BARRA_INFERIOR_Y_TOP+BARRA_INFERIOR_Y_SIZE-1;
   
	//--------------------------------------------
   //BARRA VERTICAL IZQUIERDA 
   //--------------------------------------------
	
   //BARRA_IZQUIERDA: Bordes izquierdo y derecho
   localparam BARRA_IZQUIERDA_X_LEFT = 0;
   localparam BARRA_IZQUIERDA_X_RIGHT = 8;
   //BARRA_IZQUIERDA: Bordes superior y inferior 
   localparam BARRA_IZQUIERDA_Y_SIZE = 480;
   localparam BARRA_IZQUIERDA_Y_TOP = 0; 
   localparam BARRA_IZQUIERDA_Y_BOTTOM = BARRA_IZQUIERDA_Y_TOP+BARRA_IZQUIERDA_Y_SIZE-1;
	
	
   //--------------------------------------------
   //BARRA DERECHA 
   //--------------------------------------------
	
   //BARRA_DERECHA: Bordes izquierdo y derecho
   localparam BARRA_DERECHA_X_LEFT = 632;
   localparam BARRA_DERECHA_X_RIGHT = 640;
   //BARRA_DERECHA: Bordes superior y inferior 
   localparam BARRA_DERECHA_Y_SIZE = 480;
   localparam BARRA_DERECHA_Y_TOP = 0; 
   localparam BARRA_DERECHA_Y_BOTTOM = BARRA_DERECHA_Y_TOP+BARRA_DERECHA_Y_SIZE-1;
   
   //-----------------------------------------------------------------
   // Señales de salida: Indican la barra a pintar y el color del pixel
   //-----------------------------------------------------------------
   wire barra_izquierda_on,barra_superior_on, barra_inferior_on, barra_derecha_on, barra_cursor_on;
	wire barra_horizontal2_on;
   wire [7:0] barra_izquierda_rgb,barra_superior_rgb, barra_inferior_rgb,barra_derecha_rgb;
	wire [7:0] barra_horizontal2_rgb, barra_cursor_rgb;
	
	
	 //Nueva posicion del cursor: A la hora de que se mueven los botones se asigna la nueva posicion del cursor	
	assign barra_cursor_next = 
		(move_x_right_tick && (barra_cursor_reg == MAX_X-1)) ? 0 : ((posicion_cursor_reg==0 && move_x_right_tick)) ?
		barra_cursor_reg + 77 : ((posicion_cursor_reg == 1 && move_x_right_tick)) ? barra_cursor_reg + 87 : 
		((posicion_cursor_reg == 2 && move_x_right_tick)) ? barra_cursor_reg + 300 : 
		((posicion_cursor_reg == 3 && move_x_right_tick)) ? barra_cursor_reg + 77: 
		((posicion_cursor_reg == 4 && move_x_left_tick)) ? barra_cursor_reg - 77: 
		((posicion_cursor_reg == 3 && move_x_left_tick)) ? barra_cursor_reg - 300:
		((posicion_cursor_reg == 2 && move_x_left_tick)) ? barra_cursor_reg - 87:
		((posicion_cursor_reg == 1 && move_x_left_tick)) ? barra_cursor_reg - 77 : barra_cursor_reg;
	
	assign posicion_cursor_next = (move_x_right_tick) ? posicion_cursor_reg + 1 : 
 	(move_x_left_tick) ? posicion_cursor_reg - 1 : posicion_cursor_reg;
	
	//--------------------------------------------
   // BARRA CURSOR
   //--------------------------------------------
   //Indica si el pixel que hay que pintar se encuentra dentro de la barra vertical izquierda
   assign barra_cursor_on = pinta_pantalla_principal && ((barra_cursor_reg<=pix_x) && 
						 (pix_x<=barra_cursor_reg + 56) &&
                   (BARRA_CURSOR_Y_TOP<=pix_y) && (pix_y<=BARRA_CURSOR_Y_BOTTOM));
   //Indica el color del pixel del cursor
   assign barra_cursor_rgb = 8'b11111100; // cyan
	
	//--------------------------------------------
   // BARRA VERTICAL IZQUIERDA
   //--------------------------------------------
   //Indica si el pixel que hay que pintar se encuentra dentro de la barra vertical izquierda
   assign barra_izquierda_on = pinta_pantalla_principal && ((BARRA_IZQUIERDA_X_LEFT<=pix_x) && 
						 (pix_x<=BARRA_IZQUIERDA_X_RIGHT) &&
                   (BARRA_IZQUIERDA_Y_TOP<=pix_y) && (pix_y<=BARRA_IZQUIERDA_Y_BOTTOM));
   //Indica el color del pixel de la barra
   assign barra_izquierda_rgb = 8'b11111100; // verde
   
	//--------------------------------------------
   // BARRA VERTICAL DERECHA
   //--------------------------------------------
   //Indica si el pixel que hay que pintar se encuentra dentro de la barra derecha
   assign barra_derecha_on = pinta_pantalla_principal &&((BARRA_DERECHA_X_LEFT<=pix_x) && 
						 (pix_x<=BARRA_DERECHA_X_RIGHT) &&
                   (BARRA_DERECHA_Y_TOP<=pix_y) && (pix_y<=BARRA_DERECHA_Y_BOTTOM));
   //Indica el color del pixel de la barra
   assign barra_derecha_rgb = 8'b11111100; // verde
	
	//--------------------------------------------
   // BARRA HORIZONTAL 2
   //--------------------------------------------
   //Indica si el pixel que hay que pintar se encuentra dentro de la barra derecha
   assign barra_horizontal2_on = pinta_pantalla_principal &&((BARRA_HORIZONTAL2_X_LEFT<=pix_x) && 
						 (pix_x<=BARRA_HORIZONTAL2_X_RIGHT) &&
                   (BARRA_HORIZONTAL2_Y_TOP<=pix_y) && (pix_y<=BARRA_HORIZONTAL2_Y_BOTTOM));
   //Indica el color del pixel de la barra
   assign barra_horizontal2_rgb = 8'b11111100; // verde
	
	
	//--------------------------------------------
   // BARRA HORIZONTAL SUPERIOR
   //--------------------------------------------
   //Indica si el pixel que hay que pintar se encuentra dentro de la barra derecha
   assign barra_superior_on = pinta_pantalla_principal && ((BARRA_SUPERIOR_X_LEFT<=pix_x) && (pix_x<=BARRA_SUPERIOR_X_RIGHT) &&
                   (BARRA_SUPERIOR_Y_TOP<=pix_y) && (pix_y<=BARRA_SUPERIOR_Y_BOTTOM));
   //Indica el color del pixel de la barra
   assign barra_superior_rgb = 8'b11111100; // verde
	
	//--------------------------------------------
   // BARRA HORIZONTAL INFERIOR
   //--------------------------------------------
   //Indica si el pixel que hay que pintar se encuentra dentro de la barra derecha
   assign barra_inferior_on = pinta_pantalla_principal && ((BARRA_INFERIOR_X_LEFT<=pix_x) && (pix_x<=BARRA_INFERIOR_X_RIGHT) &&
                   (BARRA_INFERIOR_Y_TOP<=pix_y) && (pix_y<=BARRA_INFERIOR_Y_BOTTOM));
   //Indica el color del pixel de la barra
   assign barra_inferior_rgb = 8'b11111100; // verde
   
   //-------------------------------------------------------------------------------------------
   // Circuito multiplexor que se encargan de indicar cual barra se está pintando en ese momento
   //-------------------------------------------------------------------------------------------
   always @*
      if (~video_on)
         graph_rgb = 8'b11111111; //Pinta el fondo de negro
      else
         if (barra_izquierda_on)
            graph_rgb = barra_izquierda_rgb;
			else if(barra_derecha_on)
				graph_rgb = barra_derecha_rgb;
         else if (barra_superior_on)
            graph_rgb = barra_superior_rgb;
         else if (barra_inferior_on)
            graph_rgb = barra_inferior_rgb;
			else if (barra_horizontal2_on)
            graph_rgb = barra_horizontal2_rgb;
			else if (barra_cursor_on)
            graph_rgb = barra_cursor_rgb;
         else
            graph_rgb = 8'b00000000; //fondo negro
	
	//Señala que el pixel que tiene que pintar es el de una barra
	assign graph_on = barra_izquierda_on | barra_derecha_on | barra_superior_on | barra_inferior_on
							| barra_horizontal2_on | barra_cursor_on;

endmodule