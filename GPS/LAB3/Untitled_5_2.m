clear;clc;
load obs;
sp = read_sp3('IGS13230.SP3');
estacion = yebe;
NT = length(estacion.tow);
S3 = zeros(4,NT);
X3=[yebe.XYZ;0];
S4 = zeros(4,NT);
X4=[vill.XYZ;0];
for k = 1:NT
    medidas_yebe = yebe.obs(:,k);
    medidas_vill = vill.obs(:,k);
    aux_yebe = find(medidas_yebe~=-1);
    aux_vill = find(medidas_vill~=-1);
    aux_interseccion = intersect(aux_yebe, aux_vill);
    obs_yebe = medidas_yebe(aux_interseccion);
    obs_vill = medidas_vill(aux_interseccion);
    prn = yebe.prn(aux_interseccion);
    TR = vill.tow(k);
    S3(:,k) = get_pos(sp,TR,prn,obs_yebe,X3);
    S4(:,k) = get_pos(sp,TR,prn,obs_vill,X4);
end

Epos = vill.XYZ-S4(1:3,:);

S3_corregido = S3(1:3,:) + Epos;
llh3 = xyz2llh(S3(1:3,:));
llh3_corregido = xyz2llh(S3_corregido);
llh_verdadero = xyz2llh(yebe.XYZ);
utm_verdadero = ll2utm(llh_verdadero(1:2,:));
utm3 = ll2utm(llh3(1:2,:));
utm3_corregido = ll2utm(llh3_corregido(1:2,:));

err_llh1 = llh3-llh_verdadero;
err_llh2 = llh3_corregido-llh_verdadero;
err_utm1 = utm3-utm_verdadero;
err_utm2 = utm3_corregido-utm_verdadero;
err_h1 = llh3(3,:)-llh_verdadero(3,:);
err_h2 = llh3_corregido(3,:)-llh_verdadero(3,:);
media_err_este = mean(abs(err_utm1(1,:)));
media_err_norte = mean(abs(err_utm1(2,:)));
media_err_altura = mean(abs(err_llh1(3,:)));
media_err_este_corr = mean(abs(err_utm2(1,:)));
media_err_norte_corr = mean(abs(err_utm2(2,:)));
media_err_altura_corr = mean(abs(err_llh2(3,:)));

fprintf("distintos satelites\n");
fprintf("  media error este: %.4f\n  media error norte: %.4f\n  media error altura: %.4f\n", media_err_este, media_err_norte, media_err_altura);
fprintf("con los mismos satelites\n");
fprintf("  media error este: %.4f\n  media error norte: %.4f\n  media error altura: %.4f\n", media_err_este_corr, media_err_norte_corr, media_err_altura_corr);

figure;
plot(utm3(1,:), utm3(2,:), '.r', utm3_corregido(1,:), utm3_corregido(2,:), '.b', utm_verdadero(1), utm_verdadero(2), '*g');
legend('distintos satelites','mismos satelites','estacion');
figure;
subplot(3,1,1);
plot(1:NT, err_utm1(1,:), 'r', 1:NT, err_utm2(1,:), 'b');
title("error en este");
subplot(3,1,2);
plot(1:NT, err_utm1(2,:), 'r', 1:NT, err_utm2(2,:), 'b');
title("error en norte");
subplot(3,1,3);
plot(1:NT, err_h1, 'r', 1:NT, err_h2, 'b');
title("error en h");
legend('distintos satelites','mismos satelites');