clc
clear

size=7;
A=zeros(size);  % A: Matriz de transición
                % de tamaño size x size
N=21;           % N: Número de estados 
% Rellenamos la matriz de transición con
% las transiciones del grafo
A(1,2)=0.5;A(2,1)=0.5;A(3,2)=0.5;A(6,5)=0.5;
A(7,1)=0.5;A(7,5)=0.5;A(1,7)=1;A(5,3)=1;A(7,6)=1;
A(3,4)=1/3;A(5,4)=1/3;A(7,4)=1/3;
A
x=zeros(size);      
for p=1:size           % Marca el estado inicial
    E=zeros(size,N);% E: Matriz de estados
    E(p,1)=1;       % Estado inicial
    for k=1:N-1
        E(:,k+1)=A*E(:,k);
    end
    x(p,:)=E(:,N-1);
    plot(1:size,x(p,:),'o');
    hold on;
end
hold off;
r=E(:,end);      % r: Vector estacionario
e_inic = [1 0 0 0 0 0 0]';
r2=get_R(A, e_inic, N);
C=zeros(size);
C(1,2)=1;C(1,7)=1;C(2,1)=1;C(3,2)=1;C(3,4)=1;C(5,3)=1;C(5,4)=1;
C(6,5)=1;C(7,1)=1;C(7,4)=1;C(7,5)=1;C(7,6)=1;
A2=get_A(C)