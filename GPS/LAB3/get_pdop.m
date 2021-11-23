function pdop=get_pdop(sp,t,sats,pos)
XYZ_sat= get_data_sats(sp, t, sats);
H = get_HR(XYZ_sat, pos);
Q = inv(H'*H);
%fprintf('%.3f %.3f %.3f\n', Q(1,1), Q(1,2), Q(1,3));
%fprintf('%.3f %.3f %.3f\n', Q(2,1), Q(2,2), Q(2,3));
%fprintf('%.3f %.3f %.3f\n', Q(3,1), Q(3,2), Q(3,3));
s1 = sqrt(Q(1,1));
s2 = sqrt(Q(2,2));
s3 = sqrt(Q(3,3));
pdop = sqrt(s1^2+s2^2+s3^2);
return