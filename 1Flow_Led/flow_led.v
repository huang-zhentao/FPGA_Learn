module flow_led(
		input sys_clk,		//系统时钟50MHz
		input rst_n,
		
		output reg [3:0] led

);

//reg define
/*
aim:解释为什么是24位的计数器
explain:因为系统时钟是50Mhz，所以计时周期是20ns，我们要实现延时0.2秒，则需要计时10^7个周期，10^7的二进制至少需要24位。
*/
reg [23:0] cnt;


//系统时钟，计数器计数，计时0.2s
always@(posedge sys_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt <= 0;
	else if(cnt < 24'd1000_0000)//计数满0.2S
		cnt <= cnt + 1'b1;
		else 
			cnt <= 24'd0;
end

//通过移位寄存器控制IO口的高低电平
always@(posedge sys_clk or negedge rst_n)
begin
	if(!rst_n)
		led <= 4'b0001;
	else if(cnt == 24'd1000_0000)
		led[3:0] <= {led[2:0],led[3]};//低三位拼接上高位，实现左移操作
		else  
		led <= led;
		
end

endmodule
