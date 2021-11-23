function X=get_pos(sp,Tr,sats,obs,X)
%   ARGUMENTOS DE ENTRADA:
%   sp : Estructura sp3 con los datos de los satélites durante ese día
%   Los datos suministrados por el GPS:
%       - Tr : El tiempo en que se tomo la medida según receptor,
%       - sats : Los PRNs de los satélites observados
%       - vector COLUMNA obs : Medidas tomadas a dichos satélites (vector COLUMNA obs).
%   X: vector 4x1 con hipótesis inicial (posición XYZ0+error cdt0) en metros.
%   ARGUMENTOS DE SALIDA:
%   Vector X (tamaño 4x1): el resultado final de la iteración, con la posición
%   del receptor en sus 3 primeras componentes y error de reloj cdt en la 4ª.
i=0;
while(i==0 || norm(sX,Inf)>0.01)
    i=i+1;
    % Paso 1
    cdt=X(4);
    pos=[X(1);X(2);X(3)];
    c=physconst('LightSpeed');
    % Paso 2
    Tr_gps=Tr-(cdt/c);
    T_vuelo=0.070;
    % Paso 3
    Tx_gps=Tr_gps-T_vuelo;
    % Paso 4
    [XYZ_sat,cdT]=get_data_sats(sp,Tx_gps,sats);
    % Paso 5
    Ang_rot=7.2921151467*(10^(-5))*T_vuelo;
    M_rot=[cos(Ang_rot) sin(Ang_rot) 0;-sin(Ang_rot) cos(Ang_rot) 0;0 0 1];
    M_Corr=M_rot*XYZ_sat;
    % Paso 6
    [H,R]=get_HR(M_Corr,pos);
    % Paso 7
    esp=R+cdt-cdT;
    % Paso 8
    V_Discr=esp-obs;
    % Paso 9
%     fprintf('\nIteracion %d\n',i);
    sX=H\V_Discr;
    X=X+sX;
%     fprintf('%4.2f %4.2f %4.2f %6.2f\n',X);
end

return