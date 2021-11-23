function X=get_pos2(sp,Tr,sats,obs,X)
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
nsats=length(sats);
T_vuelo_sats=ones(1,nsats)*0.07;
c=physconst('LightSpeed');
M_Corr_sats=zeros(3,nsats);
while(i==0 || norm(sX,Inf)>0.01)
    i=i+1;
    % Paso 1
    cdt=X(4);
    pos=X(1:3);
    % Paso 2
    Tr_gps=Tr-(cdt/c);
    % Paso 3
    Tx_gps_sats=Tr_gps-T_vuelo_sats;
    % Paso 4
    [XYZ_sat, cdT, Vxyz]=get_data_sats(sp,Tx_gps_sats,sats);
    % Paso 5
    Ang_rot_sats=7.2921151467*(10^(-5))*T_vuelo_sats;
    for k=1:nsats
        M_rot_sats=[cos(Ang_rot_sats(k)) sin(Ang_rot_sats(k)) 0;-sin(Ang_rot_sats(k)) cos(Ang_rot_sats(k)) 0;0 0 1];
        XYZ_unSat=XYZ_sat(:,k);
        M_Corr_sats(:,k)=M_rot_sats*XYZ_unSat;
        % Correción relativista
        Vxyz_unSat=Vxyz(:,k);
        cdT(k,1)=cdT(k,1)-2*(dot(XYZ_unSat,Vxyz_unSat)/c);
    end
    % Paso 6
    [H,R]=get_HR(M_Corr_sats,pos);
    % Paso T_vuelo diferentes por satélite
    T_vuelo_sats(1,:)=R/c;
    % Paso 7
    esp=R+cdt-cdT;
    % Paso 8
    V_Discr=esp-obs;
    % Paso 9
    fprintf('\nIteracion %d\n',i);
    sX=H\V_Discr;
    X=X+sX;
    fprintf('%4.2f %4.2f %4.2f %6.2f\n',X);
end

return