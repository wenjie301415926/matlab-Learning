clear all;close all;clc;
load('xDate.mat');load('yandu.mat');
figure;%作出包含异常值的图像
scatter(xDate,yandu);hold on;
plot(xDate,yandu);
xlabel('时间');ylabel('盐度');title('盐度随时间变化');
set(gca,'XTick',xDate);
datetick('x','mm/dd','keepticks');

%格拉布斯法检测异常值
grubbs_95=[                        %grubbs表，n=35,前两个用0代替
    0;0;1.153;1.463;1.672;
    1.822;1.938;2.032;2.110;2.176;
    2.234;2.285;2.331;2.371;2.409;
    2.443;2.475;2.501;2.532;2.557;
    2.580;2.603;2.624;2.644;2.663;
    2.681;2.698;2.714;2.730;2.745;
    2.759;2.773;2.786;2.799;2.811];
for ii=1:length(xDate)-5
    x_=mean(yandu);
    s=std(yandu);%求标准差
    if x_-min(yandu)>max(yandu)-x_  %在最值里选出可疑值
        x_i=min(yandu);
    else
        x_i=max(yandu);
    end
    m=find(yandu==x_i);
    Gj=abs(x_i-x_)/s;
    if Gj>grubbs_95(length(yandu))
        yandu(m)=[];xDate(m)=[];
    end
end


figure;%作出消除异常值后的图像
scatter(xDate,yandu);hold on;
plot(xDate,yandu);axis([1,100,29.8,31.8])
xlabel('时间');ylabel('盐度');title('盐度随时间变化');
set(gca,'XTick',xDate);
datetick('x','mm/dd','keepticks');