%%MUESTRAS TOMADAS DE PHYSIONET https://physionet.org/content/eegmmidb/1.0.0
%%Realizamos descomposicion de Wavalet Tree para tomar muestras
%%comprendidas entre 0-30 HZ
%cargamos ejemplo de toma de datos
dir='C:\Users\alvaro\Desktop\UNIVERSIDAD\TFG\MuestrasPhysionet\files\';
c='\';
d='.edf';
for sujetos=1:109

for sesion=3:14

    if sujetos<10
        a='S00';
    elseif (9<sujetos)&&(sujetos<100)
        a='S0';
    else
        a='S';
    end
    if sesion<10
        b='R0';
    else
        b='R';
    end
suj=string(sujetos);
ses = string(sesion);
filename= strcat(dir,a,suj,c,a,suj,b,ses,d);
load('Alfa.mat');
[data, anotaciones]=edfread(filename);

%Extraemos los canales que nos interesan.
CanalCz= data.Cpz_{1,1};
CanalCz=transpose(CanalCz);
CanalC3=data.Cp3_{1,1};
CanalC3=transpose(CanalC3);
CanalC4=data.Cp4_{1,1};
CanalC4=transpose(CanalC4);
long= length(data.Cpz_);
for x=2:long
auxC3= data.Cp3_{x,1};
auxCz= data.Cpz_{x,1};
auxC4= data.Cp4_{x,1};
auxC3= transpose(auxC3);
auxCz= transpose(auxCz);
auxC4= transpose(auxC4);
CanalC4= [CanalC4 auxC4];
CanalC3= [CanalC3 auxC3];
CanalCz= [CanalCz auxCz];
eventostime= anotaciones.Onset;
eventoslabel= anotaciones.Annotations;
end
%analizamos los 30 eventos observando 4 segundos de cada evento

%%Evento1
for x=1:30
event=seconds(eventostime(x));
tipoevento=eventoslabel(x);
c3aux= CanalC3(1,160*event+1:160*(event+4));
c4aux= CanalC4(1,160*event+1:160*(event+4));
czaux= CanalCz(1,160*event+1:160*(event+4));

%ritmoalfa
c3alfa= filter(Alfa,c3aux);
c4alfa= filter(Alfa,c4aux);
czalfa= filter(Alfa,czaux);
%realizamos wavalet para bajar el numero de muestras para la extracion de
%caracteristicas
[cc3 ,lc3]= wavedec(c3alfa,1,'db2');
[ccz ,lcz]= wavedec(czalfa,1,'db2');
[cc4 ,lc4]= wavedec(c4alfa,1,'db2');
C3alfa = appcoef(cc3,lc3,'db2'); 
Czalfa = appcoef(ccz,lcz,'db2'); 
C4alfa = appcoef(cc4,lc4,'db2'); 
[C3welchalfa,f] = pwelch(C3alfa);
[Czwelchalfa,f] = pwelch(Czalfa);
[C4welchalfa,f] = pwelch(C4alfa);
f=(f/(2*pi))*80;
%figure(102);
%plot(f,C3welch,f,C4welch,f,Czwelch);
%Transformada de Fourier
C3=abs(fft(C3alfa));
Cz=abs(fft(Czalfa));
C4=abs(fft(C4alfa));
C3alfa=C3alfa(32:49);
Czalfa=Czalfa(32:49);
C4alfa=C4alfa(32:49);
n=length(C3alfa);
n=(0:n-1)/(n-1)*30;
%realizamos extracion de caracteristicas
%figure(x);
%plot(n,C3,n,C4);
title('FTF signal C3 y C4 evento',tipoevento);
xlabel('Frecuencia[Hz]');
ylabel('DPS C3 y C4');
C3VARa=var(C3alfa);
CzVARa=var(Czalfa);
C4VARa=var(C4alfa);
C3COVARa=cov(C3alfa);
CzCOVARa=cov(Czalfa);
C4COVARa=cov(C4alfa);
C3MEANa=cov(C3alfa);
CzMEANa=cov(Czalfa);
C4MEANa=cov(C4alfa);
C3STDa=std(C3alfa);
CzSTDa=std(Czalfa);
C4STDa=std(C4alfa);
C3MAXPSDa=max(C3welchalfa);
CzMAXPSDa=max(Czwelchalfa);
C4MAXPSDa=max(C4welchalfa);

