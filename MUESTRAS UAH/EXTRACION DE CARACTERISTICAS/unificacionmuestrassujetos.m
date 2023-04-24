%%Unificacion de muestras para realizar la machine learning
Sujeto1=load('Sujeto1.mat');
Sujeto2=load('Sujeto2.mat');
Sujeto3=load('Sujeto3.mat');
Sujeto4=load('Sujeto4.mat');
Sujeto5=load('Sujeto5.mat');
Sujeto6=load('Sujeto6.mat');
Sujeto7=load('Sujeto7.mat');
Sujeto8=load('Sujeto8.mat');
Sujeto9=load('Sujeto9.mat');
Sujeto10=load('Sujeto10.mat');
Sujeto11=load('Sujeto11.mat');
Sujeto12=load('Sujeto12.mat');
BaseDatosUAH =[Sujeto1.SUJETOE;Sujeto2.SUJETOE;Sujeto3.SUJETOE;Sujeto4.SUJETOE;Sujeto5.SUJETOE;Sujeto6.SUJETOE;Sujeto7.SUJETOE;Sujeto8.SUJETOE;Sujeto9.SUJETOE;Sujeto10.SUJETOE;Sujeto11.SUJETOE;Sujeto12.SUJETOE];
BaseDatosNorUAH=BaseDatosUAH;
BaseDatosestandarUAH=BaseDatosUAH;
for x=1:15 
    MAX=max(BaseDatosUAH(:,x));
    MIN=min(BaseDatosUAH(:,x));
    for i=1:5040
      Var1  =BaseDatosUAH(i,x);
      Var2 =(BaseDatosUAH(i,x)-MIN)/(MAX-MIN);
      BaseDatosNorUAH(i,x)=Var2;
    end
end
for x=1:15
    MEAN=mean(BaseDatosUAH(:,x));
    STD=std(BaseDatosUAH(:,x));
    for i=5040
     BaseDatosestandarUAH(i,x)=(BaseDatosUAH(i,x)-MEAN)/(STD);
    end
end