clear all;close all;clc;
%数据来源为盐度剔除异常值后线性插值
load('yandu_2_line');

%直接画直方图
hist(temper2); title('直接法求盐度直方图');

%利用Diaconis-Freodman方法作直方图
standard_deviation=std(temper2);%标准差
n=length(temper2);%数据长度
Group_width=1.349*standard_deviation*((log(n)/n).^(1/3));%组距
Group_number=round((max(temper2)-min(temper2))/Group_width);%组数
figure;hist(temper2,Group_number); title('D-F法求盐度直方图');

%累积频率曲线和保证率曲线
[K,X]=hist(temper2,Group_number);%求出K和N
y=0; %中间变量
for i=Group_number:-1:1;%从大到小累加
y=y+K(i);
P(i)=y.*100./(sum(K)+1); %保证率
P1=1-P; %计算经验累积频率
end
figure;plot(X,P1) ;hold on;
plot(X,P,'r');legend('盐度经验累积频率图','保证率曲线');hold off;

%箱线图
figure;boxplot(temper2);title('盐度箱线图');%箱线图


%傅里叶频谱分析
x=detrend(temper2);%去除趋势项
X=fft(x);
figure;plot(abs(X));title('fft直接处理');

%利用matlab自带函数求功率谱密度
wc=[0,0.65];%宽带截止频率
Fs=24;%信号采样率
N_fft=1024;%fft个数
window=blackman(N_fft+1);%构造窗函数平滑
a=fir1(N_fft,wc,window);%
xx=filter(a,1,x);
figure;pwelch(x,window,20,N_fft,Fs,'onesided')%估计信号的功率谱密度
title('利用matlab自带函数求功率谱密度')