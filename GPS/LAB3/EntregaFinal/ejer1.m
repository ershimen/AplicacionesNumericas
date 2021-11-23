clc
clear

load obs;
sp=read_sp3('IGS13230.sp3');
estacion=yebe;
observaciones=estacion.obs;
tiempos=estacion.tow;
prn=estacion.prn;
NT=900;
S=zeros(4,NT);
X=[4850000; -310000; 4120000; 0.00];
for k=1:NT
    Tr=tiempos(k);
    medidas=observaciones(:,k);
    ok=find(medidas~=-1);
    obs=medidas(ok);
    prns=prn(ok);
    X=get_pos(sp,Tr,prns,obs,X);
    S(:,k)=X;
end
cdt=S(4,:);
c=physconst('LightSpeed');
cdt_us=(cdt/c)*(10^6);
figure
plot(1:NT,cdt_us);
legend('error de reloj del receptor en microsegundos');
XYZ=S(1:3,:);
llh=xyz2llh(XYZ);
media_lat=mean(llh(1,:));
media_long=mean(llh(2,:));
media_alt=mean(llh(3,:));
fprintf('lat = %1.5f\nlong = %1.5f\nalt = %1.1f\n\n',media_lat,media_long,media_alt);
XYZ_real=estacion.XYZ;
llh_real=xyz2llh(XYZ_real);
H=llh(3,:);
H_real=llh_real(3,:);
ll=(llh(1:2,:));
ll_real=(llh_real(1:2,:));
[utm,zona]=ll2utm(ll);
[utm_real,zona_real]=ll2utm(ll_real);
dH=H-H_real;
dE=utm(1,:)-utm_real(1,:);
dN=utm(2,:)-utm_real(2,:);
figure
plot(dH);
legend('error en Altura');
figure
plot(dE,dN,'b.');
xlabel('error en Este');
ylabel('error en Norte');
media_dH=mean(abs(dH));
media_dE=mean(abs(dE));
media_dN=mean(abs(dN));
maximo_dH=max(abs(dH));
maximo_dE=max(abs(dE));
maximo_dN=max(abs(dN));
fprintf('media_dH = %2.4f\nmedia_dE = %2.4f\nmedia_dN = %2.4f\n\n',media_dH,media_dE,media_dN);
fprintf('maximo_dH = %2.4f\nmaximo_dE = %2.4f\nmaximo_dN = %2.4f\n\n',maximo_dH,maximo_dE,maximo_dN);
r=sqrt(dE.^2+dN.^2);
media_r=mean(abs(r));
maximo_r=max(abs(r));
fprintf('media_r = %2.4f\nmaximo_r = %2.4f\n\n',media_r,maximo_r);
n_valores_50=length(find(r<5.88));
CEP_50=(n_valores_50/length(r))*100;
n_valores_95=length(find(r<12.91));
CEP_95=(n_valores_95/length(r))*100;
fprintf('CEP50 = 5.88\nCEP95 = 12.91\n\n');
figure
histogram(r);
xlabel('error en la horizontal');
ylabel('nº de casos');
E0=492000;
N0=4487000;
px=abs((utm(1,:)-E0)/2);
py=abs((utm(2,:)-N0)/2);
figure
im=imread('yebes.jpg');
image(im);
hold on
plot(px,py,'r.');
hold off
figure
image(im);
hold on
plot(px,py,'r.');

% Plot con la función get_pos
% Incluye tiempos de vuelo variables y corrección relativista

S=zeros(4,NT);
X=[4850000; -310000; 4120000; 0.00];
for k=1:NT
    Tr=tiempos(k);
    medidas=observaciones(:,k);
    ok=find(medidas~=-1);
    obs=medidas(ok);
    prns=prn(ok);
    X=get_pos2(sp,Tr,prns,obs,X);
    S(:,k)=X;
end
XYZ=S(1:3,:);
llh=xyz2llh(XYZ);
XYZ_real=estacion.XYZ;
llh_real=xyz2llh(XYZ_real);
H=llh(3,:);
H_real=llh_real(3,:);
ll=(llh(1:2,:));
ll_real=(llh_real(1:2,:));
[utm,zona]=ll2utm(ll);
[utm_real,zona_real]=ll2utm(ll_real);
dH=H-H_real;
dE=utm(1,:)-utm_real(1,:);
dN=utm(2,:)-utm_real(2,:);
r=sqrt(dE.^2+dN.^2);
px=abs((utm(1,:)-E0)/2);
py=abs((utm(2,:)-N0)/2);
plot(px,py,'b.');
legend({'sin mejoras','T.vuelo variables y corr.rel'});
hold off