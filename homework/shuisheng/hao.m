clc;clear;close all;
format long;
w=800;%设定角频率
Z=[0.0;150.0;305.0;533.0;610.0;680.0;762.0;1372.0;1829.0;3048.0;4000.0];%已知深度值
C=[1507.2;1498.1;1491.7;1480.7;1478.9;1478.0;1478.6;1483.2;1488.6;1507.5;1523.0];%已知声速值
z=0:4000;%深度分层
c=interp1(Z,C,z);%线性插值求每层声速
[c_min z_cmin]=min(c);z_cmin=z_cmin-1;
k=w./c;%每层波束

%计算n的最大值
k_zmax=sqrt(k.^2-k(1)^2);
cfan=c_min/(k(1)/max(k));%海底声速更大，声速碰海面先于碰海底。因此判断应由海面进行。

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%寻找反转深度，
%在求n的最大值时，上反转深度为0，因此只寻找下反转深度即可
i=z_cmin;
while c(i)<=cfan
    i=i+1;
end
z_shang=0;z_xia=i-1+(cfan-c(i-1))/(c(i)-c(i-1));
%求方程左边的积分
left=trapz([z_shang:z_xia],k_zmax(1:i));
%求出N
N=floor((2*left-pi)/2/pi);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%寻找水平波束kexi
%误差允许
err=10^-10;
%初始扫描范围
kmin=k(1);kmax=max(k);kmid=(kmin+kmax)/2;
%对n进行循环
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
    %生成垂直波束
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
