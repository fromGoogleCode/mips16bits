/*
  UNIVERSIDADE FEDERAL DE MINAS GERAIS
  DEPARTAMENTO DE CIENCIA DA COMPUTACAO
  ORGANIZACAO DE COMPUTADORES I
  
  Trabalho Prtico 03 - Novembro de 2012
  Arquivo: ALU.v
  
  Alunos:	Cludio da Cunha Menezes Jnior
				Daniel Carlos Hovadick Flix
				Guilherme Gonzaga Barbosa
				Marconi Chaves dos Santos
*/

module ALU (clock, A, B, opcode, ALUout, OverflowDetected, zero);
	/* Entradas do modulo. */
	input clock;
	input [3:0] opcode;
	input [15:0] A;
	input [15:0] B;
	
	/* Saidas do modulo. */
	output zero;
	output OverflowDetected;
	output [15:0] ALUout;
	
	/* Componentes internos. */
	reg [15:0] RegALUout;		// Resultado da operacao da ALU.
	reg RegOverflowDetected;	// Verificador de overflow
	reg signalA;					// Sinal do operando A.
	reg signalB;					// Sinal do operando B.
	reg signalRegALUout;			//	Sinal do resultado da operacao da ALU.
	reg regZero;
	
	initial begin
		RegOverflowDetected = 0;
	end
	
	/* Realiza a operacao da ALU. */
	always @ (clock) begin
			// A + B ou A + Constante:
			if ((opcode == 4'b0000)||(opcode == 4'b0010)) begin
					RegALUout = A + B;
					regZero = 0;
					if ((A[15] == 0) && (B[15] == 0) && (RegALUout[15] == 1)) begin
						RegOverflowDetected = 1;
					end
					else if ((A[15] == 1) && (B[15] == 1) && (RegALUout[15] == 0)) begin
						RegOverflowDetected = 1;
					end
					else begin
						RegOverflowDetected = 0;
					end
			end
			// A - B:
			else if (opcode == 4'b0001) begin
					RegALUout = A - B;
					
					if(B > A) regZero = 0;
					else if(RegALUout == 4'h0000 && RegOverflowDetected == 0) regZero = 1;        //Deu zero
					else if(RegALUout != 4'h0000 && RegOverflowDetected == 0)regZero = 0;
					
					if ((A[15] == 0) && (B[15] == 1) && (RegALUout[15] == 1)) begin
						RegOverflowDetected = 1;
					end
					else if ((A[15] == 1) && (B == 0) && (RegALUout[15] == 0)) begin
						RegOverflowDetected = 1;
					end
					else begin
						RegOverflowDetected = 0;
					end
			end			
			// A and B:
			else if (opcode == 4'b0011) begin
				regZero = 0;
				RegALUout = A & B;
				RegOverflowDetected = 0;
			end
			// A or B:
			else if (opcode == 4'b0100) begin
				RegALUout = A | B;
				RegOverflowDetected = 0;
				regZero = 0;
			end
			// not A:
			else if (opcode == 4'b0101) begin
				RegALUout = ~A;
				regZero = 0;
				RegOverflowDetected = 0;
			end
			// A << B:
			else if (opcode == 4'b0110) begin
				regZero = 0;
				RegALUout = A << B;
				RegOverflowDetected = 0;
			end
			// A >> B:
			else if (opcode == 4'b0111) begin
				regZero = 0;
				RegALUout = A >> B;
				RegOverflowDetected = 0;
			end
	end
	
	/* Envia para as saidas o resultado da ALU e o teste de overflow. */
	assign ALUout = RegALUout;
	assign OverflowDetected = RegOverflowDetected;
	assign zero = regZero;
  
endmodule
