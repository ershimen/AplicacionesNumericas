function [H,R]=get_HR(XYZ,pos)
nsat = length(XYZ(1,:));
H = zeros(nsat,4);
R = zeros(nsat,1);
% Calcular distancias a los satélites y los valores de H.
for k = 1:nsat
    R(k) = distancia(pos, XYZ(:,k));
    H(k,:) = [(XYZ(1,k)-pos(1))/R(k) (XYZ(2,k)-pos(2))/R(k) (XYZ(3,k)-pos(3))/R(k) -1];
end
return