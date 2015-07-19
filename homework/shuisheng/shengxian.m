%声线图
clear; clc;close all;
z=0:1:1000;  %海深4000米
z0=400; %声源在水下50米
n0=fix(z0/max(z)*length(z))+1;
a=-0.001;
c0=1500;
n=length(z);
c=zeros(1,n);
c(1)=c0;
for i=2:n
    c(i)=c(i-1)*(1+a*(z(i)-z(i-1)));
end
for o=-45:1:45
    m=1;
    x1=zeros(m,n);
r1=zeros(m,n);%各细分层的角度
y1=zeros(m,n);
 
r1(m,n0)=cos(o*pi/180);  %o为初始掠射角,r为各个角度的余弦
y1(m,1:n0)=z(1:n0);
  for i=n0+1:n
      r1(m,i)=c(i)*r1(m,i-1)/c(i-1);%该层掠射角的余弦
      x1(m,i)=x1(m,i-1)+((((1-(r1(m,i-1)^2))^0.5)-((1-(r1(m,i)^2))^0.5))/a/r1(m,i-1));
      y1(m,i)=i;
  end
   
  r2=zeros(m,n);
  r2(m,1)=r1(m,n);
  x2=zeros(m,n);
  x2(m,1)=x1(m,n);
  i=2;
  r2(m,i)=c(n+1-i)*r2(m,i-1)/c(n+2-i);
  y2=zeros(m,n);
  y2(m,1)=n;
  
  while r2(i)<1&i<n  
     x2(m,i)=x2(m,i-1)+((((1-(r2(m,i)^2))^0.5)-((1-(r2(m,i-1)^2))^0.5))/a/r2(m,i)); 
     y2(m,i)=n-i+1;
     i=i+1;
     r2(m,i)=c(n+1-i)*r2(m,i-1)/c(n+2-i);%该层掠射角的余弦
  end
   k2=i-1;
 
   r3=zeros(m,n);
   r3(m,1)=1;
  x3=zeros(m,n);
  x3(m,1)=x2(m,i-1);
  y3=zeros(m,n);
  y3(m,1)=y2(m,k2);
  i=2;
  r3(m,i)=c(i)*r3(m,i-1)/c(i-1);
  while y3(m,i-1)<z0;
      x3(m,i)=x3(m,i-1)+((((1-(r3(m,i-1)^2))^0.5)-((1-(r3(m,i)^2))^0.5))/a/r3(m,i-1)); 
      y3(m,i)=y3(m,i-1)+1;
      i=i+1;
      r3(m,i)=c(i)*r3(m,i-1)/c(i-1); %该层掠射角的余弦
  end
  k3=i-1;
  
  xm=[x1(m,1:n-1),x2(m,1:k2),x3(1:k3)];
  ym=[y1(m,1:n-1),y2(m,1:k2),y3(1:k3)];
  figure(1),plot(xm,-ym);hold on;     %一个周期

  x=[xm,xm(m,length(xm))+xm(n0+1:length(xm))];
  y=[ym,ym(n0+1:length(xm))];
   figure(2),plot(x,-y);hold on;  %两个周期
     m=m+1;
end

  
     
