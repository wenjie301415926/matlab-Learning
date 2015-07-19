clear all;close all;
N=100;N_sample=8;      
Ts=1;dt=Ts/N_sample;
t=0:dt:(N*N_sample-1)*dt;

gt=ones(1,N_sample);
d=sign(randn(1,N));
a=sigexpand(d,N_sample);
st=conv(a,gt);            
ht1=gt;
rt1=conv(st,ht1);
ht2=5*sinc(5*(t-5)/Ts);
rt2=conv(st,ht2);
figure(1)
subplot(321)
plot(t,st(1:length(t)));
axis([0 20 -1.5 1.5]);ylabel('输入双极性NRZ数字基带波形 ');
subplot(322)
stem(t,a);
axis([0 20 -1.5 1.5]);ylabel('输入数字序列');
subplot(323)
plot(t,[0 rt1(1:length(t)-1)]/8);
axis([0 20 -1.5 1.5]);ylabel('方波滤波后输出');
subplot(324)
dd=rt1(N_sample:N_sample:end);
ddd=sigexpand(dd,N_sample);
stem(t,ddd(1:length(t))/8);
axis([0 20 -1.5 1.5 ]);ylabel('方波滤波后抽样输出');
subplot(325)
plot(t-5,[0 rt2(1:length(t)-1)]/8);
axis([0 20 -1.5 1.5 ]);
xlabel('t/Ts');ylabel('理想低通滤波器输出');
subplot(326)
dd=rt2(N_sample-1:N_sample:end);
ddd=sigexpand(dd,N_sample);
stem(t-5,ddd(1:length(t))/8);
axis([0 20 -1.5 1.5 ]);
xlabel('t/Ts');ylabel('理想低通滤波器抽样输出 ');