function skyplot(sp,t,p_obs) 
    prns=sp.prn; 
    [XYZ_sats]=get_data_sats(sp,t,prns); 
    [el,az]=elaz(XYZ_sats,p_obs); 
    Satelites_visibles=find(el>0); 
    prns_buenos=prns(Satelites_visibles); 
    az_bueno=az(Satelites_visibles); 
    el_bueno=el(Satelites_visibles); 
    x=cosd(el_bueno).*cosd(az_bueno); 
    y=cosd(el_bueno).*sind(az_bueno); 
    th=linspace(0,2*pi,200); 
    for r=[1 0.77 0.5 0.17] 
        plot(r*cos(th),r*sin(th)','r:','LineWidth',1); 
        hold on 
    end 
    text([1 0.77 0.5 0.17],[0 0 0 0],{'0º','40º','60º','80º'},'Color','r','FontSize',12); 
    for k=1:length(prns_buenos) 
        str=num2str(prns_buenos(k)); 
        text(x(k),y(k),str); 
    end 
    hold off
    set(gca,'Xlim',[-1 1],'Ylim',[-1 1]);
    axis equal; 
    axis off;
return
