clear;clc;
%设计滤波器
fs=10000;
wp=400/(fs/2);ws=1500/(fs/2);ap=3;as=60;%作数字滤波器时wp,ws要进行归一化处理，即除以(fs/2)
[N,wc]=buttord(wp,ws,ap,as);
[B,A]=butter(N,wc);
%fk=0:fs/512:fs-fs/512;wk=2*pi*fk;
Hk=freqs(B,A);
plot(20*log10(abs(Hk)));grid on;