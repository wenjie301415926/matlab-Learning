clear all;close all;clc;
fs=100;Ts=1;
f0=10;A=1;
t=1/fs:1/fs:Ts;
cw=A*exp(j*2*pi*f0*t);
subplot(211);plot(real(cw));
subplot(212);plot(abs(fft(cw)));
cw_mohu=mohu(cw);