//16x8 synchronous dual port RAM memory
module RAM_16x8_SYNCHRONOUS(data_out,rst,clk,Re,We,Wr_addr,Rd_addr,data_in);
parameter width=8,depth=16,addr_bus=4;
input rst;	//For control operation of RAM
input clk;	//For making synchronous with clock
input Re,We;	//ReadEnable and WriteEnable Selection Pins for RAM
input [width-1:0]data_in;	//8-Bit Data_in
input [addr_bus-1:0]Wr_addr,Rd_addr;	//4-bit Wr_addr & Rd_addr
output reg [width-1:0]data_out;
reg [width-1:0] mem [depth-1:0];		//Creating A Memory(MEM) of 16*8
integer x;
always@(posedge clk)
	begin
		if(rst)
			begin
				data_out <= 4'b0000;
				for(x=0;x<16;x=x+1)
					begin
						mem[x] <= 0;
					end
				end
		else if(We == 1)
			begin
				mem[Wr_addr] <= data_in;
			end
		else if(Re == 1)
			begin
				data_out <= mem[Rd_addr];
			end
	end
endmodule