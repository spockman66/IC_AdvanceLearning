close all;                  % 关闭文件操作
% clear all;                % 清零右边的工作区
clc;                        % 清除下方的命令窗口

% 创建一个文件
% coe所有的系数都乘以1024
% 所有的，变大的系数都存在一个文件里。
file_id = fopen('E:\study\3.lesson_for_fpga\1.fir_low_pass\document\num.txt', 'w');         %write

num_coe = coe .* 1024                           % 系数放大，    '.*' coe所有的系数，都会分别乘 1024
num_int = round(num_coe)                        % 四舍五入

% printf
%for i = 1:32
   fprintf(file_id, '%d\r\n', num_int); 
    
%end

fclose(file_id);



