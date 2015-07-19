clc;clear;
fs=10000;
t=1/fs:1/fs:1;
x=chirp(t,400,1,700);
N=8;the=30;d=0.1;c=1500;
fl=400;
fh=700;
for n=1:N
    y(n,:)=fft(x);
end
for f=fl:fh
    for n=1:N
        pha(n)=-j*2*pi*f*(n-1)*d*sind(the)/c*fs;
        y(n,f)=y(n,f)*exp(pha(n));
    end
end
 
for theta=-90:90;
    for f=fl:fh;
        for n=1:N;
            phase(n)=2*j*pi*f*(n-1)*d*sind(theta)/c*fs;
            sf(n)=y(n,f)*exp(phase(n));
        end
        beamf(f,theta+91)=sum(sf);
    end
    beam=sum(abs(beamf));
end
figure
plot(-90:90,beam); title('µÈ¼ä¸ô')
            

    