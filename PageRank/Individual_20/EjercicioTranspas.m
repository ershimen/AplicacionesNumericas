clc
clear

%Ejercicios Transparencias
N_estados=21;
C=zeros(6);
C(2,1)=1; C(3,2)=1; C(6,2)=1; C(5,6)=1; C(2,5)=1; C(5,4)=1;
C
[Nj,dj]=get_nj_dj(C);
Nj
dj
A=get_A(C)
S=get_S(C,dj)
alfa=0.85;
G=get_G(S,alfa)
E0=[1 0 0 0 0 0];
[E,r]=get_E_R(G, E0, N_estados);
E(:,20)
fprintf("Orden: 2 > 5 > 3 = 7 > 1 = 4\n");