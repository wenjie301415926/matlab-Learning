close all;clear;clc;
%波束形成
fs=1000;T=1;t=1/fs:1/fs:T;
N=20;thita=20;c=1500;d=5;
SNR=20;

%信号构建
% %------宽带---------%
x=randn(1,length(t));
xb=fir1(100,[100/(fs/2),200/(fs/2)]);
xs=filter(xb,1,x);
% %------CW---------%
% f0=150;
% xs=cos(2*pi*f0*t);
%------Chirp------%
% f0=100;F=100;
% xs=cos(2*pi*f0*t+pi*F*t.^2);

%------补零-------%
xs=[zeros(1,length(t)),xs,zeros(1,length(t))];
T=3;
%------各振源之间实际接收的信号-------%
for n=1:N
    delt=(n-1)*d*sind(thita)/c;
    deltn=round(delt*fs);
    s(n,:)=circshift(xs,[1,deltn]);
    s(n,:)=10^(SNR/20)*s(n,:)+randn(1,length(xs));
end
%------扫描波束形成-------%
%----------时域----------%
% sr=[];beam=[];theta=-90:1:90;
% for nn=1:length(theta)
%     for n=1:N
%         delt=(n-1)*d*sind(theta(nn))/c;
%         deltn=round(delt*fs);
%         sr(n,:)=circshift(s(n,:),[1,-deltn]);
%     end
%     arr=sum(sr);
%     beam(nn)=sum(arr.^2);
% end
%---------频域-----------%
sf=[];%各振元接收信号fft
for n=1:N
    sf(n,:)=fft(s(n,:));
end
sfr=[];beam=[];theta=-90:1:90;
nfmin=100*T;nfmax=200*T;
for nn=1:length(theta)
    for n=1:N
        delt=(n-1)*d*sind(theta(nn))/c;
        phy=2*pi*(nfmin:1:nfmax)/T*delt;
        sfr(n,:)=sf(n,nfmin:nfmax).*exp(j*phy);
    end
    arr=sum(sfr);
    beam(nn)=sum(abs(arr).^2);
end
%可视化
figure;plot(theta,beam/(max(beam)));
figure;polar(theta*pi/180,beam/(max(beam)));

    

