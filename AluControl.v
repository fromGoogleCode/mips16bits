module AluControl(clock, OpAlu, Opcode, state, newOpcode);
	input clock;
	input [1:0] OpAlu;
	input [3:0] Opcode;
	input [3:0] state;
	output [3:0] newOpcode;
   
	reg [3:0] aux;
	
	always @ (negedge clock) begin
		// Jump:
		if(Opcode == 4'b1011) aux = 4'b0000; 
		// Load:
		else if(Opcode == 4'b1000) aux = 4'b0000;
		// Store:
		else if(Opcode == 4'b1001) aux = 4'b0000;
		//Branch:
		else if(Opcode == 4'b1010 && state == 4'b0001) aux = 4'b0000;
		else if(Opcode == 4'b1010 && state == 4'b1000) aux = 4'b0001;
		else if (OpAlu == 2'b00) aux = 4'b0000; // incrementar o pc
		// Tipo R:
		else aux = Opcode;
	end
	
	assign newOpcode = aux;

endmodule