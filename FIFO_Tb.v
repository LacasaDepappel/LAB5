//SYNCHRONOUS FIFO
module FIFO_Tb();
reg [15:0]din;
reg clk;
reg re,we,rst;
wire [15:0]dout;
wire full;
wire empty;
integer x;
FIFO F1(dout,empty,full,re,we,rst,clk,din);

initial
    begin
        clk=1'b0;
        forever #5 clk =~clk;
    end
    
task initialization;
    begin
        rst = 1'b0;
        we = 1'b0;
        re = 1'b0;
        din=16'h0000;
    end
endtask
task resetting;
    begin
    @(negedge clk)
        rst =1'b1;
    @(negedge clk)
        rst = 1'b0;
    end
endtask    
task writingdata(input [15:0]j);
    @(negedge clk)
        begin
            re = 1'b0;
            we = 1'b1;
            din = j;
        end
endtask

task reading;
    @(negedge clk)
        begin
            we =1'b0;
            re = 1'b1;
        end
endtask

task delay;
    begin
        #10;
    end
endtask

initial
    begin
        initialization;
        resetting;
        delay;
        for(x=0;x<8;x=x+1)
            begin
                writingdata(x);
            end
        delay;
        reading;
        delay;
    end

initial
    begin
        $monitor("Time:%0t Din=%d Dout=%d Full=%b Empty=%b",$time,din,dout,full,empty);
        #200 $finish;
    end
endmodule