function [km] = next_kmer(ii,km)
switch(km(ii))
    case 'A'
        km(ii)='C';
    case 'C'
        km(ii)='G';
    case 'G'
        km(ii)='T';
    case 'T'
        km(ii)='A';                 %������Tʱ���൱�ڽ�λ,��λ����A����λ�ݹ�
        km=next_kmer(ii+1,km);
    otherwise
        disp('something wrong!'); %�ַ�����ACGTʱ����
end

end