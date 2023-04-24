%%MUESTRAS TOMADAS DE PHYSIONET https://physionet.org/content/eegmmidb/1.0.0
%%Realizamos descomposicion de Wavalet Tree para tener menos muestras a la
%%hora de la extraccion de caracteristicas

%cargamos ejemplo de toma de datos
for i=1:2
a='A02_';
b= string(i);
c='.mat';
filename= strcat(a,b,c);
load(filename);
load('Alfa.mat');

c3=canal(1,1152*i+1:1152*(i+1));
cz=canal(2,1152*i+1:1152*(i+1));
c4=canal(3,1152*i+1:1152*(i+1));
c3=filter(Alfa,c3);
c4=filter(Alfa,c4);
%%[S3,f,t]=stft(c3,128,'Window',kaiser(256,5),'Overlaplength',220,'FFTLength',1152);
[S3,f,t]=stft(c3,128);
figure(200);
mesh(t,f,abs(S3));
title('SFTF signal S3');
xlabel('Tiempo[S]');
ylabel('Frecuencia[Hz]');
zlabel('Magnitud');
[S4,f,t]=stft(c4,128);
figure(210);
mesh(t,f,abs(S4));
title('SFTF signal S4');
xlabel('Tiempo[S]');
ylabel('Frecuencia[Hz]');
zlabel('Magnitud');
%% analisis segundo a segundo
%for x=3:8 
%c3=canal(1,1152*i+1+128*x:1152*i+128*(x+1));
%c4=canal(3,1152*i+1+128*x:1152*i+128*(x+1));
%c3=filter(Alfa,c3);
%c4=filter(Alfa,c4);
%C3= abs(fft(c3));
%C3=C3.^2;
%C3=C3./128;
%figure(x);
%C4= abs(fft(c4));
%C4=C4.^2;
%C4=C4./128;
%plot(n,C3,n,C4);
%title('FTF signal C3 y C4');
%xlabel('Frecuencia[Hz]');
%ylabel('DPS C3 y C4');
%end

%% muestreamos desde t=3,5 a t= 5,5
for x=0:59
c3=canal(1,1152*x+449:1152*x+704);
cz=canal(2,1152*x+449:1152*x+704);
c4=canal(3,1152*x+449:1152*x+704);
c3=c3*100;
cz=cz*100;
c4=c4*100;
[c3welch, f]=pwelch(c3);
[czwelch, f]=pwelch(cz);
[c4welch, f]=pwelch(c4);
f=(f/(2*pi))*128;
%figure(100);
%plot(f,c3welch,f,c4welch,f,czwelch);

%Rito Alfa.
c3=filter(Alfa,c3);
cz=filter(Alfa,cz);
c4=filter(Alfa,c4);
[c3welch, f]=pwelch(c3);
[czwelch, f]=pwelch(cz);
[c4welch, f]=pwelch(c4);
f=(f/(2*pi))*128;
%figure(101);
%plot(f,c3welch,f,c4welch,f,czwelch);
%Realizamos Wavalet para redicir el numero de muestras en la extracion de
%caracteristicas
[cc3 ,lc3]= wavedec(c3,1,'db2');
[ccz ,lcz]= wavedec(cz,1,'db2');
[cc4 ,lc4]= wavedec(c4,1,'db2');
C3 = appcoef(cc3,lc3,'db2'); 
Cz = appcoef(ccz,lcz,'db2'); 
C4 = appcoef(cc4,lc4,'db2'); 
[C3welch,f] = pwelch(C3);
[Czwelch,f] = pwelch(Cz);
[C4welch,f] = pwelch(C4);
f=(f/(2*pi))*64;
%figure(102);
%plot(f,C3welch,f,C4welch,f,Czwelch);

%filtramos solo para ver las caracteristicas de los ritmos alfa y mu
%comprendidos entre 8-12 hz.
C3= abs(fft(C3));
C3=C3(1:65);
C4= abs(fft(C4));
C4=C4(1:65);
Cz= abs(fft(Cz));
Cz=Cz(1:65);
n = length(C3);
n=(0:n-1)/n*32;
figure(x+1);
%exportacion de caracteristicas.
plot(n,C3,n,C4,n,Cz);
title('FTF signal C3 y C4 evento',x+1);
xlabel('Frecuencia[Hz]');
ylabel('DPS C3 y C4');

