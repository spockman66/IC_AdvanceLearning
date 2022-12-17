# ========================< 清空软件残留信息 >==============================

# 退出之前仿真
quit -sim

# 清空信息
.main clear

# =========================< 建立工程并仿真 >===============================

# 得到工程名
set in0 "small random"

# 建立新的工程库
vlib work

# 映射逻辑库到物理目录
vmap work work

# 编译仿真文件
# vlog ./tb/*.v

# 编译设计文件
vlog ./rtl/*.v

# 无优化simulation                                      *** 请修改文件名 ***
vsim -novopt work.tb

#取消warning，例如‘x’，‘u’，‘z’信号的警告，对提高编译速度很有帮助
set StdarithNoWarning 1

# ============================< 加载波形 >=================================

# 添加波形，radix：binary, octal, decimal, signed, unsigned, hexadecimal, ascii or default.
add wave -radix hexadecimal ./*

# 清空信息
.main clear

# 跑完
run -all