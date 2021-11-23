clear;clc;
segundosLunes = 9*3600 + 20 *60;
tSemana = segundosLunes + 24 *3600;
sp = read_sp3('IGS12651.SP3');
t = sp.tow(39);
prev = 38;
rg = prev+(-3:4);
% comprobar el indice del satelite que tiene PRN=25
% sp.prn();
x = sp.XYZT(1,rg,22);
%fprintf('%.4f ',x);
%fprintf('\n');
dX = get_difs(x);
%fprintf('%.4f ',dX);
%fprintf('\n');

% El tiempo es t = 120000
% El tiempo en el nodo 38 es 119700
% El tiempo en el nodo 39 es 120600
% La fraccion f es 300/900
f = 300/900;
C = get_coefs(6/9);
%fprintf('%.4f ',C);
%fprintf('\n');
x_interpolado = dX * C;
%fprintf('%.4f ',x_interpolado);
%fprintf('\n');
[XYZ, cdT] = interp_sat(sp,120000,25);
fprintf('XYZ= [%.2f %.2f %.2f] cdT = %.2f\n',XYZ,cdT);
