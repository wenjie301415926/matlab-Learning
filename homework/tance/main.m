clear all;close all;clc;
a=dir;
for ii=3:34    
    file_name=a(ii).name
    [file]=officedoc(file_name,'open');
    [data]=officedoc(file,'read');
    %�������ļ������ݵ����ں�ʱ��
    x0=strfind(data,'ʱ��');
    date_str=data(x0+3:x0+20);
    %date_num=datenum(date_str);
    %date(ii-2,:)=datestr(date_num,'yyyy-mm-dd HH:MM:SS');
    [y,m,d,h,mi,s]=datevec(date_str);%������������
    xDate(ii-2)=datenum([y,m,d,h,mi,s]);
    %date(ii-2,:)=datetsr[y,m,d,h,mi,s];%��������������һ��2ά����
    %date(ii-2,:)=datestr([y,m,d,h,mi,s],'yyyy-mm-dd HH:MM:SS')
    %yue(ii-2)=m;
    %ri(ii-2)=d; 
    %shi(ii-2)=h;

    %����
    x1=strfind(data,'����');
    temper_str=data(x1+6:x1+11);
    temper(ii-2)=str2double(temper_str);
    %��ѹ
     x2=findstr(data,'��ѹ(hPa)');
     qiya_str=data(x2+9:x2+13);
     qiya(ii-2)=str2double(qiya_str);
    %ƽ������
     x3=findstr(data,'ƽ������(m/s)');
     fengsu_str=data(x3+10:x3+15); 
     fengsu(ii-2)=str2double(fengsu_str);
    %ˮ��
     x4=findstr(data,'ˮ��(��)');
     shuiwen_str=data(x4+6:x4+10);
     shuiwen(ii-2)=str2double(shuiwen_str);
    %�ζ�
     x5=findstr(data,'�ζ�(��)');
     yandu_str=data(x5+6:x5+10);
     yandu(ii-2)=str2double(yandu_str);
    %Ҷ����
     x6=findstr(data,'Ҷ����(ppb)');
     yelvsu_str=data(x6+9:x6+12);
     yelvsu(ii-2)=str2double(yelvsu_str);
    %����
     x7=strfind(data,'ƽ������(m)');
     bogao_str=data(x7+8:x7+11);
     bogao(ii-2)=str2double(bogao_str);
end

plot(xDate,bogao);hold on;legend('ƽ������','Location','SouthOutside')
xlabel('ʱ��');ylabel('ƽ������');
set(gca,'XTick',xDate);
datetick('x','mm/dd','keepticks'); 
scatter(xDate,bogao);hold off;

save('yandu.mat','yandu');
save('temper.mat','temper');
save('xDate.mat','xDate');