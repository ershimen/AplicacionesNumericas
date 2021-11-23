clc
clear

% Apartado A
%{
N=1000;
r=20;
[A,sd]=matrizA(N,r);
sd
N-sd
%}

% Apartado B
%{
N = 10^3;
r=20;
niter=1000;
[ordenpagerank,tiempo,precision, niter2] = CalculoPageRank(N,r,niter);
N
tiempo
precision
niter2
%}

% Apartado C
%%{

fun = @(x,xdata)x(1)*exp(x(2)*xdata);
%}
