close all;clear all;clc;
y=wavread('I Will Always Love You1');%������Ҫ������wav��ʽ����Ƶ
sound(y,44100);
len=length(y);fs=44100;
t=0:1/fs:len/fs-1/fs;%ʱ�򶨱�
subplot(211);plot(t,y);
title('ʱ�����');xlabel('��λ����');
Y=fft(y);
k=0:fs/len:fs-fs/len;%Ƶ�򶨱�
subplot(212);plot(k/1000,abs(Y));
axis([0 5 0 10000]);%ֻ��ʾ0-5k
title('Ƶ�����');xlabel('��λ��kHz');