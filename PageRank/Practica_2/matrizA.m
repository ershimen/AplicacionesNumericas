function [A,sd] = matrizA(N,r)
% Variables de entrada
% N: dimensión de la matriz
% r: nº medio de links de entrada/salida de cada nodo
% Variables de salida
% A: matriz del modelo dispersa de tamaño NxN (sum(A) debe ser un vector
% 1's o 0's
p=randi(N,1,r*N);
q=randi(N,1,r*N);
A=sparse(p,q,1,N,N); 

Nj = sum(A);

i= Nj==0;

dj=zeros(1,N);
dj(i) = 1;
sd=sum(dj)

ind_log = dj==1;
A(:,~ind_log)=A(:,~ind_log)./Nj(~ind_log);

return