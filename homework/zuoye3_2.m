clear all;clc;
t=10;
n=0:0.1:t-0.1;
xn=chirp(n);
xn1=[xn,zeros(1,100)];
xn_r=xn+3*randn(1,length(xn));
xn2=[zeros(1,100),xn_r];
y=xcorr(xn1,xn2);
plot(y);