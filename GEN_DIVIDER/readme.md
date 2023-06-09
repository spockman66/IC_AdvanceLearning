## 各种分频器
分频器是各种手撕代码中的重点，因此在此将所有分频器的原理、实现和仿真汇总起来。

### **偶数分频器**

级联触发器分频：将每级寄存器的输出接到下一级寄存器的时钟信号上，$2^n$分频
计数器分频：从0开始，在DIV_PARAM/2-1时，计数器清零，时钟线翻转

- [clk_divider_even.v](./clk_divider_even.v)


### **奇数分频器**

奇数分频器跟偶数分频器一样，当计数器的值等于分频系数（加1或者减1）的一半或等于分频系数时，时钟信号翻转，形成两个40%或者60%占空比的信号。
上升沿和下降沿分别操，二者之间取或（40%）或者且（60%）

- [clk_divider_odd.v](./clk_divider_odd.v)


### **半数分频器**

半分频：用上升沿和下降沿各产生一个7分频的时钟信号，这两个信号分别在0和3处拉高，加上时钟沿不同，距离是3.5个时钟周期，用逻辑或的形式，即可产生无抖动3.5分频信号   

占空比50%的半分频：用上升沿和下降沿分别产生7分频的计数器，当正计数器值为0-3时，输出高电平，负计数器等于3时，输出高电平，两个信号周期均为7，取或即可。

- [clk_divider_half.v](./clk_divider_half.v)
- [clk_divider_half_50.v](./clk_divider_half_50.v).v（占空比50%）

### **浮点数分频器**

任意小数分频原理：43/5实际上是5个时钟周期内持续的时间信号为430ns
  - 双模前置小数分频
    - 对于8.6分频，整数部分为8，因此选用8分频和9分频来进行合成，列出二元方程组如下   
        $8a+9b=43$  
        $a+b=5$
    - 得出来a和b的解为2和3，即需要做2个8分频，3个9分频   
        (1) 先进行 2 次 8 分频，再进行 3 次 9 分频；   
        (2) 先进行 3 次 9 分频，再进行 2 次 8 分频；    
        (3) 将 2 次 8 分频平均的插入到 3 次 9 分频中；   
    - 实现：
        - 实际上很多种抽象方法，即用一个大的计数器count（从0计到4，即代表了5个周期）
        - 当count=0，2，4的时候，执行9分频，当count=1，3的时候，执行8分频


  - [clk_divider_float.v](./clk_divider_float.v)