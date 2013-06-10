/*
	Modulo LCD a ser usado no tp01 de OCII 2013 - 01.
	O sinal de entrada "CLOCK_50" e os sinais de sada: "LCD_DATA" (8 bits), "LCD_RW", "LCD_EN", "LCD_RS", "LCD_ON", 
	"LCD_BLON" so padres da placa e devem ser declarados no mdulo principal do TP. Os sinais "r0", "r1", "r2"
	devem receber os valores dos registradores R0, R1, R2. O sinal "start" deve ser inicializado como "1'b0" e se
	tornar "1'b1" ao final de execuo do TP.
	
	O mdulo LCD deve ser declarado no mdulo principal do TP, um exemplo dessa declarao seria:
		LCD LCD(CLOCK_50, LCD_DATA, LCD_RW, LCD_EN, LCD_RS, LCD_ON, LCD_BLON, R0, R1, R2, wire_Start);
		
	Mais informaes sobre o uso do LCD podem ser encontradas no manual do usurio da Altera e no manual do fabricante
	do	LCD (ftp://ftp.altera.com/up/pub/Webdocs/DE2_UserManual.pdf e 
	http://ebookbrowse.com/lcd-cfah1602btmcjp-pdf-d225374640 respectivamente).

*/

module LCD(CLOCK_50, LCD_DATA, LCD_RW, LCD_EN, LCD_RS, LCD_ON, LCD_BLON, r0, r1, r2, start);

input CLOCK_50;
input [15:0] r0, r1, r2;
input start;

output [7:0] LCD_DATA;
output LCD_RW;
output LCD_EN;
output LCD_RS;
output LCD_ON;
output LCD_BLON;

wire [7:0] c0, c1, c2, c3, c4, c5;

reg [4:0] estado;
reg mudou_estado;
reg [32:0] conta_clock;
reg [7:0] data;
reg rs;
reg rw;
reg enable;
reg acende;

wire clk;

initial begin
  estado <= 4'b0000;
  mudou_estado <= 0;
  enable <= 0;
  acende <= 0;
end

always @(posedge CLOCK_50) begin
  conta_clock = conta_clock + 1'b1;
end

always @(posedge clk)begin
  case(estado)

    5'd0:begin
      enable <= 1;
      mudou_estado <= 0;
		if(start == 1)begin
			estado <= estado + 1'b1;
			acende <= 1'b1;
		end
		
		else estado <= 4'b0000;
		
    end

    5'd1: begin
      data <= 8'b00000001;
      mudou_estado <= 1;
      estado <= estado + 1'b1;
    end

    5'd2: begin
      enable <= 0;
      rs <= 0;
      rw <= 0;
      mudou_estado <= 0;
      estado <= estado + 1'b1;
    end

	5'd3:begin
      enable <= 1;
      estado <= estado + 1'b1;
      mudou_estado <= 0;
    end

    5'd4: begin
      data <= 8'b00001111;
      mudou_estado <= 1;
      estado <= estado + 1'b1;
    end

    5'd5: begin
      enable <= 0;
      rs <= 1;
      rw <= 0;
      mudou_estado <= 0;
	  data <= 8'b00000000;      
	  estado <= estado + 1'b1;
    end

	5'd6:begin
      enable <= 1;
      estado <= estado + 1'b1;
      mudou_estado <= 0;
    end

    5'd7: begin
      data <= c0;//C
      mudou_estado <= 1;
      estado <= estado + 1'b1;
    end

    5'd8: begin
      enable <= 0;
      rs <= 1;
      rw <= 0;
      mudou_estado <= 0;
      estado <= estado + 1'b1;
      end

	5'd9:begin
      enable <= 1;
      estado <= estado + 1'b1;
      mudou_estado <= 0;
    end


    5'd10: begin
      data <= c1;//o
      mudou_estado <= 1;
      estado <= estado + 1'b1;
    end
	 
	5'd11: begin
      enable <= 0;
      rs <= 1;
      rw <= 0;
      mudou_estado <= 0;
      estado <= estado + 1'b1;
   end

	5'd12:begin
      enable <= 1;
      estado <= estado + 1'b1;
      mudou_estado <= 0;
    end


    5'd13: begin
      data <= c2;//r
      mudou_estado <= 1;
      estado <= estado + 1'b1;
    end
	 
   5'd14: begin
      enable <= 0;
      rs <= 1;
      rw <= 0;
      mudou_estado <= 0;
      estado <= estado + 1'b1;
   end

	5'd15:begin
      enable <= 1;
      estado <= estado + 1'b1;
      mudou_estado <= 0;
    end

   5'd16: begin
      data <= c2;//r
      mudou_estado <= 1;
      estado <= estado + 1'b1;
    end
	 
   5'd17: begin
      enable <= 0;
      rs <= 1;
      rw <= 0;
      mudou_estado <= 0;
      estado <= estado + 1'b1;
   end

	5'd18:begin
      enable <= 1;
      estado <= estado + 1'b1;
      mudou_estado <= 0;
    end


   5'd19: begin
      data <= c3;//e
      mudou_estado <= 1;
      estado <= estado + 1'b1;
    end
	 
   5'd20: begin
      enable <= 0;
      rs <= 1;
      rw <= 0;
      mudou_estado <= 0;
      estado <= estado + 1'b1;
   end

	5'd21:begin
      enable <= 1;
      estado <= estado + 1'b1;
      mudou_estado <= 0;
    end


    5'd22: begin
      data <= c4;//t
      mudou_estado <= 1;
      estado <= estado + 1'b1;
    end
	 
    5'd23: begin
      enable <= 0;
      rs <= 1;
      rw <= 0;
      mudou_estado <= 0;
      estado <= estado + 1'b1;
    end

	5'd24:begin
      enable <= 1;
      estado <= estado + 1'b1;
      mudou_estado <= 0;
    end


    5'd25: begin
      data <= c1;//o
      mudou_estado <= 1;
      estado <= estado + 1'b1;
    end
	 
   5'd26: begin
      enable <= 0;
      rs <= 1;
      rw <= 0;
      mudou_estado <= 0;
      estado <= estado + 1'b1;
   end

	5'd27:begin
      enable <= 1;
      estado <= estado + 1'b1;
      mudou_estado <= 0;
    end


    5'd28: begin
      data <= c5;//!
      mudou_estado <= 1;
      estado <= estado + 1'b1;
    end

    5'd29: begin
      enable <= 0;
      rs <= 0;
      rw <= 0;
      mudou_estado <= 0;
      estado <= estado + 1'b1;
    end

	5'd30: begin
      mudou_estado <= 1;
      enable <= 0;
    end
  
   endcase
end

assign c0 = r0 [15:8];//C = 43;
assign c1 = r0 [7:0];//o = 6F;
assign c2 = r1 [15:8];//r = 72;
assign c3 = r1 [7:0];//e = 65;
assign c4 = r2 [15:8];//t = 74;
assign c5 = r2 [7:0];//! = 21; 
assign LCD_EN = enable;
assign LCD_ON = acende;
assign LCD_BLON = 0;
assign LCD_DATA = data;
assign LCD_RS = rs;
assign LCD_RW = rw;
assign clk = conta_clock [14];

endmodule