function [XYZ_sat, cdT, Vxyz]=get_data_sats(sp,t,prn)
nsat = length(prn);
XYZ_sat=zeros(3,nsat);
cdT=zeros(nsat,1);
Vxyz=zeros(3,nsat);
if length(t)==1, t = t*ones(1,nsat); end % Si t comun, replicarlo
for k = 1:nsat
    [XYZ_sat(:,k), cdT(k), Vxyz(:,k)] = interp_sat(sp,t(k),prn(k));
end
return
