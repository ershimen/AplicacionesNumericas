function [XYZ_sat, cdT, Vxyz, D]=get_data_sats(sp,t,prn)
    nsat = length(prn);
    XYZ_sat=zeros(3,nsat);
    cdT=zeros(nsat,1);
    Vxyz=zeros(3,nsat);
    D=zeros(1,nsat);
    % Si t es común, lo replicamos para todos los sats
    if length(t)==1 
        t = t*ones(1,nsat);
    end
    if length(t) == nsat
        for i = 1:nsat
            [XYZ_sat(:,i), cdT(i,1), Vxyz(:,i), D(1,i)] = interp_sat(sp,t(i),prn(i));
        end
    end
return
        