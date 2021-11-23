function X=get_pos3(sp,Tr,sats,obs,X)
c=physconst('LightSpeed');
vel_angular = 7.2921151467*(10^-5);
lim = 1;
nsats = length(sats);
T_vuelo = ones(1, nsats)*0.07;
pos_corregidas = zeros(3, nsats);
i=1;
while(lim>0.01)
    cdt_aux = X(4);
    X_aux = X(1:3);
    Tx_gps = Tr - (cdt_aux/c) - T_vuelo;
    [XYZ_sat, cdT, Vxyz] = get_data_sats(sp, Tx_gps, sats);
    angulos = vel_angular .* T_vuelo;
    Q = zeros(nsats, nsats);
    for k = 1:nsats
        m_rotacion = [cos(angulos(k)) sin(angulos(k)) 0; -sin(angulos(k)) cos(angulos(k)) 0; 0 0 1];
        pos_corregidas(:,k) = m_rotacion * XYZ_sat(:,k);
        cdT(k)=cdT(k)-2*(dot(XYZ_sat(:,k),Vxyz(:,k))/c);
        % pesos
        angulo = elaz(XYZ_sat(:,k),X(1:3));
        if angulo > 0 
            Q(k,k) = sind(angulo)^2;
        end
    end
    [H, R] = get_HR(pos_corregidas, X_aux);
    esp = R + cdt_aux - cdT;
    T_vuelo = R/c;
    discrepancia_p = esp - obs;
    Sx = (H'*Q*H)\((H'*Q)*discrepancia_p);
    X = X + Sx;
    lim = norm(Sx, Inf);
    %fprintf('    Iteracion %d:\n', i);
    %fprintf('X = %.2f %.2f %.2f %.2f\n', X);
    i=i+1;
end

return
