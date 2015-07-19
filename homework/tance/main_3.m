clear all;close all;clc;
load('xDate.mat');load('yandu.mat');load('temper.mat');

%时间插值
N=(datenum(2010,11,26)-datenum(2010,9,01))*24+(6-2)+1;
%N=(xDate(32)-xDate(1))/0.0417
day_num=datenum(2010,9,01,2,0,0);
for n=1:N
    xDate2(n)=day_num;
    [y m d h mi s]=datevec(day_num);
    datestr([y m d h mi s]);  
    mi=mi+60;
    day_num=datenum([y m d h mi s]); 
end
%datestr(xDate2)%可查看时间插值是否正确




figure;%盐度
%不插值的原始数据图像
scatter(xDate,yandu);hold on;
%plot(xDate,temper);
xlabel('时间');ylabel('盐度');title('盐度随时间变化');
set(gca,'XTick',xDate);
datetick('x','mm/dd','keepticks');
%插值后的图像
temper2=interp1(xDate,yandu,xDate2);%线性插值
plot(xDate2,temper2); 
temper3=interp1(xDate,yandu,xDate2,'spline');%三次样条插值
plot(xDate2,temper3,'r');
temper4=interp1(xDate,yandu,xDate2,'cubic');%三次多项式插值
plot(xDate2,temper4,'g');
legend('原始数据','线性插值','三次样条插值','三次多项式插值');
