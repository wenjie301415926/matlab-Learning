fs=2400;    %����Ƶ��1.5--5KHz
N=600;      %��N����,��ʱ��N/fs��
n=0:N-1;
t=n/fs;     %ʱ������

%����ֻ������Ƶ�ʳɷֵ������ź�cos(2*pi*fL*t)+cos(2*pi*fH*t)
fL=20;      %ԭ�źŵ�Ƶ�ɷ�
fH=100;     %ԭ�źŸ�Ƶ�ɷ�
s=5*cos(2*pi*fL*t)+3*cos(2*pi*fH*t);%�źŲɼ�
s=s+randn(1,N); %������
sfft=fft(s);    %�ź�Ƶ�����

%�ź�ʱ���Ƶ����ӻ�
figure(1);
subplot(121);
plot(t,s);
%axis([0,N/fs,-10,10]);
title('�����ź�');xlabel('t/s');ylabel('��ֵ');

%Ƶ��
subplot(122);
len_sfft=length(sfft);                  %��ȡƵ�����ݳ���
fss=(0:len_sfft-1)*fs/N;                %����Ƶ������,Ƶ�����ɢ���Ϊ1/(N*Ts)��fs/N
plot(fss,2*abs(sfft)/length(sfft));     %��ʵƵ����ӻ�len_sfft/2�����ݵ㼴��(2pi����,pi��Ϊ��Ƶ)
axis([0,fs/2,0,10]);
title('�ź�Ƶ��');xlabel('Ƶ��/Hz');ylabel('��ֵ');

%��Ƶ�ͨ�˲���
Wp=100/fs;      %ͨ����ֹƵ��Ϊ100Hz
Ws=200/fs;      %�����ֹƵ��Ϊ200Hz
ap=1;           %ͨ������С��1db
as=50;          %���˥������50db
[n,Wn]=buttord(Wp,Ws,ap,as);    %���Ƶõ�Butterworth��ͨ�˲�������С����n�ͽ���Ƶ��Wn
[a,b]=butter(n,Wn);             %���Butterworth��ͨ�˲���
[h,f]=freqz(a,b,'whole',fs);    %�����ֵ�ͨ�˲�����Ƶ����Ӧ
f=(0:length(f)-1)*fs/length(f); %���ж�Ӧ��Ƶ��ת��

%����Butterworth��ͨ�˲�����Ƶ����Ӧͼ
figure(2)
plot(f(1:length(f)/2),abs(h(1:length(f)/2)));%��ʵƵ����ӻ�length(f)/2�����ݵ㼴��(2pi����,pi��Ϊ��Ƶ)
title('Butterworth��ͨ�˲���');xlabel('Ƶ��/Hz');ylabel('��ֵ');
grid;

%�ź�s�����˲�����,�Լ��������ź�ʱ���Ƶ����ӻ�  
%����
%ʱ���ź��˲�����,ʱ����(�źŽ�����洢�ĳ弤��Ӧ������˵���),Ƶ��˻�
sF=filter(a,b,s); 
figure(3);          
subplot(121);
plot(t,sF);         %ʱ��
title('����ź�');xlabel('t/s');ylabel('��ֵ');
subplot(122);
SF=fft(sF);         %Ƶ��
plot((0:length(SF)-1)*fs/length(SF),2*abs(SF)/length(SF)); %��ʵƵ����ʾlength(SF)/2�����ݵ㼴��(2pi����,pi��Ϊ��Ƶ)
axis([0,fs/2,0,10]);
title('��ͨ�˲����˲�������Ƶ��ͼ');xlabel('Ƶ��/Hz');ylabel('��ֵ');
grid;


%�����ź��˲�����
[mymusic,ft,bit]=wavread('wavf.wav');
wavplay(mymusic,ft,'async');                %����ԭmusic�ź�
pause(10);
mymusicF=filter(a,b,mymusic);
figure(4);          
subplot(121);
plot((0:length(mymusic)-1)/ft,mymusic);          %ʱ��ԭ�����źſ��ӻ�
title('ԭmusic�ź�');xlabel('t/s');ylabel('��ֵ');
subplot(122);
plot((0:length(mymusicF)-1)/ft,mymusicF);        %ʱ���˲�����������źſ��ӻ�
title('��ͨ�˲����music�ź�');xlabel('t/s');ylabel('��ֵ');

wavplay(mymusicF,ft,'async');                   %�����˲�������music�ź�
pause(10);

figure(5);
subplot(121);                                    %Ƶ��ԭ�����źſ��ӻ�
mymusicfft=fft(mymusic);
len_mfft=length(mymusicfft);
plot((0:len_mfft/2-1)*ft/len_mfft,2*abs(mymusicfft(1:len_mfft/2))/len_mfft); %��ʵƵ����ӻ�len_mfft/2�����ݵ㼴��(2pi����,pi��Ϊ��Ƶ)
title('ԭmusic�źŵ�Ƶ��');xlabel('Ƶ��/Hz');ylabel('��ֵ');
subplot(122);                       %Ƶ���˲������������źſ��ӻ�
mymusicFfft=fft(mymusicF);
len_mFfft=length(mymusicFfft);
plot((0:len_mFfft/2-1)*ft/len_mFfft,2*abs(mymusicFfft(1:len_mFfft/2))/len_mFfft);     %��ʵƵ����ӻ�len_mfft/2�����ݵ㼴��(2pi����,pi��Ϊ��Ƶ)
title('�˲�������music�źŵ�Ƶ��');xlabel('Ƶ��/Hz');ylabel('��ֵ');


%���music����,��circshifѭ��������tft/len_mfft*NN ��Hz  0.1
%��ԭ�ź����������
Right=2000;
Left=-2000;
HmR=circshift(mymusicfft(1:len_mfft/2),Right);
HmL=circshift(mymusicfft(len_mfft/2+1:len_mfft),Left);
Hmusicfft=[HmR;HmL];
hmusic=real(ifft(Hmusicfft));
wavplay(hmusic,ft,'async');                  %�����������������music�ź�

figure(6);
subplot(121)
plot((0:length(hmusic)-1)/ft,hmusic);        %�������������music�źſ��ӻ�
title('�������������music�ź�');xlabel('t/s');ylabel('��ֵ');
subplot(122);                                %�������������music�źſ��ӻ�
len_Hmfft=length(Hmusicfft);
plot((0:len_Hmfft/2-1)*ft/len_Hmfft,2*abs(Hmusicfft(1:len_Hmfft/2))/len_Hmfft);     %��ʵƵ����ӻ�len_mfft/2�����ݵ㼴��(2pi����,pi��Ϊ��Ƶ)
title('�������������music�źŵ�Ƶ��');xlabel('Ƶ��/Hz');ylabel('��ֵ');



