clear all;clc;
n=0:9;
xn=cos(0.48*pi*n)+cos(0.52*pi*n);
y1=fft(xn);subplot(311);stem(abs(y1));
y2=fft(xn,100);subplot(312);stem(abs(y2));%相当于在xn后补了90个0
n=0:99;  %n取0:99相当于取得更密了
y3=fft(xn);subplot(313);stem(abs(y3));