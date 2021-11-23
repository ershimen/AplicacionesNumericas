function [ordenpagerank,tiempo,precision,niter2] = CalculoPageRank(N,r,niter)

% Variables de entrada:
% N=dimensión de la matriz,
% r=número medio de links de entrada/salida de cada nodo.
% niter=número de iteraciones
% Variable de salida:
% Ordenpagerank es el vector de índices [1:N] ordenado según el pagerank de la matriz G
% obtenido.
% tiempo= es el tiempo de ejecución de la rutina.
% precision= ||Gx-x||2 es la precisión obtenida

tic;

i=randi(N,1,r*N);
j=randi(N,1,r*N);
A=sparse(i,j,1,N,N);

Nj = sum(A);

i= Nj==0;

dj=zeros(1,N);
dj(i) = 1; 

ind_log = dj==1;
A(:,ind_log)=1/N;
A(:,~ind_log)=A(:,~ind_log)./Nj(~ind_log);

G=get_G(A,0.85);
whos A

[lambda,pagerank,niter2] = potencia_D(G,niter);

precision1 = norm(G*pagerank - lambda*pagerank);

precision2 = abs(lambda - 1);

precision =  max(precision1,precision2);

ordenpagerank = sort(pagerank,'descend');
tiempo = toc;

end




