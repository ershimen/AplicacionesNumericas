clear;clc;
sp = read_sp3('IGS12651.SP3');
nsat = sp.nsat();
prn = sp.prn();
week = sp.week();
delta = sp.delta();
tow = sp.tow();
XYZT = sp.XYZT();

% Índices de datos con prn = 15 y prn = 23.
indice15 = find(prn==15);
indice23 = find(prn==23); % No existe uno con prn = 23.
indice21 = find(prn==21);
x15 = sp.XYZT(1, 1:96, indice15);
y15 = sp.XYZT(2, 1:96, indice15);
z15 = sp.XYZT(3, 1:96, indice15);

x21 = sp.XYZT(1, 1:96, indice21);
y21 = sp.XYZT(2, 1:96, indice21);
z21 = sp.XYZT(3, 1:96, indice21);

xyzt15 = [x15; y15; z15];

%xyzt15 = sp.XYZT(1:3, 1:4:24, indice15);
v = 1:96;

%plot(v, x15, v, y15, v, z15);

%plot3(x15, y15, z15, x21, y21, z21);
% Tiene el aspecto de las líneas blancas de una bola de tenis, es el
% esperado.


f = mod(tow, 900)/900;
T = sp.XYZT(4, 1:96, indice15);
plot(v, T);
% Tiene sentido el resultado dado, que a lo largo del día el satélite se
% alejaba de la Tierra.