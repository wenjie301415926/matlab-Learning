clc;clear;close all;
format long;
w=800;%�趨��Ƶ��
Z=[0.0;150.0;305.0;533.0;610.0;680.0;762.0;1372.0;1829.0;3048.0;4000.0];%��֪���ֵ
C=[1507.2;1498.1;1491.7;1480.7;1478.9;1478.0;1478.6;1483.2;1488.6;1507.5;1523.0];%��֪����ֵ
z=0:4000;%��ȷֲ�
c=interp1(Z,C,z);%���Բ�ֵ��ÿ������
[c_min z_cmin]=min(c);z_cmin=z_cmin-1;
k=w./c;%ÿ�㲨��

%����n�����ֵ
k_zmax=sqrt(k.^2-k(1)^2);
cfan=c_min/(k(1)/max(k));%�������ٸ����������������������ס�����ж�Ӧ�ɺ�����С�

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Ѱ�ҷ�ת��ȣ�
%����n�����ֵʱ���Ϸ�ת���Ϊ0�����ֻѰ���·�ת��ȼ���
i=z_cmin;
while c(i)<=cfan
    i=i+1;
end
z_shang=0;z_xia=i-1+(cfan-c(i-1))/(c(i)-c(i-1));
%�󷽳���ߵĻ���
left=trapz([z_shang:z_xia],k_zmax(1:i));
%���N
N=floor((2*left-pi)/2/pi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Ѱ��ˮƽ����kexi
%�������
err=10^-10;
%��ʼɨ�跶Χ
kmin=k(1);kmax=max(k);kmid=(kmin+kmax)/2;
%��n����ѭ��
tic;
for n=0:N;
    while 1
    kexin=kmid;
    cfann=kexin/(k(1)/max(k));
    i=z_cmin;
    while c(i)<=cfan
        i=i+1;
    end
    %nxia=i;
    z_xia=i-1;%+(cfan-c(i-1))/(c(i)-c(i-1));
    i=z_cmin;
    while c(i)<=cfan
        i=i-1;
        if i==0;
            break;
        end
    end
    %nshang=i;
    z_shang=i+1;%-(cfan-c(i+1))/(c(i)-c(i+1));
    %���ɴ�ֱ����
    kzn=sqrt(k.^2-kexin^2);
    leftn=2*trapz([z_shang:z_xia],kzn(z_shang:z_xia))-(2*n+1)*pi;
    if leftn>err
        kmin=kmid;kmid=(kmin+kmax)/2;
    elseif leftn<-err
        kmax=kmid;kmid=(kmin+kmax)/2;
    else
        kexi(n+1)=kexin;
        break;
    end
    end
    kmin=k(1);kmax=kexin;kmid=(kmin+kmax)/2;
end
toc;
kexi
