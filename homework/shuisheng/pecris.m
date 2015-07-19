clear all;close all;clc;
H=30; 
z0=5; %��Դ���
c0=1500; 
f0=100;
N=fix((H*2*pi*f0/(pi*c0))+0.5);  %NΪ��������,fix,��0��£ȡ��
r=100;  %���յ�෢���ˮƽ����1000��
z=5; %���յ�ຣ��5��
fs=5000; 
T=0.2;  
t=0:1/fs:(T-1/fs); 
x=cos(2*pi*f0*t);

k=(0:length(t)-1)/length(t)*T;
subplot(211);plot(k,x);
xlabel('ʱ��/s');
ylabel('��ֵ');
title('�����ź�');

WN=(N-0.5)*c0*pi/H;
CN=c0*(1-(WN/2/pi/f0)^2)^0.5;
tmax=r/CN; 
pzero=tmax*fs;
s=zeros(1,length(t)+pzero);
for n=1:N
    kn=(n-0.5)*pi/H;
    sn=((2*pi*f0/c0)^2-kn^2)^0.5;
    wn=(n-0.5)*c0*pi/H; 
    cn=c0*(1-(wn/2/pi/f0)^2)^0.5;
    t(1,n+1)=r/cn; 
    pn=-j*2/H*((2*pi/r/sn)^0.5)*sin(kn*z)*sin(kn*z0)*exp(-j*(sn*r-(pi/4)))*exp(j*2*pi*f0*t);
    zq=fix((t(1,n+1)-t(1,n))*fs);
    zh=length(s)-length(pn)-zq; 
    p=[zeros(1,zq),pn,zeros(1,zh)];
    s=s+p;
end
t=(0:length(s)-1)/length(s)*length(s)/length(t)*T;
subplot(212);plot(t,real(s));
xlabel('ʱ��/s');
ylabel('��ֵ');
title('�����ź�');
figure(3),plot((0:length(s)-1)/length(s)*fs,abs(fft(real(s))));
title('FFT');axis([0,500,0,35]);



