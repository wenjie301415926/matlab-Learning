clear all;close all;clc;
load('xDate.mat');load('yandu.mat');
figure;%���������쳣ֵ��ͼ��
scatter(xDate,yandu);hold on;
plot(xDate,yandu);
xlabel('ʱ��');ylabel('�ζ�');title('�ζ���ʱ��仯');
set(gca,'XTick',xDate);
datetick('x','mm/dd','keepticks');

%������˹������쳣ֵ
grubbs_95=[                        %grubbs��n=35,ǰ������0����
    0;0;1.153;1.463;1.672;
    1.822;1.938;2.032;2.110;2.176;
    2.234;2.285;2.331;2.371;2.409;
    2.443;2.475;2.501;2.532;2.557;
    2.580;2.603;2.624;2.644;2.663;
    2.681;2.698;2.714;2.730;2.745;
    2.759;2.773;2.786;2.799;2.811];
for ii=1:length(xDate)-5
    x_=mean(yandu);
    s=std(yandu);%���׼��
    if x_-min(yandu)>max(yandu)-x_  %����ֵ��ѡ������ֵ
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


figure;%���������쳣ֵ���ͼ��
scatter(xDate,yandu);hold on;
plot(xDate,yandu);axis([1,100,29.8,31.8])
xlabel('ʱ��');ylabel('�ζ�');title('�ζ���ʱ��仯');
set(gca,'XTick',xDate);
datetick('x','mm/dd','keepticks');