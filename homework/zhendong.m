close all;clear all;clc;
%y=wavread('line42');%������Ҫ������wav��ʽ����Ƶ
y=wavrecord(5*12000,12000);
sound(y,12000);
len=length(y);fs=44100;
t=0:1/fs:len/fs-1/fs;%ʱ�򶨱�
subplot(211);plot(t,y);
title('ʱ�����');xlabel('��λ����');
Y=fft(y);
k=0:fs/len:fs-fs/len;%Ƶ�򶨱�
subplot(212);plot(k/1000,abs(Y));
%ֻ��ʾ0-5k
title('Ƶ�����');xlabel('��λ��kHz');