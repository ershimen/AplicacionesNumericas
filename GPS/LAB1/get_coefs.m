function [C, dC] = get_coefs(f)
% Entrada: fraccion f
C=zeros(8,1);  % Salida: vector columna coeficientes C
dC=zeros(8,1);
% Vuestro codigo para rellenar los valores de Ck
s = 3+f;
C(1)=1;
dC(1)=0;
for k = 0:6
    C(k+2) = C(k+1)*(s-k)/(k+1);
    dC(k+2) = (C(k+1)+(s-k+2)*dC(k+1))/(k+1);
end
return