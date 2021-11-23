function [nj, dj]=get_nj_dj(C)
    nj=sum(C);
    N=size(C,1);
    dj=zeros(1,N);
    for k=1:N
        if(nj(k) == 0)
            dj(k)=1;
        else
            dj(k)=0;
        end
    end
return