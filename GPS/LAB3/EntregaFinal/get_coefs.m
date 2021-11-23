function [C,dC] = get_coefs(f)
% Entrada: fraccion f
C=zeros(8,1);  % Salida: vector columna coeficientes C
dC=zeros(8,1);  % Salida: vector columna coeficientes dC
% Vuestro codigo para rellenar los valores de Ck y dCk
s=(3+f);
C(1,1)=1;
dC(1,1)=0;
for k=1:7
   C(k+1,1)= C(k,1)*((s-k+1)/k); 
   dC(k+1,1)=(C(k,1)+(s-k+1)*dC(k,1))/k;
end

return