%Cogemos los varoles que reprensentan entre 8 y 12 Hz;
C3=C3(12:25);
Cz=Cz(12:25);
C4=C4(12:25);
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
ETIQUETA = clase(x+1);
 
 DAT = [ C3VAR,C3COVAR,C3MEAN,C3STD,C3MAXPSD,CzVAR,CzCOVAR,CzSTD,CzMEAN,CzMAXPSD,C4VAR,C4COVAR,C4MEAN,C4STD,C4MAXPSD,ETIQUETA];
 if x>0
    DATOS =[DATOS;DAT];
 else
    DATOS= DAT;
 end
end
 if i>1
    SUJETO =[SUJETO;DATOS];
 else
    SUJETO= DATOS;
 end

 %% muestreamos desde t=0 a t= 2
for x=0:59
c3=canal(1,1152*x+1:1152*x+256);
cz=canal(2,1152*x+1:1152*x+256);
c4=canal(3,1152*x+1:1152*x+256);
c3=c3*100;
cz=cz*100;
c4=c4*100;
[c3welch, f]=pwelch(c3);
[czwelch, f]=pwelch(cz);
[c4welch, f]=pwelch(c4);
f=(f/(2*pi))*128;
%figure(100);
%plot(f,c3welch,f,c4welch,f,czwelch);

%Rito Alfa.
c3=filter(Alfa,c3);
cz=filter(Alfa,cz);
c4=filter(Alfa,c4);
[c3welch, f]=pwelch(c3);
[czwelch, f]=pwelch(cz);
[c4welch, f]=pwelch(c4);
f=(f/(2*pi))*128;
%figure(101);
%plot(f,c3welch,f,c4welch,f,czwelch);
%Realizamos Wavalet para redicir el numero de muestras en la extracion de
%caracteristicas
[cc3 ,lc3]= wavedec(c3,1,'db2');
[ccz ,lcz]= wavedec(cz,1,'db2');
[cc4 ,lc4]= wavedec(c4,1,'db2');
C3 = appcoef(cc3,lc3,'db2'); 
Cz = appcoef(ccz,lcz,'db2'); 
C4 = appcoef(cc4,lc4,'db2'); 
[C3welch,f] = pwelch(C3);
[Czwelch,f] = pwelch(Cz);
[C4welch,f] = pwelch(C4);
f=(f/(2*pi))*64;
%figure(102);
%plot(f,C3welch,f,C4welch,f,Czwelch);

%filtramos solo para ver las caracteristicas de los ritmos alfa y mu
%comprendidos entre 8-12 hz.
C3= abs(fft(C3));
C3=C3(1:65);
C4= abs(fft(C4));
C4=C4(1:65);
Cz= abs(fft(Cz));
Cz=Cz(1:65);
n = length(C3);
n=(0:n-1)/n*32;
figure(x+1);
%exportacion de caracteristicas.
plot(n,C3,n,C4,n,Cz);
title('FTF signal C3 y C4 evento',x+1);
xlabel('Frecuencia[Hz]');
ylabel('DPS C3 y C4');

%Cogemos los varoles que reprensentan entre 8 y 12 Hz;
C3=C3(12:25);
Cz=Cz(12:25);
C4=C4(12:25);
C3VAR0=var(C3);
CzVAR0=var(Cz);
C4VAR0=var(C4);
C3COVAR0=cov(C3);
CzCOVAR0=cov(Cz);
C4COVAR0=cov(C4);
C3MEAN0=cov(C3);
CzMEAN0=cov(Cz);
C4MEAN0=cov(C4);
C3STD0=std(C3);
CzSTD0=std(Cz);
C4STD0=std(C4);
C3MAXPSD0=max(C3welch);
CzMAXPSD0=max(Czwelch);
C4MAXPSD0=max(C4welch);
ETIQUETA0 = 0;
 
 DAT0 = [ C3VAR0,C3COVAR0,C3MEAN0,C3STD0,C3MAXPSD0,CzVAR0,CzCOVAR0,CzSTD0,CzMEAN0,CzMAXPSD0,C4VAR0,C4COVAR0,C4MEAN0,C4STD0,C4MAXPSD0,ETIQUETA0];
 if x>0
    DATOS0 =[DATOS0;DAT0];
 else
    DATOS0= DAT0;
 end
end
 if i>1
    SUJETO0 =[SUJETO0;DATOS0];
 else
    SUJETO0= DATOS0;
 end
end
SUJETOE =[SUJETO0;SUJETO];