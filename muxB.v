module muxB (clock, B, Immediate, OrigBALU,Data, opcode);
	input  clock;
	input  [15:0]B;
	input  [3:0]Immediate;
	input  [3:0]opcode;
	input  [1:0]OrigBALU;

	output [15:0]Data;
	
	reg [15:0]Reg;
	
	wire [3:0]extendImmediate;
	assign extendImmediate = {{12{1'b0}},Immediate[3:0]};
	
	
	always@(clock or B or OrigBALU or Immediate)begin
	  
	 case (OrigBALU)
      2'b00:begin
			if (opcode == 4'b0010) Reg = extendImmediate;
			else Reg = B;
		end
      2'b01: Reg = 16'h0001;
      2'b10: Reg = extendImmediate;
      2'b11: Reg = extendImmediate << 2;
   endcase
  end
	
	assign Data = Reg;

endmodule