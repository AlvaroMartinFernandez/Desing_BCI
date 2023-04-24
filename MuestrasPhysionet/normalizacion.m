load('BaseDatos03092022.mat');
BaseDatosNor=BaseDatos;
BaseDatosestandar=BaseDatos;
for x=1:66 
    MAX=max(BaseDatos(:,x));
    MIN=min(BaseDatos(:,x));
    for i=1:62368
      Var1  =BaseDatos(i,x);
      Var2 =(BaseDatos(i,x)-MIN)/(MAX-MIN);
      BaseDatosNor(i,x)=Var2;
    end
end
for x=1:66 
    MEAN=mean(BaseDatos(:,x));
    STD=std(BaseDatos(:,x));
    for i=62368
     BaseDatosestandar(i,x)=(BaseDatos(i,x)-MEAN)/(STD);
    end
end