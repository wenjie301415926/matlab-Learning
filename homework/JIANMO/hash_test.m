clear all;close all;clc;

k=4;
%kmer序列初始化,kemr设置为100个空格字符，填充k个A后删除其余空格
kmer_0='                                                                                             ';
for ii=1:k
    kmer_0(ii)='A';
end
kmer_0=deblank(kmer_0);
kmer=kmer_0;  
count=0;                   %hash值初始置零

hash_map=containers.Map(kmer,count);%初始化hash表
count=count+1;%由于AAAA已经记录了，count+1,为CAAA做准备

%做4^k次循环，把kmer序列的每一种可能对应一个hash值，并添加到hash表hash_map中
while (count<(4.^k))
    kmer=next_kmer(1,kmer);       %用递归函数改变kmer
   % disp(kmer);disp('=');disp(count);                  %可以设置是否显示kmer序列
    hash_map(kmer)=count;     %kmer序列对应hash值并添加到hash表hash_map中 
    count=count+1;              %hash值+1
    
end
disp('please input hash_map(kmer_x)if you want to know the hash number of kmer_x.')
