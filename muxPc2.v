module muxPc2 (clock, ALUOut, Dest, Jump, OrigPC, newPC);
	/* Entradas do mdulo. */
	input clock;
	input [15:0] Jump;
	input [15:0] ALUOut;
	input [15:0] Dest;
	input [1:0 ] OrigPC;
	
	/* Sada do mdulo. */
	output [5:0] newPC;
	
	/* Componentes internos. */
	reg [5:0] addr;	// Endereo selecionado.
	
	always@(clock or OrigPC or Jump or Dest) begin
    case (OrigPC)
      2'b00: addr = ALUOut[5:0];
      2'b01: addr = Dest[5:0]; //pc
      2'b10: addr = Jump[5:0]; 
    endcase
  end
	
	/* Novo endereo de PC. */
	assign newPC = addr;

endmodule
