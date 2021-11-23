function dV=get_difs(V)
% Entrada: V vector fila con 8 componentes
% Salida:  dV vector fila con sus 8 diferencias finitas
dV=V; %Inicializamos vector de salida 
for i=2:8
    for j=8:-1:i
        dV(j)= dV(j) - dV(j-1);
    end
end       
return