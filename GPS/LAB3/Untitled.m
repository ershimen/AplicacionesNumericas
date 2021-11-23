clear;clc;
load obs;
sp = read_sp3('igs13230.SP3');
NT = sp.delta;
estacion = yebe;
S = zeros(4,NT);
X=[estacion.XYZ;0];
figure;
im=imread('yebes.jpg');
image(im);
hold on;
%-------------------- get_pos -------------------
for k = 1:NT
    medidas = estacion.obs(:,k);
    aux = find(medidas~=-1);
    obs = medidas(aux);
    prn = estacion.prn(aux);
    TR = estacion.tow(k);
    S(:,k) = get_pos(sp,TR,prn,obs,X);
end
error = S(4,:);
error = error ./ physconst('LightSpeed') *10^6;
%plot(1:900, error);
subS = S(1:3,:);
llh = xyz2llh(subS);
mediaLon = mean(llh(1,:));
mediaLat = mean(llh(2,:));
mediaAlt = mean(llh(3,:));
fprintf('%5.5f %5.5f %5.5f\n', mediaLat, mediaLon, mediaAlt);
H = subS(3,:);
[utm, zona] = ll2utm(llh(1:2,:));
norte = utm(2,:);
este = utm(1,:);
% pos verdaderas
xyz_verdaderos = estacion.XYZ;
llh_verdaderos = xyz2llh(xyz_verdaderos);
[utm_verd, zona_verd] = ll2utm(llh_verdaderos(1:2,1));
err_verdaderos(1,:) = H-llh_verdaderos(3,:);
err_verdaderos(2:3,:) = utm-utm_verd;
%plot(err_verdaderos(2,:), err_verdaderos(3,:),'o');
errores_abs = [mean(abs(err_verdaderos(1,:))), mean(abs(err_verdaderos(2,:))), mean(abs(err_verdaderos(3,:)))];
errores_max = [max(abs(err_verdaderos(1,:))), max(abs(err_verdaderos(2,:))), max(abs(err_verdaderos(3,:)))];
r = sqrt((err_verdaderos(2,:).^2) + (err_verdaderos(3,:).^2));
media_r = mean(abs(r));
max_r = max(abs(r));
n = length(find(abs(r)<6));
porcentaje = n/length(r);
%histogram(r);


E0=492000;
N0=4487000;
% metros a pixeles
E_imagen = abs((utm(1,:)-E0)/2);
N_imagen = abs((utm(2,:)-N0)/2);
plot(E_imagen, N_imagen,'r.');



%-------------------- get_pos1 -------------------
for k = 1:NT
    medidas = estacion.obs(:,k);
    aux = find(medidas~=-1);
    obs = medidas(aux);
    prn = estacion.prn(aux);
    TR = estacion.tow(k);
    S(:,k) = get_pos1(sp,TR,prn,obs,X);
end
error = S(4,:);
error = error ./ physconst('LightSpeed') *10^6;
%plot(1:900, error);
subS = S(1:3,:);
llh = xyz2llh(subS);
mediaLon = mean(llh(1,:));
mediaLat = mean(llh(2,:));
mediaAlt = mean(llh(3,:));
fprintf('%5.5f %5.5f %5.5f\n', mediaLat, mediaLon, mediaAlt);
H = subS(3,:);
[utm, zona] = ll2utm(llh(1:2,:));
norte = utm(2,:);
este = utm(1,:);
% pos verdaderas
xyz_verdaderos = estacion.XYZ;
llh_verdaderos = xyz2llh(xyz_verdaderos);
[utm_verd, zona_verd] = ll2utm(llh_verdaderos(1:2,1));
err_verdaderos(1,:) = H-llh_verdaderos(3,:);
err_verdaderos(2:3,:) = utm-utm_verd;
%plot(err_verdaderos(2,:), err_verdaderos(3,:),'o');
errores_abs = [mean(abs(err_verdaderos(1,:))), mean(abs(err_verdaderos(2,:))), mean(abs(err_verdaderos(3,:)))];
errores_max = [max(abs(err_verdaderos(1,:))), max(abs(err_verdaderos(2,:))), max(abs(err_verdaderos(3,:)))];
r = sqrt((err_verdaderos(2,:).^2) + (err_verdaderos(3,:).^2));
media_r = mean(abs(r));
max_r = max(abs(r));
n = length(find(abs(r)<6));
porcentaje = n/length(r);
%histogram(r);
E0=492000;
N0=4487000;
% metros a pixeles
E_imagen = abs((utm(1,:)-E0)/2);
N_imagen = abs((utm(2,:)-N0)/2);
plot(E_imagen, N_imagen,'b.');


