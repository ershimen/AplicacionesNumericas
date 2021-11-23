function llh=xyz2llh(xyz)
% XYZ  a Lat, Long, H para el elipsoide de proyeccion cuyos 
% datos se dan en el segundo argumento ellip (da,d(1/f)). 
% Por defecto Internacional Hayford, correspondiente a European 1950

% Datos absolutos
%if nargin==1, ellip=[6378388  297.0]; end
%a=ellip(1); f=1.0/ellip(2);


% Ellipsoide con diferencias
a_WGS84=6378137;
f_WGS84=1/298.257223563;
if nargin==1, ellip=[0 0]'; end %ellip=[-251.0 -0.14192702]'; end
a = a_WGS84 - ellip(1);
f = f_WGS84 - ellip(2)*1e-4;



e2=f*(2-f);
b=(1-f)*a;
e2p=e2/(1-f).^2;


X=xyz(1,:);
Y=xyz(2,:);
Z=xyz(3,:);


p=sqrt(X.^2+Y.^2);
theta=atan((Z*a)./(p*b));

s3=sin(theta).^3;
c3=cos(theta).^3;
lat =atan((Z+e2p*b*s3)./(p-e2*a*c3));
long=atan2(Y,X);
N=a./sqrt(1-e2.*sin(lat).^2);

h=p./cos(lat) -N;

lat=lat*180/pi;long=long*180/pi;
llh=[long; lat; h];




