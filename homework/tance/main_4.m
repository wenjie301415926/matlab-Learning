clear all;close all;clc;
%������ԴΪ�ζ��޳��쳣ֵ�����Բ�ֵ
load('yandu_2_line');

%ֱ�ӻ�ֱ��ͼ
hist(temper2); title('ֱ�ӷ����ζ�ֱ��ͼ');

%����Diaconis-Freodman������ֱ��ͼ
standard_deviation=std(temper2);%��׼��
n=length(temper2);%���ݳ���
Group_width=1.349*standard_deviation*((log(n)/n).^(1/3));%���
Group_number=round((max(temper2)-min(temper2))/Group_width);%����
figure;hist(temper2,Group_number); title('D-F�����ζ�ֱ��ͼ');

%�ۻ�Ƶ�����ߺͱ�֤������
[K,X]=hist(temper2,Group_number);%���K��N
y=0; %�м����
for i=Group_number:-1:1;%�Ӵ�С�ۼ�
y=y+K(i);
P(i)=y.*100./(sum(K)+1); %��֤��
P1=1-P; %���㾭���ۻ�Ƶ��
end
figure;plot(X,P1) ;hold on;
plot(X,P,'r');legend('�ζȾ����ۻ�Ƶ��ͼ','��֤������');hold off;

%����ͼ
figure;boxplot(temper2);title('�ζ�����ͼ');%����ͼ


%����ҶƵ�׷���
x=detrend(temper2);%ȥ��������
X=fft(x);
figure;plot(abs(X));title('fftֱ�Ӵ���');

%����matlab�Դ������������ܶ�
wc=[0,0.65];%�����ֹƵ��
Fs=24;%�źŲ�����
N_fft=1024;%fft����
window=blackman(N_fft+1);%���촰����ƽ��
a=fir1(N_fft,wc,window);%
xx=filter(a,1,x);
figure;pwelch(x,window,20,N_fft,Fs,'onesided')%�����źŵĹ������ܶ�
title('����matlab�Դ������������ܶ�')