%-------------------- get_pos2 -------------------
for k = 1:NT
    medidas = estacion.obs(:,k);
    aux = find(medidas~=-1);
    obs = medidas(aux);
    prn = estacion.prn(aux);
    TR = estacion.tow(k);
    S(:,k) = get_pos2(sp,TR,prn,obs,X);
end
error = S(4,:);
error = error ./ physconst('LightSpeed') *10^6;
%plot(1:900, error);
subS = S(1:3,:);
llh = xyz2llh(subS);
mediaLon = mean(llh(1,:));
mediaLat = mean(llh(2,:));
mediaAlt = mean(llh(3,:));
fprintf('%5.5f %5.5f %5.5f\n', mediaLat, mediaLon, mediaAlt);
H = subS(3,:);
[utm, zona] = ll2utm(llh(1:2,:));
norte = utm(2,:);
este = utm(1,:);
% pos verdaderas
xyz_verdaderos = estacion.XYZ;
llh_verdaderos = xyz2llh(xyz_verdaderos);
[utm_verd, zona_verd] = ll2utm(llh_verdaderos(1:2,1));
err_verdaderos(1,:) = H-llh_verdaderos(3,:);
err_verdaderos(2:3,:) = utm-utm_verd;
%plot(err_verdaderos(2,:), err_verdaderos(3,:),'o');
errores_abs = [mean(abs(err_verdaderos(1,:))), mean(abs(err_verdaderos(2,:))), mean(abs(err_verdaderos(3,:)))];
errores_max = [max(abs(err_verdaderos(1,:))), max(abs(err_verdaderos(2,:))), max(abs(err_verdaderos(3,:)))];
r = sqrt((err_verdaderos(2,:).^2) + (err_verdaderos(3,:).^2));
media_r = mean(abs(r));
max_r = max(abs(r));
n = length(find(abs(r)<6));
porcentaje = n/length(r);
%histogram(r);

E0=492000;
N0=4487000;
% metros a pixeles
E_imagen = abs((utm(1,:)-E0)/2);
N_imagen = abs((utm(2,:)-N0)/2);
plot(E_imagen, N_imagen,'g.');

%-------------------- get_pos3 -------------------
for k = 1:NT
    medidas = estacion.obs(:,k);
    aux = find(medidas~=-1);
    obs = medidas(aux);
    prn = estacion.prn(aux);
    TR = estacion.tow(k);
    S(:,k) = get_pos3(sp,TR,prn,obs,X);
end
error = S(4,:);
error = error ./ physconst('LightSpeed') *10^6;
%plot(1:900, error);
subS = S(1:3,:);
llh = xyz2llh(subS);
mediaLon = mean(llh(1,:));
mediaLat = mean(llh(2,:));
mediaAlt = mean(llh(3,:));
fprintf('%5.5f %5.5f %5.5f\n', mediaLat, mediaLon, mediaAlt);
H = subS(3,:);
[utm, zona] = ll2utm(llh(1:2,:));
norte = utm(2,:);
este = utm(1,:);
% pos verdaderas
xyz_verdaderos = estacion.XYZ;
llh_verdaderos = xyz2llh(xyz_verdaderos);
[utm_verd, zona_verd] = ll2utm(llh_verdaderos(1:2,1));
err_verdaderos(1,:) = H-llh_verdaderos(3,:);
err_verdaderos(2:3,:) = utm-utm_verd;
%plot(err_verdaderos(2,:), err_verdaderos(3,:),'o');
errores_abs = [mean(abs(err_verdaderos(1,:))), mean(abs(err_verdaderos(2,:))), mean(abs(err_verdaderos(3,:)))];
errores_max = [max(abs(err_verdaderos(1,:))), max(abs(err_verdaderos(2,:))), max(abs(err_verdaderos(3,:)))];
r = sqrt((err_verdaderos(2,:).^2) + (err_verdaderos(3,:).^2));
media_r = mean(abs(r));
max_r = max(abs(r));
n = length(find(abs(r)<6));
porcentaje = n/length(r);
%histogram(r);

E0=492000;
N0=4487000;
% metros a pixeles
E_imagen = abs((utm(1,:)-E0)/2);
N_imagen = abs((utm(2,:)-N0)/2);
plot(E_imagen, N_imagen,'m.');

hold off;


%{
p_obs=[4850000;-310000;4120000];
skyplot(sp, 6000, p_obs);
%}

%{
p_obs=[4850000;-310000;4120000];
sats1 = [01 02 05 06 14 16 21 25 30];
nch = nchoosek(sats1,6);
res = zeros(1, length(nch));
for k = 1:length(nch)
    res(k) = get_pdop(sp, 6000, nch(k,:), p_obs);
end
pdop_max = max(res);
sats_peores = nch(find(res==pdop_max),:);
%}
