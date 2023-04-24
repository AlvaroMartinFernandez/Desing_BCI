load('Basedatossujeto1.mat')

for x=1:35640
    if BaseDatos(x,13)==0
       BaseDatos(x,:) = [];
    elseif BaseDatos(x,13)==7
        BaseDatos(x,:) = [];
    end
end
