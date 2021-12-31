module asynchronous_ram_8x16_singleport_tb();
reg we,enable;
reg addr;
wire [15:0]data;
reg [15:0] tempdata;
integer i;
asynchronous_ram_8x16_singleport DUT(data,addr,we,enable);
assign data = (we && enable) ? tempdata :16'hzzzz;


task initialize;
    begin
        we = 1'b0;
        enable = 1'b0;
        tempdata = 16'h0000;
    end
endtask
    
task stimulus(input[2:0]add,input[15:0]ddata);
    begin
        addr = add;
        tempdata = ddata;
    end
endtask

task  writing;
    begin
        we = 1'b1;
        enable = 1'b1;
    end
endtask

task reading;
    begin
        we = 1'b0;
        enable = 1'b1;
    end
endtask

initial
    begin
    initialize;
    #10;
    writing;
    for(i=0;i<8;i=i+1)
        begin
            stimulus (i,i);
            #10;
        end
    initialize;
    #10;
    reading;
    for(i=0;i<8;i=i+1)
        begin
            stimulus (i,i);
            #10;
        end
    end

initial
        begin
            $monitor("Time:%0t Datain=%d Dataout=%d",$time,data,data);
            #200 $finish;
        end
endmodule