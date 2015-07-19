format long;
clear all;clc;
c0=1450;a=-1;
z=0:4000;
c=c0*(1+a*z);
rs=0;
zs=1000;%初始深度
afa0=5/180*pi;%初始掠射角
cs=c0+a*zs;
afa=acos(cos(afa0).*c/cs);%不同深度的掠射角
cf=cs./cos(afa);%反转点声速
zf=(cf-c0)/a;%反转点
zfl=round(zf+1);
h(1)=zs;
x(1)=rs;
zx=zs;
zl=zx+1;%当前下标
for i=0:4001*6
    if c(zl)>=cf|zl==1|zl==4001
        flag=-1*flag;
    end
    dx(1:i+1)=((tan(0.5*(afa(zl+flag)))).^(-1));
    x(i+2)=sum(dx(1:i+1));
    zx=zx+flag;
    h(i+2)=zx;
    zl=zl+flag;
end