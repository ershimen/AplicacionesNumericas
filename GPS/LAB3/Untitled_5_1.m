clear;clc;
load obs;
sp = read_sp3('IGS13230.SP3');
estacion = yebe;
NT = length(estacion.tow);
S3 = zeros(4,NT);
X3=[yebe.XYZ;0];
for k = 1:NT
    medidas = estacion.obs(:,k);
    aux = find(medidas~=-1);
    obs = medidas(aux);
    prn = estacion.prn(aux);
    TR = estacion.tow(k);
    S3(:,k) = get_pos(sp,TR,prn,obs,X3);
end
estacion = vill;
NT = length(estacion.tow);
S4 = zeros(4,NT);
X4=[vill.XYZ;0];
for k = 1:NT
    medidas = estacion.obs(:,k);
    aux = find(medidas~=-1);
    obs = medidas(aux);
    prn = estacion.prn(aux);
    TR = estacion.tow(k);
    S4(:,k) = get_pos(sp,TR,prn,obs,X4);
end

Epos = vill.XYZ-S4(1:3,:);

S3_corregido = S3(1:3,:) + Epos;
llh3 = xyz2llh(S3(1:3,:));
llh3_corregido = xyz2llh(S3_corregido);
llh_verdadero = xyz2llh(yebe.XYZ);
utm_verdadero = ll2utm(llh_verdadero(1:2,:));
utm3 = ll2utm(llh3(1:2,:));
utm3_corregido = ll2utm(llh3_corregido(1:2,:));
err_utm1 = utm3-utm_verdadero;
err_utm2 = utm3_corregido-utm_verdadero;
err_h1 = llh3(3,:)-llh_verdadero(3,:);
err_h2 = llh3_corregido(3,:)-llh_verdadero(3,:);
media_err_este = mean(abs(err_utm1(1,:)));
media_err_norte = mean(abs(err_utm1(2,:)));
media_err_altura = mean(abs(err_h1));
media_err_este_corr = mean(abs(err_utm2(1,:)));
media_err_norte_corr = mean(abs(err_utm2(2,:)));
media_err_altura_corr = mean(abs(err_h2));
fprintf("errores sin Poor's Man DGPS\n");
fprintf("  media err este: %.4f\n  media error norte: %.4f\n  media error altura: %.4f\n", media_err_este, media_err_norte, media_err_altura);
fprintf("errores con Poor's Man DGPS\n");
fprintf("  media err este: %.4f\n  media error norte: %.4f\n  media error altura: %.4f\n", media_err_este_corr, media_err_norte_corr, media_err_altura_corr);

figure;
plot(utm3(1,:), utm3(2,:), '.r', utm3_corregido(1,:), utm3_corregido(2,:), '.b', utm_verdadero(1), utm_verdadero(2), '*g');
legend('sin Poors Man DGPS','con Poors Man DGPS','estacion');
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
legend('sin Poors Man DGPS','con Poors Man DGPS');
