function [XYZ, cdT, Vxyz, D]=interp_sat(sp,tow,PRN)
% Parametros entrada: sp -> estructura con posiciones satélites.
%                     tow ->  tiempo de la semana en seg
%                     PRN del sat en el que estamos interesados
% Parametros SALIDA:  XYZ : vector 3x1 con la posición interpolada (en mt)
%                     cdT : error reloj (en mt) interpolado en tiempo t.
%                     Vxyz : vector 3 x 1 con la velocidad (Vx,Vy,Vz) del sat (m/s)
%                     D : deriva del reloj (m/s) en tiempo t.

tt = (tow-sp.tow(1))/sp.delta;
prev = floor(tt)+1;
indice=1;
for k=1:length(sp.prn())
    if sp.prn(k)==PRN
        indice=k;
        k=length(sp.prn());
    end
end
rg = prev+(-3:4);
vX = sp.XYZT(1,rg,indice);
vY = sp.XYZT(2,rg,indice);
vZ = sp.XYZT(3,rg,indice);

dX = get_difs(vX);
dY = get_difs(vY);
dZ = get_difs(vZ);
M = [dX; dY; dZ];

f = mod(tow,sp.delta)/sp.delta;
[C,dC] = get_coefs(f);

XYZ = M*C;
Vxyz = (M*dC)/sp.delta;
D = ((sp.XYZT(4,prev+1,indice))-(sp.XYZT(4,prev,indice)))/sp.delta;

cdT = (1-f)*sp.XYZT(4,prev,indice)+f*sp.XYZT(4,prev+1,indice);
% fprintf('XYZ = [%.2f %.2f %.2f] \ncdT = %.2f\nVxyz = [%.2f %.2f %.2f] \nD = deriva = %.2e \n',XYZ,cdT,Vxyz,D);
return