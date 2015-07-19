clear all;close all;clc;
load('xDate.mat');load('yandu.mat');load('temper.mat');

%ʱ���ֵ
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
%datestr(xDate2)%�ɲ鿴ʱ���ֵ�Ƿ���ȷ




figure;%�ζ�
%����ֵ��ԭʼ����ͼ��
scatter(xDate,yandu);hold on;
%plot(xDate,temper);
xlabel('ʱ��');ylabel('�ζ�');title('�ζ���ʱ��仯');
set(gca,'XTick',xDate);
datetick('x','mm/dd','keepticks');
%��ֵ���ͼ��
temper2=interp1(xDate,yandu,xDate2);%���Բ�ֵ
plot(xDate2,temper2); 
temper3=interp1(xDate,yandu,xDate2,'spline');%����������ֵ
plot(xDate2,temper3,'r');
temper4=interp1(xDate,yandu,xDate2,'cubic');%���ζ���ʽ��ֵ
plot(xDate2,temper4,'g');
legend('ԭʼ����','���Բ�ֵ','����������ֵ','���ζ���ʽ��ֵ');
