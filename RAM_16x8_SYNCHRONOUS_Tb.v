//16x8 synchronous dual port RAM memory
module RAM_16x8_SYNCHRONOUS_Tb();
parameter width=8,depth=16,addr_bus=4;
reg rst,clk;
reg Re,We;
reg [width-1:0]data_in;
reg [addr_bus-1:0]Wr_addr,Rd_addr;
wire [width-1:0]data_out;
RAM_16x8_SYNCHRONOUS DUT(data_out,rst,clk,Re,We,Wr_addr,Rd_addr,data_in);

//CLOCK GENERATION
initial
	begin
		clk = 1'b0;
		forever #5 clk = ~clk;
	end

//Initialization the memory with some default values
task initialization;
	begin
	{data_in,rst} = 9'b 000000001;
	end
endtask

//Resetting the RAM to Zero's
task resetting;
	begin
	    @(negedge clk)
		    begin
		    	rst = 1'b1;
		    end
	    @(negedge clk)
		    begin
			    rst = 1'b0;
		    end
	end
endtask

//Writing Random data_in in Random Loaction
task writingdata(input [7:0]k,input [3:0]j,input l);
	begin
	@(negedge clk)
	    begin
	        data_in=k;
	        Wr_addr = j;
			Re = 0;
	        We = l;
	    end
	 end
	
endtask

//Reading data which has been written in Memory
task readingdata(input [3:0]m,input n);
	begin
	    @(negedge clk)
	         begin
	                Rd_addr = m;
					We = 0;
	                Re=n;
	            end
	 end
endtask

//Getting sequence of operation running sequentially
initial
	begin
	initialization;
	resetting;
	#10 writingdata({$random},4'b1011,1'b1);
	#10 readingdata(4'b1011,1'b1);
	end

initial
	begin
	$monitor("Time:%d Clk=%b Rst=%b We=%b Re=%b Wr_addr=%d Rd_addr=%d data_in=%d data_out=%d",$time,clk,rst,We,Re,Wr_addr,Rd_addr,data_in,data_out);
	#70 $finish;
	end

endmodule