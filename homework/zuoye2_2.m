clear all;clc;
n=0:9;
xn=cos(0.48*pi*n)+cos(0.52*pi*n);
y1=fft(xn);subplot(311);stem(abs(y1));
y2=fft(xn,100);subplot(312);stem(abs(y2));%�൱����xn����90��0
n=0:99;  %nȡ0:99�൱��ȡ�ø�����
y3=fft(xn);subplot(313);stem(abs(y3));