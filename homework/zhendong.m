close all;clear all;clc;
%y=wavread('line42');%读入需要分析的wav格式的音频
y=wavrecord(5*12000,12000);
sound(y,12000);
len=length(y);fs=44100;
t=0:1/fs:len/fs-1/fs;%时域定标
subplot(211);plot(t,y);
title('时域分析');xlabel('单位：秒');
Y=fft(y);
k=0:fs/len:fs-fs/len;%频域定标
subplot(212);plot(k/1000,abs(Y));
%只显示0-5k
title('频域分析');xlabel('单位：kHz');