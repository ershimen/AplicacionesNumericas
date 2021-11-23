function dV=get_difs(V)
% Entrada: V vector fila con 8 componentes
% Salida:  dV vector fila con sus 8 diferencias finitas
dV=V; %Inicializamos vector de salida
for k=6:-1:0
    for j=0:k
        dV(8-j) = dV(8-j)-dV(8-j-1);
    end
end
return