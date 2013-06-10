module mux_PC (clock, PC, aluOut, addr, IouD);
	input clock;
	input [5:0] PC;
	input [15:0] aluOut;
	input IouD;
	
	output [5:0] addr;
	
	reg [5:0] C;
	
	
	always@(clock or aluOut or IouD or PC)begin
	  case(IouD)
	    1'b0: C = PC;
	    1'b1: C = aluOut[5:0];
	  endcase 
	end
	
	assign addr = C;
	
endmodule
