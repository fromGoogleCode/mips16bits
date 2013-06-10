module muxReg (clock, Reg1, Reg2, RegDst, Dest);
	input  clock;
	input  [3:0]Reg1;
	input  [3:0]Reg2;
	input  RegDst;

	output [3:0]Dest;
	
	reg [3:0]Reg;
	/*
	always@(RegDst or Reg1 or Reg2)begin
		if(RegDst == 1'b0) Reg = Reg1;
		else Reg = Reg2;
	end*/
	
	always@(clock or Reg1 or Reg2 or RegDst)begin
	  case(RegDst)
	     1'b0: Reg = Reg1;
	     1'b1: Reg = Reg2;
	  endcase
	  
	end
	
	assign Dest = Reg;
endmodule 

	
