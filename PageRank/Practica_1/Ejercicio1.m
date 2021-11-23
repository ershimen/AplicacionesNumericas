clc
clear

% Apartado A
%%{
N=7; % Dimensión de la matriz
i=[1,1,1,2,2,3,3,4,4,6,6,6,7,7];
j=[2,4,5,3,7,4,6,2,7,4,5,7,2,4];
C=sparse(j,i,1,N,N);
% Crea la matriz dispersa C de tamaño NxN tal que C(j(k),i(k))=1.
% Los vectores i, j del mismo tamaño contienen los nodos de entrada y de salida
full(C); % Visualizamos la matriz completa.
Ccompleta=full(C) % Creamos la matriz completa
whos % Vemos el tamaño que ocupan en memoria las matrices C y Ccompleta
Nj=sum(C)
i = (Nj==0);
dj=zeros(1,N);
dj(i)=1;
dj
S=C;
ind_log = dj==1;
S(:,ind_log)=1/N;
S(:,~ind_log)=S(:,~ind_log)./Nj(~ind_log);
S

G=get_G(S,0.85)


% Apartado B 

[V,D]=eig(G);
autovectores=abs(V)
autovalores=sum(abs(D))
max_autovalor=max(autovalores)
i=find(D == max_autovalor)
autovector_asociado_a_1 = autovectores(:,i)

% Apartado C
[avlr,avct]=potencia(G,50);
avct
avlr
