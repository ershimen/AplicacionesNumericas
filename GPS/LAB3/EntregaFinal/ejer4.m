clc
clear

load obs;
sp=read_sp3('IGS13230.sp3');
% Estación yebe
estacion_yebe=yebe;
observaciones_yebe=estacion_yebe.obs;
tiempos_yebe=estacion_yebe.tow;
prn_yebe=estacion_yebe.prn;
NT_yebe=900;
X_yebe=[4850000; -310000; 4120000; 0.00];
RES_yebe=zeros(32,NT_yebe);
for k=1:NT_yebe
    Tr_yebe=tiempos_yebe(k);
    % Obtenemos las medidas y prns válidos
    medidas_yebe=observaciones_yebe(:,k);
    ok_yebe=find(medidas_yebe~=-1);
    obs_yebe=medidas_yebe(ok_yebe);
    prns_yebe=prn_yebe(ok_yebe);
    [X_yebe,res_yebe]=get_pos3_res(sp,Tr_yebe,prns_yebe,obs_yebe,X_yebe);
    % Guardamos el residuo
    RES_yebe(prns_yebe,k)=res_yebe;
end
figure
hold on
for i=prn_yebe
    plot(1:NT_yebe,RES_yebe(i,:));
end
hold off

% Estacion mer1
estacion_mer1=mer1;
observaciones_mer1=estacion_mer1.obs;
tiempos_mer1=estacion_mer1.tow;
prn_mer1=estacion_mer1.prn;
NT_mer1=120;
X_mer1=[4850000; -310000; 4120000; 0.00];
RES_mer1=zeros(32,NT_mer1);
for k=1:NT_mer1
    Tr_mer1=tiempos_mer1(k);
    % Obtenemos las medidas y prns válidos
    medidas_mer1=observaciones_mer1(:,k);
    ok_mer1=find(medidas_mer1~=-1);
    obs_mer1=medidas_mer1(ok_mer1);
    prns_mer1=prn_mer1(ok_mer1);
    [X_mer1,res_mer1]=get_pos3_res(sp,Tr_mer1,prns_mer1,obs_mer1,X_mer1);
    % Guardamos el residuo
    RES_mer1(prns_mer1,k)=res_mer1;
end
figure
hold on
for i=prn_mer1
    plot(1:NT_mer1,RES_mer1(i,:));
end
hold off

% Estacion mer2
estacion_mer2=mer2;
observaciones_mer2=estacion_mer2.obs;
tiempos_mer2=estacion_mer2.tow;
prn_mer2=estacion_mer2.prn;
NT_mer2=120;
X_mer2=[4850000; -310000; 4120000; 0.00];
RES_mer2=zeros(32,NT_mer2);
for k=1:NT_mer2
    Tr_mer2=tiempos_mer2(k);
    % Obtenemos las medidas y prns válidos
    medidas_mer2=observaciones_mer2(:,k);
    ok_mer2=find(medidas_mer2~=-1);
    obs_mer2=medidas_mer2(ok_mer2);
    prns_mer2=prn_mer2(ok_mer2);
    [X_mer2,res_mer2]=get_pos3_res(sp,Tr_mer2,prns_mer2,obs_mer2,X_mer2);
    % Guardamos el residuo
    RES_mer2(prns_mer2,k)=res_mer2;
end
figure
hold on
for i=prn_mer2
    plot(1:NT_mer2,RES_mer2(i,:));
end
hold off