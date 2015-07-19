clc;clear;
fs=10000;
t=1/fs:1/fs:1;
x=chirp(t,400,1,700);
N=8;the=30;c=1500;
d=[0,0.05,0.13,0.25,0.45,0.57,0.65,0.8];
fl=400;
fh=700;
for n=1:N
    y(n,:)=fft(x);
end
for f=fl:fh
    for n=1:N
        pha(n)=-j*2*pi*f*d(n)*sind(the)/c*fs;
        y(n,f)=y(n,f)*exp(pha(n));
    end
end
 
for theta=-90:90;
    for f=fl:fh;
        for n=1:N;
            phase(n)=2*j*pi*f*d(n)*sind(theta)/c*fs;
            sf(n)=y(n,f)*exp(phase(n));
        end
        beamf(f,theta+91)=sum(sf);
    end
    beam=sum(abs(beamf));
end
figure
plot(-90:90,beam);title('²»µÈ¼ä¸ô')
            