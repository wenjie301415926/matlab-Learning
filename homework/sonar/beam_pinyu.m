clear all;close all;clc;
fs=6000;
c=1500;
N=32;
d=1;
theta_0=30;
fl=400;fh=700;

%�������ɿ���ź�
s_0=randn(1,6000);
b=fir1(10,[fl/(6000/2),fh/(6000/2)]);
s=filter(b,1,s_0);
%plot(abs(fft(s)));

%���ɷ���Ľ�������
for n=1:N
    tao(n)=round((n-1)*d*sind(theta_0)/c*fs);
    y(n,:)=s(n,1000+tao(n):5000+tao(n));
end

%Ƶ�����γ�
for n=1:N
    Y(n,:)=fft(y(n,:));
end
for theta=-90:90
    for f=fl:fh
        for n=1:N
         phase(n)=2*pi*f*(n-1)*d*sind(theta)/c;
         s_f(n)=Y(n,f)*exp(j*phase(n));
        end
        beam_f(f)=sum(s_f)
    end
    beam(theta)=sum(abs(beam_f(f)));
end