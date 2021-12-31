
//CLOCK-BUFFER
module clkbuffer(Mclk,Bufclk);
input Mclk; 	//Master Clock
output Bufclk;	//Buffer Clock as output
buf B1(Bufclk,Mclk);
endmodule