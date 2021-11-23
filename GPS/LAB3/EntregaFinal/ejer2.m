clc
clear

sp=read_sp3('IGS13230.sp3');
p_obs=[4850000; -310000; 4120000];
t=6000;
skyplot(sp,t,p_obs);
sats=[01 02 05 06 14 16 21 25 30];
[pdop,Q]=get_pdop(sp,t,sats,p_obs);
Q
fprintf('PDop = %1.3f\n\n',pdop);
% Satélites visibles tapando el sur
sats_1=[02 05 6 21 30];
[pdop1,Q1]=get_pdop(sp,t,sats_1,p_obs);
fprintf('PDop1 = %1.3f\n\n',pdop1);
% Satélites visibles tapando el norte
sats_2=[01 14 16 25];
[pdop2,Q2]=get_pdop(sp,t,sats_2,p_obs);
fprintf('PDop2 = %1.3f\n\n',pdop2);
%para 4 satelites
lista4=nchoosek(sats,4);
for k=1:length(lista4(:,1))
    pdop1(k)=get_pdop(sp,t,lista4(k,:),p_obs);
end
max_er_4=max(pdop1)
indice=find(pdop1==max_er_4);
peor_sats_4=lista4(indice,:)
%para 5 satelites
lista5=nchoosek(sats,5);
for k=1:length(lista5(:,1))
    pdop2(k)=get_pdop(sp,t,lista5(k,:),p_obs);
end
max_er_5=max(pdop2)
indice=find(pdop2==max_er_5);
peor_sats_5=lista5(indice,:)

lista6=nchoosek(sats,6);
for k=1:length(lista6(:,1))
    pdop3(k)=get_pdop(sp,t,lista6(k,:),p_obs);
end
max_er_6=max(pdop3)
indice2=find(pdop3==max_er_6);
peor_sats_6=lista6(indice2,:)