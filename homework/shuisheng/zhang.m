clc;clear;close all;
w=800;%设定角频率
Z=[0.0;150.0;305.0;533.0;610.0;680.0;762.0;1372.0;1829.0;3048.0;4000.0];%已知深度值
C=[1507.2;1498.1;1491.7;1480.7;1478.9;1478.0;1478.6;1483.2;1488.6;1507.5;1523.0];%已知声速值
z=0:4000;%深度分层
c=interp1(Z,C,z);%线性插值求每层声速

 %绘制声速剖面图
 plot(c,z,'r');
 set(gca,'yDir','reverse');set(gca,'XAxisLocation','top');%y轴反转，x轴取有效部分
 title('声速剖面图');
 xlabel('声速(m/s)');ylabel('深度(m)');
 hold on;
 stem(C,Z);
 grid on;

k=w./c;%每层波束
nc=length(c);%声速值个数
cc=c;zz=z;kk=k;nnc=nc;%保存初始声速剖面


%找出声速最小值位置，并将声源放在该处
cmin=min(c);
for m=1:nc
    if c(m)==cmin;
        z0=z(m);
        break
    end
end


o=m;
kmin=k(1);%不碰海面也不碰海底波束最小值取海面
kmax=k(o);%波束最大值即波速最小
k1=kmin;k2=kmax;%保存声速波束最大最小值


%计算能够传播的简正波的最大号数N
kx=kmin;%kx为水平波束ξn,ξn随简正波号数n的增大而减小，则最大简正波号数N则是ξn取最小值时得来
cosa0=kx/k(o);%水平波束确定初始掠射角a0
cver=c(o)/cosa0;%初始掠射角a0确定反转深度
%找上部反转处层数n1
for i=o:-1:1
    if c(i)>=cver
        n1=i;
        break
    end
end
%找下部反转处层数n2
for i=o:nc
    if c(i)>=cver
        n2=i;
        break
    end 
end
zver1=z(n1+1)-(c(n1+1)-cver)/(c(n1+1)-c(n1));%上部实际反转深度
zver2=z(n2)-(c(n2)-cver)/(c(n2)-c(n2-1));%下实际反转深度
%下部反转处加一层
for i=nc+1:-1:n2+1
    c(i)=c(i-1);z(i)=z(i-1); 
end
c(n2)=cver;z(n2)=zver2;
nc=nc+1;
%上层反转处加一层
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
        kz(i)=sqrt(t);%波束垂直分量
    end
end
fleft=2*sum(kz);%方程左边
N=((fleft/pi-1)/2); 
t=length(kz);p=n2-n1+1-t;


%解频散方程,利用二分法，求不同号数的水平波束ξn
for n=0:N
    fright=(2*n+1)*pi;%方程右边
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
    while abs(fleft-fright)>10^-10;%设立方程精度
        if fleft<fright %如果左边小于右边，要使左边增大则降低水平波束
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
        if fleft>fright %如果左边大于右边，要使左边降低则增大水平波束
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
    sprintf('ξ(%d)=%f',n,kx(n+1))
end