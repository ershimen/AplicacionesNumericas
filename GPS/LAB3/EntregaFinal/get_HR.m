function [H,R]=get_HR(XYZ,pos)
nsat=length(XYZ(1,:));
H=zeros(nsat,4);
H(:,4)=-1;
R=sqrt(((XYZ(1,:)-pos(1)).^2)+((XYZ(2,:)-pos(2)).^2)+((XYZ(3,:)-pos(3)).^2));
R=R';
for i=1:nsat
    for k=1:3
       H(i,k)= (XYZ(k,i)-pos(k,1))/R(i);
    end
end
return