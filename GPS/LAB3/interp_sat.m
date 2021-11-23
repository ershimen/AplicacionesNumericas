function [XYZ, cdT, Vxyz, D]=interp_sat(sp,tow,PRN)
% Parametros entrada: sp -> estructura con posiciones sat�lites.
%                     tow ->  tiempo de la semana en seg
%                     PRN del sat en el que estamos interesados
% Parametros SALIDA:  XYZ : vector 3x1 con la posici�n interpolada (en mt)
%                     cdT : error reloj (en mt) interpolado en tiempo t.
%                     Vxyz : vector 3 x 1 con la velocidad (Vx,Vy,Vz) del sat (m/s)
%                     D : deriva del reloj (m/s) en tiempo t.
tt=(tow-sp.tow(1))/sp.delta;
prev=floor(tt)+1;
rg = prev+(-3:4);
% Calcular el indice del sat�lite con PRN
indice = find(sp.prn==PRN);
x = sp.XYZT(1,rg,indice);
y = sp.XYZT(2,rg,indice);
z = sp.XYZT(3,rg,indice);
dX = get_difs(x);
dY = get_difs(y);
dZ = get_difs(z);
h=sp.delta;
% Calcular el valor de f
f = mod(tow, h)/h;

% Vector coeficientes
[C, dC] = get_coefs(f);

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
%fprintf('XYZ= [%.2f %.2f %.2f] cdT = %.2f\nVxyz= [%.2f %.2f %.2f] D = %d\n',XYZ,cdT,Vxyz,D);
return