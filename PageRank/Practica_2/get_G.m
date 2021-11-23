function G=get_G(S, alfa)
    N=size(S,1);
    e=ones(N,1);
    G=alfa*S+(1-alfa)*(1/N)*(e*e');
return