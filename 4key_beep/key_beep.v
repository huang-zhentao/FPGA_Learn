//------------------
//file:顶层模块
//author:hzt
//------------------
module key_beep(
		input 		sys_clk,
		input 		rst_n,
		input 		key,
		
		output 		beep
);

wire key_value;
wire key_flag;
//例化消抖
key_debounce u_key_debounce(
			.sys_clk			(sys_clk),
			.rst_n			(rst_n),
			.key				(key),
			.key_flag		(key_flag),
			.key_value		(key_value)
);

//例化蜂鸣器
beep_control u_beep_control(
			 .sys_clk 			(sys_clk),
			 .rst_n 				(rst_n),
			 .key_value 		(key_value),
			 .key_flag 			(key_flag),
			 .beep 				(beep),
 );


endmodule
