clear;clc;
load obs;
sp = read_sp3('IGS13230.SP3');
estacion = mer;
NT = length(estacion.tow);
% Siempre que haya dos variables que se llamen igual solo que una con "2" y
% otra con "3", significa que la que tiene "2" es de get_pos2 (sin pesos) y
% la que tiene "3" es de get_pos3 (con pesos).
S2 = zeros(4,NT);
S3 = zeros(4,NT);
X2=[estacion.XYZ;0];
X3=[estacion.XYZ;0];
for k = 1:NT
    medidas = estacion.obs(:,k);
    aux = find(medidas~=-1);
    obs = medidas(aux);
    prn = estacion.prn(aux);
    TR = estacion.tow(k);
    S2(:,k) = get_pos2(sp,TR,prn,obs,X2);
    S3(:,k) = get_pos3(sp,TR,prn,obs,X3);
end
llh2 = xyz2llh(S2(1:3,:));
llh3 = xyz2llh(S3(1:3,:));
xyz_verdaderos = estacion.XYZ;
llh_verdaderos = xyz2llh(xyz_verdaderos);
utm_verdaderos = ll2utm(llh_verdaderos(1:2,:));
err_llh2 = llh2-llh_verdaderos;
err_llh3 = llh3-llh_verdaderos;
err_xyz2 = S2(1:3,:)-xyz_verdaderos;
err_xyz3 = S3(1:3,:)-xyz_verdaderos;
err_max_altura2 = max(abs(err_llh2(3,:)));
err_medio_altura2 = mean(err_llh2(3,:));
err_max_altura3 = max(abs(err_llh3(3,:)));
err_medio_altura3 = mean(err_llh3(3,:));
fprintf("Error maximo de altura sin pesos: %.4f\nError medio de altura sin pesos: %.4f\nError maximo de altura con pesos: %.4f\nError medio de altura con pesos: %.4f\n", err_max_altura2, err_medio_altura2, err_max_altura3, err_medio_altura3);
utm2 = ll2utm(llh2(1:2,:));
utm3 = ll2utm(llh3(1:2,:));
err_utm2 = utm2-utm_verdaderos;
err_utm3 = utm3-utm_verdaderos;
figure;
plot(utm2(1,:), utm2(2,:), '.r', utm3(1,:), utm3(2,:), '.b', utm_verdaderos(1), utm_verdaderos(2), '*g');
legend('get\_pos2 (sin pesos)', 'get\_pos3 (con pesos)', 'estacion');
figure;
subplot(3,1,1);
plot(1:NT, err_llh2(3,:), 'r', 1:NT, err_llh3(3,:), 'b');
title("error en altura");
subplot(3,1,2);
plot(1:NT, err_utm2(1,:), 'r', 1:NT, err_utm3(1,:), 'b');
title("error en este");
subplot(3,1,3);
plot(1:NT, err_utm2(2,:), 'r', 1:NT, err_utm3(2,:), 'b');
title("error en norte");
legend('get\_pos2 (sin pesos)','get\_pos3 (con pesos)');

