module key_board(
		input 				sys_clk,			//50MHz
		input 				rst_n,
		input 		[3:0] row,		//矩阵键盘 行
		output reg 	[3:0] col,		//矩阵键盘 列
		output reg 	[3:0] key_value
);

//----------
//分频开始
//----------
reg [19：0] cnt;

always@(posedge sys_clk or negedge rst_n)
begin
	if(!rst_n)
		cnt <= 0;
	else 
		cnt <= cnt + 1'b1;
end

wire key_clk = cnt[19];			//(2^20/50M = 21 )ms

endmodule 
