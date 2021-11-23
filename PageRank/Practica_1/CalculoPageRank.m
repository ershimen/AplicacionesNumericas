function [ordenpagerank,precision] = CalculoPageRank(N,p,niter)

i=randi(N,1,p*N);
j=randi(N,1,p*N);
C=sparse(i,j,1,N,N);


Ccompleta=full(C); % Creamos la matriz completa

Nj = sum(Ccompleta);

i=Nj==0;

dj=zeros(1,N);
dj(i) = 1;

S = Ccompleta; 

for k=1:N
   
    if(dj(k)==1) 
        S(:,k)= 1/N;
    else 
        S(:,k)= S(:,k)/Nj(k);
    end
        
    
end

alpha = 0.85;

G = alpha*S + (1-alpha) * ones(N)/N;


%28 iteraciones para error de 1e-12

[lambda,pagerank] = potencia(G,niter,N);

precision1 = norm(G*pagerank-pagerank);

precision2 = abs(lambda - 1);

precision =  max(precision1,precision2);

ordenpagerank = sort(pagerank,'descend');




