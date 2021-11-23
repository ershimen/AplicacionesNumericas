clear;clc;

N=11; % DimensiÃ³n de la matriz
i=[1,1,1,2,2,3,3,3,3,4,4,5,6,6,6,7,7,7,7,8,11,11,11];
j=[2,4,5,3,7,4,6,8,10,2,7,11,4,5,7,2,4,8,11,9,2,9,10];
C=sparse(j,i,1,N,N);%calculo de la matriz C
Nj=sum(C);
    i = (Nj==0);
    dj=zeros(1,N);
    dj(i)=1;
    S=C;
    ind_log = dj==1;
S(:,ind_log)=1/N;
S(:,~ind_log)=S(:,~ind_log)./Nj(~ind_log);%calculo de la matriz S

alpha = 0.85;

G = alpha*S + (1-alpha) * ones(N)/N;

[lambda,pagerank] = potencia(G,50,N);

precision1 = norm(G*pagerank-pagerank);

precision2 = abs(lambda - 1);

bar(pagerank);