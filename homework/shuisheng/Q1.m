clear all;clc;close all


xmin=-5;xmax=5;ymin=-5;ymax=5;
[X Y]=meshgrid(xmin:.1:xmax,ymin:.1:ymax);Z=2000./(0.05*(X.^2+Y.^2)+1);[C,h]=contour(X,Y,Z);text_handle = clabel(C,h);
view(0,90)

jj=0;
for ii=1:5:89
hold on
sita=-ii/180*pi;
jj=jj+1;

x_in=0;y_in=5;


xori=x_in;yori=y_in;
a_x=cos(sita);a_y=sin(sita);h= 0.1;t=0.1;flag=1;





D=0;MD=[];Time=0;MT=[];MP=[];


while (flag)
norm=sqrt(a_x^2+a_y^2);a_x=a_x/norm;a_y=a_y/norm;



xh=h*a_x+x_in;yh=h*a_y+y_in;
b1_x=a_y;b1_y=-a_x;b2_x=-a_y;b2_y=a_x;
x2=xh+t/2*b1_x;y2=yh+t/2*b1_y;x3=xh+t/2*b2_x;y3=yh+t/2*b2_y;
%% 

z=20.08;c1=z*sqrt(T1(x_in,y_in));c2=z*sqrt(T1(x2,y2));c3=z*sqrt(T1(x3,y3));
% if(c2<c3)
%     tmp=x2;
%     x2=x3;
%     x3=tmp;
%     tmp=y2;
%     y2=y3;
%     y3=tmp;
% end
%     
%     c1=z*sqrt(T(x_in,y_in));c2=z*sqrt(T(x2,y2));c3=z*sqrt(T(x3,y3));
%     
%%

A=[x_in y_in 1;x2 y2 1; x3 y3 1];Co=A\[c1;c2;c3];
cx=Co(1);cy=Co(2);c0=Co(3);

R=(c1*t/(c2-c3));
    d=(R-sqrt(R^2-h^2));
% if(R<0)
%     R=-R;
%     d=(R-sqrt(R^2-h^2));
% end

    
l=-a_y;m=a_x;
xout=xh+d*l/(sqrt(l^2+m^2));
yout=yh+d*m/(sqrt(l^2+m^2));
Rm=1/R;
bx=h*Rm*l/(sqrt(l^2+m^2))+(l-d*Rm)*a_x;
by=h*Rm*m/(sqrt(l^2+m^2))+(l-d*Rm)*a_y;
a_x=bx;a_y=by;



%%
dleD=sqrt((x_in-xout)^2+(y_in-yout)^2);
cs1=x_in/sqrt(x_in^2+y_in^2);
cs2=xout/sqrt(xout^2+yout^2);
delT=1/(2*sqrt(cx^2+cy^2))*abs(log((1+cs1)/(1-cs1)*(1-cs2)/(1+cs2)));


D=D+dleD;
MD=[MD; D];
Time=Time+delT;
%%
MT=[MT;Time];



hold on
figure(1)
x_in=xout;
y_in=yout;


if(x_in>xmax  || x_in<xmin  ||y_in>ymax  ||y_in<ymin)
    flag=0;
end



if(flag)
    MP=[MP;x_in y_in];
plot(MP(:,1),MP(:,2),'linewidth',2.3);
set(gca,'fontsize',14)
drawnow;

end

end
plot(-MP(:,1),MP(:,2),'linewidth',2.3);

MDD(ii)=sqrt((MP(end,1)-xori)^2+ (MP(end,2)-yori)^2);
MHD(ii)=MD(end);
MMT(ii)=MT(end);
disp(['第' num2str(jj) '次飞行的时间、弧线距离、直线距离分别为：'   num2str(MT(end))          '          '  num2str(MHD(end))        '       '  num2str(MDD(end))   ])
end



