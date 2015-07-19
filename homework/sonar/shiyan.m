clear all;close all;clc;
fs=1000;t=1/fs:1/fs:1;
tao=2500/fs;
f=40;
x1=cos(2*pi*f*t);
x=[x1];
y=[zeros(1,tao*fs),x1,zeros(1,1000)];
subplot(311);plot(x);axis([0,5000,-1,1])
subplot(312);plot(y);axis([0,5000,-1,1])
subplot(313);plot(xcorr(y,x));