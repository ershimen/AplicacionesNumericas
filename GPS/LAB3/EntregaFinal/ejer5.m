clc
clear

clc
clear

load obs;
sp=read_sp3('IGS13230.sp3');
% Apartado a
% Estacion yebe
estacion_yebe=yebe;
observaciones_yebe=estacion_yebe.obs;
tiempos_yebe=estacion_yebe.tow;
prn_yebe=estacion_yebe.prn;
% Estacion vill
estacion_vill=vill;
observaciones_vill=estacion_vill.obs;
tiempos_vill=estacion_vill.tow;
prn_vill=estacion_vill.prn;
NT=900;
S=zeros(3,NT);
P1=[4850000; -310000; 4120000; 0.00];
P2=[4850000; -310000; 4120000; 0.00];
P_vill=estacion_vill.XYZ;
for k=1:NT
    Tr_yebe=tiempos_yebe(k);
    % Obtenemos las medidas y prns válidos para yebe
    medidas_yebe=observaciones_yebe(:,k);
    ok_yebe=find(medidas_yebe~=-1);
    obs_yebe=medidas_yebe(ok_yebe);
    prns_yebe=prn_yebe(ok_yebe);
    P1=get_pos(sp,Tr_yebe,prns_yebe,obs_yebe,P1);
    
    Tr_vill=tiempos_vill(k);
    % Obtenemos las medidas y prns válidos para vill
    medidas_vill=observaciones_vill(:,k);
    ok_vill=find(medidas_vill~=-1);
    obs_vill=medidas_vill(ok_vill);
    prns_vill=prn_vill(ok_vill);
    P2=get_pos(sp,Tr_vill,prns_vill,obs_vill,P2);
   
    % Guardamos posicion corregida
    Epos=P_vill-P2(1:3);
    S(1:3,k)=P1(1:3)+Epos;
end
XYZ=S(1:3,:);
% Obtenemos latitud, longitud y altura reales y calculadas
llh=xyz2llh(XYZ);
XYZ_real=estacion_yebe.XYZ;
llh_real=xyz2llh(XYZ_real);
H=llh(3,:);
H_real=llh_real(3,:);
ll=(llh(1:2,:));
ll_real=(llh_real(1:2,:));
% Obtenemos coordenadas utm (Este, Norte y Altura) reales y calculadas
[utm,zona]=ll2utm(ll);
[utm_real,zona_real]=ll2utm(ll_real);
dH_ejer5=H-H_real;
dE_ejer5=utm(1,:)-utm_real(1,:);
dN_ejer5=utm(2,:)-utm_real(2,:);
% Calculamos las medias y las imprimimos
media_dH_ejer5=mean(abs(dH_ejer5));
media_dE_ejer5=mean(abs(dE_ejer5));
media_dN_ejer5=mean(abs(dN_ejer5));
fprintf('media_dH_ejer5 = %.4f\n',media_dH_ejer5);
fprintf('media_dE_ejer5 = %.4f\n',media_dE_ejer5);
fprintf('media_dN_ejer5 = %.4f\n',media_dN_ejer5);


% Apartado b
NT=900;
S=zeros(3,NT);
P1=[4850000; -310000; 4120000; 0.00];
P2=[4850000; -310000; 4120000; 0.00];
P_vill=estacion_vill.XYZ;
% Los prns son comunes para yebe y vill
prn_sim=estacion_yebe.prn;
for k=1:NT
    % Obtenemos las medidas y prns válidos
    % simultáneos para ambas estaciones
    medidas_yebe=observaciones_yebe(:,k);
    medidas_vill=observaciones_vill(:,k);
    ok_yebe=find(medidas_yebe~=-1);
    ok_vill=find(medidas_vill~=-1);
    % Intersección para hallar el vector lógico
    ok_sim=intersect(ok_yebe,ok_vill);
    obs_sim_yebe=medidas_yebe(ok_sim);
    obs_sim_vill=medidas_vill(ok_sim);
    prns_sim=prn_sim(ok_sim);

    % Tiempos y cálculos de posiciones de cada estación
    Tr_yebe=tiempos_yebe(k);
    P1=get_pos(sp,Tr_yebe,prns_sim,obs_sim_yebe,P1);
    
    Tr_vill=tiempos_vill(k);
    P2=get_pos(sp,Tr_vill,prns_sim,obs_sim_vill,P2);
   
    % Guardamos posicion corregida
    Epos=P_vill-P2(1:3);
    S(1:3,k)=P1(1:3)+Epos;
end
XYZ=S(1:3,:);
% Obtenemos latitud, longitud y altura reales y calculadas
llh=xyz2llh(XYZ);
XYZ_real=estacion_yebe.XYZ;
llh_real=xyz2llh(XYZ_real);
H=llh(3,:);
H_real=llh_real(3,:);
ll=(llh(1:2,:));
ll_real=(llh_real(1:2,:));
% Obtenemos coordenadas utm (Este, Norte y Altura) reales y calculadas
[utm,zona]=ll2utm(ll);
[utm_real,zona_real]=ll2utm(ll_real);
dH_sim=H-H_real;
dE_sim=utm(1,:)-utm_real(1,:);
dN_sim=utm(2,:)-utm_real(2,:);
% Calculamos las medias simultáneas y las imprimimos
media_dH_SIM=mean(abs(dH_sim));
media_dE_SIM=mean(abs(dE_sim));
media_dN_SIM=mean(abs(dN_sim));
fprintf('media_dH_SIM = %.4f\n',media_dH_SIM);
fprintf('media_dE_SIM = %.4f\n',media_dE_SIM);
fprintf('media_dN_SIM = %.4f\n',media_dN_SIM);
% Gráficas comparando errores entre distintos satélites
% y mismos satélites
figure;
subplot(3,1,1);
plot(1:NT, dE_ejer5, 'r', 1:NT, dE_sim, 'b');
title("error en este");
subplot(3,1,2);
plot(1:NT, dN_ejer5, 'r', 1:NT, dN_sim, 'b');
title("error en norte");
subplot(3,1,3);
plot(1:NT, dH_ejer5, 'r', 1:NT, dH_sim, 'b');
title("error en h");
legend('distintos satelites','mismos satelites');
