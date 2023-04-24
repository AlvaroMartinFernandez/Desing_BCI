%Calculamos la Densidad espectral de Potencia mediante el metodo Welch 
[C3welch,f] = pwelch(c3alfat);
[Czwelch,f] = pwelch(czalfat);
[C4welCH,f] = pwelch(c4alfat);
%Calculamos la FFT de la señal.
C3alfat = abs(fft(c3alfat)); 
Czalfat = abs(fft(czalfat));
C4alfat = abs(fft(c4alfat)); 

%Calculamos la Densidad espectral de Potencia mediante el metodo Welch 
[C3welchbeta,f] = pwelch(c3betat);
[Czwelchbeta,f] = pwelch
(czbetat);
[C4welchbeta,f] = pwelch(c4betat);
%Calculamos la FFT de la señal.
C3betat = abs(fft(c3betat)); 
Czbetat = abs(fft(czbetat));
C4betat = abs(fft(c4betat)); 

fb=((0:40)/40)*40;
ft=((0:length(C4alfat)-1)/length(C4alfat));
f=(f/(2*pi))*80;
%%Extracion de Caracteristicas 
% Alfa 
C3VARa=var(C3alfat);
CzVARa=var(Czalfat);
C4VARa=var(C4alfat);
C3COVARa=cov(C3alfat);
CzCOVARa=cov(Czalfat);
C4COVARa=cov(C4alfat);
C3MEANa=cov(C3alfat);
CzMEANa=cov(Czalfat);
C4MEANa=cov(C4alfat);
C3STDa=std(C3alfat);
CzSTDa=std(Czalfat);
C4STDa=std(C4alfat);
C3MAXPSDa=max(C3welchalfa);
CzMAXPSDa=max(Czwelchalfa);
C4MAXPSDa=max(C4welchalfa);
c3VARa=var(c3alfat);
czVARa=var(czalfat);
c4VARa=var(c4alfat);
c3COVARa=cov(c3alfat);
czCOVARa=cov(czalfat);
c4COVARa=cov(c4alfat);
c3MEANa=cov(c3alfat);
czMEANa=cov(czalfat);
c4MEANa=cov(c4alfat);
c3STDa=std(c3alfat);
czSTDa=std(czalfat);
c4STDa=std(c4alfat);
c3MAXa=max(c3alfat);
czMAXa=max(czalfat);
c4MAXa=max(c4alfat);
c3MINa=min(c3alfat);
czMINa=min(czalfat);
c4MINa=min(c4alfat);

%Beta
C3VARb=var(C3betat);
CzVARb=var(Czbetat);
C4VARb=var(C4betat);
C3COVARb=cov(C3betat);
CzCOVARb=cov(Czbetat);
C4COVARb=cov(C4betat);
C3MEANb=cov(C3betat);
CzMEANb=cov(Czbetat);
C4MEANb=cov(C4betat);
C3STDb=std(C3betat);
CzSTDb=std(Czbetat);
C4STDb=std(C4betat);
C3MAXPSDb=max(C3welchbeta);
CzMAXPSDb=max(Czwelchbeta);
C4MAXPSDb=max(C4welchbeta);
c3VARb=var(c3betat);
czVARb=var(czbetat);
c4VARb=var(c4betat);
c3COVARb=cov(c3betat);
czCOVARb=cov(czbetat);
c4COVARb=cov(c4betat);
c3MEANb=cov(c3betat);
czMEANb=cov(czbetat);
c4MEANb=cov(c4betat);
c3STDb=std(c3betat);
czSTDb=std(czbetat);
c4STDb=std(c4betat);
c3MAXb=max(c3betat);
czMAXb=max(czbetat);
c4MAXb=max(c4betat);
c3MINb=min(c3betat);
czMINb=min(czbetat);
c4MINb=min(c4betat);

%Vector de caracteristicas para el MACHINE LEARNING
DAT = [ C3VARa,C3COVARa,C3MEANa,C3STDa,C3MAXPSDa,c3VARa,c3COVARa,c3MEANa,c3STDa,c3MAXa,c3MINa,CzVARa,CzCOVARa,CzMEANa,CzMAXPSDa,CzSTDa,czVARa,czCOVARa,czMEANa,czSTDa,czMAXa,czMINa,C4VARa,C4COVARa,C4MEANa,C4MAXPSDa,C4STDa,c4VARa,c4COVARa,c4MEANa,c4STDa,c4MAXa,c4MINa,C3VARb,C3COVARb,C3MEANb,C3MAXPSDb,C3STDb,c3VARb,c3COVARb,c3MEANb,c3STDb,c3MAXb,c3MINb,CzVARb,CzCOVARb,CzMEANb,CzMAXPSDb,CzSTDb,czVARb,czCOVARb,czMEANb,czSTDb,czMAXb,czMINb,C4VARb,C4COVARb,C4MEANb,C4MAXPSDb,C4STDb,c4VARb,c4COVARb,c4MEANb,c4STDb,c4MAXb,c4MINb];