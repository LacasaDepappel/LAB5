//Asynchronous 8*16 Dualport RAM
//8--->DEPTH
//16-->WIDTH

module asynchronous_dual_port_8x16_ram(dout,din,wraddr,rdaddr,rdclk,wrclk,rst,we,re);
parameter width=16,depth=8,address=3;
input rst,we,re;
input rdclk,wrclk;
input [address-1:0]wraddr,rdaddr;
input [width-1:0]din;
output reg [width-1:0]dout;
reg [width-1:0]mem[depth-1:0];
integer x;
always @(posedge wrclk or posedge rst)
    begin
        if(rst)
            begin
                for(x=0;x<8;x=x+1)
                    begin
                        mem[x] <= 0;
                    end
            end
        else if(we)
            begin
                mem[wraddr] <= din;
            end
    end

always @(posedge rdclk or posedge rst)
    begin
        if(rst)
            begin
                dout <= 16'h0000;
            end
        else if(re)
            begin
                dout <= mem[rdaddr];
            end
    end

endmodule