function [lambda, pagerank, niter2] = potencia_D(G,niter)

N = size(G,1);  % Dimension del grafo

x1 = ones(N,1); % N dimension del grafo y x1 vector de arranque
precision = 1;
niter2 = 0;

while (niter2 < niter && precision > 10^(-12))
    
    niter2 = niter2 + 1;
    x = x1;
    x = x/norm(x);
    x1 = G*x;
    
    lambda = x' * x1;
    r = sum(x);
    pagerank = x/r;
    
    precision1 = norm(G*pagerank - lambda*pagerank);

    precision2 = abs(lambda - 1);

    precision =  max(precision1,precision2);
end

return