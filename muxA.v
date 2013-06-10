 module muxA (clock, A, PC, OrigAALU,Data);
	input  clock;
	input  [15:0] A;
	input  [5:0 ] PC;
	
	input  OrigAALU;
	
	output [15:0]Data;
	
	reg [15:0]Reg;
	
	wire [15:0]extendPc; 
	assign extendPc = {{10{PC[5]}},PC[5:0]};
	/*
	always@(OrigAALU or PC or A)begin
		if(OrigAALU == 1'b0) Reg = extendPc;
		else Reg = A; 
	end*/
	
	always@(posedge clock) begin //funcionou
	   case(OrigAALU)
	     1'b0: Reg = extendPc;
	     1'b1: Reg = A;
	   endcase
	     
	end
	
	assign Data = Reg;
	
endmodule 

