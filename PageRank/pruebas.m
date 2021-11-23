clear; clc;
C = [0 1 0 0 1; 1 0 1 0 1; 0 0 0 1 0; 0 1 0 0 1; 0 0 0 0 0]';
n = length(C(1,:));
Nj = sum(C);
A = zeros(n, n);
% A
for i = 1:n
    for j = 1:n
        if Nj(j) ~= 0 
            A(i, j) = C(i, j)/Nj(j);
        end
    end
end
nj = sum(A);
% dj
dj = ones(1, n);
for k=1:n
    if(Nj(k) ~= 0)
        dj(k)=0;
    end
end
% G
alfa = 0.85;
e=ones(n,1);
S=A+(1/n)*e*dj;
G=alfa*S+(1-alfa)*(1/n)*(e*e');

N=51;
for p=1:5 
    E=zeros(5,N);
    E(3,1) = 1;
    for k=1:N-1
        E(:,k+1)=G*E(:,k);
    end
end
r = E(:,end);
error = S*r-r;



