clc
clear

load obs;
estacion=yebe;
observaciones=estacion.obs;
tiempos=estacion.tow;
prn=estacion.prn;
sp=read_sp3('IGS13230.sp3');
im=imread('yebes.jpg');
image(im);
hold on
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
% plot(1:NT,cdt_us);
XYZ=S(1:3,:);
llh=xyz2llh(XYZ);
media_lat=mean(llh(1,:));
media_long=mean(llh(2,:));
media_alt=mean(llh(3,:));
%fprintf('lat = %1.5f long = %1.5f alt = %1.1f',media_lat,media_long,media_alt);

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
% figure
% plot(dH);
% figure
% plot(dE,dN);
media_dH=mean(abs(dH));
media_dE=mean(abs(dE));
media_dN=mean(abs(dN));
maximo_dH=max(abs(dH));
maximo_dE=max(abs(dE));
maximo_dN=max(abs(dN));
r=sqrt(dE.^2+dN.^2);
media_r=mean(abs(r));
maximo_r=max(abs(r));
n_valores=length(find(r<12.91));
CEP=(n_valores/length(r))*100;
% histogram(r);
E0=492000;
N0=4487000;
px=abs((utm(1,:)-E0)/2);
py=abs((utm(2,:)-N0)/2);
plot(px,py,'r.');


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
cdt=S(4,:);
c=physconst('LightSpeed');
cdt_us=(cdt/c)*(10^6);
% plot(1:NT,cdt_us);
XYZ=S(1:3,:);
llh=xyz2llh(XYZ);
media_lat=mean(llh(1,:));
media_long=mean(llh(2,:));
media_alt=mean(llh(3,:));
%fprintf('lat = %1.5f long = %1.5f alt = %1.1f',media_lat,media_long,media_alt);

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
% figure
% plot(dH);
% figure
% plot(dE,dN);
media_dH=mean(abs(dH));
media_dE=mean(abs(dE));
media_dN=mean(abs(dN));
maximo_dH=max(abs(dH));
maximo_dE=max(abs(dE));
maximo_dN=max(abs(dN));
r=sqrt(dE.^2+dN.^2);
media_r=mean(abs(r));
maximo_r=max(abs(r));
n_valores=length(find(r<12.91));
CEP=(n_valores/length(r))*100;
% histogram(r);
E0=492000;
N0=4487000;
px=abs((utm(1,:)-E0)/2);
py=abs((utm(2,:)-N0)/2);
plot(px,py,'b.');
legend({'Sin mejoras','Con las 2 mejoras'});
hold off


