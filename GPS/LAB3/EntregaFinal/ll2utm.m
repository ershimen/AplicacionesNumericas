function [utm,zona]=ll2utm(ll)
% Recibe una tira de [long; lat ] y las convierte a UTM
% usando el elipsoide de proyeccion definido por ellip [da df*10^4]. 
% Por defecto usamos elipsoide Hayford internacional (del Datum Europeo)
% La zona la devuelve como un array de strings Nx3. 
% La conversion de un tipo a otro es inmediata como char() o cellstr()


% Ellipsoide con datos absolutos
%if nargin==1, ellip=[6378388 297]'; end
% a=ellip(1); f=1/ellip(2);


% Ellipsoide con diferencias
if nargin==1, ellip=[0 0]; end %ellip=[-251.0 -0.14192702]'; end
%if nargin==1, ellip=[-251.0 -0.14192702]'; end
a_WGS84=6378137;
f_WGS84=1/298.257223563;
da=ellip(1); df=ellip(2);
a = a_WGS84 - da;
f = f_WGS84 - df*1e-4;


e=f*(2-f);
ep=e/(1-e);


k0=0.9996;

lat=ll(2,:);
lon=ll(1,:);
ndatos=size(ll,2);

%%%%%%%%%%%%%%%%%
franjas=[-80 -72:8:72 84];
letras=[ 'Z' char(67:72) char(74:78) char(80:88) 'Z']; 

zn=floor((lon+180)/6)+1; zletter=zeros(1,ndatos);
for k=1:ndatos
   zletter(k)=letras(1+sum(lat(k)>=franjas)); 
end   

%%%%%%%%%%%%%%%%%

c1=sprintf('%02d',zn); c1=reshape(c1,2,ndatos)';
c2=sprintf('%c',zletter); %c2=reshape(c2,ndatos,1)',
zona=[c1 c2'];

%zona=cellstr(zona)';


LatR=lat*pi/180;
LonR=lon*pi/180;



LonOrg=(zn-1)*6 -180 +3; LorgR=LonOrg*pi/180;


co=cos(LatR);
co2=co.*co;
si2=1-co2;



N=a./sqrt(1-e*si2);
T=si2./co2;
C=ep*co2;
A=co.*(LonR-LorgR);




E=e/8; E2=E*E; E3=E2*E;
T1=(1-2*E-3*E2-10*E3)*LatR; 
T2=(3*E+6*E2+45*E3/2)*sin(2*LatR);
T3=(15*E2/4+45*E3/2) *sin(4*LatR); 
T4=(35*E3/6)*sin(6*LatR);


M=a*( T1 - T2 + T3 + T4);
%fprintf('%8.0f ',a*T1,a*T2,a*T3,a*T4);fprintf('\n');


A2=A.*A;   
A4=A2.*A2;  
A2=A2/6;
A4=A4/120;

T1=1;
T2=(1-T+C).*A2;
T3=(5-18*T+T.*T+72*C-58*ep).*A4;
F=k0*N.*A;
UTMe=500000+ F.*(T1 + T2 + T3);
%fprintf('%8.0f ',500000,F*T1,F*T2,F*T3);fprintf('\n');


F=N.*tan(LatR).*A2;
T1=3;
T2=3*(5-T + 9*C + 4*C.*C).*A2/2;
T3=(61-58*T+T.*T+600*C-330*ep).*A4;
UTMn= k0 * (M + F.*(T1 + T2 + T3));
%fprintf('%8.0f ',M,F*T1,F*T2,F*T3);fprintf('\n');


%utm=zeros(2,ndatos);
utm=[UTMe;UTMn];


%fprintf('E %7.0f  N %8.0f\n',utm);