clc;clear;close all;
w=800;%�趨��Ƶ��
Z=[0.0;150.0;305.0;533.0;610.0;680.0;762.0;1372.0;1829.0;3048.0;4000.0];%��֪���ֵ
C=[1507.2;1498.1;1491.7;1480.7;1478.9;1478.0;1478.6;1483.2;1488.6;1507.5;1523.0];%��֪����ֵ
z=0:4000;%��ȷֲ�
c=interp1(Z,C,z);%���Բ�ֵ��ÿ������

 %������������ͼ
 plot(c,z,'r');
 set(gca,'yDir','reverse');set(gca,'XAxisLocation','top');%y�ᷴת��x��ȡ��Ч����
 title('��������ͼ');
 xlabel('����(m/s)');ylabel('���(m)');
 hold on;
 stem(C,Z);
 grid on;

k=w./c;%ÿ�㲨��
nc=length(c);%����ֵ����
cc=c;zz=z;kk=k;nnc=nc;%�����ʼ��������


%�ҳ�������Сֵλ�ã�������Դ���ڸô�
cmin=min(c);
for m=1:nc
    if c(m)==cmin;
        z0=z(m);
        break
    end
end


o=m;
kmin=k(1);%��������Ҳ�������ײ�����Сֵȡ����
kmax=k(o);%�������ֵ��������С
k1=kmin;k2=kmax;%�������ٲ��������Сֵ


%�����ܹ������ļ�������������N
kx=kmin;%kxΪˮƽ������n,��n�����������n���������С����������������N���Ǧ�nȡ��Сֵʱ����
cosa0=kx/k(o);%ˮƽ����ȷ����ʼ�����a0
cver=c(o)/cosa0;%��ʼ�����a0ȷ����ת���
%���ϲ���ת������n1
for i=o:-1:1
    if c(i)>=cver
        n1=i;
        break
    end
end
%���²���ת������n2
for i=o:nc
    if c(i)>=cver
        n2=i;
        break
    end 
end
zver1=z(n1+1)-(c(n1+1)-cver)/(c(n1+1)-c(n1));%�ϲ�ʵ�ʷ�ת���
zver2=z(n2)-(c(n2)-cver)/(c(n2)-c(n2-1));%��ʵ�ʷ�ת���
%�²���ת����һ��
for i=nc+1:-1:n2+1
    c(i)=c(i-1);z(i)=z(i-1); 
end
c(n2)=cver;z(n2)=zver2;
nc=nc+1;
%�ϲ㷴ת����һ��
for i=nc+1:-1:n1+2
    c(i)=c(i-1);z(i)=z(i-1); 
end
c(n1+1)=cver;z(n1+1)=zver1;
n1=n1+1;n2=n2+1;

k=k(n1:n2);
m=k.^2-kx^2;
for i=1:(n2-n1+1)
    if m(i)>=0
        t=m(i);
        kz(i)=sqrt(t);%������ֱ����
    end
end
fleft=2*sum(kz);%�������
N=((fleft/pi-1)/2); 
t=length(kz);p=n2-n1+1-t;


%��Ƶɢ����,���ö��ַ�����ͬ������ˮƽ������n
for n=0:N
    fright=(2*n+1)*pi;%�����ұ�
    kmin=k1;kmax=k2;kmid=(kmin+kmax)/2;
    kx=kmid;
    c=cc;z=zz;k=kk;nc=nnc;
    cosa0=kx/k(o);
    cver=c(o)/cosa0;
    for i=o:-1:1
        if c(i)>=cver
            n1=i;
            break
        end
    end
    for i=o:nc
        if c(i)>=cver
             n2=i;
             break
         end 
    end
    zver1=z(n1+1)-(c(n1+1)-cver)/(c(n1+1)-c(n1));
    zver2=z(n2)-(c(n2)-cver)/(c(n2)-c(n2-1));
            
    for i=nc+1:-1:n2+1
        c(i)=c(i-1);z(i)=z(i-1); 
    end
    c(n2)=cver;z(n2)=zver2;
    nc=nc+1;
    for i=nc+1:-1:n1+2
        c(i)=c(i-1);z(i)=z(i-1); 
    end
    c(n1+1)=cver;z(n1+1)=zver1;
    n1=n1+1;n2=n2+1;
    k=k(n1:n2-p);
    m=k.^2-kx^2;
    kz=sqrt(m);
    fleft=2*sum(kz);
    while abs(fleft-fright)>10^-10;%�������̾���
        if fleft<fright %������С���ұߣ�Ҫʹ��������򽵵�ˮƽ����
            kmax=kmid;
            kmid=(kmin+kmax)/2;
            kx=kmid;
            c=cc;z=zz;k=kk;nc=nnc;
            cosa0=kx/k(o);
            cver=c(o)/cosa0;
            for i=o:-1:1
                if c(i)>=cver
                    n1=i;
                    break
                end
             end
             for i=o:nc
                 if c(i)>=cver
                     n2=i;
                     break
                 end 
             end
             zver1=z(n1+1)-(c(n1+1)-cver)/(c(n1+1)-c(n1));
             zver2=z(n2)-(c(n2)-cver)/(c(n2)-c(n2-1));
             for i=nc+1:-1:n2+1
                 c(i)=c(i-1);z(i)=z(i-1); 
             end
             c(n2)=cver;z(n2)=zver2;
             nc=nc+1;
             for i=nc+1:-1:n1+2
                 c(i)=c(i-1);z(i)=z(i-1); 
             end
             c(n1+1)=cver;z(n1+1)=zver1;
             n1=n1+1;n2=n2+1;
             k=k(n1:n2-p);
             m=k.^2-kx^2;
             kz=sqrt(m);
            fleft=2*sum(kz);
        end %if fleft<fright
        if fleft>fright %�����ߴ����ұߣ�Ҫʹ��߽���������ˮƽ����
            kmin=kmid;
            kmid=(kmin+kmax)/2;
            kx=kmid;
            c=cc;z=zz;k=kk;nc=nnc;
            cosa0=kx/k(o);
            cver=c(o)/cosa0;
            for i=o:-1:1
                if c(i)>=cver
                     n1=i;
                     break
                end
             end
             for i=o:nc
                 if c(i)>=cver
                     n2=i;
                     break
                 end 
             end
             zver1=z(n1+1)-(c(n1+1)-cver)/(c(n1+1)-c(n1));
             zver2=z(n2)-(c(n2)-cver)/(c(n2)-c(n2-1));
            
             for i=nc+1:-1:n2+1
                 c(i)=c(i-1);z(i)=z(i-1); 
             end
             c(n2)=cver;z(n2)=zver2;
             nc=nc+1;
             for i=nc+1:-1:n1+2
                 c(i)=c(i-1);z(i)=z(i-1); 
             end
             c(n1+1)=cver;z(n1+1)=zver1;
             n1=n1+1;n2=n2+1;
             k=k(n1:n2-p);
             m=k.^2-kx^2;
             kz=sqrt(m);
             fleft=2*sum(kz);
        end %if fleft>fright      
    end %while
    kx(n+1)=kx;
    sprintf('��(%d)=%f',n,kx(n+1))
end