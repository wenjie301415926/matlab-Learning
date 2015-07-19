clear all;close all;clc;

Z=[0.0;150.0;305.0;533.0;610.0;680.0;762.0;1372.0;1829.0;3048.0;4000.0];%已知深度值
C=[1507.2;1498.1;1491.7;1480.7;1478.9;1478.0;1478.6;1483.2;1488.6;1507.5;1523.0];%已知声速值
z=0:4000;%深度分层,1m一层
c=interp1(Z,C,z);%线性插值求每层声速
zc_map=containers.Map(z,c);
scatter(C,Z,'r','+'); grid on; hold on;
plot(c,z);legend('已知声速散点值','插值生成声速剖面');
set(gca,'ydir','reverse');set(gca,'xaxislocation','top');%声速剖面，且为反向显示
xlabel('声速(m/s)');ylabel('海深(m)');hold off;

x0=0;z0=400;%声源位置
afa_0=pi/60;%初始掠射角
c0=zc_map(z0);
c_fan=c0/cos(afa_0)*cos(0);%计算反转速度
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

