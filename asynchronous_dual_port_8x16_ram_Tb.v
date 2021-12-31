module asynchronous_dual_port_8x16_ram_Tb();
parameter width=16,depth=8,address=3;
reg rst,we,re;
reg rdclk,wrclk;
reg [address-1:0]wraddr,rdaddr;
reg [width-1:0]din;
wire[width-1:0]dout;
integer m,n;
asynchronous_dual_port_8x16_ram DUT(dout,din,wraddr,rdaddr,rdclk,wrclk,rst,we,re);
initial
    begin
        wrclk = 1'b0;
        forever #10 wrclk = ~wrclk;
    end
initial
    begin
        rdclk = 1'b0;
        forever #10 rdclk = ~rdclk;
    end

task initialization;
    begin
        we = 1'b0;
        re = 1'b0;
        rst= 1'b0;
        din=16'h0000;
    end
endtask

task resetting;
    begin
        @(negedge wrclk)
            rst = 1'b1;
        @(negedge wrclk)
            rst = 1'b0;
        @(negedge rdclk)
            rst = 1'b1;
        @(negedge rdclk)
            rst = 1'b0;
    end
endtask

task writingdata(input a,input[15:0]b,input[2:0]c);
    @(negedge wrclk)
    begin
        re = 1'b0;
        we = a;
        din= b;
        wraddr = c;
    end
endtask
    
task readingdata(input d,input[2:0]e);
    @(negedge rdclk) 
    begin
        we  =1'b0;
        re  =d;
        rdaddr=e;
    end
endtask

initial
    begin
        initialization;
        resetting;
        for(m=0;m<8;m=m+1)
            begin
                writingdata(1'b1,m+5,m);
            end
        #10;
        for(n=0;n<8;n=n+1)
            begin
                readingdata(1'b1,n);
            end
    end

initial
    begin
        $monitor("Time:%0t Datain=%d Dataout=%d",$time,din,dout);
        #600 $finish;
    end
    
endmodule