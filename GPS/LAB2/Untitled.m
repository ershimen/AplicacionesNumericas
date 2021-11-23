clear;clc;
sp = read_sp3('IGS13230.SP3');
PRNs = [1 2 5 6 14];
t1=10000;
t2=10010;
t3=20000;
[XYZ_sat1, cdT1]= get_data_sats(sp, t1, PRNs);
[XYZ_sat2, cdT2]= get_data_sats(sp, t2, PRNs);
[XYZ_sat3, cdT3]= get_data_sats(sp, t3, PRNs);
fprintf('%12.2f ',XYZ_sat1(1,:)); fprintf('\n');
fprintf('%12.2f ',XYZ_sat1(2,:)); fprintf('\n');
fprintf('%12.2f ',XYZ_sat1(3,:)); fprintf('\n');
fprintf('%12.2f ',cdT1); fprintf('\n');
distancia = distancia(XYZ_sat1(:,1),XYZ_sat2(:,1));
dif_err_reloj = abs(cdT2(1)-cdT1(1));
fprintf('Distancia: %6.4f\nErr_reloj: %6.4f\n', distancia, dif_err_reloj);

pos = [4850000; -310000; 4120000];

[H, R] = get_HR(XYZ_sat3, pos);
fprintf('%9.5f %9.5f %9.5f %6.2f      %12.3f\n',[H R]');
