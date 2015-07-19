clear all;close all;clc;

Z=[0.0;150.0;305.0;533.0;610.0;680.0;762.0;1372.0;1829.0;3048.0;4000.0];%��֪���ֵ
C=[1507.2;1498.1;1491.7;1480.7;1478.9;1478.0;1478.6;1483.2;1488.6;1507.5;1523.0];%��֪����ֵ
z=0:4000;%��ȷֲ�,1mһ��
c=interp1(Z,C,z);%���Բ�ֵ��ÿ������
zc_map=containers.Map(z,c);
scatter(C,Z,'r','+'); grid on; hold on;
plot(c,z);legend('��֪����ɢ��ֵ','��ֵ������������');
set(gca,'ydir','reverse');set(gca,'xaxislocation','top');%�������棬��Ϊ������ʾ
xlabel('����(m/s)');ylabel('����(m)');hold off;

x0=0;z0=400;%��Դλ��
afa_0=pi/60;%��ʼ�����
c0=zc_map(z0);
c_fan=c0/cos(afa_0)*cos(0);%���㷴ת�ٶ�
zi=z0;
while c(zi)<=c_fan
    zi=zi+1;
end
z_fan_L=zi;
afa(z0)=afa_0;
x(1)=x0;
for ii=z0+1:zi
    afa(ii)=acos(zc_map(ii)/c0*cos(afa_0));
    dx=1/tan((afa(ii)+afa(ii-1))/2);
    x(ii-z0+1)=x(ii-z0)+dx;
    h(ii-z0+1)=ii;
end

figure;plot(x,h);

