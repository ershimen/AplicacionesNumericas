function A=get_A(C)
    N=size(C,1);
    A=zeros(N);
    Nj=sum(C);
    for k=1:N
        if (Nj(k) ~= 0)
            A(:,k)=C(:,k)./Nj(k);
        end
    end
return