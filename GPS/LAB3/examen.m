clear;clc;
sp = read_sp3('igs13221.SP3');
nsats = length(sp.prn);
tows = length(sp.tow);
delta = sp.delta;
xyz = zeros(3, tows);
tiempos = 7200:900:79200; % cada 10 min
nsats_visibles = zeros(1,length(tiempos));
pos = [4850000; -310000; 4120000];
pos_ecuador = [4850000; 0; 0];
for k=1:length(tiempos)
    xyz_aux = get_data_sats(sp,tiempos(k),sp.prn);
    [a, b] = elaz(xyz_aux, pos);
    sat_visibles = a>0;
    nsat_visibles = length(a(sat_visibles));
end
min_sats_visibles = min(nsats_visiblesibles);
max_sats_visisbles = max(nsats_visiblesibles);
plot(tiempos, nsats_visibles, tiempos, min_sats_visibles, tiempos, max_sats_visisbles);
