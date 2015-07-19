clear;clc;
duan=importdata('short.txt');
str1=('AGCTA');
hang=40;
anss(hang,100)=0;
for n=1:hang
    
  dua=duan{n};
  strfind(dua,str1); 
  l=length(ans);
  anss(n,1:l)=ans;
  

end

