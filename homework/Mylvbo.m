fs=2400;    %采样频率1.5--5KHz
N=600;      %采N个点,用时间N/fs秒
n=0:N-1;
t=n/fs;     %时间序列

%构建只有两个频率成分的余弦信号cos(2*pi*fL*t)+cos(2*pi*fH*t)
fL=20;      %原信号低频成分
fH=100;     %原信号高频成分
s=5*cos(2*pi*fL*t)+3*cos(2*pi*fH*t);%信号采集
s=s+randn(1,N); %加噪声
sfft=fft(s);    %信号频域分析

%信号时域和频域可视化
figure(1);
subplot(121);
plot(t,s);
%axis([0,N/fs,-10,10]);
title('输入信号');xlabel('t/s');ylabel('幅值');

%频域
subplot(122);
len_sfft=length(sfft);                  %获取频域数据长度
fss=(0:len_sfft-1)*fs/N;                %构建频率序列,频域的离散间隔为1/(N*Ts)即fs/N
plot(fss,2*abs(sfft)/length(sfft));     %其实频域可视化len_sfft/2个数据点即可(2pi周期,pi处为高频)
axis([0,fs/2,0,10]);
title('信号频谱');xlabel('频率/Hz');ylabel('幅值');

%设计低通滤波器
Wp=100/fs;      %通带截止频率为100Hz
Ws=200/fs;      %阻带截止频率为200Hz
ap=1;           %通带波纹小于1db
as=50;          %阻带衰减大于50db
[n,Wn]=buttord(Wp,Ws,ap,as);    %估计得到Butterworth低通滤波器的最小阶数n和截至频率Wn
[a,b]=butter(n,Wn);             %设计Butterworth低通滤波器
[h,f]=freqz(a,b,'whole',fs);    %求数字低通滤波器的频率响应
f=(0:length(f)-1)*fs/length(f); %进行对应的频率转换

%绘制Butterworth低通滤波器的频率响应图
figure(2)
plot(f(1:length(f)/2),abs(h(1:length(f)/2)));%其实频域可视化length(f)/2个数据点即可(2pi周期,pi处为高频)
title('Butterworth低通滤波器');xlabel('频率/Hz');ylabel('幅值');
grid;

%信号s进行滤波处理,以及处理后的信号时域和频域可视化  
%问题
%时域信号滤波处理,时域卷积(信号进来与存储的冲激响应序列相乘叠加),频域乘积
sF=filter(a,b,s); 
figure(3);          
subplot(121);
plot(t,sF);         %时域
title('输出信号');xlabel('t/s');ylabel('幅值');
subplot(122);
SF=fft(sF);         %频域
plot((0:length(SF)-1)*fs/length(SF),2*abs(SF)/length(SF)); %其实频域显示length(SF)/2个数据点即可(2pi周期,pi处为高频)
axis([0,fs/2,0,10]);
title('低通滤波器滤波处理后的频谱图');xlabel('频率/Hz');ylabel('幅值');
grid;


%音乐信号滤波处理
[mymusic,ft,bit]=wavread('wavf.wav');
wavplay(mymusic,ft,'async');                %播放原music信号
pause(10);
mymusicF=filter(a,b,mymusic);
figure(4);          
subplot(121);
plot((0:length(mymusic)-1)/ft,mymusic);          %时域原音乐信号可视化
title('原music信号');xlabel('t/s');ylabel('幅值');
subplot(122);
plot((0:length(mymusicF)-1)/ft,mymusicF);        %时域滤波处理后音乐信号可视化
title('低通滤波后的music信号');xlabel('t/s');ylabel('幅值');

wavplay(mymusicF,ft,'async');                   %播放滤波处理后的music信号
pause(10);

figure(5);
subplot(121);                                    %频域原音乐信号可视化
mymusicfft=fft(mymusic);
len_mfft=length(mymusicfft);
plot((0:len_mfft/2-1)*ft/len_mfft,2*abs(mymusicfft(1:len_mfft/2))/len_mfft); %其实频域可视化len_mfft/2个数据点即可(2pi周期,pi处为高频)
title('原music信号的频谱');xlabel('频率/Hz');ylabel('幅值');
subplot(122);                       %频域滤波处理后的音乐信号可视化
mymusicFfft=fft(mymusicF);
len_mFfft=length(mymusicFfft);
plot((0:len_mFfft/2-1)*ft/len_mFfft,2*abs(mymusicFfft(1:len_mFfft/2))/len_mFfft);     %其实频域可视化len_mfft/2个数据点即可(2pi周期,pi处为高频)
title('滤波处理后的music信号的频谱');xlabel('频率/Hz');ylabel('幅值');


%提高music音调,用circshif循环左右移tft/len_mfft*NN 个Hz  0.1
%用原信号做音调提高
Right=2000;
Left=-2000;
HmR=circshift(mymusicfft(1:len_mfft/2),Right);
HmL=circshift(mymusicfft(len_mfft/2+1:len_mfft),Left);
Hmusicfft=[HmR;HmL];
hmusic=real(ifft(Hmusicfft));
wavplay(hmusic,ft,'async');                  %播放提高音调处理后的music信号

figure(6);
subplot(121)
plot((0:length(hmusic)-1)/ft,hmusic);        %调高音调处理后music信号可视化
title('调高音调处理后music信号');xlabel('t/s');ylabel('幅值');
subplot(122);                                %调高音调处理后music信号可视化
len_Hmfft=length(Hmusicfft);
plot((0:len_Hmfft/2-1)*ft/len_Hmfft,2*abs(Hmusicfft(1:len_Hmfft/2))/len_Hmfft);     %其实频域可视化len_mfft/2个数据点即可(2pi周期,pi处为高频)
title('调高音调处理后music信号的频谱');xlabel('频率/Hz');ylabel('幅值');



