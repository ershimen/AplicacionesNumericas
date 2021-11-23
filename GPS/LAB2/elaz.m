function [el,az]=elaz(XYZ_sat,xyz)
% Elevacion y azimuth (grados) a los satelites dadas:
%  XYZ_sat  = posiciones de los satélites (matriz 3 x N)
%  xyz  = posicion observador (vector 3x1)
%  el, az = elevacion y azimuth (vectores 1xN) en grados
%  USO: elev=elaz(XYZ_sat,xyz_obs);      % Solo elevación
%       [elev, az]=elaz(XYZ_sat,xyz_obs); % Elevación + azimuth

XYZ_sat=squeeze(XYZ_sat);

xyz=xyz'; XYZ_sat=XYZ_sat';

R=norm(xyz);
p=norm(xyz(1:2));


up=    xyz'/R;
east=  [-xyz(2) xyz(1) 0]'/p;
north= [-xyz(3)*xyz(1:2) p*p ]'/(p*R);
   
   
Nsat=size(XYZ_sat,1);      
d=XYZ_sat-ones(Nsat,1)*xyz;   
for k=1:Nsat, v=d(k,:); d(k,:)=v/norm(v); end

%fprintf('Up %f North %f East %f\n',d*up,d*north,d*east);

el=asin(d*up)'; el=180*el/pi;
az=atan2(d*east,d*north)'; az=az*180/pi;
return




   
   


