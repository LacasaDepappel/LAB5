module clkbuffer_Tb();
reg Mclk;
wire Bufclk;
realtime t1,t2,t3,t4,t5,t6;
realtime frequency,phase;
clkbuffer DUT(Mclk,Bufclk);

initial
	begin
		Mclk = 1'b0;
		forever #5 Mclk = 1'b1;
	end
task master;
	begin
	@(posedge Mclk) t1 <= $realtime;
	@(negedge Mclk) t2 <= $realtime;
	t3 = t2-t1;
	end
endtask

task buffer;
	begin
		@(posedge Bufclk) t3 <=$realtime;
		@(negedge Bufclk) t4 <=$realtime;
		t5 = t4-t3;
	end
endtask

task verifying;
			begin
				frequency = t5-t3;
				phase = t3 - t1;
				$monitor("FreqDiff=%0t,Phasefifference = %0t",frequency,phase);
			end
endtask

initial
begin
master;
buffer;
verifying;
end

initial
begin
$monitor("FreqDiff=%0t,Phasefifference = %0t",frequency,phase);
#100 $finish;
end
endmodule