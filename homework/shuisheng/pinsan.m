clear all;close all;clc;
w=800;
Z=[0.0;150.0;305.0;533.0;610.0;680.0;762.0;1372.0;1829.0;3048.0;4000.0];%给定的深度值
C=[1507.2;1498.1;1491.7;1480.7;1478.9;1478.0;1478.6;1483.2;1488.6;1507.5;1523.0];%对应的声速值
z=0:4000;%深度分层
c=interp1(Z,C,z);%线性插值求每层声速
k=w./c;
scatter(C,Z,'r'); grid on; hold on;
plot(c,z);legend('已知声速散点值','插值生成声速剖面');
set(gca,'ydir','reverse');set(gca,'xaxislocation','top');%声速剖面，且为反向显示
xlabel('声速(m/s)');ylabel('海深(m)');hold off;

c_min=min(c)%声速最小时的深度即为z0，声源放置处,而且此深度有k_max
for ii=1:length(c)
    if c(ii)==c_min
        z0=z(ii)
        k_max=k(ii)
        break;
    end
end

