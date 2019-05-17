//------------------
//file:beep_control
//author:hzt
//------------------
module beep_control(
		input 		sys_clk,
		input 		rst_n,
		
		input 		key_flag,
		input 		key_value,
		
		output reg 	beep
);

always@(posedge sys_clk or negedge rst_n)
begin
	if(!rst_n)
		beep <= 1'b1;			//开启
		else if(key_flag && (~key_value))	//按键按下确认，蜂鸣器取反开始关闭，当再次检测到按下，再次取反，开始鸣叫
		beep <= ~beep;
end


endmodule 
