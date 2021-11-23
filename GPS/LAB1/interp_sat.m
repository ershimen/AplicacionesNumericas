function [XYZ, cdT, Vxyz, D]=interp_sat(sp,tow,PRN)
% Parametros entrada: sp -> estructura con posiciones satélites.
%                     tow ->  tiempo de la semana en seg
%                     PRN del sat en el que estamos interesados
% Parametros SALIDA:  XYZ=vector 3x1 con la posición interpolada (en mt)
%                     cdT = error reloj (en mt) interpolado en tiempo t.
tt=(tow-sp.tow(1))/sp.delta;
prev=floor(tt)+1;
rg = prev+(-3:4);
% Calcular el indice del satélite con PRN
indice = find(sp.prn==PRN);
x = sp.XYZT(1,rg,indice);
y = sp.XYZT(2,rg,indice);
z = sp.XYZT(3,rg,indice);
dX = get_difs(x);
dY = get_difs(y);
dZ = get_difs(z);

% Calcular el valor de f
f = mod(tow, 900)/900;

% Vector coeficientes
[C, dC] = get_coefs(f);
h=900;
% Valores interpolados
XYZ(1) = dX * C;
XYZ(2) = dY * C;
XYZ(3) = dZ * C;

Vxyz(1) = (dX * dC)/h; 
Vxyz(2) = (dY * dC)/h;
Vxyz(3) = (dZ * dC)/h;

% Tiempo error interpolado
cdT = (1-f)*sp.XYZT(4,prev, indice) + f*sp.XYZT(4,prev+1, indice);

% Deriva
D = (sp.XYZT(4,prev, indice)-sp.XYZT(4,prev+1, indice))/h;

return