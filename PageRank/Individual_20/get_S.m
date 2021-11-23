function S=get_S(C, dj)
    A=get_A(C);
    N=size(A,1);
    e=ones(N,1);
    S=A+(1/N)*e*dj;
return