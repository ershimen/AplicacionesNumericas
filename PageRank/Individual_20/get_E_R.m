function [E,r]=get_E_R(M_Trans, E_inicial, N_estados)
    nodos = size(M_Trans,1);
    
    E=zeros(nodos,N_estados);    % E: Matriz de estados
    E(:,1)=E_inicial;           % Añadimos el estado inicial
    for k=1:N_estados-1
        E(:,k+1)=M_Trans*E(:,k);
    end
    r=E(:,end);
return