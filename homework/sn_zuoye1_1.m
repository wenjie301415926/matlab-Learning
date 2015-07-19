clear all;close all;clc;
fs=10000;%采样频率10kHz
f=100;%正弦波频率100Hz
tmax=0.03;
t=1/fs:1/fs:tmax;
y=sin(2*pi*f*t);
plot(t,y);
k=1/tmax:1/tmax:fs;
Y=fft(y);
figure;stem(k/1000,abs(Y));xlabel('kHz');