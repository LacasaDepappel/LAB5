//SYNCHRONOUS FIFO
module FIFO(dout,empty,full,re,we,rst,clk,din);
input [15:0]din;
input clk;
input re,we,rst;
reg [3:0]rdaddr;
reg [3:0]wraddr;
output reg [15:0]dout;
output full;
output empty;
reg [15:0]mem[7:0];
integer i;
always@(posedge clk)
    begin
        if(rst)
            for(i=0;i<8;i=i+1)
                begin
                    wraddr <= 4'b000;
                    mem[i] = 0;
                end
        else if(we && !full)
                begin
                    mem[wraddr[3:0]] <= din;
                    wraddr[3:0] = wraddr[3:0]+1;
                end
    end
always@(posedge clk)
    begin
        if(rst)
            begin
                dout <=16'h0000;
                rdaddr[3:0] <= 4'h0;
            end
        else if(re && !empty)
            begin   
               dout <= mem[rdaddr[3:0]];
                rdaddr = rdaddr[3:0]+1;
            end
    end
assign empty = (wraddr == rdaddr)? 1'b1 : 1'b0;
assign full = (wraddr == {~rdaddr[3],rdaddr[2:0]} ) ? 1'b1 : 1'b0;

endmodule