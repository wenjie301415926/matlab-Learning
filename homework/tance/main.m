clear all;close all;clc;
a=dir;
for ii=3:34    
    file_name=a(ii).name
    [file]=officedoc(file_name,'open');
    [data]=officedoc(file,'read');
    %读出该文件中数据的日期和时间
    x0=strfind(data,'时间');
    date_str=data(x0+3:x0+20);
    %date_num=datenum(date_str);
    %date(ii-2,:)=datestr(date_num,'yyyy-mm-dd HH:MM:SS');
    [y,m,d,h,mi,s]=datevec(date_str);%创建日期向量
    xDate(ii-2)=datenum([y,m,d,h,mi,s]);
    %date(ii-2,:)=datetsr[y,m,d,h,mi,s];%将日期向量存入一个2维数组
    %date(ii-2,:)=datestr([y,m,d,h,mi,s],'yyyy-mm-dd HH:MM:SS')
    %yue(ii-2)=m;
    %ri(ii-2)=d; 
    %shi(ii-2)=h;

    %气温
    x1=strfind(data,'气温');
    temper_str=data(x1+6:x1+11);
    temper(ii-2)=str2double(temper_str);
    %气压
     x2=findstr(data,'气压(hPa)');
     qiya_str=data(x2+9:x2+13);
     qiya(ii-2)=str2double(qiya_str);
    %平均风速
     x3=findstr(data,'平均风速(m/s)');
     fengsu_str=data(x3+10:x3+15); 
     fengsu(ii-2)=str2double(fengsu_str);
    %水温
     x4=findstr(data,'水温(℃)');
     shuiwen_str=data(x4+6:x4+10);
     shuiwen(ii-2)=str2double(shuiwen_str);
    %盐度
     x5=findstr(data,'盐度(‰)');
     yandu_str=data(x5+6:x5+10);
     yandu(ii-2)=str2double(yandu_str);
    %叶绿素
     x6=findstr(data,'叶绿素(ppb)');
     yelvsu_str=data(x6+9:x6+12);
     yelvsu(ii-2)=str2double(yelvsu_str);
    %波高
     x7=strfind(data,'平均波高(m)');
     bogao_str=data(x7+8:x7+11);
     bogao(ii-2)=str2double(bogao_str);
end

plot(xDate,bogao);hold on;legend('平均波高','Location','SouthOutside')
xlabel('时间');ylabel('平均波高');
set(gca,'XTick',xDate);
datetick('x','mm/dd','keepticks'); 
scatter(xDate,bogao);hold off;

save('yandu.mat','yandu');
save('temper.mat','temper');
save('xDate.mat','xDate');