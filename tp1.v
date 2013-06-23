

module tp1 (CLOCK_50, KEY, SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, LCD_DATA, LCD_RW, LCD_EN, LCD_RS, LCD_ON, LCD_BLON);
		/* Entradas do mdulo. */
	input CLOCK_50;
	input [3:0] KEY;
	input [19:0] SW;
	
	/* Sadas do mdulo. */
	output [6:0] HEX0;
	output [6:0] HEX1;
	output [6:0] HEX2;
	output [6:0] HEX3;
	output [6:0] HEX4;
	output [6:0] HEX5;
	
	/* Saidas LCD. */
	output [7:0] LCD_DATA;
	output LCD_RW;
	output LCD_EN;
	output LCD_RS;
	output LCD_ON;
	output LCD_BLON;
	
	/* Componentes internos.*/
	reg [5:0] PC;				// Contador de programa.
	reg start;					// Inicializa a maquina.
	reg RegDst;
	reg EscreveReg;
	reg OrigAALU;
	reg [1:0] OrigBALU;
	reg [1:0]OpALU;
	reg LeMem;
	reg EscreveMem;
	reg MemparaReg;
	reg IouD;
	reg EscreveIR;
	reg EscrevePC;
	reg EscrevePCCond;
	reg [1:0] OrigPC;
	reg [15:0] A;
	reg [15:0] B;
	reg [15:0] IR;				// Registrador de instruo.
	reg [15:0] MDR;			// registrador de dados.
	reg [3:0] state;			// Contador de estados.
	reg [5:0] newPC;			// Valor de PC atualizado.
	reg [15:0] aluOut;
	reg [3:0] offsetLoadStore;
	reg [5:0] endereco;
	wire [5:0] selectedPC;
	wire zero;
	wire startSignal;			// Sinal que inicia o funcionamento do controle.
	wire overflow;
	wire [5:0] addrPC;
	wire [5:0] addrMem;
	wire [3:0] addra;
	wire [3:0] addrb;
	wire [3:0] addrc;
	wire [15:0] dataALU1;
	wire [15:0] dataALU2;
	wire [15:0] dataALU3;
	wire [15:0] dataALU4;
	wire [15:0] dataa;
	wire [15:0] datab;
	wire [15:0] datac;
	wire [3:0] opcSignal;	// Sinal de entrada para o Controle com o opcode.
	wire [3:0] prevState; 	// Sinal de entrada para o Controle com o estado anterior.
	wire [3:0] nextState;	// Sinal de sada do Controle com o prximo estado.
	wire [15:0] ctlSignal;	// Sinal de controle relativos ao estado corrente.
	wire [3:0] auxc;
	wire [15:0] auxMDR;
	wire [15:0] dataIR;
	wire [15:0] dataMDR;
	wire [15:0] operatorA;
	wire [15:0] operatorB;
	wire [15:0] jump;
	wire [3:0] controleALU;
	
	/* Saida do display LCD. */
	reg [15:0] r0;
	reg [15:0] r1;
	reg [15:0] r2;
	
	reg clockreg;
	initial begin
		//state = 4'b1010;
		state = 4'b0000;  //para teste
		start = 0;
		PC = 6'b000000;
		RegDst = 0;
		EscreveReg = 0;
		OrigAALU = 0;
		OrigBALU[1:0] = 0;
		OpALU = 0;
		LeMem = 0;
		EscreveMem = 0;
		MemparaReg = 0;
		IouD = 0;
		EscreveIR = 0;
		EscrevePC = 0;
		EscrevePCCond = 0;
		OrigPC[1:0] = 2'b11;
		clockreg = 0;
	end
	
	wire clock;

	assign clock = CLOCK_50;
	
	/* Atualiza os sinais de entrada do Controle. */
	assign opcSignal = IR[15:12];
	assign prevState = state;
	
	/* Ativa o Controle.*/
	Controle ctl(opcSignal,prevState,clock,ctlSignal,nextState);
	
	always@(posedge clock) state = nextState; 
	/*always@(posedge clock) begin
		if (KEY[0] == 1)begin
			state = nextState;
		end
		else state = 0;
	end*/
	
	 always@(ctlSignal) begin
	  if(ctlSignal != 0) begin
		  RegDst <= ctlSignal[0];
		  EscreveReg <= ctlSignal[1];
		  OrigAALU <= ctlSignal[2];
		  OrigBALU[1:0] <= ctlSignal[4:3];
		  OpALU <= ctlSignal[6:5];
		  LeMem <= ctlSignal[7];
		  EscreveMem <= ctlSignal[8];
		  MemparaReg <= ctlSignal[9];
	 	  IouD <= ctlSignal[10];
		  EscreveIR <= ctlSignal[11];
		  EscrevePC <= ctlSignal[12];
		  EscrevePCCond <= ctlSignal[13];
		  OrigPC[1:0] <= ctlSignal[15:14];
		end
	end
	
	wire [5:0] wirePC;
	//reg [5:0] aux;

	always@(negedge EscrevePC) begin
	  if(state == 4'b0001)
      PC <= selectedPC;
	  if(state == 4'b1100)
	   PC <= selectedPC;
	  if(state == 4'b1101 && zero == 1'b1)
		PC <= selectedPC;
	  //if (state == 4'b1010) PC <= 0;
   end
		
	assign wirePC = PC;
     
   mux_PC mxPC(clock, wirePC,dataALU1,addrMem,IouD);
	wire [15:0] store;

	/* Fios usados exclusivamente para verificar a memoria. */
	wire [5:0] CHAVEm;
	wire [5:0] CHAVE;
	wire [15:0]VALOR;
	wire [15:0]VALORb;
	//assign CHAVEm = SW[5:0];
	assign CHAVE = SW[5:0];
	
	Memoria mem(addrMem,LeMem,dataIR,dataMDR,EscreveMem,store,CHAVEm,VALOR,state);
	
	/* Envia o valor da posicao selecionada para os displays. */
	/*Display digit_0(HEX0,{VALOR[3],VALOR[2],VALOR[1],VALOR[0]});
	Display digit_1(HEX1,{VALOR[7],VALOR[6],VALOR[5],VALOR[4]});
	Display digit_2(HEX2,{VALOR[11],VALOR[10],VALOR[9],VALOR[8]});
	Display digit_3(HEX3,{VALOR[15],VALOR[14],VALOR[13],VALOR[12]});
	*/
	/* Envia o valor da posicao selecionada para os displays. */
	Display digit_0(HEX0,{VALORb[3],VALORb[2],VALORb[1],VALORb[0]});
	Display digit_1(HEX1,{VALORb[7],VALORb[6],VALORb[5],VALORb[4]});
	Display digit_2(HEX2,{VALORb[11],VALORb[10],VALORb[9],VALORb[8]});
	Display digit_3(HEX3,{VALORb[15],VALORb[14],VALORb[13],VALORb[12]});
	

	/*Verificando Status*/
	Display st(HEX4,{state[3],state[2],state[1],state[0]});
	
	/*Verificando pc*/
	Display pc(HEX5,{PC[3],PC[2],PC[1],PC[0]});
	
  reg [3:0] regADDRA;
  reg [3:0] regADDRB;
  reg [3:0] regADDRC;
  reg [5:0] bnch;
  reg [15:0] regjump;
  reg [15:0] immediate;
  
  always@(dataIR or dataMDR) begin
    MDR = dataMDR;
    if (EscreveIR == 1) begin
        IR <= dataIR;
    end
	 if(state == 4'b0001)begin
			if (IR[15:12] == 4'b1000  || IR[15:12] == 4'b1001) begin
				regADDRA = dataIR[7:4];  
				regADDRB = dataIR[3:0];
				regADDRC = dataIR[11:8];
				endereco = {{8{IR[7]}},IR[7:0]};
			end
			else begin
				regADDRA = dataIR[11:8];  
				regADDRB = dataIR[7:4];
				regADDRC = dataIR[3:0];
				immediate = {{12{1'b0}},dataIR[7:4]};
				if (dataIR[3] == 1'b0) bnch = PC + {{2{1'b0}},IR[3:0]};
				else if(dataIR[3] == 1'b1)bnch = PC - {{2{1'b0}},IR[3:0]};
				regjump = {{3{1'b0}},dataIR[11:0]};
			end
		end
  end
  
  assign addra = regADDRA;
  assign addrb = regADDRB;
  assign auxc  = regADDRC;
  
  assign dataALU1 = endereco;//acesso a memoria para load store
  assign auxMDR = MDR;
  
  muxReg mxRG(clock,addrb,auxc,RegDst,addrc);
  muxData mxDT(clock, auxMDR,dataALU2,MemparaReg,datac);
  
  wire [15:0]wire_r0;
  wire [15:0]wire_r1;
  wire [15:0]wire_r2;
  
  Banco bnc(clock,state, EscreveReg,addra,addrb,addrc,dataa,datab,datac, store, CHAVE, VALORb, wire_r0, wire_r1, wire_r2, KEY[1]);
  
  always@(dataa or datab) begin
    A <= dataa;
    B <= datab;
  end
    
  muxA mxA(clock,A,addrMem, OrigAALU, operatorA);
  muxB mxB(clock,B,immediate,OrigBALU, operatorB, IR[15:12]);

  AluControl alc(clock, OpALU, opcSignal, state, controleALU);
  
  ALU alu(clock, operatorA, operatorB, controleALU, dataALU3, overflow, zero);

  always@(dataALU3)begin
    aluOut = dataALU3; // PC
  end
  
  assign dataALU2 = aluOut;	//resultado de alu pra memoria
  assign dataALU4 =  {{10{1'b0}},bnch[5:0]}; //desvio
  assign jump = regjump;
  
  muxPc2 mxPC2(clock,dataALU3,dataALU4,jump,OrigPC,selectedPC); 
  
  reg startLCD;
  wire wire_startLCD;
  
	always@(state) begin
		if (state == 4'b1010)begin
			startLCD = 1'b1;
		end
		else startLCD = 1'b0;
	end
 
 
  assign wire_startLCD = startLCD; 
  
  LCD LCD(CLOCK_50, LCD_DATA, LCD_RW, LCD_EN, LCD_RS, LCD_ON, LCD_BLON, wire_r0, wire_r1, wire_r2, wire_startLCD);
  
endmodule