%ritmo Theta
c3theta= filter(Theta,c3aux);
c4theta= filter(Theta,c4aux);
cztheta= filter(Theta,czaux);
%realizamos wavalet para bajar el numero de muestras para la extracion de
%caracteristicas
[cc3 ,lc3]= wavedec(c3theta,1,'db2');
[ccz ,lcz]= wavedec(cztheta,1,'db2');
[cc4 ,lc4]= wavedec(c4theta,1,'db2');
C3theta = appcoef(cc3,lc3,'db2'); 
Cztheta = appcoef(ccz,lcz,'db2'); 
C4theta = appcoef(cc4,lc4,'db2'); 
[C3welchtheta,f] = pwelch(C3theta);
[Czwelchtheta,f] = pwelch(Cztheta);
[C4welchtheta,f] = pwelch(C4theta);
f=(f/(2*pi))*80;
%figure(102);
%plot(f,C3welch,f,C4welch,f,Czwelch);
%Transformada de Fourier
C3theta=abs(fft(C3theta));
Cztheta=abs(fft(Cztheta));
C4theta=abs(fft(C4theta));
C3theta=C3theta(32:49);
Cztheta=Cztheta(32:49);
C4theta=C4theta(32:49);
n=length(C3theta);
n=(0:n-1)/(n-1)*30;
%realizamos extracion de caracteristicas
%figure(x);
%plot(n,C3,n,C4);
title('FTF signal C3 y C4 evento',tipoevento);
xlabel('Frecuencia[Hz]');
ylabel('DPS C3 y C4');
C3VARt=var(C3theta);
CzVARt=var(Cztheta);
C4VARt=var(C4theta);
C3COVARt=cov(C3theta);
CzCOVARt=cov(Cztheta);
C4COVARt=cov(C4theta);
C3MEANt=cov(C3theta);
CzMEANt=cov(Cztheta);
C4MEANt=cov(C4theta);
C3STDt=std(C3theta);
CzSTDt=std(Cztheta);
C4STDt=std(C4theta);
C3MAXPSDt=max(C3welchtheta);
CzMAXPSDt=max(Czwelchtheta);
C4MAXPSDt=max(C4welchtheta);

%ritmo delta
c3delta= filter(Delta,c3aux);
c4delta= filter(Delta,c4aux);
czdelta= filter(Delta,czaux);
%realizamos wavalet para bajar el numero de muestras para la extracion de
%caracteristicas
[cc3 ,lc3]= wavedec(c3delta,1,'db2');
[ccz ,lcz]= wavedec(czdelta,1,'db2');
[cc4 ,lc4]= wavedec(c4delta,1,'db2');
C3delta = appcoef(cc3,lc3,'db2'); 
Czdelta = appcoef(ccz,lcz,'db2'); 
C4delta = appcoef(cc4,lc4,'db2'); 
[C3welchdelta,f] = pwelch(C3delta);
[Czwelchdelta,f] = pwelch(Czdelta);
[C4welchdelta,f] = pwelch(C4delta);
f=(f/(2*pi))*80;
%figure(102);
%plot(f,C3welch,f,C4welch,f,Czwelch);
%Transformada de Fourier
C3delta=abs(fft(C3delta));
Czdelta=abs(fft(Czdelta));
C4delta=abs(fft(C4delta));
C3delta=C3delta(32:49);
Czdelta=Czdelta(32:49);
C4delta=C4delta(32:49);
n=length(C3delta);
n=(0:n-1)/(n-1)*30;
%realizamos extracion de caracteristicas
%figure(x);
%plot(n,C3,n,C4);
title('FTF signal C3 y C4 evento',tipoevento);
xlabel('Frecuencia[Hz]');
ylabel('DPS C3 y C4');
C3VARd=var(C3delta);
CzVARd=var(Czdelta);
C4VARd=var(C4delta);
C3COVARd=cov(C3delta);
CzCOVARd=cov(Czdelta);
C4COVARd=cov(C4delta);
C3MEANd=cov(C3delta);
CzMEANd=cov(Czdelta);
C4MEANd=cov(C4delta);
C3STDd=std(C3delta);
CzSTDd=std(Czdelta);
C4STDd=std(C4delta);
C3MAXPSDd=max(C3welchdelta);
CzMAXPSDd=max(Czwelchdelta);
C4MAXPSDd=max(C4welchdelta);

