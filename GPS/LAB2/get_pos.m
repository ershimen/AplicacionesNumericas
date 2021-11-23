function X=get_pos(sp,Tr,sats,obs,X)
c=physconst('LightSpeed');
vel_angular = 7.2921151467*(10^-5);
lim = 1;
nsats = length(sats);
T_vuelo = 0.07;
i=1;
while(lim>0.01)
    cdt_aux = X(4);
    X_aux = X(1:3);
    Tx_gps = Tr - (cdt_aux/c) - T_vuelo;
    [XYZ_sat, cdT]= get_data_sats(sp, Tx_gps, sats);
    angulo = vel_angular * T_vuelo;
    m_rotacion = [cos(angulo) sin(angulo) 0; -sin(angulo) cos(angulo) 0; 0 0 1];
    pos_corregidas = m_rotacion * XYZ_sat;
    [H, R] = get_HR(pos_corregidas, X_aux);
    esp = R + cdt_aux - cdT;
    discrepancia_p = esp - obs;
    Sx = H\discrepancia_p;
    X = X + Sx;
    lim = norm(Sx, Inf);
    fprintf('    Iteracion %d:\n', i);
    fprintf('X = %.2f %.2f %.2f %.2f\n', X);
    i=i+1;
end

return