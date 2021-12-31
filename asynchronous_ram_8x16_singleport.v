module asynchronous_ram_8x16_singleport(data,addr,we,enable);
input we,enable;
input addr;
inout [15:0]data;
reg [15:0]mem[7:0];
always @(enable or we or addr or data)
        if(we & enable)
            mem[addr] <= data;
        assign data = (enable && !we) ? mem[addr] :16'hzzzz;
endmodule