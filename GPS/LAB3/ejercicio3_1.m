% Explicacion nombres de variables:
% las variables correspondientes a calculos con get_pos tienen "1"
% las variables correspondientes a calculos con get_pos1 tienen "2"
% las variables correspondientes a calculos con get_pos2 tienen "3"
% las variables correspondientes a calculos con get_pos3 tienen "4"
clear;clc;
load obs;
sp = read_sp3('igs13230.SP3');
NT = sp.delta;
estacion = yebe;
S1 = zeros(4,NT);
S2 = zeros(4,NT);
S3 = zeros(4,NT);
S4 = zeros(4,NT);
X1=[estacion.XYZ;0];
X2=[estacion.XYZ;0];
X3=[estacion.XYZ;0];
X4=[estacion.XYZ;0];
figure;
im=imread('yebes.jpg');
image(im);
hold on;
for k = 1:NT
    medidas = estacion.obs(:,k);
    aux = find(medidas~=-1);
    obs = medidas(aux);
    prn = estacion.prn(aux);
    TR = estacion.tow(k);
    S1(:,k) = get_pos(sp,TR,prn,obs,X1);
    S2(:,k) = get_pos1(sp,TR,prn,obs,X2);
    S3(:,k) = get_pos2(sp,TR,prn,obs,X3);
    S4(:,k) = get_pos3(sp,TR,prn,obs,X4);
end

llh1 = xyz2llh(S1(1:3,:));
llh2 = xyz2llh(S2(1:3,:));
llh3 = xyz2llh(S3(1:3,:));
llh4 = xyz2llh(S4(1:3,:));

utm1 = ll2utm(llh1(1:2,:));
utm2 = ll2utm(llh2(1:2,:));
utm3 = ll2utm(llh3(1:2,:));
utm4 = ll2utm(llh4(1:2,:));

% valores verdaderos
xyz_verdaderos = estacion.XYZ;
llh_verdaderos = xyz2llh(xyz_verdaderos);
utm_verdadero= ll2utm(llh_verdaderos(1:2,1));

% metros a pixeles
E0=492000;
N0=4487000;
E_imagen1 = abs((utm1(1,:)-E0)/2);
N_imagen1 = abs((utm1(2,:)-N0)/2);
E_imagen2 = abs((utm2(1,:)-E0)/2);
N_imagen2 = abs((utm2(2,:)-N0)/2);
E_imagen3 = abs((utm3(1,:)-E0)/2);
N_imagen3 = abs((utm3(2,:)-N0)/2);
E_imagen4 = abs((utm4(1,:)-E0)/2);
N_imagen4 = abs((utm4(2,:)-N0)/2);
E_imagen_estacion = abs((utm_verdadero(1,:)-E0)/2);
N_imagen_estacion = abs((utm_verdadero(2,:)-N0)/2);
plot(E_imagen1, N_imagen1,'r.',E_imagen2, N_imagen2,'b.',E_imagen3, N_imagen3,'g.',E_imagen4, N_imagen4,'m.', E_imagen_estacion, N_imagen_estacion, 'yO');
legend('get\_pos', 'get\_pos1', 'get\_pos2', 'get\_pos3', 'estacion');
hold off;

% calculo de CEP95
err_utm1 = utm1-utm_verdadero;
err_utm2 = utm2-utm_verdadero;
err_utm3 = utm3-utm_verdadero;
err_utm4 = utm4-utm_verdadero;
r1=sqrt(err_utm1(1,:).^2+err_utm1(2,:).^2);
r2=sqrt(err_utm2(1,:).^2+err_utm2(2,:).^2);
r3=sqrt(err_utm3(1,:).^2+err_utm3(2,:).^2);
r4=sqrt(err_utm4(1,:).^2+err_utm4(2,:).^2);
% Para calcular CEP95 se tantea con el valor dentro de las siguientes expresiones:
n_valores1=length(find(r1<12.91));
n_valores2=length(find(r2<7.5));
n_valores3=length(find(r3<6.1));
n_valores4=length(find(r4<5.89));
% CEP95 (get_pos) = 12.91
% CEP95 (get_pos1)= 7.5
% CEP95 (get_pos2)= 6.1
% CEP95 (get_pos3)= 5.89
CEP_1=(n_valores1/length(r1))*100;
CEP_2=(n_valores2/length(r2))*100;
CEP_3=(n_valores3/length(r3))*100;
CEP_4=(n_valores4/length(r4))*100;
fprintf("CEP95:\n get_pos  -> 12.91\n get_pos1 -> 7.5 \n get_pos2 -> 6.1 \n get_pos3 -> 5.89\n");
