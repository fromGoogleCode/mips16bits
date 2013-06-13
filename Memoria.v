/*
nsahjfsdakjsda  UNIVERSIDADE FEDERAL DE MINAS GERAIS
  DEPARTAMENTO DE CINCIA DA COMPUTAO
  ORGANIZAO DE COMPUTADORES I
teste  
  Trabalho Prtico 05 - Novembro de 2012
  Arquivo: Memoria.v
tESTE
  
  Alunos:	Cludio da Cunha Menezes Jnior
				Daniel Carlos Hovadick Flix
				Guilherme Gonzaga Barbosa
				Marconi Chaves dos Santos
*/

module Memoria (addrMem, readMem, dataIR, dataMDR, writeMem, data, CHAVE, VALOR, state);
	/* Entradas do mdulo. */
	
	input [3:0]state;
	input [5:0] addrMem;
	input [15:0] data;
	input readMem;
	input writeMem;
	input [5:0]CHAVE;
	
	/* Sadas do mdulo. */
	output [15:0] dataIR;
	output [15:0] dataMDR;
	output [15:0] VALOR;
	
	/* Componentes internos do Mdulo. */
	reg [15:0] memory [0:49];	// Mdulo de memria de 50 posies. 
	reg [15:0] storedData;		// Registrador auxiliar.
	
	/* Inicializa a memria com valores prdefinidos. */
	initial begin
		/*memory[0] = 16'h6020; //reg[f] = mem[f+6]
		memory[1] = 16'h9016;
		memory[2] = 16'hC004;
      //memory[2] = 16'hB004;
      //memory[2] = 16'hA001;//jump pro 3
		memory[3] = 16'h9016;
		//memory[3] = 16'hC213; // mem[1+3] = reg[2]
		memory[4] = 16'hC011;
		//memory[4] = 16'h1011;
		//memory[3] = 16'hCF0F;
		memory[5] = 16'h9116;//mem[f+7] = reg[1]
		memory[6] = 16'hCF8F;
		memory[7] = 16'h0B46;
		memory[8] = 16'h11AA;
		memory[9] = 16'h4481;
		memory[10]= 16'h6163;
		memory[11]= 16'h75E8;
		memory[12]= 16'h04CC;
		memory[13]= 16'h1C61;
		memory[14]= 16'h2C6A;
		memory[15]= 16'h6A1F;
		memory[16]= 16'h3B9F;
		memory[17]= 16'h7205;
		memory[18]= 16'h368A;
		memory[19]= 16'h363C;
		//memory[20]= 16'h2F83;
		memory[20]= 16'h0001;
		memory[21]= 16'h0C39;*/
		memory[0]  = 16'b0010000000010000;
		memory[1]  = 16'b0010000101100001;
		memory[2]  = 16'b0110000000010000;
		memory[3]  = 16'b0010001000010010;
		memory[4]  = 16'b0010001000100010;
		memory[5]  = 16'b0100001000000000;
		memory[6]  = 16'b0010000100100001;
		memory[7]  = 16'b0110000000010000;
		memory[8]  = 16'b0010000100010100;
		memory[9]  = 16'b0010001101000011;
		memory[10] = 16'b0110010000110100;
		memory[11] = 16'b0010111100011111;
		memory[12] = 16'b0001010111110101;
		memory[13] = 16'b0111010100010101;
		memory[14] = 16'b0101010000000100;
		memory[15] = 16'b0011010001010100;
		memory[16] = 16'b0100010000000000;
		memory[17] = 16'b0010011001110110;
		memory[18] = 16'b0101010000000100;
		memory[19] = 16'b0011010001110100;
		memory[20] = 16'b0010010000100100;
		memory[21] = 16'b0110011000110110;
		memory[22] = 16'b0000011001000110;
		memory[23] = 16'b0010100010001000;
		memory[24] = 16'b0110011010000110;
		memory[25] = 16'b0010011111000111;
		memory[26] = 16'b0010100100011001;
		memory[27] = 16'b0110011110010111;
		memory[28] = 16'b0000100101110111;
		memory[29] = 16'b0010100100011001;
		memory[30] = 16'b0110011110010111;
		memory[31] = 16'b0010011000010110;
		memory[32] = 16'b0100011001110110;
		memory[33] = 16'b0100011010100001;
		memory[34] = 16'b0010001011010010;
		memory[35] = 16'b0010100100011001;
		memory[36] = 16'b0110001010010010;
		memory[37] = 16'b0010100110011001;
		memory[38] = 16'b0001001010010010;
		memory[39] = 16'b0110001010000010;
		memory[40] = 16'b0010101111111011;
		memory[41] = 16'b0010110000011100;
		memory[42] = 16'b0110101111001011;
		memory[43] = 16'b0010101100111011;
		memory[44] = 16'b0000101100100010;
		memory[45] = 16'b1100000000000000;
	end
	
	/* Realiza a leitura da memria na borda de subida do sinal readMem. */
	always @ (posedge readMem) begin
		if (readMem == 1 ) storedData = memory[addrMem];
	end

	always @ (negedge writeMem) begin
	 if(state == 4'b1011) 
		memory[addrMem] = data;
	end
	
	reg [15:0] info;
	
	always@(CHAVE or state) begin
		if (state == 4'b1010) info = memory[CHAVE];
		else info = 0;
	end
	
	/* Atribuicao da posicao selecionada para as saidas. */
	assign dataIR  = storedData;
	assign dataMDR = storedData;
	
	/* Valor enviado para os displays. */
	assign VALOR = info;

endmodule

