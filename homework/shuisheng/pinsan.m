clear all;close all;clc;
w=800;
Z=[0.0;150.0;305.0;533.0;610.0;680.0;762.0;1372.0;1829.0;3048.0;4000.0];%���������ֵ
C=[1507.2;1498.1;1491.7;1480.7;1478.9;1478.0;1478.6;1483.2;1488.6;1507.5;1523.0];%��Ӧ������ֵ
z=0:4000;%��ȷֲ�
c=interp1(Z,C,z);%���Բ�ֵ��ÿ������
k=w./c;
scatter(C,Z,'r'); grid on; hold on;
plot(c,z);legend('��֪����ɢ��ֵ','��ֵ������������');
set(gca,'ydir','reverse');set(gca,'xaxislocation','top');%�������棬��Ϊ������ʾ
xlabel('����(m/s)');ylabel('����(m)');hold off;

c_min=min(c)%������Сʱ����ȼ�Ϊz0����Դ���ô�,���Ҵ������k_max
for ii=1:length(c)
    if c(ii)==c_min
        z0=z(ii)
        k_max=k(ii)
        break;
    end
end

