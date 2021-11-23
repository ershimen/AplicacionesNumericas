function sp3=read_sp3(fich)

% Lee datos de un fichero SP3 (incluye tipo c) 
% Antonio Tabernero, 2015

c = 299792458;  %   Speed of light

sp3=struct('nsat',NaN,'prn',NaN,'tow',NaN,'XYZT',NaN,'week',NaN,'delta',900,'fecha',[]);
%sp3=struct('nsat',NaN,'prn',NaN,'tow',NaN,'week',NaN,'delta',900,'date',[]);

fid = fopen(fich);
if fid==-1, msgbox(sprintf('Couldn''t open SP3 file %s',fich)); return; end

% 1ª linea
line=fgetl(fid); data=sscanf(line(4:end),'%f')';
fecha = sprintf('%d/%d/%d @ %02.0fh%02.0fm%09.6fs',data([3 2 1 4 5 6]));
sp3.fecha=fecha;
NE = data(7);

% 2ª linea
line=fgetl(fid); data=sscanf(line(3:end),'%f');
sp3.week=data(1); sp3.tow=data(2);  sp3.delta=data(3);

prn=[];
% Lineas 3-7 (sats)
for k=1:5,
  line=fgetl(fid); idx=10; 
  for j=1:17, 
    t = line(idx); sv = str2num(line(idx+(1:2)));
    if sv==0, break; end
    if (t=='G' || t==' '), prn=[prn sv]; end  
    idx=idx+3;
  end
end

sp3.nsat=length(prn); 
sp3.prn=prn;

sp3.tow=zeros(1,NE);
sp3.XYZT=zeros(4,NE,sp3.nsat);
%sp3.cdT=zeros(NE,sp3.nsat);

while (strcmp(line(1),'*')==0),  line=fgetl(fid);  end


k=0;
while(line~=-1),
   
 switch line(1),
  case '*',   % Date
    k=k+1; 
    data=sscanf(line(3:end),'%f');  %[sp3.tow(k) w]=civil2gps(data); 
    
    [second w]=civil2gps(data(1:5)');
     sp3.tow(k)=round(second)+data(6);

  case 'P',
    tipo = line(2);  
    data=sscanf(line(3:end),'%f');
    
    if (tipo=='G' || tipo==' '),  % GPS sat    
      sv=data(1);
      index=find(prn==sv);
      sp3.XYZT(1:3,k,index)=data(2:4)*1000;
      if data(5)>900000, data(5)=NaN; end
      data(5)=(data(5)/1e6)*c; 
      sp3.XYZT(4,k,index)=data(5);
      %sp3.cdT(k,index)=data(5);
    end
    
  case 'V',  
      
  case 'E',
         
  end   
  line=fgetl(fid); 
end


fclose(fid);

%sp3.cdT=sp3.cdT';
%sp3.XYZ=permute(sp3.XYZ,[1 3 2]);

return

function [tow,week]=civil2gps(civil)

N=length(civil);
civil = [civil zeros(1,6-N)];

y=civil(1);
m=civil(2);
d=civil(3);
h=civil(4);
min=civil(5);
sec=civil(6);

% From civil date to Julian Day
% From Hoffman-Wellenhof. Valid until 2100.

if m <= 2, y = y-1; m = m+12; end
jd = floor(365.25*y)+floor(30.6001*(m+1))+d+1720981.5;
jd =jd + (h + min/60 + sec/3600 )/24.0;


% From Julian Day to GPS time (Hoffman-Wellenhof)

days_gps=(jd-2444244.5);
week = floor(days_gps/7);
tow = (days_gps-week*7)*86400;
%%%%%%% end gps_time.m	%%%%%%%%%%%%%


