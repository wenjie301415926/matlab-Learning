clear all;close all;clc;

k=4;
%kmer���г�ʼ��,kemr����Ϊ100���ո��ַ������k��A��ɾ������ո�
kmer_0='                                                                                             ';
for ii=1:k
    kmer_0(ii)='A';
end
kmer_0=deblank(kmer_0);
kmer=kmer_0;  
count=0;                   %hashֵ��ʼ����

hash_map=containers.Map(kmer,count);%��ʼ��hash��
count=count+1;%����AAAA�Ѿ���¼�ˣ�count+1,ΪCAAA��׼��

%��4^k��ѭ������kmer���е�ÿһ�ֿ��ܶ�Ӧһ��hashֵ������ӵ�hash��hash_map��
while (count<(4.^k))
    kmer=next_kmer(1,kmer);       %�õݹ麯���ı�kmer
   % disp(kmer);disp('=');disp(count);                  %���������Ƿ���ʾkmer����
    hash_map(kmer)=count;     %kmer���ж�Ӧhashֵ����ӵ�hash��hash_map�� 
    count=count+1;              %hashֵ+1
    
end
disp('please input hash_map(kmer_x)if you want to know the hash number of kmer_x.')
