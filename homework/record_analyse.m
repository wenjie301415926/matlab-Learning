close all;clear all;clc;
y=wavrecord(44100*3,44100);
sound(y,44100);

len=length(y);fs=44100;
t=0:1/fs:len/fs-1/fs;%时域定标
subplot(211);plot(t,y);
title('时域分析');xlabel('单位：秒');

Y=fft(y);
k=0:fs/len:fs-fs/len;%频域定标
subplot(212);plot(k/1000,abs(Y));
axis([0,5,0,1000]);
title('频域分析');xlabel('单位：kHz');
