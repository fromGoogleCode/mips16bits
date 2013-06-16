/*KEY[1]  responsvel por zerar o banco*/

module Banco (clock, state, writeReg, addra, addrb, addrc, dataa, datab, datac, store, CHAVE, VALOR, r0, r1, r2,reset);
	/* Entradas do mdulo. */
	input [3:0]state;
	input clock;
	input writeReg;
	input [3:0] addra;
	input [3:0] addrb;
	input [3:0] addrc;
	input reset;
	
	input [15:0] datac;
	input [5:0]CHAVE;
	  
	/* Sadas do mdulo. */
	output [15:0] dataa;
	output [15:0] datab;
	output [15:0] store;
	output [15:0] VALOR;
	output [15:0] r0;
	output [15:0] r1;
	output [15:0] r2;
	
	/* Componentes internos do mdulo. */
	reg [15:0] Registradores [0:15];	// Banco de registradores.
	reg [15:0] A;							// Registrador auxiliar A.
	reg [15:0] B;							// Registrador auxiliar B.
	reg [15:0] S;       // Registrador auxilar para STORE; 
	reg operation;							// Controla o reset do banco.
	integer i;								// ndice de acesso ao banco.
	
	/* Inicializa o banco com valores predefinidos. */
	initial begin
	
		Registradores[0] = 16'h0000;
		Registradores[1] = 16'h0000;
		Registradores[2] = 16'h0000;
		Registradores[3] = 16'h0000;
		Registradores[4] = 16'h0000;
		Registradores[5] = 16'h0000;
		Registradores[6] = 16'h0000;
		Registradores[7] = 16'h0000;
		Registradores[8] = 16'h0000;
		Registradores[9] = 16'h0000;
		Registradores[10]= 16'h0000;
		Registradores[11]= 16'h0000;
		Registradores[12]= 16'h0000;
		Registradores[13]= 16'h0000;
		Registradores[14]= 16'h0000;
		Registradores[15]= 16'h0000;
		
	end
	/* Leitura ou escrita no banco. */
	always@(posedge clock) begin
    	  if(writeReg == 1 && state == 4'b0111)Registradores[addrc] = datac;
  		  else if(writeReg == 1 && state == 4'b0100)Registradores[addrc] = datac;
		  else if(reset == 1'b0)begin
				for(i = 0; i < 15; i = i+1)begin
					Registradores[i] = 16'h0000;;
				end
		  end
  	end

	always@(negedge clock) begin
		A = Registradores[addra]; 
		B = Registradores[addrb];
		S = Registradores[addrc];
	end
	
	/* Atribuio das posies selecionadas para as sadas. */
	assign dataa = A;
	assign datab = B;
   assign store = S;
  
  	reg [15:0] info;
	always@(CHAVE or state) begin
		if (state == 4'b1010)begin
			info = Registradores[CHAVE];
		end
		else info = 0;
	end
	
	/* Valor enviado para os displays. */
	assign VALOR = info;
		
	assign r0 = Registradores[0];
	assign r1 = Registradores[1];
	assign r2 = Registradores[2];
  
endmodule
