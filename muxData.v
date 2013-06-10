module muxData (clock, MDR, AluOut,MemToReg, Data);
	input  [15:0]MDR;
	input  [15:0]AluOut;
	input  MemToReg;
	input  clock;
	output [15:0]Data;

	reg [15:0] Reg;


	always@(clock or MDR or AluOut)begin //tava so clock
		/*if(MemToReg == 1'b0) Reg = AluOut;
		else Reg = MDR;*/
		case(MemToReg)
		  1'b0: Reg = AluOut;
		  1'b1: Reg = MDR;
		endcase
		
	end

	assign Data = Reg;

endmodule
