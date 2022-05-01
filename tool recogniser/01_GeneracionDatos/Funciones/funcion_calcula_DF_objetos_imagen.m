function X = funcion_calcula_DF_objetos_imagen(Ietiq,N)
%Calculamos el momento de Hu de cada objeto etiquetado
X=[];

for i=1:N
    
    Ibin_i=Ietiq==i;
    
    m=Funcion_Calcula_DF(Ibin_i,10);
    X(i,:)=m';
end