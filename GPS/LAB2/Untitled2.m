clear; clc;
sp = read_sp3('IGS13230.SP3');
tow = 2*3600;
obs=[4850000;-310000;4120000];
[XYZ_sat, cdT]= get_data_sats(sp, tow, sp.prn);
[a, b] = elaz(XYZ_sat, obs);
angulo_min = 10;
sat_visibles = a>angulo_min;
n_sat_visibles = length(a(sat_visibles));
sat_operativos = sp.prn(sat_visibles);
nsat_visibles = zeros(1,240);
tow1 = 7200;
for k = 1: 241
    [XYZ_sat1, cdT1]= get_data_sats(sp, tow1, sp.prn);
    [a1, b1] = elaz(XYZ_sat1, obs);
    sat_visibles = a1>10;
    nsat_visibles(k) = length(a1(sat_visibles));
    tow1 = tow1 + 300;
end
tiempo = 7200:300:79200;
plot(tiempo, nsat_visibles);