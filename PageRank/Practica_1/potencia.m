function [atvlA, pagerank] = potencia(A,niter,N)

% N Dimension del grafo

x1 = ones(N,1); % N dimension del grafo y x1 vector de arranque

for k = 1:niter

    x = x1;
    x = x/norm(x);
    x1 = A*x;

end

atvlA = x' * x1;

r = sum(x);


pagerank = x/r;