%ritmo beta
c3aux= filter(Alfa,c3aux);
c4aux= filter(Alfa,c4aux);
czaux= filter(Alfa,czaux);
%realizamos wavalet para bajar el numero de muestras para la extracion de
%caracteristicas
[cc3 ,lc3]= wavedec(c3aux,1,'db2');
[ccz ,lcz]= wavedec(czaux,1,'db2');
[cc4 ,lc4]= wavedec(c4aux,1,'db2');
C3 = appcoef(cc3,lc3,'db2'); 
Cz = appcoef(ccz,lcz,'db2'); 
C4 = appcoef(cc4,lc4,'db2'); 
[C3welch,f] = pwelch(C3);
[Czwelch,f] = pwelch(Cz);
[C4welch,f] = pwelch(C4);
f=(f/(2*pi))*80;
%figure(102);
%plot(f,C3welch,f,C4welch,f,Czwelch);
%Transformada de Fourier
C3=abs(fft(C3));
Cz=abs(fft(Cz));
C4=abs(fft(C4));
C3=C3(32:49);
Cz=Cz(32:49);
C4=C4(32:49);
n=length(C3);
n=(0:n-1)/(n-1)*30;
%realizamos extracion de caracteristicas
%figure(x);
%plot(n,C3,n,C4);
title('FTF signal C3 y C4 evento',tipoevento);
xlabel('Frecuencia[Hz]');
ylabel('DPS C3 y C4');
C3VAR=var(C3);
CzVAR=var(Cz);
C4VAR=var(C4);
C3COVAR=cov(C3);
CzCOVAR=cov(Cz);
C4COVAR=cov(C4);
C3MEAN=cov(C3);
CzMEAN=cov(Cz);
C4MEAN=cov(C4);
C3STD=std(C3);
CzSTD=std(Cz);
C4STD=std(C4);
C3MAXPSD=max(C3welch);
CzMAXPSD=max(Czwelch);
C4MAXPSD=max(C4welch);

if tipoevento == "T2"
    if (sesion==3)||(sesion==4)||(sesion==7)||(sesion==8)||(sesion==11)||(sesion==12)
     ETIQUETA=1;
    else
     ETIQUETA=4;
    end
elseif tipoevento == "T0"
    ETIQUETA =0;
else 
    if (sesion==3)||(sesion==4)||(sesion==7)||(sesion==8)||(sesion==11)||(sesion==12)
     ETIQUETA=2;
    else
     ETIQUETA=3;
    end
end
 
 DAT = [ C3VAR,C3COVAR,C3MEAN,C3MAXPSD,C3STD,CzVAR,CzCOVAR,CzMEAN,CzMAXPSD,CzSTD,C4VAR,C4COVAR,C4MEAN,C4MAXPSD,C4STD,ETIQUETA];
 if x>1
    DATOS =[DATOS;DAT];
 else
    DATOS= DAT;
 end
end
 if sesion>3
    SUJETO =[SUJETO;DATOS];
 else
    SUJETO= DATOS;
 end
end
 if sujetos>1
    BaseDatos =[BaseDatos;SUJETO];
 else
    BaseDatos= SUJETO;
 end
end