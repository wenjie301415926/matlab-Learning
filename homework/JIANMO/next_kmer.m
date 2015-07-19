function [km] = next_kmer(ii,km)
switch(km(ii))
    case 'A'
        km(ii)='C';
    case 'C'
        km(ii)='G';
    case 'G'
        km(ii)='T';
    case 'T'
        km(ii)='A';                 %当遇到T时，相当于进位,本位复置A，高位递归
        km=next_kmer(ii+1,km);
    otherwise
        disp('something wrong!'); %字符不是ACGT时报错
end

end