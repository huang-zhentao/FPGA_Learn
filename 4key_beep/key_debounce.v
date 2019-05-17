//------------------
//file:key_debounce
//author:hzt
//------------------
module key_debounce(
		input 		sys_clk,
		input 		rst_n,
		input 		key,		//before debounce
		
		output 		reg key_flag,	//press flag
		output 		reg key_value	//after debounce
);

//reg define
reg [31:0] delay_cnt;
reg 			key_reg;



always@(posedge sys_clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			key_reg <= 1'b1;
			delay_cnt <= 32'b0;
		end
	else 
		begin
			key_reg <= key;						//把按键此时的值赋给key_reg
			if(key_reg != key)					//判断按键值是否改变
				delay_cnt <= 32'd1000000;		//计数器重装值
			else if(key_reg == key)	
					begin
						if(delay_cnt >= 32'd0)			//按键在稳定时，计数器开始递减，20ms
							delay_cnt = delay_cnt - 1'b1;
						else 
							delay_cnt <= delay_cnt;
					end
		end
		
end

always@(posedge sys_clk or negedge rst_n)
begin
		if(!rst_n)
			begin
				key_flag <= 1'b0;
				key_value <= 4'b1;				//未按下			
			end
		else if(delay_cnt == 32'd1)			//当计数器递减到1时，说明按键维持了20ms
						begin
							key_flag <= 1'b1;				//此时按键消抖结束，给出一个标志位
							key_value <= key;				//寄存此时的按键值			
						end
					else
						begin
							key_flag <= 1'b0;
							key_value <= key_value;
						end
end


endmodule 

