/*
  UNIVERSIDADE FEDERAL DE MINAS GERAIS
  DEPARTAMENTO DE CIENCIA DA COMPUTACAO
  ORGANIZACAO DE COMPUTADORES I
  
  Trabalho Prtico 04 - Novembro de 2012
  Arquivo: Controle.v
  
  Alunos:	Cludio da Cunha Menezes Jnior
				Daniel Carlos Hovadick Flix
				Guilherme Gonzaga Barbosa
				Marconi Chaves dos Santos
*/

module Controle (opcode, prevState, clock, control, nextState);
	/* Entradas do mdulo. */
	input [3:0] opcode;
	input [3:0] prevState;
	input clock;
	
	/* Sadas do mdulo. */
	output [15:0] control;
	output [3:0] nextState;
	
	/* Componentes internos. */
	reg [15:0] ROM [0:13];	// Controle rgido via ROM.
	reg [15:0] signal;		// Sinal de controle do estado corrente.
	reg [3:0] state;			// Contador de estados.
	//reg enable;					// Sinal que habilita o funcionamento do Controle.
	
	/* Inicializa a ROM com a tabela de sinais de controle. */
	initial begin
		//enable = 0;
		//state = 4'b1010;
		ROM[0] = 16'b0101100010001000;
		ROM[1] = 16'b0000000000011000;
		ROM[2] = 16'b0000010000000101;//mudei o origbalu para 00, mudei o ioud para 1
		                              //mudei regdest para o store
		ROM[3] = 16'b0000011010000001;//mudei memprareg para 1
		                              //mudei o regdest para o store
		ROM[4] = 16'b0000001000000011; 
		ROM[5] = 16'b0000010100000101;//mudei o regdest para o store
		
		ROM[6] = 16'b0000000001000100;
		ROM[7] = 16'b0000000000000011;
		ROM[8] = 16'b0111000000100100;
		ROM[9] = 16'b1001000000000000;
		ROM[10]= 16'b0000000010000000;
		ROM[11]= 16'b0000000000000101;//colokei
		ROM[12]= 16'b1000000000000000;//para dar tempo para o jump
		ROM[13]= 16'b0100000000000000;
	end
	
	/* Realiza a transio de estados na subida de clock. */
	always@(negedge clock) begin
		state = prevState;
		case (state)
			// Estado 0:
			4'b0000: begin
				signal <= ROM[0];
				state  <= 4'b0001;
			end
			// Estado 1:
			4'b0001: begin
				signal <= ROM[1];
				// Prximo estado para instruo do Tipo R:
				if ((opcode == 4'b0000)||(opcode == 4'b0001)||(opcode == 4'b0010)||(opcode == 4'b0011)||(opcode == 4'b0100)||(opcode == 4'b0101) ||(opcode == 4'b0110) ||(opcode == 4'b0111)) begin
					state <= 4'b0110;
				end
				// Prximo estado para instruo LW ou SW:
				else if ((opcode == 4'b1000)||(opcode == 4'b1001)) begin
					state <= 4'b0010;
				end
				// Prximo estado para instruo BEQ:
				else if (opcode == 4'b1010) begin
					state <= 4'b1000;
				end
				// Prximo estado para instruo J:
				else if (opcode == 4'b1011) begin
					state <= 4'b1001;
				end
				// Prximo estado para instruo HALT:
				else if (opcode == 4'b1100) begin
					state <= 4'b1010;
					//enable <= 0;
					signal <= 0;
				end
			end
			// Estado 2:
			4'b0010: begin
				signal <= ROM[2];
				if (opcode == 4'b1000) state = 4'b0011; // LW.
				else state = 4'b0101; // SW.
			end
			// Estado 3:
			4'b0011: begin
				signal <= ROM[3];
				state  <= 4'b0100;
			end
			// Estado 4:
			4'b0100: begin
				signal <= ROM[4];
				state  <= 4'b0000;
			end
			// Estado 5:
			4'b0101: begin
				signal <= ROM[5];
				state  <= 4'b1011;//para dar tempo de escrever
			end
			// Estado 6:
			4'b0110: begin
				signal <= ROM[6];
				state  <= 4'b0111;
			end
			// Estado 7:
			4'b0111: begin
				signal <= ROM[7];
				state  <= 4'b0000;
			end
			// Estado 8:
			4'b1000: begin
				signal <= ROM[8];
				state  <= 4'b1101;
			end
			// Estado 9:
			4'b1001: begin
				signal <= ROM[9];
				state  <= 4'b1100;
			end
			// Estado HALT:
			4'b1010: begin
				signal <= ROM[10];
				state <= 4'b1010;
			end
			// Estado espera para escrita:
			4'b1011: begin
				signal <= ROM[11];
				state  <= 4'b0000;//para dar tempo de escrever
			end
			//estado 12 jump
			4'b1100: begin
				signal <= ROM[12];
				state  <= 4'b0000;
			end
			//estado 13 bnch
			4'b1101: begin
				signal <= ROM[13];
				state  <= 4'b0000;
			end
		endcase
	end
	
	/* Envia os sinais de controle e o prximo estado para a sada. */
	assign control = signal;
	assign nextState = state;
	
endmodule

