clear all;clc 
t=0:0.001:1;
y=chirp(t,10,0.5,100);             
% 参数t是时间序列，不是起始时刻，第二个参数是起始时刻的瞬时f，第三个是某一时刻，第四个是该时刻的瞬时f
subplot(211);plot(y);
subplot(212);plot(abs(fft(y)));