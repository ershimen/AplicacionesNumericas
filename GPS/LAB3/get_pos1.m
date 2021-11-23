function X=get_pos1(sp,Tr,sats,obs,X)
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
    %fprintf('Tx_gps: %4.8f\n',Tx_gps);
    [XYZ_sat, cdT]= get_data_sats(sp, Tx_gps, sats);
    angulos = vel_angular .* T_vuelo;
    %{
    for n=1:nsats
        fprintf('%13.3f %13.3f %13.3f  %13.2f  ',XYZ_sat(:,n),cdT(n));
        fprintf('\n');
    end
    %}
    for k = 1:nsats
        m_rotacion = [cos(angulos(k)) sin(angulos(k)) 0; -sin(angulos(k)) cos(angulos(k)) 0; 0 0 1];
        pos_corregidas(:,k) = m_rotacion * XYZ_sat(:,k);
    end
    %{
    for n=1:nsats
        fprintf('%1.4e %13.3f %13.3f  %13.3f  ',angulos(n),pos_corregidas(:,n));
        fprintf('\n');
    end
    %}
    [H, R] = get_HR(pos_corregidas, X_aux);
    esp = R + cdt_aux - cdT;
    T_vuelo = R/c;
    discrepancia_p = esp - obs;
    %{
    for n=1:nsats
        fprintf('%13.7f %13.7f %13.7f %d        ',H(n,:));
        fprintf('%13.2f    ',R(n));
        fprintf('%13.2f    ',cdT(n));
        fprintf('%13.3f',discrepancia_p(n));
        fprintf('\n');
    end
    %}
    Sx = H\discrepancia_p;
    %fprintf('%.3f %.3f %.3f %.2f\n',Sx);
    X = X + Sx;
    lim = norm(Sx, Inf);
    %fprintf('    Iteracion %d:\n', i);
    %fprintf('X = %.2f %.2f %.2f %.2f\n', X);
    i=i+1;
end

return