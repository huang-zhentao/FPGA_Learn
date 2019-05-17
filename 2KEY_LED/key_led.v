//无按键按下时， LED灯全灭； 按键1按下时， LED灯显示
//自右向左的流水效果；按键2按下时， LED灯显示自左向右的流水效果；
//按键3按下时，四个LED灯同时闪烁； 按键4按下时， LED灯全亮。

module key_led(
		input sys_clk,
		input rst_n,
		
		output reg [3:0] key,
		output reg [3:0] led
);

reg [23:0] cnt;
reg [1:0] led_control;

//系统时钟，计数器计数，计时0.2s
always@(posedge sys_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt <= 0;
		else if(cnt < 24'd9_999_999)//计数满0.2S,此处于上个流水灯实验不同，上个流水灯实验实际上多计数了一个周期，此处刚好1000_0000个周期
		cnt <= cnt + 1'b1;
		else 
			cnt <= 24'd0;
end

//led状态选择
always@(posedge sys_clk or negedge rst_n)
begin
	if(!rst_n)
		led_control <= 0;
	else if(cnt == 24'd9_999_999)
				led_control <= led_control + 1'b1;
			else	
				led_control <= led_control;
end


//检测按键
always@(posedge sys_clk or negedge rst_n)
begin
	if(!rst_n)
		led <= 4'b0000;			//led全灭
	else if(key[0]==0)
			begin
				case(led_control)
				2'b00:led <= 4'b1000;
				2'b01:led <= 4'b0100;
				2'b10:led <= 4'b0010;
				2'b11:led <= 4'b0001;
				default:led <= 4'b0000;				
			end
	else if(key[1]==0)
			begin
				case(led_control)
				2'b00:led <= 4'b0001;
				2'b01:led <= 4'b0010;
				2'b10:led <= 4'b0100;
				2'b11:led <= 4'b1000;
				default:led <= 4'b0000;				
			end
	else if(key[2]==0)
			begin
				case(led_control)
				2'b00:led <= 4'b1111;
				2'b01:led <= 4'b0000;
				2'b10:led <= 4'b1111;
				2'b11:led <= 4'b0000;
				default:led <= 4'b0000;				
			end
	else if(key[3]==0)
			led <= 4'b1111;
		else
			led <= 4'b0000;

end

endmodule 
