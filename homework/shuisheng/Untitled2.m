format long;
clear all;clc;
c0=1450;a=-1;
z=0:4000;
c=c0*(1+a*z);
rs=0;
zs=1000;%��ʼ���
afa0=5/180*pi;%��ʼ�����
cs=c0+a*zs;
afa=acos(cos(afa0).*c/cs);%��ͬ��ȵ������
cf=cs./cos(afa);%��ת������
zf=(cf-c0)/a;%��ת��
zfl=round(zf+1);
h(1)=zs;
x(1)=rs;
zx=zs;
zl=zx+1;%��ǰ�±�
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