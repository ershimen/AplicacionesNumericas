clear;clc;
sp = read_sp3('IGS12651.SP3');
[XYZ, cdT, Vxyz, D]=interp_sat(sp,120000,25);