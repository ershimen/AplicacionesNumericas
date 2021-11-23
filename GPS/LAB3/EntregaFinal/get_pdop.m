function [pdop,Q]=get_pdop(sp,t,sats,pos)
    [XYZ_sats]=get_data_sats(sp,t,sats);
    [H]=get_HR(XYZ_sats,pos);
    Q=inv(H'*H);
    sigma_x=sqrt(Q(1,1));
    sigma_y=sqrt(Q(2,2));
    sigma_z=sqrt(Q(3,3));
    pdop=sqrt(sigma_x^2 + sigma_y^2 + sigma_z^2);
return
